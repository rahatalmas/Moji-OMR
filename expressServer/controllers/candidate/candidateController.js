// get list off all candidates for all exam
// add candidate 
// delete candidate
// update candidate data
const db = require("../../config/db");
const { candidateQ, examsQ } = require("../../queries/queries");
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
        //validating request data
        if(!serial_number || !candidate_name || !school_name || !class_level || !exam_id){
            console.log("Invalid request");
            res.status(306).json({"message":"Invalid Request"});
            return;
        }
        console.log("Candidate ",serial_number,candidate_name, school_name,class_level,exam_id);

        //getting exam
        const [exam] = await db.query(examsQ.getSpecificById,exam_id);
        console.log(exam[0]);
        const totalSits = exam[0].candidate_count;
        console.log("Total Sits: ",totalSits);

        //getting candidate counts 
        const [count] = await db.query(candidateQ.getCandidateCount,exam_id);
        const candidateCount = count[0].candidate_count
        console.log(candidateCount);

        //validation for sits available or not
        if(candidateCount == totalSits){
            res.status(406).json({"message":"Seats not available"});
            return;
        }
        
        //adding candidate
        const [result] = await db.execute(
             candidateQ.addCandidate,
            [serial_number,candidate_name,school_name,class_level, exam_id ]
        );
        console.log("Query result ",result);
        res.status(201).json({"message":"New Candidate Added"});
    }catch(err){
        console.log("error ",err);
        if(err.errno == 1062){
            console.log("dublicate serial number entry");
            res.status(406).json({"message":"Serial number already exist"});
            return;
        }
        res.status(500).json({"message":"Internal Server Error"});
        return;
    }
}

const candidateCount = async (req,res) => {
    try{
        const examId = req.params.examId;
        console.log("Candidate count query for exam Id: ",examId);
        const [result] = await db.query(candidateQ.getCandidateCount,[examId]);
        console.log(result[0].candidate_count);
        res.status(200).json(result);
    }catch(err){
        res.status(500).json({ "message": "Sorry! Internal Server error" })
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
    candidateCount,
    addCandidate,
    // updateCandidate,
    // deleteCandidate
}