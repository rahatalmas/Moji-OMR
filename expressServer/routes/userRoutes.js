const express = require('express');
const { login } = require('../controllers/login');
const { authCheck } = require('../controllers/middlewares');
const { userList,
        addUser, 
        deleteUser,
        indiVidualUser,
        updateUserName,
        updateUserPassword,
        
} = require('../controllers/user/userController');

const userRouter = express.Router()

userRouter.post("/login",login);
userRouter.use(authCheck);
userRouter.get("/list",userList);
userRouter.post("/register",addUser);
userRouter.put("/update/name",updateUserName);
userRouter.put("/update/password",updateUserPassword);
userRouter.delete("/delete/:id",deleteUser);
userRouter.get("/list/:id",indiVidualUser);

module.exports = userRouter;
