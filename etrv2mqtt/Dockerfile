ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Build arguments for etrv repository
ARG ETRV_REPO=https://github.com/double-em/etrv.git
ARG ETRV_BRANCH=main

# Install system dependencies for Bluetooth, Python, and git
RUN apk add --no-cache \
    python3 \
    py3-pip \
    bluez \
    bluez-libs \
    dbus \
    git

# Set working directory
WORKDIR /app

# Clone the etrv repository to get dependencies
RUN git clone --depth 1 --branch ${ETRV_BRANCH} ${ETRV_REPO} /tmp/etrv

# Debug: List repository structure
RUN echo "Repository structure:" && \
    ls -la /tmp/etrv/ && \
    echo "Checking for packages directory:" && \
    ls -la /tmp/etrv/packages/ || echo "No packages directory found"

# Install Python packages from the cloned repository (packages are in packages/ subdirectory)
RUN pip3 install --no-cache-dir --break-system-packages \
    /tmp/etrv/packages/libetrv \
    /tmp/etrv/packages/etrv2mqtt

# Clean up git and temporary files to reduce image size
RUN apk del git && \
    rm -rf /tmp/etrv

# Copy run script from addon directory
COPY run.sh /
RUN chmod a+x /run.sh

# Set labels
LABEL \
    io.hass.name="eTRV MQTT Bridge" \
    io.hass.description="MQTT bridge for Danfoss Eco Bluetooth thermostats" \
    io.hass.type="addon" \
    io.hass.version="1.0.0"

CMD [ "/run.sh" ]
