const {generateHash,hashCompare} = require('../controllers/utility/hash');
const {generateAccessToken,generateRefreshToken} = require('../controllers/utility/jwt');
const { keys } = require('./utility/keys');
//const hashedpassword = await generateHash(password) //123456$
const hashpassword = "$2b$10$ydta7s1xfVGt4Gkt8qLdGOBcobbO21blY1Wxl.YPMBhExc6X4pT/."

const login = async (req,res)=>{
    try{
        const {username,password} = req.body
        /*
           // data retriving section from database
        */
        const result = await hashCompare(password,hashpassword)
        console.log("hash compare result: ",result);
        if(result){
            const accesstoken = await generateAccessToken({username:username,key:keys[0]});
            const refreshtoken = await generateRefreshToken({username:username,key:keys[0]});
            console.log("Access Token: ",accesstoken);
            console.log("Access Token: ",refreshtoken);
            /*
              // set refreshing token to cookies with http secure
            */
            res.status(201).json({
                "message":"Login Successful",
                "username":username,
                "accesstoken":accesstoken
            })
        }else{
            res.status(401).json({"message":"Incorrect Password"})
        }
    }catch(err){
        console.log(err)
        return res.status(500).json({ message: 'Server error. Please try again later.' });
    }
}

module.exports = {
    login
}