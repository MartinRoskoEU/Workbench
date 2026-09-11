local addonName, Workbench = ...
Workbench.AddonName = addonName

local MainWindow = {}
MainWindow.__index = MainWindow

local instance

local function createFrame(self)
    if self.frame then
        return self.frame
    end

    local frame = CreateFrame(
        "Frame",
        "WorkbenchMainWindow",
        UIParent,
        "DefaultPanelFlatTemplate"
    )
    
    frame:SetSize(920, 720)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:SetFrameStrata("FULLSCREEN_DIALOG")

    local closeButton = CreateFrame(
        "Button",
        nil,
        frame,
        "UIPanelCloseButton"
    )

    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    closeButton:SetScript("OnClick", function ()
        self:Hide()     
    end)

    frame.TitleContainer.TitleText:SetText("Workbench")
    frame.TitleContainer:EnableMouse(true)
    frame.TitleContainer:RegisterForDrag("LeftButton")

    frame.TitleContainer:SetScript("OnDragStart", function ()
        frame:StartMoving()        
    end)

    frame.TitleContainer:SetScript("OnDragStop", function ()
        frame:StopMovingOrSizing()        
    end)

    frame:Hide()

    self.frame = frame

    return frame
end

function MainWindow.new()

    if instance then
        return instance
    end
    
    instance = setmetatable({}, MainWindow)    
    createFrame(instance)

    return instance

end

function MainWindow:Show()
    self.frame:Show()
end

function MainWindow:Hide()
    self.frame:Hide()
end

function MainWindow:Toggle()
    if self.frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

Workbench.Classes.MainWindow = MainWindow