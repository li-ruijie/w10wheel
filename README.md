# W10Wheel.NET

Fork of [ykon/w10wheel.net](https://github.com/ykon/w10wheel.net) with crash fixes and improvements.

W10Wheel.NET is the Mouse Wheel Simulator for Windows 10.
[W10Wheel (Java Edition)](https://github.com/ykon/w10wheel) ported to .NET Framework.

## Installation

Download the latest release from [Releases](https://github.com/li-ruijie/w10wheel/releases).

## Requirements

- Windows 10/11
- .NET Framework 4.8.1 or later

### Windows 8.1

Requires software to enable scroll inactive windows, such as [WizMouse](http://antibody-software.com/web/software/software/wizmouse-makes-your-mouse-wheel-work-on-the-window-under-the-mouse/).

### Windows 10/11

Enable "Scroll inactive windows when I hover over them" in Settings > Devices > Mouse.

## Version History

### v2.8.0 (2026-01-25)

**Crash Fixes:**
- Fixed crashes during Windows shutdown/logoff
- Wrapped `SessionEnding` handler in try-catch
- Added `TypeInitializationException` and `SEHException` handling
- Cached F# union case names to prevent reflection failures

**Improvements:**
- Upgraded to .NET Framework 4.8.1
- Replaced deprecated F# ref cell operators
- Added `dragThreshold` setting

### v2.7.3 (2021-02-07)

Original upstream release by Yuki Ono.

## Usage

Run `W10Wheel.exe`. The application will appear in the system tray.

- **Right-click** the tray icon to access settings and options
- **Double-click** the tray icon to toggle Pass Mode (disable/enable scrolling)

For detailed usage, see the [Wiki](https://github.com/ykon/w10wheel.net/wiki).

## Command Line Parameters

```
┌─────────────────────┬─────────────────────────────────────────────────────────┐
│ Parameter           │ Description                                             │
├─────────────────────┼─────────────────────────────────────────────────────────┤
│ --sendExit          │ Send exit signal to running instance                    │
├─────────────────────┼─────────────────────────────────────────────────────────┤
│ --sendPassMode      │ Toggle pass mode (add true/false to set specific state) │
├─────────────────────┼─────────────────────────────────────────────────────────┤
│ --sendReloadProp    │ Reload properties file in running instance              │
├─────────────────────┼─────────────────────────────────────────────────────────┤
│ --sendInitState     │ Reset internal state of running instance                │
├─────────────────────┼─────────────────────────────────────────────────────────┤
│ <name>              │ Load named properties file on startup                   │
└─────────────────────┴─────────────────────────────────────────────────────────┘
```

**Examples:**
```
W10Wheel.exe --sendExit           # Close running instance
W10Wheel.exe --sendPassMode true  # Enable pass mode
W10Wheel.exe --sendPassMode false # Disable pass mode
W10Wheel.exe --sendReloadProp     # Reload current properties
W10Wheel.exe MyProfile            # Start with "MyProfile" properties
```

## Settings

Settings are stored in `.W10Wheel.properties` in the user profile directory (`%USERPROFILE%`).

Named profiles are stored as `.W10Wheel.<name>.properties`.

### Trigger Settings

The trigger determines how scroll mode is activated.

```
┌─────────────┬────────────────────────────────────────────────────────────────┐
│ Trigger     │ Description                                                    │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ LR          │ Press Left then Right (or Right then Left) mouse button        │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ Left        │ Press Left then Right mouse button                             │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ Right       │ Press Right then Left mouse button                             │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ Middle      │ Press Middle mouse button                                      │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ X1          │ Press X1 (Back) mouse button                                   │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ X2          │ Press X2 (Forward) mouse button                                │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ LeftDrag    │ Hold Left button and drag                                      │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ RightDrag   │ Hold Right button and drag                                     │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ MiddleDrag  │ Hold Middle button and drag                                    │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ X1Drag      │ Hold X1 button and drag                                        │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ X2Drag      │ Hold X2 button and drag                                        │
├─────────────┼────────────────────────────────────────────────────────────────┤
│ None        │ Disable mouse triggers (use keyboard trigger only)             │
└─────────────┴────────────────────────────────────────────────────────────────┘
```

**Property:** `firstTrigger` (default: `LR`)

### Keyboard Trigger

Enable keyboard-based scroll activation using a specific key.

```
┌───────────────┬──────────────────────────────────────────────────────────────┐
│ Property      │ Description                                                  │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ keyboardHook  │ Enable keyboard trigger (true/false, default: false)         │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ targetVKCode  │ Key to use as trigger (default: VK_NONCONVERT)               │
└───────────────┴──────────────────────────────────────────────────────────────┘
```

**Available keys:** `VK_TAB`, `VK_PAUSE`, `VK_CAPITAL`, `VK_CONVERT`, `VK_NONCONVERT`, `VK_PRIOR`, `VK_NEXT`, `VK_END`, `VK_HOME`, `VK_SNAPSHOT`, `VK_INSERT`, `VK_DELETE`, `VK_LWIN`, `VK_RWIN`, `VK_APPS`, `VK_NUMLOCK`, `VK_SCROLL`, `VK_LSHIFT`, `VK_RSHIFT`, `VK_LCONTROL`, `VK_RCONTROL`, `VK_LMENU`, `VK_RMENU`, `None`

### Number Settings

```
┌─────────────────────┬─────────┬───────┬────────────────────────────────────────┐
│ Property            │ Default │ Range │ Description                            │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ pollTimeout         │ 200     │ 50-500│ Polling interval in milliseconds       │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ scrollLocktime      │ 200     │150-500│ Time before scroll mode can exit (ms)  │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ verticalThreshold   │ 0       │ 0-500 │ Minimum vertical movement to scroll    │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ horizontalThreshold │ 75      │ 0-500 │ Minimum horizontal movement to scroll  │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ dragThreshold       │ 0       │ 0-500 │ Minimum movement before drag triggers  │
│                     │         │       │ activate (prevents accidental scrolls) │
└─────────────────────┴─────────┴───────┴────────────────────────────────────────┘
```

### Boolean Settings

```
┌─────────────────────┬─────────┬──────────────────────────────────────────────────┐
│ Property            │ Default │ Description                                      │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ cursorChange        │ true    │ Change cursor icon during scroll mode            │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ horizontalScroll    │ true    │ Enable horizontal scrolling                      │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ reverseScroll       │ false   │ Reverse scroll direction (flip)                  │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ swapScroll          │ false   │ Swap vertical and horizontal scroll axes         │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ sendMiddleClick     │ false   │ Send middle click when single trigger released   │
│                     │         │ quickly (only for single-button triggers)        │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ draggedLock         │ false   │ Lock scroll mode after drag (only for drag       │
│                     │         │ triggers)                                        │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ passMode            │ false   │ Disable all scroll functionality temporarily     │
└─────────────────────┴─────────┴──────────────────────────────────────────────────┘
```

### Acceleration Table

Control scroll speed acceleration based on mouse movement speed.

```
┌─────────────────────┬─────────┬──────────────────────────────────────────────────┐
│ Property            │ Default │ Description                                      │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ accelTable          │ true    │ Enable acceleration table                        │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ accelMultiplier     │ M5      │ Acceleration multiplier preset                   │
├─────────────────────┼─────────┼──────────────────────────────────────────────────┤
│ customAccelTable    │ false   │ Use custom acceleration values                   │
└─────────────────────┴─────────┴──────────────────────────────────────────────────┘
```

**Multiplier presets** (based on MouseWorks by Kensington):

```
┌──────┬─────────────────────────────────────────────────────────────────────────┐
│ Name │ Multiplier range                                                        │
├──────┼─────────────────────────────────────────────────────────────────────────┤
│ M5   │ 1.0, 1.3, 1.7, 2.0, 2.4, 2.7, 3.1, 3.4, 3.8, 4.1, 4.5, 4.8              │
├──────┼─────────────────────────────────────────────────────────────────────────┤
│ M6   │ 1.2, 1.6, 2.0, 2.4, 2.8, 3.3, 3.7, 4.1, 4.5, 4.9, 5.4, 5.8              │
├──────┼─────────────────────────────────────────────────────────────────────────┤
│ M7   │ 1.4, 1.8, 2.3, 2.8, 3.3, 3.8, 4.3, 4.8, 5.3, 5.8, 6.3, 6.7              │
├──────┼─────────────────────────────────────────────────────────────────────────┤
│ M8   │ 1.6, 2.1, 2.7, 3.2, 3.8, 4.4, 4.9, 5.5, 6.0, 6.6, 7.2, 7.7              │
├──────┼─────────────────────────────────────────────────────────────────────────┤
│ M9   │ 1.8, 2.4, 3.0, 3.6, 4.3, 4.9, 5.5, 6.2, 6.8, 7.4, 8.1, 8.7              │
└──────┴─────────────────────────────────────────────────────────────────────────┘
```

**Custom acceleration:** Set `customAccelThreshold` (int array) and `customAccelMultiplier` (double array) in the properties file.

### Real Wheel Mode

Simulate actual mouse wheel events instead of scroll commands.

```
┌───────────────┬─────────┬───────┬────────────────────────────────────────────────┐
│ Property      │ Default │ Range │ Description                                    │
├───────────────┼─────────┼───────┼────────────────────────────────────────────────┤
│ realWheelMode │ false   │  -    │ Enable real wheel event simulation             │
├───────────────┼─────────┼───────┼────────────────────────────────────────────────┤
│ wheelDelta    │ 120     │10-500 │ Wheel delta value per scroll event             │
├───────────────┼─────────┼───────┼────────────────────────────────────────────────┤
│ vWheelMove    │ 60      │10-500 │ Vertical movement needed per wheel event       │
├───────────────┼─────────┼───────┼────────────────────────────────────────────────┤
│ hWheelMove    │ 60      │10-500 │ Horizontal movement needed per wheel event     │
├───────────────┼─────────┼───────┼────────────────────────────────────────────────┤
│ quickFirst    │ false   │  -    │ Send first wheel event immediately             │
├───────────────┼─────────┼───────┼────────────────────────────────────────────────┤
│ quickTurn     │ false   │  -    │ Respond faster to direction changes            │
└───────────────┴─────────┴───────┴────────────────────────────────────────────────┘
```

### VH Adjuster

Fine-tune vertical/horizontal scroll direction detection.

```
┌─────────────────────┬─────────┬───────┬────────────────────────────────────────┐
│ Property            │ Default │ Range │ Description                            │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ vhAdjusterMode      │ false   │  -    │ Enable VH adjuster (requires           │
│                     │         │       │ horizontalScroll enabled)              │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ vhAdjusterMethod    │Switching│  -    │ Method: Fixed or Switching             │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ firstPreferVertical │ true    │  -    │ Prefer vertical scroll on initial move │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ firstMinThreshold   │ 5       │ 1-10  │ Minimum movement for direction detect  │
├─────────────────────┼─────────┼───────┼────────────────────────────────────────┤
│ switchingThreshold  │ 50      │10-500 │ Movement needed to switch direction    │
└─────────────────────┴─────────┴───────┴────────────────────────────────────────┘
```

### Process Priority

```
┌──────────────┬────────────────────────────────────────────────────────────────┐
│ Priority     │ Description                                                    │
├──────────────┼────────────────────────────────────────────────────────────────┤
│ High         │ High priority (may affect system responsiveness)               │
├──────────────┼────────────────────────────────────────────────────────────────┤
│ AboveNormal  │ Above normal priority (default, recommended)                   │
├──────────────┼────────────────────────────────────────────────────────────────┤
│ Normal       │ Normal priority                                                │
└──────────────┴────────────────────────────────────────────────────────────────┘
```

**Property:** `processPriority` (default: `AboveNormal`)

### Language

**Property:** `uiLanguage` (values: `en`, `ja`)

## Example Properties File

```properties
# Trigger configuration
firstTrigger=Middle
sendMiddleClick=true

# Scroll behavior
cursorChange=true
horizontalScroll=true
reverseScroll=false
swapScroll=false

# Timing
pollTimeout=200
scrollLocktime=200
dragThreshold=5

# Thresholds
verticalThreshold=0
horizontalThreshold=75

# Acceleration
accelTable=true
accelMultiplier=M6

# Real wheel mode (disabled)
realWheelMode=false
wheelDelta=120
vWheelMove=60
hWheelMove=60

# System
processPriority=AboveNormal
uiLanguage=en
```

## Building

```
msbuild W10Wheel.sln /p:Configuration=Release
```

Output: `W10Wheel/bin/Release/W10Wheel.exe`

## License

The MIT License

## Credits

- **Original Author:** Yuki Ono (2016-2021)
- **Fork Maintainer:** Li Ruijie (2026-)
