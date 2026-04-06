#!/usr/bin/with-contenv bashio
set -e

bashio::log.info "Starting eTRV MQTT Bridge..."

# Configuration file path (provided by Home Assistant)
CONFIG_PATH="/data/options.json"

# Check if configuration exists
if ! bashio::fs.file_exists "${CONFIG_PATH}"; then
    bashio::log.error "Configuration file not found at ${CONFIG_PATH}"
    exit 1
fi

bashio::log.info "Configuration file: ${CONFIG_PATH}"

# Log some configuration details (without secrets)
MQTT_SERVER=$(bashio::config 'mqtt.server')
POLL_INTERVAL=$(bashio::config 'options.poll_interval')
bashio::log.info "MQTT Server: ${MQTT_SERVER}"
bashio::log.info "Poll Interval: ${POLL_INTERVAL}s"

# Count thermostats
THERMOSTAT_COUNT=$(bashio::config 'thermostats | length')
bashio::log.info "Configured thermostats: ${THERMOSTAT_COUNT}"

# Start the application
bashio::log.info "Starting etrv2mqtt daemon..."
exec python3 -m etrv2mqtt.cli "${CONFIG_PATH}"
