#!/bin/bash
set -e

echo "Starting LLM AI Dashboard..."

# Ensure /data subdirectories exist and are writable.
# HA supervisor mounts /data as root:root mode 0755 over the image's /data.
# The chmod here runs AS ROOT (before any USER switch) so it actually works
# on the supervisor mount point. chmod 777 makes the dirs traversable+writable
# by whichever user the image eventually runs as.
if [ -d /data ]; then
    echo "Setting up /data directories..."
    for subdir in voices persons samples memory sessions voiceprints enrollments vector_memory; do
        mkdir -p "/data/${subdir}" 2>/dev/null || true
    done
    chmod -R 777 /data 2>/dev/null || true
fi

# Ensure app directory is writable
chown -R root:root /app 2>&1 || true

# Start Flask as root (the published image now runs without USER switch;
# if it still switches to appuser the dirs are already 777 so it works)
echo "Starting Flask app as $(whoami)..."
cd /app
exec python3 app.py --host 0.0.0.0 --port 8099
