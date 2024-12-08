const express = require('express');
const { getCandidateList, addCandidate } = require('../controllers/candidate/candidateController');
const { authCheck } = require('../controllers/middlewares');
const candidateRouter = express.Router();

candidateRouter.use(authCheck);
candidateRouter.get('/:examId',getCandidateList);
candidateRouter.post('/add',addCandidate);

module.exports = candidateRouter;