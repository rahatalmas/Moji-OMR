const express = require('express');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const userRouter = require('./routes/userRoutes');
const examRouter = require('./routes/examRoutes');
const ScholarRouter = require('./routes/scholarRoutes');

const app = express();
app.use(cors());
app.use(express.json());
app.use(cookieParser());
const PORT = 8080;

app.get("/",(req,res)=>{
    res.status(201).json({"message": "Hello from Server"})
})

app.use("/api/user",userRouter);
app.use("/api/exam",examRouter);
app.use("/api/scholar",ScholarRouter);

app.listen(PORT, (err)=>{
    if(err){
        console.log("Listen Error: ",err)
        return
    }
    console.log(`Server is running on port ${PORT}`)
})