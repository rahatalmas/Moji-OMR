const adminsQ = {
    getList: "SELECT * FROM admins",
    getSpecificById:"SELECT * FROM admins WHERE admin_id=?",
    getSpecificByName:"SELECT * FROM admins WHERE admin_username=?",
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
    addExam: `INSERT INTO exams
                  (exam_name, exam_date, exam_location, exam_duration, question_count, candidate_count)
              VALUES 
                  (?, ?, ?, ?, ?, ?);`,
    editExam: `UPDATE exams SET 
              exam_name=?, exam_date=?, exam_location=?, exam_duration=?, question_count=?, candidate_count=?
              WHERE exam_id=?`,
}

module.exports = {
    adminsQ,
    examsQ
}