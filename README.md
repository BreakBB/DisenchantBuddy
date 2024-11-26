# Disenchant Buddy

Disenchant Buddy is a lightweight World of Warcraft addon that displays disenchant results on item tooltips.
It helps players to quickly see what materials they can expect to receive from disenchanting an item.

## Installation

1. Download the latest version of the addon.
2. Extract the contents of the zip file to your World of Warcraft Interface\AddOns directory:
    - Era/HC/Anniversary: `World of Warcraft\_classic_era_\Interface\AddOns\DisenchantBuddy`
3. Restart World of Warcraft or reload your UI

## Development

### luacheck

This project uses [luacheck](https://github.com/lunarmodules/luacheck/) for linting. To run the linter, execute the following command:

```sh
luacheck .
```

### Unit Tests

This project uses [busted](https://github.com/lunarmodules/busted) for unit testing. To run the tests, execute the following command:

```sh
busted -p ".test.lua" .
```
