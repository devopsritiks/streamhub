# StreamHub Backend

A Flask-based API for serving video metadata and Google Drive URLs.

## Setup
1. Install dependencies: `pip install -r requirements.txt`
2. Run locally: `python src/app.py` (runs on http://localhost:5000)
3. Test endpoint: `curl http://localhost:5000/videos`

## Docker
- Build image: `docker build -t streamhub-backend .`
- Run container: `docker run -p 5000:5000 streamhub-backend`
