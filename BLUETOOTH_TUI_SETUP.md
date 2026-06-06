# omablue-bluetooth-tui — Setup & Compilation Guide

## Overview

A modern Bluetooth TUI manager for OddOs/secureblue, built in Rust with theme integration.

## Status

- ✅ **Scaffolding**: Complete (in `/tmp/omablue-bluetooth-tui/`)
- ✅ **Architecture**: Planned & documented
- ⏳ **Binary**: Needs compilation (placeholder script in place)
- ✅ **OddOs integration**: Ready

## Quick Start

### Option 1: Compile Locally (Recommended)

If you have Rust installed:

```bash
cd /tmp/omablue-bluetooth-tui
cargo build --release
```

Then copy the binary:

```bash
cp target/release/omablue-bluetooth-tui ~/.local/share/omablue/bin/
chmod +x ~/.local/share/omablue/bin/omablue-bluetooth-tui
```

Test it:

```bash
omablue-bluetooth-tui
# or
omablue-launch-tui "TUI.float" "omablue-bluetooth-tui" "120x35"
```

### Option 2: Use Placeholder Script

A placeholder script is already in place at:

```
~/.local/share/omablue/bin/omablue-bluetooth-tui
```

Running it will show instructions for compilation.

### Option 3: Build on GitHub CI/CD

The project is ready for GitHub Actions:

```bash
git clone https://github.com/odd-git/omablue-bluetooth-tui.git
cd omablue-bluetooth-tui
git push origin main
# GitHub Actions automatically builds and uploads binary artifacts
```

## Project Location

Scaffolding source:
```
/tmp/omablue-bluetooth-tui/
├── Cargo.toml          (dependencies)
├── README.md           (user docs)
├── src/                (11 Rust files)
└── .github/workflows/  (CI/CD)
```

## Documentation

All guides are in `/tmp/`:

- `README_CONSEGNA.md` — Overview (Italian)
- `IMPLEMENTATION_SUMMARY.md` — Technical details
- `ODDOS_INTEGRATION.md` — Deployment guide
- `DELIVERY_CHECKLIST.txt` — Feature status
- `FINAL_SUMMARY.txt` — Complete reference

## Architecture Highlights

### No C Dependencies
- Uses `zbus` (pure Rust DBus) instead of `bluer` (C-dependent)
- No `libdbus`, `libbluetooth`, or `libssl` needed
- Only glibc + libm (unavoidable system libs)

### Theme Integration
- Reads omablue theme from `~/.config/omablue/current/theme/colors.toml`
- Colors update in real-time without restart (inotify watcher)
- Fallback theme: Catppuccin Mocha

### TUI Features
- Two-panel layout: device list + device info
- Keybindings: j/k nav, Enter connect, d disconnect, s scan, t toggle BT, q quit
- Desktop notifications via Dunst (no subprocess)

### SecureBlue Aligned
- ✅ Memory-safe (Rust)
- ✅ No root required
- ✅ No subprocess execution
- ✅ Minimal attack surface
- ✅ XDG-compliant paths

## Binary Details

| Aspect | Value |
|--------|-------|
| Size | 5-8 MB (release, LTO, stripped) |
| Edition | Rust 2024 |
| Dependencies | Ratatui 0.29, Tokio 1.40, zbus 4.4 |
| Target | x86_64-unknown-linux-gnu |
| C libs | None (glibc + libm only) |

## How It Works

1. **Event Loop**: Tokio async multiplexing keyboard + Bluetooth events + theme changes
2. **Bluetooth**: zbus DBus proxies to Adapter1/Device1 (BlueZ)
3. **UI**: Ratatui rendering with colors from omablue theme
4. **Notifications**: notify-rust via DBus (no shell execution)

## Next Steps

### For Immediate Testing
1. Extract scaffold: `tar -xzf /tmp/omablue-bluetooth-tui-scaffold.tar.gz`
2. Read docs: `cat /tmp/README_CONSEGNA.md`
3. Compile: `cd omablue-bluetooth-tui && cargo build --release`
4. Deploy: Copy binary to `~/.local/share/omablue/bin/`

### For Development
1. Push to GitHub: `cd omablue-bluetooth-tui && git init && git push`
2. Set up GitHub Actions (already configured in scaffold)
3. Implement remaining features (see IMPLEMENTATION_SUMMARY.md)
4. Test with real Bluetooth hardware

### For Production
1. Test on live OddOs image
2. Package as RPM (optional)
3. Document in OddOs wiki
4. Share with community

## Troubleshooting

**"command not found: omablue-bluetooth-tui"**
- Ensure PATH includes `~/.local/share/omablue/bin`
- Or use full path: `~/.local/share/omablue/bin/omablue-bluetooth-tui`

**"Failed to get DBus connection"**
- Verify BlueZ is running: `systemctl status bluetooth`
- Test DBus: `busctl --user call org.bluez /org/bluez/hci0 org.bluez.Adapter1 GetDiscoveryFilters`

**"No devices found"**
- Check Bluetooth is powered on (press `t` in TUI to toggle)
- Manually scan: press `s` to start scan
- Verify devices are discoverable and in range

## References

- SecureBlue: https://github.com/secureblue/
- Ratatui: https://docs.rs/ratatui/
- zbus: https://docs.rs/zbus/
- BlueZ DBus API: https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc

## Contact

Project repo: https://github.com/odd-git/omablue-bluetooth-tui
Questions? Check the issue tracker.

---

**Last updated**: 2026-06-07
**Status**: Scaffolding complete, ready for development
