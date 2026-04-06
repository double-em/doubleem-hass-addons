# LLM AI Dashboard Add-on

## About

This add-on provides AI Provider management, voice cloning, and Text-to-Speech (TTS) capabilities for Home Assistant.

## Features

- **AI Provider Management** - Configure and switch between AI providers
- **Voice Cloning** - Clone voices for personalized TTS
- **Text-to-Speech** - Convert text to speech with customizable settings
- **AI Memory** - Integration with AI memory systems
- **Configurable Settings** - Adjust voice speed and diffusion steps

## Prerequisites

1. **Supported AI Provider** - Configure your AI provider credentials
2. **Network Access** - Required for API communication

## Configuration

### Basic Configuration

```yaml
options:
  default_provider: "minimax"      # Default AI provider
  default_voice_speed: 1.0          # Voice playback speed (0.5x to 2.0x)
  default_diffusion_steps: 32        # Diffusion steps for voice generation (1-100)
```

## Usage

### Accessing the Dashboard

1. Navigate to the add-on in Home Assistant
2. Access the web interface on port 8000
3. Configure AI providers and voice settings

### Text-to-Speech

Use the dashboard to:
- Select voice and language
- Adjust speech parameters
- Generate and preview audio

## Support

- [GitHub Issues](https://github.com/double-em/llm-hass-app/issues)
- [Main Repository](https://github.com/double-em/llm-hass-app)

## Technical Details

- **Base Image**: Home Assistant Python base image (Alpine Linux)
- **Python Version**: 3.11+
- **Architecture Support**: aarch64, amd64
- **Network**: Host network mode required for API access

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.
