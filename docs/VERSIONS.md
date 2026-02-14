# Version Notes

This file keeps a short, trackable summary of changes made in each release.
When a new version is published, add a new section at the top and keep previous sections intact.

## Update Guidelines

- Add a `## [x.y.z] - YYYY-MM-DD` heading at the top for each new release.
- Use the following categories: `Added`, `Changed`, `Fixed`, `Removed`.
- Focus on user-facing changes whenever possible.
- Include a release link at the end of each version section.

---

## [1.1.0] - 2026-02-14

### Added

- Root-task shell script hardened with strict command allowlist (only `dnf`, `grubby`, `dracut`, `systemctl`, `modprobe`, `timeshift` permitted)
- Kernel version compatibility check (`is_version_compatible()`) before driver installation
- 23 unit tests across `updater`, `detector`, `command`, and `i18n` modules
- MSRV 1.82 verification job in CI pipeline
- SECURITY.md responsible disclosure policy
- `.dockerignore` to keep container builds lean
- `parse_locale()` pure function for testable locale detection without environment variable side effects

### Changed

- Dockerfile upgraded from Fedora 41 to Fedora 42 with multi-stage build and `rustup`-based toolchain
- Flatpak manifest updated with `--release` build flag and Qt6 modules
- i18n tests rewritten to avoid `std::env::set_var` (safe for parallel execution on Rust 1.88+)
- `rust-toolchain.toml` documented in BUILDING.md
- Config URLs corrected to use `ro-Control` (capital C) consistently

### Fixed

- `po/POTFILES.in` paths corrected to match current source tree
- Metainfo XML URLs and screenshot paths fixed for Flathub validation
- CI format and test failures resolved (cargo fmt, thread-safe tests)

### Removed

- Unused dependencies: `env_logger`, `open`
- Environment-variable-dependent i18n tests replaced with pure function tests

Release: [v1.1.0](https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-Control/releases/tag/v1.1.0)

---

## [1.0.0] - 2026-02-14

### Added

- New desktop architecture built with Rust + Qt6 (CXX-Qt)
- NVIDIA driver install / uninstall workflows via RPM Fusion
- Express and Expert installation modes
- Live GPU / CPU / RAM performance monitoring dashboard
- Secure Boot detection and warning flow
- Automatic update checking via GitHub Releases API
- Feral GameMode one-click installation
- Flatpak / Steam permission repair utility
- NVIDIA Wayland fix (`nvidia-drm.modeset=1` via GRUB)
- Hybrid graphics switching (NVIDIA / Intel / On-Demand)
- PolicyKit integration for secure privilege escalation
- Timeshift snapshot creation before driver operations
- English and Turkish bilingual interface

### Changed

- Fedora / RPM Fusion–focused driver management
- Improved readability and layout across all UI components
- Simplified QML page structure (Install / Expert / Performance / Progress)
- Initramfs regeneration uses `dracut` (Fedora-native)
- Desktop entry and metainfo follow latest FreeDesktop standards

### Fixed

- Qt/QML startup errors and type/import mismatches resolved
- Logger initialization API incompatibility resolved

### Removed

- Legacy web UI artifacts (React/Vite)
- Unused platform and scenario dependencies
- Debian `.deb` packaging (replaced by `.rpm`)

Release: [v1.0.0](https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-Control/releases/tag/v1.0.0)

---

## Template

```markdown
## [x.y.z] - YYYY-MM-DD

### Added

- ...

### Changed

- ...

### Fixed

- ...

### Removed

- ...

Release: https://github.com/Acik-Kaynak-Gelistirme-Toplulugu/ro-Control/releases/tag/vx.y.z
```
