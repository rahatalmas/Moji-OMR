const express = require('express')
const { login } = require('../controllers/login')
const userRouter = express.Router()

userRouter.get("/:id",(req,res)=>{
    const userid = req.params.id
    res.status(201).json({"userid":userid})
})

userRouter.post("/login",login)

module.exports = userRouter
