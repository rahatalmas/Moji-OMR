const express = require('express');
const { login } = require('../controllers/login');
const { authCheck } = require('../controllers/middlewares');
const { userList, addUser } = require('../controllers/user/userController');
const userRouter = express.Router()

userRouter.get("/list/:id",(req,res)=>{
    const userid = req.params.id
    res.status(201).json({"userid":userid})
})

userRouter.post("/login",login);
userRouter.use(authCheck);
userRouter.get("/list",userList);
userRouter.post("/register",addUser);

module.exports = userRouter
