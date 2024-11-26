---@meta _
C_AnimaDiversion = {}

---[Documentation](https://warcraft.wiki.gg/wiki/API_C_AnimaDiversion.CloseUI)
function C_AnimaDiversion.CloseUI() end

---[Documentation](https://warcraft.wiki.gg/wiki/API_C_AnimaDiversion.GetAnimaDiversionNodes)
---@return AnimaDiversionNodeInfo[] animaNodes
function C_AnimaDiversion.GetAnimaDiversionNodes() end

---[Documentation](https://warcraft.wiki.gg/wiki/API_C_AnimaDiversion.GetOriginPosition)
---@return vector2? normalizedPosition
function C_AnimaDiversion.GetOriginPosition() end

---[Documentation](https://warcraft.wiki.gg/wiki/API_C_AnimaDiversion.GetReinforceProgress)
---@return number progress
function C_AnimaDiversion.GetReinforceProgress() end

---[Documentation](https://warcraft.wiki.gg/wiki/API_C_AnimaDiversion.GetTextureKit)
---@return textureKit textureKit
function C_AnimaDiversion.GetTextureKit() end

---[Documentation](https://warcraft.wiki.gg/wiki/API_C_AnimaDiversion.OpenAnimaDiversionUI)
function C_AnimaDiversion.OpenAnimaDiversionUI() end

---[Documentation](https://warcraft.wiki.gg/wiki/API_C_AnimaDiversion.SelectAnimaNode)
---@param talentID number
---@param temporary boolean
function C_AnimaDiversion.SelectAnimaNode(talentID, temporary) end

---@class AnimaDiversionCostInfo
---@field currencyID number
---@field quantity number

---@class AnimaDiversionFrameInfo
---@field textureKit textureKit
---@field title string
---@field mapID number

---@class AnimaDiversionNodeInfo
---@field talentID number
---@field name string
---@field description string
---@field costs AnimaDiversionCostInfo[]
---@field currencyID number
---@field icon number
---@field normalizedPosition vector2
---@field state Enum.AnimaDiversionNodeState
