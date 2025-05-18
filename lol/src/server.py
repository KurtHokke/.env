from flask import Flask, jsonify
import json

app = Flask(__name__)

# Define the endpoint
@app.route('/liveclientdata/allgamedata')
def serve_game_data():
    try:
        # Read the JSON file
        with open('res/allgamedataOTHER0.json', 'r') as file:
            data = json.load(file)
        return jsonify(data)  # Return JSON response
    except FileNotFoundError:
        return jsonify({"error": "JSON file not found"}), 404
    except json.JSONDecodeError:
        return jsonify({"error": "Invalid JSON format"}), 500

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=2999, debug=True, ssl_context=('cert.pem', 'key.pem'))
