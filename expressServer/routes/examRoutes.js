const express = require('express');
const examRouter = express.Router();
const {authCheck} = require('../controllers/middlewares');
const { getExamList } = require('../controllers/exam');

const result = [
    {
        name:"sakura",
        result:"A"
    },
    {
        name:"Itachi",
        result:"A+"
    }
]

examRouter.get("/result",(req,res)=>{
    res.status(201).json(result)
})

examRouter.use(authCheck);
examRouter.get("/history/list",getExamList);

module.exports = examRouter;