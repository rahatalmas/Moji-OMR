const db = require("../../config/db");
const { adminsQ } = require("../../queries/queries");
const { generateHash } = require("../utility/hash");
const { roles } = require("../utility/keys");

const addUser = async (req,res) =>{
    try{
        const {username,password,role} = req.body;
        if (!username || !password || !role) {
            return res.status(400).json({ "message": "Missing required fields" });
        }
        console.log("add user Post: ",{username,password,role});
        const [user] = await db.query(adminsQ.getSpecific,[username]);
        if(user.length>0 && user[0].admin_username === username){
            res.status(409).json({"message":"User name already exists"});
            return;
        }
        console.log("req user: ",req.user.key)
        console.log(roles[req.user.key])
        if(roles[req.user.key] != "admin"){
            res.status(401).json({"message":"Access Denied"});
            return;
        }
        const hashedPassword = await generateHash(password);
        let role_key = ""
        if(role == "admin"){
            role_key = "admin_key";
        }else if(role == "editor"){
            role_key = "editor_key"
        }else{
            role_key = "user_key"
        }
        const result = await db.execute(adminsQ.addAdmin,[username,hashedPassword,role_key]);
        console.log(result);
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
        const id = req.params.id;
        console.log(id);
        const result = await db.execute(adminsQ.deleteAdmin,[id]);
        console.log(result);
        res.status(201).json({"message":"User Deleted"});
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