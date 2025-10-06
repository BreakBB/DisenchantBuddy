# Disenchant Buddy

[![Downloads](https://img.shields.io/github/downloads/BreakBB/DisenchantBuddy/total.svg)](https://github.com/BreakBB/DisenchantBuddy/releases/)
[![Downloads Latest](https://img.shields.io/github/downloads/BreakBB/DisenchantBuddy/v2.1.3/total.svg)](https://github.com/BreakBB/DisenchantBuddy/releases/latest)

Disenchant Buddy is a lightweight World of Warcraft addon that displays disenchant results on item tooltips.
It helps players to quickly see what materials they can expect to receive from disenchanting an item.

When [Auctionator](https://github.com/Auctionator/Auctionator) is installed, then Disenchant Buddy will also show the auction prices for the materials.

## Compatibility

Disenchant Buddy is compatible with and available for the following World of Warcraft versions:

- Classic Era/HC/Anniversary :white_check_mark:
- Season of Discovery :white_check_mark:
- Wrath of the Lich King :white_check_mark:
- Cataclysm :white_check_mark:
- Mists of Pandaria :white_check_mark:
- Retail :x: (not planned)

## Installation

I suggest you use an addon manager like the [CurseForge Client](https://curseforge.overwolf.com/) to ease the installation and update process. You will find
DisenchantBuddy [here on CurseForge](https://www.curseforge.com/wow/addons/disenchantbuddy).

Alternatively you can always use [the latest GitHub release](https://github.com/BreakBB/DisenchantBuddy/releases/latest) and manually install it:

1. Extract the contents of the zip file to your World of Warcraft Interface\AddOns directory:
    - Era/HC/Anniversary/SoD: `World of Warcraft\_classic_era_\Interface\AddOns\DisenchantBuddy`
    - Cata and beyond: `World of Warcraft\_classic_\Interface\AddOns\DisenchantBuddy`
2. Restart World of Warcraft or reload your UI

## Development

### Installing lua

1. Install [Lua](https://www.lua.org/download.html) (5.1, since the WoW client uses Lua 5.1)
    - For macOS that is `brew install lua@5.1`
2. Install [luarocks](https://luarocks.org/)
    - For macOS that is `brew install luarocks`
3. Configure `luarocks` to use the correct Lua version (by default luarocks uses the latest installed Lua version)
    - `luarocks config lua_version 5.1`
4. Install [busted](https://github.com/lunarmodules/busted)
    - `luarocks install busted`
5. Install [luacheck](https://github.com/lunarmodules/luacheck/)
    - `luarocks install luacheck`

### luacheck

This project uses `luacheck` for linting. To run the linter, execute the following command:

```sh
luacheck -q .
```

### Unit Tests

This project uses `busted` for unit testing. To run the tests, execute the following command:

```sh
busted -p ".test.lua" .
```
