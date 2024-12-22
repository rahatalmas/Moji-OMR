const db = require("../../config/db");
const { resultQ } = require("../../queries/queries");

//All result for a exam
const getAllResult = async (req,res)=> {
    console.log("All Result Controller: ");
    const examId = req.params.examId;
    console.log("ExamId: ",examId);
    try{
        const [result] = await db.query(resultQ.getAllResult,[examId]);
        console.log([result]);
        res.status(200).json(result);          
    }catch(err){
        console.log(err);
        res.status(500).json({"message":"Internal Server Error"});    
    }
}

//Specific students result for a exam
const myResult = async (req,res)=>{
    console.log("My Result Controller: ");
    const examId = req.params.examId;
    const serialNumber = req.params.serialNumber;
    console.log("ExamId: ",examId);
    console.log("Serial Number: ",serialNumber);
    try{
        const [result] = await db.query(resultQ.getMyResult,[examId,serialNumber]);
        console.log([result]);
        res.status(200).json(result);          
    }catch(err){
        console.log(err);
        res.status(500).json({"message":"Internal Server Error"});    
    }
}

//add result
const addResult = async (req,res)=> {
    console.log("Adding Result: ");
    const {exam_id,serial_number,correct_answers,incorrect_answers,grade} = req.body;
    console.log("Result: ",exam_id,serial_number,correct_answers,incorrect_answers,grade);
    try{
        const [result] = await db.execute(resultQ.addResult,[exam_id,serial_number,correct_answers,incorrect_answers,grade]);
        console.log([result]);
        res.status(201).json({"message":"New Result Added"});          
    }catch(err){
        console.log(err);
        res.status(500).json({"message":"Internal Server Error"});    
    }
}

//update exam result
const updateExamResults = async (req,res)=>{
    console.log("Updating Result: ");
    const {exam_id,serial_number,correct_answers,incorrect_answers,grade} = req.body;
    console.log("Result: ",exam_id,serial_number,correct_answers,incorrect_answers,grade);
    try{
        const [result] = await db.execute(resultQ.updateCandidateResult,[correct_answers,incorrect_answers,grade,exam_id,serial_number]);
        console.log([result]);
        res.status(201).json({"message":"Result Updated"});          
    }catch(err){
        console.log(err);
        res.status(500).json({"message":"Internal Server Error"});    
    }
}

//delete exam results
const deleteExamResults = async (req,res)=>{
    console.log("Delete Exam Results: ");
    const examId = req.params.examId;
    console.log("ExamId: ",examId);
    try{
        const [result] = await db.execute(resultQ.deleteAllResultForExam,[examId]);
        console.log([result]);
        res.status(204).json({"message":"Results Deleted"});          
    }catch(err){
        console.log(err);
        res.status(500).json({"message":"Internal Server Error"});    
    }
}

//delete candidate result
const deleteMyResult = async (req,res)=>{
    console.log("Delete My result: ");
    const examId = req.params.examId;
    const serialNumber = req.params.serialNumber;
    console.log("ExamId: ",examId);
    console.log("Serial Number: ",serialNumber);
    try{
        const [result] = await db.execute(resultQ.deleteResultForCandidate,[serialNumber,examId]);
        console.log([result]);
        res.status(204).json({"message":"Results Deleted"});          
    }catch(err){
        console.log(err);
        res.status(500).json({"message":"Internal Server Error"});    
    }
}

module.exports = {
    getAllResult,
    myResult,
    addResult,
    updateExamResults,
    deleteExamResults,
    deleteMyResult,
}