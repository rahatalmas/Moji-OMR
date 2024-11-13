CREATE TABLE IF NOT EXISTS admins (
    admin_id INT NOT NULL AUTO_INCREMENT,
    admin_username VARCHAR(50),
    admin_password VARCHAR(255),
    admin_role_key VARCHAR(255),
    PRIMARY KEY (admin_id)
);


CREATE TABLE IF NOT EXISTS exams (
    exam_id INT NOT NULL AUTO_INCREMENT,
    exam_name VARCHAR(255) NOT NULL,
    exam_date DATETIME NOT NULL,
    exam_location VARCHAR(255) NOT NULL,
    exam_duration INT NOT NULL,
    question_count INT NOT NULL,
    candidate_count INT NOT NULL,
    UNIQUE (exam_name, exam_date),
    PRIMARY KEY (exam_id)
);

CREATE TABLE IF NOT EXISTS candidates (
    serial_number INT NOT NULL,
    candidate_name VARCHAR(100) NOT NULL,
    school_name VARCHAR(255) NOT NULL,
    class_level VARCHAR(25) NOT NULL,
    exam_id INT NOT NULL,
    PRIMARY KEY(serial_number),
    CONSTRAINT fk_exam_candidates FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

CREATE TABLE IF NOT EXISTS questions (
    question_id INT NOT NULL AUTO_INCREMENT,
    question_text VARCHAR(255) NOT NULL,
    options_per_question INT NOT NULL,
    exam_id INT NOT NULL,
    PRIMARY KEY(question_id),
    CONSTRAINT fk_exam_questions FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);


CREATE TABLE IF NOT EXISTS options (
    option_id INT NOT NULL AUTO_INCREMENT,
    option_text VARCHAR(255) NOT NULL,
    question_id INT NOT NULL,
    PRIMARY KEY(option_id),
    CONSTRAINT fk_question FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

CREATE TABLE IF NOT EXISTS results (
    result_id INT NOT NULL AUTO_INCREMENT,
    total_mark INT NOT NULL,
    grade VARCHAR(20) NOT NULL,
    serial_number INT NOT NULL,
    exam_id INT NOT NULL,
    PRIMARY KEY(result_id),
    CONSTRAINT fk_candidate FOREIGN KEY (serial_number) REFERENCES candidates(serial_number),
    CONSTRAINT fk_exam_result FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);