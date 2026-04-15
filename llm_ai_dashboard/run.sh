#!/bin/bash
set -e

echo "Starting LLM AI Dashboard..."

# Ensure /data subdirectories exist and are writable by appuser
# (HA supervisor may mount /data as root, blocking appuser writes)
if [ -d /data ]; then
    echo "Setting up /data directories..."
    mkdir -p /data/voices /data/persons /data/samples /data/memory /data/sessions /data/voiceprints /data/enrollments 2>/dev/null || true
    chmod -R 777 /data 2>/dev/null || true
fi

# Ensure app directory is writable
chown -R appuser:appuser /app 2>&1 || true

# Drop to appuser and start Flask
echo "Starting Flask app as $(whoami)..."
exec su -s /bin/bash -c 'cd /app && exec python3 app.py --host 0.0.0.0 --port 8099' appuser