from flask import Flask, request, jsonify
import os
import check
import mysql.connector
from mysql.connector import Error, IntegrityError

app = Flask(__name__)

UPLOAD_FOLDER = './uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Database connection configuration
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'moji_main'
}

def get_db_connection():
    return mysql.connector.connect(**DB_CONFIG)

@app.route('/home', methods=['GET'])
def home():
    return "Server is running"

@app.route('/getomr', methods=['POST'])
def get_omr():
    try:
        # Check if the image file is in the request
        if 'image' not in request.files:
            return jsonify({'error': 'No image file found in the request'}), 400

        image_file = request.files['image']

        # Ensure the uploaded file has a filename
        if image_file.filename == '':
            return jsonify({'error': 'No selected file'}), 400

        # Check if the request is JSON or Form-data
        if request.is_json:
            data = request.get_json()  # Use .get_json() for JSON data
        else:
            data = request.form  # Use .form for form-data

        # Get examId from the data (handling both JSON and form data)
        exam_id = data.get('examId') if data else None
        if not exam_id:
            return jsonify({'error': 'Exam ID is required'}), 400

        # Save the file temporarily
        image_path = os.path.join(app.config['UPLOAD_FOLDER'], image_file.filename)
        image_file.save(image_path)

        # Process the OMR image
        answers = check.check(image_path)
        
        # Establish DB connection
        db_connection = get_db_connection()
        cursor = db_connection.cursor()

        # Query the exam table for the question count based on examId
        cursor.execute("SELECT question_count FROM exams WHERE exam_id = %s", (exam_id,))
        exam_data = cursor.fetchone()
        if not exam_data:
            return jsonify({'error': 'Exam not found'}), 404

        question_count = exam_data[0]
        print("question count ", question_count)
        
        # Query question_answers for correct answers for the examId and question_set_id = 1
        cursor.execute("""
            SELECT question_number, correct_answer 
            FROM question_answers 
            WHERE exam_id = %s AND question_set_id = 1
        """, (exam_id,))
        correct_answers_data = cursor.fetchall()

        # Create a dictionary for correct answers by question number
        correct_answers_dict = {row[0]: row[1] for row in correct_answers_data}

        correct_answers = 0
        incorrect_answers = 0

        # Iterate over the answers obtained from the OMR and compare with correct answers
        for i in range(question_count):
            omr_answer = answers[i][i + 1]  # Get the answer from the OMR image or default to -1 for missing answers
            correct_answer = correct_answers_dict.get(i + 1)  # Get the correct answer based on question number (1-based index)
            print(f"omr answer {omr_answer} : correct answer: {correct_answer}")

            if omr_answer == correct_answer:
                correct_answers += 1
            elif omr_answer == -1 or omr_answer != correct_answer:
                incorrect_answers += 1

        # Calculate grade based on correct and incorrect answers
        total_answers = correct_answers + incorrect_answers
        grade = "Fail"
        if total_answers > 0:
            grade = "Pass" if (correct_answers / total_answers) >= 0.3 else "Fail"

        # Insert the result into the results table
        try:
            cursor.execute("""
                INSERT INTO results (exam_id, serial_number, correct_answers, incorrect_answers, grade) 
                VALUES (%s, %s, %s, %s, %s)
            """, (exam_id, 1005, correct_answers, incorrect_answers, grade))  # Assuming serial_number is 1005

            db_connection.commit()
        
        except IntegrityError as e:
            if e.errno == 1062:  # Duplicate entry error code
                return jsonify({'error': 'Duplicate entry found. Result already exists for this exam and serial number.'}), 409
        
        cursor.close()
        db_connection.close()

        # Remove the uploaded image after processing
        os.remove(image_path)
        
        return jsonify({
            'message': 'Image received and processed successfully',
            'answers': answers,
            'correct_answers': correct_answers,
            'incorrect_answers': incorrect_answers,
            'grade': grade
        }), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
