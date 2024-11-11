const express = require('express');
const examRouter = express.Router();
const {authCheck} = require('../controllers/middlewares');

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
examRouter.get("/history/list",(req,res)=>{
    res.status(201).json({"name":"O LEVEL EXAM"});
})

module.exports = examRouter;