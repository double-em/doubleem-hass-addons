#!/usr/bin/with-contenv bashio

echo "Starting LLM AI Dashboard..."

# Start the Flask app as non-root user
cd /app
exec su-exec appuser python3 app.py --host 0.0.0.0 --port 8000
