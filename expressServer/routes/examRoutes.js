const express = require('express');
const examRouter = express.Router();
const {authCheck} = require('../controllers/middlewares');
const db = require('../config/db');
const { getExamList } = require('../controllers/exam/examController');

const res = [
    {
        name:"sakura",
        result:"A"
    },
    {
        name:"Itachi",
        result:"A+"
    }
]

examRouter.use(authCheck);
examRouter.get("/list",getExamList);

module.exports = examRouter;