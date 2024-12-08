// get list off all candidates for all exam
// add candidate 
// delete candidate
// update candidate data
const db = require("../../config/db");
const { candidateQ } = require("../../queries/queries");
const { roles } = require("../utility/keys");

const getCandidateList = async (req, res) => {
    const examId = req.params.examId;
    try {
        if(!req.user){
            res.status(401).json({"message":"Access Denied"});
            return;
        }
        const rolekey = req.user.key;
        const role = roles[rolekey];
        console.log(role);
        if(role != "admin" && role != "editor"){
            res.status(401).json({"message":"Access Denied"});
            return;
        }
        const [candidates] = await db.query(candidateQ.getList,[examId]);
        res.status(200).json(candidates);
    } catch (err) {
        res.status(500).json({ "message": "Sorry! Internal Server error" });
    }
}

const addCandidate = async (req, res) =>{
    try{
        const{
               serial_number,
               candidate_name,
               school_name,
               class_level,
               exam_id   
             } = req.body;
        console.log("Candidate ",serial_number,candidate_name, school_name,class_level,exam_id);
        const [result] = await db.execute(
             candidateQ.addCandidate,
            [serial_number,candidate_name,school_name,class_level, exam_id ]
        );
        console.log("Query result ",result);
        res.status(201).json({"message":"New Candidate Added"});
    }catch(err){
        console.log("error ",err);
        res.status(500).json({"message":"Internal Server Error"});
    }
}

// const updateCandidate = async (req, res) => {
//     try {
//         try {
//             const {
//             } = req.body;
//             const result = await db.execute(
//                 ,
//                 [ ]
//             );
//             res.status(204).json({ "message": "Candidate data Updated" });
//         } catch (err) {
//             console.log(err);
//             res.status(500).json({ "message": "Internal Server Error" });
//         }
//     } catch (err) {
//         res.status(500).json({ "message": "Sorry! Internal Server error" });
//     }
// }

// const deleteCandidate = async (req, res) => {
//     try {
//         try {
//             const id = req.params.id;
//             const result = await db.execute(, [id]);
//             res.status(204).json({ "message": "Candidate Deleted" });
//         } catch (err) {
//             console.log(err.message)
//             res.status(500).json({ "message": "Internal Server Error" });
//         }
//     } catch (err) {
//         res.status(500).json({ "message": "Sorry! Internal Server error" });
//     }
// }

module.exports = {
    getCandidateList,
    addCandidate,
    // updateCandidate,
    // deleteCandidate
}