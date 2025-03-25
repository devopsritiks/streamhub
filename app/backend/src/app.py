from flask import Flask, jsonify
from config import VIDEO_DATA

app = Flask(__name__)

@app.route('/videos', methods=['GET'])
def get_videos():
    return jsonify(VIDEO_DATA)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
