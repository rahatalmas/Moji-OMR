const express = require('express');
const { login } = require('../controllers/login');
const { authCheck } = require('../controllers/middlewares');
const { userList, addUser, updateUser, deleteUser } = require('../controllers/user/userController');
const userRouter = express.Router()

userRouter.post("/login",login);
userRouter.use(authCheck);
userRouter.get("/list",userList);
userRouter.post("/register",addUser);
userRouter.put("/update/:id",updateUser);
userRouter.delete("/delete/:id",deleteUser);
userRouter.get("/list/:id",(req,res)=>{
    const userid = req.params.id
    res.status(201).json({"userid":userid})
})

module.exports = userRouter;
