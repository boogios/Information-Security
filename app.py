# app.py
from flask import Flask, jsonify, request
import subprocess

app = Flask(__name__)

# 초기 후보자 목록 및 투표 결과
candidates = {'Candidate A': 0, 'Candidate B': 0, 'Candidate C': 0}

def decrypt_data(encrypted_data):
    # C++ 프로그램을 실행하여 복호화
    process = subprocess.Popen(['./decrypt', encrypted_data], stdout=subprocess.PIPE)
    output, _ = process.communicate()
    return output.decode('utf-8')


@app.route('/vote', methods=['POST'])
def vote():
    data = request.json
    encrypted_candidate = data.get('candidate')
    encrypted_name = data.get('name')
    encrypted_ssn = data.get('ssn')
    
    # 데이터 복호화
    candidate = decrypt_data(encrypted_candidate)
    name = decrypt_data(encrypted_name)
    ssn = decrypt_data(encrypted_ssn)

    if candidate and candidate in candidates:
        candidates[candidate] += 1
        return jsonify({'message': 'Vote for {} successfully recorded.'.format(candidate)})
    else:
        return jsonify({'error': 'Invalid candidate or candidate not specified.'}), 400

@app.route('/result', methods=['GET'])
def result():
    return jsonify(candidates)

if __name__ == '__main__':
    app.run(debug=True)
