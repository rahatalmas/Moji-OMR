const db = require("../../config/db");
const { scholarQ } = require("../../queries/queries");
const { roles } = require("../utility/keys");

const getScholarList = async (req, res) => {
    try {
        // const rolekey = req.user.key;
        // const role = roles[rolekey];
        // console.log(role);
        // if(role != "admin" && role != "editor"){
        //     res.status(401).json({"message":"Access Denied"});
        //     return;
        // }
        const [scholars] = await db.query(scholarQ.getList);
        //scholars.reverse();
        res.status(200).json(scholars);
    } catch (err) {
        res.status(500).json({ "message": "Sorry! Internal Server error" });
    }
}

const AddScholar = async (req, res) => {
    try{
        const{
               scholar_name,
               scholar_school,
               class_level,    
             } = req.body;
        console.log("scholar ",scholar_name, scholar_school,class_level);
        const [result] = await db.execute(
            scholarQ.addScholar,
            [scholar_name,scholar_school,class_level]
        );
        console.log(result);
        res.status(201).json({"message":"New Scholar Added"});
    }catch(err){
        console.log(err);
        res.status(500).json({"message":"Internal Server Error"});
    }
}

const UpdateScholar = async (req, res) => {
    try {
        try {
            const {
                scholar_id,
                scholar_name,
                scholar_school,
                class_level
            } = req.body;
            console.log("update req ");
            console.log(scholar_name);
            const result = await db.execute(
                scholarQ.editScholar,
                [ scholar_name, scholar_school, class_level, scholar_id]
            );
            console.log("udated");

            res.status(204).json({ "message": "Scholar data Updated" });
        } catch (err) {
            console.log(err);
            res.status(500).json({ "message": "Internal Server Error" });
        }
    } catch (err) {
        res.status(500).json({ "message": "Sorry! Internal Server error" });
    }
}

const DeleteScholar = async (req, res) => {
    try {
        try {
            const id = req.params.id;
            const result = await db.execute(scholarQ.deleteScholar, [id]);
            console.log(result);
            res.status(204).json({ "message": "Exam Deleted" });
        } catch (err) {
            console.log(err.message)
            res.status(500).json({ "message": "Internal Server Error" });
        }
    } catch (err) {
        res.status(500).json({ "message": "Sorry! Internal Server error" });
    }
}

module.exports = {
    getScholarList,
    AddScholar,
    UpdateScholar,
    DeleteScholar
}