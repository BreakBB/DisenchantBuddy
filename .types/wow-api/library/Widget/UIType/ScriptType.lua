---@meta _
---@alias ScriptType string
---|"OnLoad"               # ScriptObject
---|"OnUpdate"             # ScriptObject
---@alias ScriptAnimation      ScriptType | "OnFinished" | "OnPause" | "OnPlay" | "OnStop"
---@alias ScriptAnimationGroup ScriptType | "OnFinished" | "OnPause" | "OnPlay" | "OnStop" | "OnLoop"
---@alias ScriptFrame          ScriptType
---|"OnAttributeChanged"   # Frame
---|"OnChar"               # Frame
---|"OnDisable"            # Frame
---|"OnDragStart"          # Frame
---|"OnDragStop"           # Frame
---|"OnEnable"             # Frame
---|"OnEnter"              # Frame
---|"OnEvent"              # Frame
---|"OnGamePadButtonDown"  # Frame
---|"OnGamePadButtonUp"    # Frame
---|"OnGamePadStick"       # Frame
---|"OnHide"               # Frame
---|"OnHyperlinkClick"     # Frame
---|"OnHyperlinkEnter"     # Frame
---|"OnHyperlinkLeave"     # Frame
---|"OnKeyDown"            # Frame
---|"OnKeyUp"              # Frame
---|"OnLeave"              # Frame
---|"OnMouseDown"          # Frame
---|"OnMouseUp"            # Frame
---|"OnMouseWheel"         # Frame
---|"OnReceiveDrag"        # Frame
---|"OnShow"               # Frame
---|"OnSizeChanged"        # Frame

---@alias ScriptModel           ScriptFrame
---|"OnAnimFinished"       # Model
---|"OnAnimStarted"        # Model
---|"OnModelLoaded"        # Model
---@alias ScriptCinematicModel  ScriptModel
---|"OnPanFinished"        # CinematicModel
---@alias ScriptDressUpModel    ScriptModel
---|"OnDressModel"         # DressUpModel
---@alias ScriptModelSceneActor
---|"OnAnimFinished"       # ModelSceneActor
---|"OnModelLoaded"        # ModelSceneActor
---|"OnModelLoading"       # ModelSceneActor
---@alias ScriptButton          ScriptFrame
---|"OnClick"              # Button
---|"OnDoubleClick"        # Button
---|"PostClick"            # Button
---|"PreClick"             # Button
---@alias ScriptColorSelect     ScriptFrame
---|"OnColorSelect"        # ColorSelect
---@alias ScriptCooldown        ScriptFrame
---|"OnCooldownDone"       # Cooldown
---@alias ScriptFogOfWarFrame   ScriptFrame
---|"OnUiMapChanged"       # FogOfWarFrame
---@alias ScriptMovieFrame      ScriptFrame
---|"OnMovieFinished"      # MovieFrame
---|"OnMovieHideSubtitle"  # MovieFrame
---|"OnMovieShowSubtitle"  # MovieFrame
---@alias ScriptScrollFrame     ScriptFrame
---|"OnHorizontalScroll"   # ScrollFrame
---|"OnScrollRangeChanged" # ScrollFrame
---|"OnVerticalScroll"     # ScrollFrame
---@alias ScriptSlider          ScriptFrame
---|"OnMinMaxChanged"      # Slider
---|"OnValueChanged"       # Slider
---@alias ScriptStatusBar       ScriptFrame
---|"OnMinMaxChanged"      # StatusBar
---|"OnValueChanged"       # StatusBar
---@alias ScriptGameTooltip     ScriptFrame
---|"OnTooltipAddMoney"         # GameTooltip
---|"OnTooltipCleared"          # GameTooltip
---|"OnTooltipSetAchievement"   # GameTooltip
---|"OnTooltipSetDefaultAnchor" # GameTooltip
---|"OnTooltipSetEquipmentSet"  # GameTooltip
---|"OnTooltipSetFramestack"    # GameTooltip
---|"OnTooltipSetItem"          # GameTooltip
---|"OnTooltipSetQuest"         # GameTooltip
---|"OnTooltipSetSpell"         # GameTooltip
---|"OnTooltipSetUnit"          # GameTooltip

---@alias ScriptBrowser         ScriptFrame | "OnEditFocusGained" | "OnEditFocusLost" | "OnEscapePressed" | "OnButtonUpdate" | "OnError" | "OnExternalLink"
---@alias ScriptCheckout        ScriptFrame | "OnEditFocusGained" | "OnEditFocusLost" | "OnEscapePressed" | "OnButtonUpdate" | "OnError" | "OnExternalLink" | "OnRequestNewSize"
---@alias ScriptEditBox         ScriptFrame
---|"OnArrowPressed"         # EditBox
---|"OnCharComposition"      # EditBox
---|"OnCursorChanged"        # EditBox
---|"OnEditFocusGained"      # EditBox
---|"OnEditFocusLost"        # EditBox
---|"OnEnterPressed"         # EditBox
---|"OnEscapePressed"        # EditBox
---|"OnInputLanguageChanged" # EditBox
---|"OnSpacePressed"         # EditBox
---|"OnTabPressed"           # EditBox
---|"OnTextChanged"          # EditBox
---|"OnTextSet"              # EditBox

---@alias LE_SCRIPT_BINDING_TYPE
---|"LE_SCRIPT_BINDING_TYPE_INTRINSIC_PRECALL"
---|"LE_SCRIPT_BINDING_TYPE_EXTRINSIC"
---|"LE_SCRIPT_BINDING_TYPE_INTRINSIC_POSTCALL"
