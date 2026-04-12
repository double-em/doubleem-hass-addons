#!/usr/bin/with-contenv bashio

echo "Starting LLM AI Dashboard..."

# Ensure /data is writable by appuser (HA supervisor may mount with root ownership)
mkdir -p /data/voices /data/persons /data/samples /data/memory
chown -R appuser:appuser /data 2>/dev/null || true

# Start the Flask app
cd /app
exec python3 app.py --host 0.0.0.0 --port 8000
