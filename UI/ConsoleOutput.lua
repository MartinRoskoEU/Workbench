local _, Workbench = ...

local ConsoleOutput = {}
ConsoleOutput.__index = ConsoleOutput

local function createFrame(self, parent)

    local frame = CreateFrame(
        "Frame",
        nil,
        parent
    )

    local title = frame:CreateFontString(
        nil,
        "ARTWORK",
        "GameFontHighlightLarge"
    )

    title:SetPoint(
        "TOPLEFT",
        frame,
        "TOPLEFT",
        0,
        0
    )

    title:SetText("Output")

    local content = CreateFrame(
        "Frame",
        nil,
        frame,
        "BackdropTemplate"
    )

    content:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1
    })

    content:SetBackdropColor(0.02, 0.02, 0.02, 0.65)
    content:SetBackdropBorderColor(0.25, 0.25, 0.25, 0.8)

    content:SetPoint(
        "TOPLEFT",
        frame,
        "TOPLEFT",
        0,
        -30
    )

    content:SetPoint(
        "BOTTOMRIGHT",
        frame,
        "BOTTOMRIGHT",
        0,
        0
    )

    self.frame = frame
    self.title = title
    self.content = content

end

function ConsoleOutput.New(parent)

    local self = setmetatable({}, ConsoleOutput)

    createFrame(self, parent)

    return self

end

Workbench.Classes.ConsoleOutput = ConsoleOutput