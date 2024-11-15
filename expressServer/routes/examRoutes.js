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

const adminListQ = "SELECT * FROM admin;";

examRouter.get("/result", async (req, res) => {
    try {
        //const [result] = await db.execute("SELECT * FROM admin");
        const [result] = await db.query(adminListQ);
        //const refreshToken = req.cookies;
        //console.log(refreshToken);
        res.status(201).json(result);
    } catch (err) {
        console.error('Error fetching users:', err.message);
        res.status(500).send({ message: 'Error fetching users', error: err.message });
    }
});

examRouter.use(authCheck);
examRouter.get("/list",getExamList);

module.exports = examRouter;