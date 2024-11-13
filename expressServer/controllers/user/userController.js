const db = require("../../config/db");
const { adminsQ } = require("../../queries/queries");
const { generateHash } = require("../utility/hash");

const addUser = async (req,res) =>{
    try{
        const {username,password,role_key} = req.body;
        if (!username || !password || !role_key) {
            return res.status(400).json({ "message": "Missing required fields" });
        }
        console.log("add user Post: ",{username,password,role_key});
        const [user] = await db.query(adminsQ.getSpecific,[username]);
        if(user.length>0 && user[0].admin_username === username){
            console.log(user[0].admin_username);
            res.status(409).json({"message":"User name already exists"});
            return;
        }
        const hashedPassword = await generateHash(password);
        const [rows,fields] = await db.execute(adminsQ.addAdmin,[username,hashedPassword,role_key]);
        console.log(rows,fields);
        res.status(200).json({"message":"New User Added"});
    }catch(err){
        console.log(err.message)
        res.status(500).json({"message":"Internal Server Error","err":err.message});
    }
}

const userList = async (req,res)=>{
    try{
        const [adminList] = await db.query(adminsQ.getList);
        res.status(201).json(adminList);
    }catch(err){
        console.log(err.message)
        res.status(500).json({"message":"Internal Server Error"});
    }
}

const updateUser = async (req,res)=>{
    try{
        res.status(201).json({"message":"update request..."});
    }catch(err){
        console.log(err.message)
        res.status(500).json({"message":"Internal Server Error"});
    }
}

const deleteUser = async (req,res)=>{
    try{
        res.status(201).json({"message":"delete request..."});
    }catch(err){
        console.log(err.message)
        res.status(500).json({"message":"Internal Server Error"});
    }
}


module.exports = {
    addUser,
    userList,
    updateUser,
    deleteUser
}