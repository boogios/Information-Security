# app.py
from flask import Flask, jsonify, request

app = Flask(__name__)

# 초기 후보자 목록 및 투표 결과
candidates = {'Candidate A': 0, 'Candidate B': 0, 'Candidate C': 0}

@app.route('/vote', methods=['POST'])
def vote():
    selected_candidate = request.json.get('candidate')
    if selected_candidate and selected_candidate in candidates:
        candidates[selected_candidate] += 1
        return jsonify({'message': 'Vote for {} successfully recorded.'.format(selected_candidate)})
    else:
        return jsonify({'error': 'Invalid candidate or candidate not specified.'}), 400

@app.route('/result', methods=['GET'])
def result():
    return jsonify(candidates)

if __name__ == '__main__':
    app.run(debug=True)
