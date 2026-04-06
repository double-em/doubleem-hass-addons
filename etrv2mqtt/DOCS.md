# eTRV MQTT Bridge Add-on

## About

This add-on provides MQTT integration for Danfoss Eco Bluetooth thermostats, enabling seamless control through Home Assistant.

The bridge automatically discovers your thermostats and publishes them to Home Assistant via MQTT with full climate entity support.

## Features

- **Automatic MQTT Discovery** - Devices appear in Home Assistant automatically
- **Temperature Control** - Set target temperature via Home Assistant UI
- **Battery Monitoring** - Track battery levels
- **Multiple Devices** - Support for multiple thermostats
- **Reliable Polling** - Configurable polling intervals
- **Room Temperature** - Optional room temperature reporting

## Prerequisites

1. **MQTT Broker** - Install the Mosquitto broker add-on or use external MQTT server
2. **Bluetooth Adapter** - Raspberry Pi or other device with Bluetooth
3. **Paired Devices** - Devices must be paired and secret keys retrieved

## Configuration

### Pairing Devices First

Before configuring this add-on, you need to retrieve the secret key for each device:

1. **Put device in pairing mode**:
   - Press and hold the button on the eTRV until it shows pairing symbols

2. **Get the secret key**:
   - Use the `etrvcli` tool (see monorepo documentation)
   - Or use a Bluetooth scanner with the `libetrv2` Python library

3. **Note the device address and secret key** for configuration

### MQTT Configuration

If using the Mosquitto broker add-on, use these settings:

```yaml
mqtt:
  server: "core-mosquitto"  # Internal add-on hostname
  port: 1883
  user: ""                  # Leave empty if no auth
  password: ""              # Leave empty if no auth
  base_topic: "homeassistant"
  autodiscovery: true
  autodiscovery_topic: "homeassistant"
```

For external MQTT brokers, update `server` to your broker's hostname/IP.

### Thermostat Configuration

Add each thermostat to the `thermostats` array:

```yaml
thermostats:
  - topic: "living_room"
    address: "AA:BB:CC:DD:EE:FF"
    secret_key: "0123456789abcdef0123456789abcdef"
  - topic: "bedroom"
    address: "11:22:33:44:55:66"
    secret_key: "abcdef0123456789abcdef0123456789"
```

**Fields:**
- `topic`: Unique identifier for MQTT topics (use room name)
- `address`: Bluetooth MAC address (format: AA:BB:CC:DD:EE:FF)
- `secret_key`: 32-character hex string obtained during pairing

### Options

Configure polling and behavior:

```yaml
options:
  retry_limit: 5              # Connection retry attempts
  poll_interval: 300          # Polling interval in seconds (300 = 5 min)
  stay_connected: false       # Keep BLE connection open (uses more battery)
  report_room_temperature: true   # Report current room temperature
  setpoint_debounce_time: 5   # Delay before applying temperature changes
```

## Example Complete Configuration

```yaml
mqtt:
  server: "core-mosquitto"
  port: 1883
  base_topic: "homeassistant"
  autodiscovery: true
  autodiscovery_topic: "homeassistant"
options:
  retry_limit: 5
  poll_interval: 300
  stay_connected: false
  report_room_temperature: true
  setpoint_debounce_time: 5
thermostats:
  - topic: "living_room"
    address: "AA:BB:CC:DD:EE:FF"
    secret_key: "your_secret_key_here"
```

## Usage

### After Installation

1. Configure the add-on (see above)
2. Start the add-on
3. Thermostats will automatically appear in Home Assistant as climate entities:
   - `climate.living_room`
   - `climate.bedroom`
   - etc.

### Controlling Thermostats

Use Home Assistant UI:
- Navigate to **Settings** > **Devices & Services** > **MQTT**
- Find your thermostats
- Set target temperature
- View current temperature and battery level

### Troubleshooting

**Add-on won't start:**
- Check logs for errors
- Verify Bluetooth adapter is available
- Ensure MQTT broker is running

**Devices not appearing:**
- Check MQTT broker connection
- Verify secret keys are correct
- Try restarting the add-on
- Check autodiscovery is enabled

**Connection errors:**
- Devices sleep to save battery (this is normal)
- Move closer to devices
- Check battery levels
- Press device button to wake

**See logs:**
- Go to add-on **Log** tab
- Enable debug logging if needed

## Support

- [GitHub Issues](https://github.com/double-em/etrv-homeassistant-addons/issues)
- [Main Repository](https://github.com/double-em/etrv)

## Technical Details

- **Base Image**: Home Assistant Python base image (Alpine Linux)
- **Python Version**: 3.11+
- **Architecture Support**: aarch64, amd64, armhf, armv7, i386
- **Bluetooth**: Requires host Bluetooth adapter access
- **Network**: Uses host network mode for Bluetooth

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.
