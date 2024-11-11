const express = require('express');
const examRouter = express.Router();
const {authCheck} = require('../controllers/middlewares');
const { getExamList } = require('../controllers/exam');
const db = require('../config/db');

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

examRouter.get("/result", async (req, res) => {
    try {
        //const [result] = await db.execute("SELECT * FROM admin");
        const [result] = await db.query("SELECT * FROM admin");
        res.status(201).json(result);
    } catch (err) {
        console.error('Error fetching users:', err.message);
        res.status(500).send({ message: 'Error fetching users', error: err.message });
    }
});

examRouter.use(authCheck);
examRouter.get("/history/list",getExamList);

module.exports = examRouter;