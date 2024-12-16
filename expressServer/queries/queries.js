const adminsQ = {
    getList: "SELECT admin_id,admin_username,admin_role_key FROM admins",
    getSpecificById:"SELECT admin_id,admin_username,admin_role_key FROM admins WHERE admin_id=?",
    getSpecificByName:"SELECT admin_id,admin_username,admin_role_key FROM admins WHERE admin_username=?",
    getCredentialsByName:"SELECT admin_password,admin_role_key FROM admins WHERE admin_username=?",
    addAdmin: `INSERT INTO admins 
                   (admin_username, admin_password, admin_role_key)
                VALUES
                   (?, ?, ?);`,
    editAdminUsername: `UPDATE admins SET admin_username=? WHERE admin_id=?`,
    editAdminPassword: `UPDATE admins SET admin_password=? WHERE admin_id=?`,
    editAdminRole: `UPDATE admins SET admin_role_key=? WHERE admin_id=?`,
    deleteAdmin: `DELETE FROM admins WHERE admin_id=?`
}


const examsQ = {
    getList: "SELECT * FROM exams",
    getSpecificById:"SELECT * FROM exams WHERE exam_id=?",
    addExam: `INSERT INTO exams
                  (exam_name, exam_date, exam_location, exam_duration, question_count, candidate_count)
              VALUES 
                  (?, ?, ?, ?, ?, ?);`,
    editExam: `UPDATE exams SET 
              exam_name=?, exam_date=?, exam_location=?, exam_duration=?, question_count=?, candidate_count=?
              WHERE exam_id=?`,
    deleteExam: `DELETE FROM exams WHERE exam_id=?`
}


const scholarQ = {
    getList: "SELECT * FROM scholars",
    getFilteredList:`
    SELECT * 
    FROM scholars 
    WHERE scholar_id NOT IN (
        SELECT c.scholar_id 
        FROM candidates c
        JOIN exams e ON c.exam_id = e.exam_id
        WHERE e.exam_id = ?
    )`,
    getSpecificById:"SELECT * FROM scholars WHERE scholar_id=?",
    addScholar: `INSERT INTO scholars
                  (scholar_name, scholar_school, class_level)
              VALUES 
                  (?, ?, ?);`,
    editScholar: `UPDATE scholars SET 
              scholar_name=?, scholar_school=?, class_level=?
              WHERE scholar_id=?`,
    deleteScholar: `DELETE FROM scholars WHERE scholar_id=?`
}

//modifying
const candidateQ = {
    getList: "SELECT * FROM candidates WHERE exam_id=?",
    getCandidateCount: "SELECT COUNT(*) AS candidate_count FROM candidates WHERE exam_id=?",
    getCandidateBySerialNumber:"SELECT * FROM candidates WHERE serial_number=? AND exam_id=?",
    addCandidate: `INSERT INTO candidates
                  (serial_number, candidate_name, school_name, class_level, scholar_id, exam_id)
              VALUES 
                  (?, ?, ?, ?, ?, ?);`,
    deleteCandidate: "DELETE FROM candidates WHERE serial_number=?",
    deleteAllCandidateForExam: "DELETE FROM candidates WHERE exam_id=?"
}

//incomplete
const questionQ = {
    getList:"",
    getQuestionCount:"",
    addQuestion:"",
    deleteQuestion:"",
    deleteAllQuestionForExam:"DELETE FROM questions WHERE exam_id=?",
}

module.exports = {
    adminsQ,
    examsQ,
    scholarQ,
    candidateQ,
    questionQ
}