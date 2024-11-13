const adminsQ = {
    getList: "SELECT * FROM admins",
    getSpecific:"SELECT * FROM admins WHERE admin_username=?",
    addAdmin: `INSERT INTO admins 
                   (admin_username, admin_password, admin_role_key)
                VALUES
                   (?, ?, ?);`,
    editAdmin: `UPDATE admins SET username=?, password=?, rolekey=? WHERE id=?`,
    deleteAdmin: `DELETE FROM admins WHERE admin_id=?`
}

const examsQ = {
    getList: "SELECT * FROM exam",
    addExam: `INSERT INTO exams
                  (exam_name, exam_date, exam_location, exam_duration, candidate_count)
              VALUES 
                  (?, ?, ?, ?, ?);`,
    editExam: `UPDATE exams SET exam_name=?, exam_date=?, exam_location=?, exam_duration=?, candidate_count=? WHERE exam_id=?`, 
}

module.exports = {
    adminsQ,
    examsQ
}