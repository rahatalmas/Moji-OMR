const { roles } = require("../utility/keys");

const getExamList = (req,res)=>{
    try{
        const rolekey = req.user.key;
        const role = roles[rolekey];
        if(role != "admin" && role != "editor"){
            res.status(401).json({"message":"Access Denied"});
            return;
        }
        res.status(201).json({"name":"O LEVEL EXAM"});
    }catch(err){
        res.status(401).json({"message":"Sorry! Internal Server error"});
    }
}

module.exports = {
    getExamList
}