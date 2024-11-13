const db = require('../config/db');
const {generateHash,hashCompare} = require('../controllers/utility/hash');
const {generateAccessToken,generateRefreshToken} = require('../controllers/utility/jwt');
const { keys } = require('./utility/keys');
//const hashedpassword = await generateHash(password) //123456$
//const hashpassword = "$2b$10$ydta7s1xfVGt4Gkt8qLdGOBcobbO21blY1Wxl.YPMBhExc6X4pT/."

const login = async (req,res)=>{
    try{
        const {username,password} = req.body
        const [user] = await db.query("SELECT * FROM admins WHERE admin_username=?",[username]);
        if(user.length<1){
            res.status(404).json({"message":"No User Found"});
            return;
        }
        const result = await hashCompare(password,user[0].admin_password);
        if(!result){
            res.status(401).json({"message":"Incorrect Password"})
            return;
        }
        const accesstoken = generateAccessToken({ username: username, key: user[0].admin_role_key });
        const refreshtoken = generateRefreshToken({ username: username, key: keys[0].admin_role_key });
        console.log("Access Token: ",accesstoken);
        console.log("Access Token: ",refreshtoken);
        res.cookie('refreshToken',refreshtoken,{
            httpOnly:true,
            secure:true,
            //secure: process.env.NODE_ENV === 'production',  // Only sent over HTTPS in production
            maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days expiration
            sameSite: 'Strict'
        });
        res.status(201).json({
            "message":"Login Successful",
            "username":username,
            "accesstoken":accesstoken
        })
    }catch(err){
        console.log(err)
        return res.status(500).json({ message: 'Server error. Please try again later.' });
    }
}

module.exports = {
    login
}