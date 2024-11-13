CREATE TABLE IF NOT EXISTS exams (
    exam_id INT NOT NULL AUTO_INCREMENT,
    exam_name VARCHAR(255) NOT NULL,
    exam_date DATETIME NOT NULL,
    exam_location VARCHAR(255) NOT NULL,
    exam_duration INT NOT NULL,
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
    CONSTRAINT fk_exam FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

CREATE TABLE IF NOT EXISTS questions (
    question_id INT NOT NULL AUTO_INCREMENT,
    question_count INT NOT NULL,
    options_per_question INT NOT NULL,
    exam_id INT NOT NULL,
    PRIMARY KEY(question_id),
    CONSTRAINT fk_exam FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);


CREATE TABLE IF NOT EXISTS options (
    option_id INT NOT NULL AUTO_INCREMENT,
    option_count INT NOT NULL,
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






-- for primary keys change 
-- ALTER TABLE exams ADD CONSTRAINT pk_exam PRIMARY KEY (exam_id);















-- adding primary keys
-- Step 1: Drop the existing primary key
--ALTER TABLE exams
--DROP PRIMARY KEY;
-- Step 2: Add a composite primary key (exam_id, exam_name)
--ALTER TABLE exams
--ADD CONSTRAINT pk_exam PRIMARY KEY (exam_id, exam_name);
--ALTER TABLE exams ADD PRIMARY KEY(exam_id,exam_name);

--all constrains ..
-- SELECT 
--    CONSTRAINT_NAME,
--    CONSTRAINT_TYPE,
--    TABLE_NAME
--FROM 
--    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
--WHERE 
--    TABLE_NAME = 'exams';  -- Replace 'exams' with your table name




--To drop a DEFAULT constraint, use the following SQL:

--ALTER TABLE table_name
-- ALTER colum_name DROP DEFAULT;