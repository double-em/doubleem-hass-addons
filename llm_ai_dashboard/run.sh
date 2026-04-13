#!/bin/bash
set -e

echo "Starting LLM AI Dashboard..."

# Fix /data permissions if mounted as root (HA supervisor behavior)
# This must happen before we drop privileges
if [ -d /data ]; then
    echo "Fixing /data permissions..."
    mkdir -p /data/voices /data/persons /data/samples /data/memory
    chown -R appuser:appuser /data 2>&1 || echo "Warning: could not chown /data (may already be correct)"
fi

# Ensure app directory is writable
chown -R appuser:appuser /app 2>&1 || true

# Drop to appuser and start Flask
echo "Starting Flask app as $(whoami)..."
exec su -s /bin/bash -c 'cd /app && exec python3 app.py --host 0.0.0.0 --port 8000' appuser