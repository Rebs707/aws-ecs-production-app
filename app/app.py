from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from AWS ECS!"

@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "service": "aws-ecs-production-app"
    }), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
