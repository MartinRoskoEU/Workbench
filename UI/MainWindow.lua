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

    frame:SetSize(900, 600)
    frame:SetPoint("CENTER")
    frame.TitleContainer.TitleText:SetText("Workbench")
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

function MainWindow:show()
    self.frame:Show()
end

function MainWindow:hide()
    self.frame:Hide()
end

function MainWindow:toggle()
    if self.frame:IsShown() then
        self:hide()
    else
        self:show()
    end
end

Workbench.Classes.MainWindow = MainWindow