# DisenchantBuddy — Agent Guidelines

DisenchantBuddy is a World of Warcraft addon written purely in **Lua 5.1**. The project uses `luacheck` for linting and `busted` for testing.

---

## Workflow

1. Write a **failing (red) test** for the fix or feature first.
2. Implement the logic to make the test pass.
3. Verify the test passes.

Keep changes as small as possible.

---

## Build / Lint / Test Commands

| Purpose                      | Command                                                  |
|------------------------------|----------------------------------------------------------|
| Lint                         | `luacheck -q .`                                          |
| Run all tests                | `busted -p ".test.lua" .`                                |
| Run a single test file       | `busted -p ".test.lua" DisenchantResults/Rare.test.lua`  |
| Run tests matching a pattern | `busted -p ".test.lua" --filter "should show tooltip" .` |
| Build the addon              | `python build.py`                                        |
| Generate changelog           | `python changelog.py`                                    |

> **Single test tip:** Use `--filter "<pattern>"` with a substring of the test name to run one specific `it()` block.

---

## Project Structure

```
DisenchantBuddy/
├── .types/                    # LuaLS type stubs (wow-api, busted, luassert, custom types)
│   └── types.lua              # Custom types: DisenchantResult, TooltipLineData, ItemId
├── .github/workflows/         # CI (luacheck + busted) and publish workflows
├── DisenchantResults/         # Drop tables per quality (Uncommon, Rare, Epic) + tests
├── Locales/                   # Translation files (enUS, deDE, frFR, …)
├── DisenchantBuddy.lua        # Main entry point: event hooks, slash command
├── AddDisenchantInfo.lua      # Core: builds and adds disenchant tooltip lines
├── AddMaterialInfo.lua        # Adds material source info to tooltip
├── GetTooltipLineData.lua     # Builds a single tooltip line data struct
├── GameVersions.lua           # Sets IsClassic/IsTBC/IsWrath/… boolean flags
├── Materials.lua              # Material item IDs, expansion-conditional
├── *.toc                      # Addon manifests per expansion
├── .luacheckrc                # Luacheck config (globals, exclusions)
└── .luarc.json                # LuaLS config (formatting, type paths)
```

---

## Code Style

### Formatting (from `.luarc.json`)

- **Indentation:** 4 spaces (no tabs)
- **Continuation indent:** 4 spaces
- **Quote style:** double quotes
- **Line endings:** LF
- **Max line length:** 160 (luacheck warns at 180)
- **No alignment formatting** — do not align table values or function params

### Module Pattern

Every production Lua file begins with the WoW addon vararg idiom:

```lua
---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)
```

All functions and state are attached to the shared `DisenchantBuddy` table. There are **no `require` calls** in production code.

### LuaDoc Annotations

Use LuaLS annotations throughout:

```lua
---@param link string|nil
---@return DisenchantResult[]|nil
function DisenchantBuddy.GetMaterialsForRareItem(link) ... end
```

Custom types (`DisenchantResult`, `TooltipLineData`, `ItemId`) are declared in `.types/types.lua`.

---

## Naming Conventions

| Element                    | Convention               | Example                                              |
|----------------------------|--------------------------|------------------------------------------------------|
| Files                      | PascalCase               | `AddDisenchantInfo.lua`                              |
| Test files                 | `<Name>.test.lua`        | `AddDisenchantInfo.test.lua`                         |
| Functions on module        | PascalCase               | `DisenchantBuddy.AddDisenchantInfo`                  |
| Local variables            | camelCase                | `itemsLoaded`, `averageValue`                        |
| Material ID constants      | SCREAMING_SNAKE_CASE     | `STRANGE_DUST`, `NEXUS_CRYSTAL`                      |
| Expansion flags            | `Is<ExpansionName>`      | `DisenchantBuddy.IsClassic`, `DisenchantBuddy.IsTBC` |
| WoW saved variable globals | `AddonName_VariableName` | `DisenchantBuddy_Profile`                            |
| Locale table shorthand     | Single-letter `L`        | `local L = DisenchantBuddy.L`                        |

---

## Error Handling

- Use **early returns** when data is invalid or unsupported:
  ```lua
  if (not link) or tooltip:IsForbidden() then
      return
  end
  ```
- Use `or` for default values / API compatibility shims:
  ```lua
  DisenchantBuddy_Profile = DisenchantBuddy_Profile or {}
  local GetItemInfo = C_Item.GetItemInfo or GetItemInfo
  ```
- Return `nil` to signal "no result" — never raise errors in addon code.
- No `pcall`/`xpcall` in application code.
- Check optional dependencies with `if Auctionator then` before using them.

---

## Lua-Specific Rules

- `return` statements that follow an `if` block go on a **new line**:
  ```lua
  if (not x) then
      return
  end
  ```
- Always wrap `not` conditions in braces:
  ```lua
  if (not x) then   -- correct
  if not x then     -- incorrect
  ```

---

## Testing Conventions

- Test names **must start with `"should"`**:
  ```lua
  it("should return nil when link is nil", function() ... end)
  ```
- Tests load production files via `loadfile` (not `require`) to allow injecting a fresh module environment:
  ```lua
  loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
  ```
- Mock WoW API globals by setting them on `_G`:
  ```lua
  _G.C_Item = { GetItemInfo = spy.new(function() ... end) }
  ```
- Use `spy.new` and `assert.spy(x).was.called_with(...)` / `assert.spy(x).was_not.called()` for behaviour assertions.
- Reset all mocks and reload the module under test in `before_each` to ensure test isolation.

---

## Expansion-Conditional Logic

Material tables and drop results are gated behind expansion flags set in `GameVersions.lua`:

```lua
if DisenchantBuddy.IsTBC then
    Materials.ARCANE_DUST = 22446
end
```

When adding data for a new expansion, follow this same pattern — add the flag in `GameVersions.lua` and gate all related data behind it.

---

## Type Definitions

Add new shared types to `.types/types.lua` as `---@class` or `---@alias` definitions. WoW API stubs live in `.types/wow-api/`. Do not add production runtime code to `.types/`.
