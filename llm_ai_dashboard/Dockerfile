ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Build arguments for LLM AI Dashboard source repository
ARG LLM_REPO=https://github.com/double-em/llm-hass-app.git
ARG LLM_BRANCH=main

# Install system dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    git

# Set working directory
WORKDIR /app

# Clone the source repository
RUN git clone --depth 1 --branch ${LLM_BRANCH} ${LLM_REPO} /tmp/llm-hass-app

# Install Python dependencies from source
RUN pip3 install --no-cache-dir --break-system-packages \
    flask \
    requests \
    torch \
    torchaudio \
    omnivoice \
    resemblyzer \
    numpy \
    chromadb \
    sentence-transformers \
    websockets

# Copy application files from source
RUN cp -r /tmp/llm-hass-app/* /app/ 2>/dev/null || true

# Create voices directory
RUN mkdir -p /data/voices

# Copy run script
COPY run.sh /app/run.sh
RUN chmod a+x /app/run.sh

# Clean up git and temporary files
RUN rm -rf /tmp/llm-hass-app

# Set labels
LABEL \
    io.hass.name="LLM AI Dashboard" \
    io.hass.description="AI Provider management, voice cloning, TTS, and AI memory for Home Assistant" \
    io.hass.type="addon" \
    io.hass.version="0.1.0"

CMD [ "/app/run.sh" ]
