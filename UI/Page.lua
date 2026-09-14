local _, Workbench = ...

local Page = {}
Page.__index = Page

function Page.New(class, parent, titleText)

    local self = setmetatable({}, class)

    local frame = CreateFrame(
        "Frame",
        nil,
        parent
    )

    frame:SetAllPoints(parent)
    frame:Hide()

    local title = frame:CreateFontString(
        nil,
        "ARTWORK",
        "GameFontHighlightHuge"
    )

    title:SetPoint(
        "TOPLEFT",
        frame,
        "TOPLEFT",
        20,
        -20
    )

    title:SetText(titleText)

    local divider = frame:CreateTexture(
        nil,
        "ARTWORK"
    )

    divider:SetAtlas(
        "Options_HorizontalDivider",
        true
    )

    divider:SetPoint(
        "TOP",
        frame,
        "TOP",
        0,
        -50
    )

    self.frame = frame
    self.title = title
    self.divider = divider

    return self

end

function Page:Show()
    self.frame:Show()
end

function Page:Hide()
    self.frame:Hide()
end

Workbench.Classes.Page = Page