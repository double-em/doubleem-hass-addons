# Changelog

All notable changes to this add-on will be documented in this file.
## [1.4.2] - 2026-06-23

### Changed
- Version bump to 1.4.2


## [1.4.1] - 2026-06-23

### Changed
- Version bump to 1.4.1 to match the underlying `double-em/llm-hass-app` image (`ghcr.io/double-em/llm-hass-app:1.4.1` + `:latest`) which shipped today via the app repo's GitHub Actions. Without this bump the supervisor sees the addon as 1.4.0 while the pulled image is 1.4.1, causing version-mismatch warnings and unstable update detection.

### Notes
- No code changes in the wrapper itself. The ingress fix (EXPOSE 8099, `/data` writable, Flask ingress support) is already in 1.4.0 + the 1.4.1 app image. This release is purely the version-tag alignment + first GitHub release for the wrapper repo.
- Pairs with `double-em/llm-hass-app` 1.4.1.

## [1.4.0] - 2026-06-20

### Changed
- Version bump to 1.4.0
- `Dockerfile` `EXPOSE` now matches the actual Flask listen port (8099, not 8000)

### Notes
- Pairs with `double-em/llm-hass-app` 1.0.1, which adds Home Assistant
  ingress support to the Flask app and templates. Without 1.0.1, the
  ingress panel would 404 on every nav link.

## [1.3.0] - 2026-04-13

### Changed
- Version bump to 1.3.0

## [1.2.2] - 2026-04-13

### Changed
- Version bump to 1.2.2

## [1.2.1] - 2026-04-13

### Changed
- Version bump to 1.2.1


## [1.1.9] - 2026-04-13

### Changed
- Version bump to 1.1.9

## [1.1.7] - 2026-04-13

### Changed
- Version bump to 1.1.7

## [1.1.5] - 2026-04-13

### Changed
- Version bump to 1.1.5

## [1.1.2] - 2026-04-13

### Changed
- Version bump to 1.1.2

## [0.1.0] - 2025-10-11

### Added
- Initial release of LLM AI Dashboard add-on
- AI Provider management for Home Assistant
- Voice cloning functionality
- Text-to-Speech (TTS) capabilities
- AI memory integration
- Configurable default provider settings
- Adjustable voice speed and diffusion steps
