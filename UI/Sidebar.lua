local _, Workbench = ...

local Sidebar = {}
Sidebar.__index = Sidebar

local function createFrame(self, parent)

    local frame = CreateFrame(
        "Frame",
        nil,
        parent
    )

    frame:SetAllPoints(parent)

    self.frame = frame

end

local function createHeader(self, text, index)

    local header = CreateFrame(
        "Frame",
        nil,
        self.frame,
        "SettingsCategoryListHeaderTemplate"
    )

    header:SetPoint(
        "TOPLEFT",
        self.frame,
        "TOPLEFT",
        0,
        0
    )

    header:Init({
        data = {
            label = text,
            headerIndex = index
        }
    })

    return header

end

local function createItem(self, text, previous)

    local button = CreateFrame(
        "Button",
        nil,
        self.frame
    )

    button:SetSize(175, 20)

    button:SetPoint(
        "TOPLEFT",
        previous,
        "BOTTOMLEFT",
        0,
        -2
    )

    local activeTexture = button:CreateTexture(
        nil,
        "BACKGROUND"
    )

    activeTexture:SetPoint("CENTER", button, "CENTER", 10, 0)
    activeTexture:SetAtlas("Options_List_Active", true)
    activeTexture:Hide()

    local hoverTexture = button:CreateTexture(
        nil,
        "BACKGROUND"
    )

    hoverTexture:SetPoint("CENTER", button, "CENTER", 10, 0)
    hoverTexture:SetAtlas("Options_List_Hover", true)
    hoverTexture:Hide()

    local label = button:CreateFontString(
        nil,
        "ARTWORK",
        "GameFontNormal"
    )

    label:SetPoint(
        "TOPLEFT",
        button,
        "TOPLEFT",
        36,
        1
    )

    label:SetPoint(
        "BOTTOMRIGHT",
        button,
        "BOTTOMRIGHT",
        0,
        1
    )

    label:SetJustifyH("LEFT")
    label:SetText(text)

    button.itemName = text
    button.activeTexture = activeTexture
    button.hoverTexture = hoverTexture
    button.label = label
    button.selected = false

    button:SetScript("OnEnter", function(button)

        if not button.selected then
            button.hoverTexture:Show()
        end

    end)

    button:SetScript("OnLeave", function(button)

        button.hoverTexture:Hide()

    end)

    button:SetScript("OnClick", function(button)

        self:SelectItem(button)

    end)

    return button

end

function Sidebar:SelectItem(button)

    if self.selectedButton == button then
        return
    end

    if self.selectedButton then

        self.selectedButton.selected = false
        self.selectedButton.activeTexture:Hide()
        self.selectedButton.label:SetFontObject(GameFontNormal)

    end

    self.selectedButton = button

    button.selected = true
    button.hoverTexture:Hide()
    button.activeTexture:Show()
    button.label:SetFontObject(GameFontHighlight)

    if self.onSelect then
        self.onSelect(button.itemName)
    end

end

function Sidebar.New(parent, onSelect)

    local self = setmetatable({}, Sidebar)

    self.onSelect = onSelect

    createFrame(self, parent)

    self.developmentHeader = createHeader(
        self,
        "Development",
        1
    )

    self.consoleButton = createItem(
        self,
        "Console",
        self.developmentHeader
    )

    self.toolsButton = createItem(
        self,
        "Tools",
        self.consoleButton
    )

    self:SelectItem(self.consoleButton)

    return self

end

Workbench.Classes.Sidebar = Sidebar