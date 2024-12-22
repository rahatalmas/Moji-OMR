const express = require('express');
const { getAllResult, myResult, addResult, updateExamResults, deleteExamResults, deleteMyResult } = require('../controllers/result/resultController');
const resultRouter = express.Router();

resultRouter.get("/all/:examId",getAllResult);
resultRouter.get("/all/myresult/:examId/:serialNumber",myResult);
resultRouter.post("/add",addResult);
resultRouter.put("/update",updateExamResults);
resultRouter.delete("/delete/:examId",deleteExamResults);
resultRouter.delete("/delete/individual/:examId/:serialNumber",deleteMyResult);

module.exports = resultRouter;