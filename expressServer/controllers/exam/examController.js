const db = require("../../config/db");
const { examsQ, candidateQ, questionQ } = require("../../queries/queries");
const { roles } = require("../utility/keys");

const getExamList = async (req,res)=>{
    try{
        const rolekey = req.user.key;
        const role = roles[rolekey];
        console.log(role);
        if(role != "admin" && role != "editor"){
            res.status(401).json({"message":"Access Denied"});
            return;
        }
        const [exams] = await db.query(examsQ.getList);
        exams.reverse();
        res.status(200).json(exams);
    }catch(err){
        res.status(500).json({"message":"Sorry! Internal Server error"});
    }
}

const getExamWithDetails = async (req,res)=>{
    try{

    }catch(err){
        console.log(err.message);
        res.status(500).json({"message":"Internal Server Error"});
    }
}

const addExam = async (req,res)=>{
    try{
        const{
                exam_name,
                exam_date,
                exam_location,
                exam_duration,
                question_count,
                candidate_count
             } = req.body;
        const [result] = await db.execute(
            examsQ.addExam,
            [exam_name,exam_date,exam_location,
            exam_duration,question_count,candidate_count]
        );
        console.log(result);
        res.status(201).json({"message":"Exam Added"});
    }catch(err){
        console.log(err.errno);
        //mysql 1062 error code means duplicate entry >_<
        if(err.errno === 1062){
            res.status(409).json({"message":"Exam Name Already Exists"});
            return;
        }
        res.status(500).json({"message":"Internal Server Error"});
    }
}

const updateExam = async (req,res)=>{
    try{
        const{
                exam_id,
                exam_name,
                exam_date,
                exam_location,
                exam_duration,
                question_count,
                candidate_count
             } = req.body;
        console.log({exam_id,exam_name,exam_date,exam_location,exam_duration,question_count,candidate_count});
        
        const [exam] = await db.query(examsQ.getSpecificById,[id]);
        if(exam.length != 1){
            console.log("Exam Id: ",id);
            console.log("No exam found with this id");
            res.status(404).json({"message":"Exam not found"});
            return;
        }

        const result = await db.execute(
            examsQ.editExam,
            [exam_name,exam_date,exam_location,exam_duration,question_count,candidate_count,exam_id]
        );
        console.log(result);
        res.status(204).json({"message":"Exam data Updated"});
    }catch(err){
        console.log(err);
        res.status(500).json({"message":"Internal Server Error"});
    }
}

const deleteExam = async (req,res)=>{
    try{
        console.log("Exam delete controller called: ");
        const id = req.params.id;
        console.log(id);
        const [exam] = await db.query(examsQ.getSpecificById,[id]);
        if(exam.length != 1){
            console.log("Exam Id: ",id);
            console.log("No exam found with this id");
            res.status(404).json({"message":"Exam not found"});
            return;
        }
        const removeCandidates = await db.execute(candidateQ.deleteAllCandidateForExam,[id]);
        console.log(removeCandidates);

        const removeQuestions = await db.execute(questionQ.deleteAllQuestionForExam,[id]);
        console.log(removeQuestions);

        const result = await db.execute(examsQ.deleteExam,[id]);
        console.log(result);
        res.status(204).json({"message":"Exam Deleted"});
    }catch(err){
        console.log(err.message)
        res.status(500).json({"message":"Internal Server Error"});
    }
}

module.exports = {
    getExamList,
    getExamWithDetails,
    addExam,
    deleteExam,
    updateExam
}