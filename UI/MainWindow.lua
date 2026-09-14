local addonName, Workbench = ...
Workbench.AddonName = addonName

local MainWindow = {}
MainWindow.__index = MainWindow

local instance

local function createFrame(self)

    local frame = CreateFrame(
        "Frame",
        "WorkbenchMainWindow",
        UIParent,
        "DefaultPanelFlatTemplate"
    )

    frame:SetSize(920, 724)
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

    closeButton:SetPoint(
        "TOPRIGHT",
        frame,
        "TOPRIGHT",
        0,
        0
    )

    closeButton:SetScript("OnClick", function()
        self:Hide()
    end)

    frame.TitleContainer.TitleText:SetText("Workbench")

    frame.TitleContainer:EnableMouse(true)
    frame.TitleContainer:RegisterForDrag("LeftButton")

    frame.TitleContainer:SetScript("OnDragStart", function()
        frame:StartMoving()
    end)

    frame.TitleContainer:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
    end)

    frame:Hide()

    self.frame = frame

end

local function createLayout(self)

    local innerFrame = self.frame:CreateTexture(
        nil,
        "OVERLAY",
        nil,
        2
    )

    innerFrame:SetAtlas("Options_InnerFrame", true)

    innerFrame:SetPoint(
        "TOPLEFT",
        self.frame,
        "TOPLEFT",
        17,
        -64
    )

    local navigationPanel = CreateFrame(
        "Frame",
        nil,
        self.frame
    )

    navigationPanel:SetPoint(
        "TOPLEFT",
        self.frame,
        "TOPLEFT",
        18,
        -76
    )

    navigationPanel:SetPoint(
        "BOTTOMLEFT",
        self.frame,
        "BOTTOMLEFT",
        18,
        46
    )

    navigationPanel:SetWidth(199)

    local contentPanel = CreateFrame(
        "Frame",
        nil,
        self.frame
    )

    contentPanel:SetPoint(
        "TOPLEFT",
        navigationPanel,
        "TOPRIGHT",
        16,
        0
    )

    contentPanel:SetPoint(
        "BOTTOMLEFT",
        navigationPanel,
        "BOTTOMRIGHT",
        16,
        1
    )

    contentPanel:SetPoint(
        "RIGHT",
        self.frame,
        "RIGHT",
        -22,
        0
    )

    self.innerFrame = innerFrame
    self.navigationPanel = navigationPanel
    self.contentPanel = contentPanel

end

local function createPages(self)

    self.pages = {}

    self.pages.console = Workbench.Classes.Console.New(
        self.contentPanel
    )

    self.pages.tools = Workbench.Classes.Tools.New(
        self.contentPanel
    )

end

local function createSidebar(self)

    self.sidebar = Workbench.Classes.Sidebar.New(
        self.navigationPanel,
        function(itemId)
            self:ShowPage(itemId)
        end
    )

end

function MainWindow.new()

    if instance then
        return instance
    end

    instance = setmetatable({}, MainWindow)

    createFrame(instance)
    createLayout(instance)
    createPages(instance)
    createSidebar(instance)

    return instance

end

function MainWindow:ShowPage(pageId)

    local page = self.pages[pageId]

    if not page then
        return
    end

    if self.activePage then
        self.activePage:Hide()
    end

    page:Show()

    self.activePage = page

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