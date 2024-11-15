const express = require('express');
const examRouter = express.Router();
const {authCheck} = require('../controllers/middlewares');
const { getExamList, getExamWithDetails, addExam, updateExam, deleteExam } = require('../controllers/exam/examController');

examRouter.use(authCheck);
examRouter.get("/list",getExamList);
examRouter.get("/list/:examId",getExamWithDetails);
examRouter.post("/add",addExam);
examRouter.put("/update",updateExam);
examRouter.delete("/delete",deleteExam);

module.exports = examRouter;