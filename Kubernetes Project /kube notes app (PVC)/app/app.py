from flask import Flask, request
import os

app = Flask(__name__)
DATA_PATH = "/data/notes.txt"

@app.route('/')
def welcome():
    return os.getenv("WELCOME_MESSAGE", "Hello!")

@app.route('/note', methods=['POST'])
def save_note():
    note = request.form.get('note')
    with open(DATA_PATH, "a") as f:
        f.write(note + "\n")
    return "Note saved!"

@app.route('/notes', methods=['GET'])
def read_notes():
    if not os.path.exists(DATA_PATH):
        return "No notes yet."
    with open(DATA_PATH, "r") as f:
        return f.read()

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)

