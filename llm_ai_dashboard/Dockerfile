ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Build arguments for LLM AI Dashboard source repository
ARG LLM_REPO=https://github.com/double-em/llm-hass-app.git
ARG LLM_BRANCH=main
ARG LLM_VERSION=unknown

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    git \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the source repository
RUN git clone --depth 1 --branch ${LLM_BRANCH} ${LLM_REPO} /tmp/llm-hass-app

# Install CPU-only PyTorch first (CPU-only index for Debian)
RUN pip3 install --no-cache-dir --break-system-packages --index-url https://download.pytorch.org/whl/cpu \
    torch==2.8.0 torchaudio==2.8.0

# Install Python dependencies from source
RUN pip3 install --no-cache-dir --break-system-packages \
    flask \
    requests \
    omnivoice \
    resemblyzer \
    numpy \
    chromadb \
    sentence-transformers \
    websockets

# Copy application files from source
RUN cp -r /tmp/llm-hass-app/* /app/

# Write version.py for logging
RUN echo '__version__ = "'"${LLM_VERSION}"'"' > /app/version.py

# Create non-root user and set up data directories
RUN mkdir -p /data/voices /data/persons /data/samples /data/memory && \
    useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app /data

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
    io.hass.version="${LLM_VERSION}"

USER appuser

CMD [ "/app/run.sh" ]
