from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return """
    <h1>Welcome to DevOps Server</h1>
    <p>Application Status: <strong>Running</strong></p>
    <p>Server: <strong>devops-server</strong></p>
    <p>Project: <strong>Linux Server Monitoring Platform</strong></p>
    """

@app.route('/health')
def health():
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

