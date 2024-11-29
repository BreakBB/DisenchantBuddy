# Disenchant Buddy

[![Downloads](https://img.shields.io/github/downloads/BreakBB/DisenchantBuddy/total.svg)](https://github.com/BreakBB/DisenchantBuddy/releases/)
[![Downloads Latest](https://img.shields.io/github/downloads/BreakBB/DisenchantBuddy/v0.0.2/total.svg)](https://github.com/BreakBB/DisenchantBuddy/releases/latest)

Disenchant Buddy is a lightweight World of Warcraft addon that displays disenchant results on item tooltips.
It helps players to quickly see what materials they can expect to receive from disenchanting an item.

## Installation

I suggest you use an addon manager like the [CurseForge Client](https://curseforge.overwolf.com/) to ease the installation and update process. You will find
DisenchantBuddy [here on CurseForge](https://www.curseforge.com/wow/addons/disenchantbuddy).

Alternatively you can always use [the latest GitHub release](https://github.com/BreakBB/DisenchantBuddy/releases/latest) and manually install it:

1. Extract the contents of the zip file to your World of Warcraft Interface\AddOns directory:
    - Era/HC/Anniversary: `World of Warcraft\_classic_era_\Interface\AddOns\DisenchantBuddy`
2. Restart World of Warcraft or reload your UI

## Development

### luacheck

This project uses [luacheck](https://github.com/lunarmodules/luacheck/) for linting. To run the linter, execute the following command:

```sh
luacheck -q .
```

### Unit Tests

This project uses [busted](https://github.com/lunarmodules/busted) for unit testing. To run the tests, execute the following command:

```sh
busted -p ".test.lua" .
```
