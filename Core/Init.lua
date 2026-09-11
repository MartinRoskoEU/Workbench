local addonName, Workbench = ...

Workbench.AddonName = addonName

local loaded = false

function Workbench_OnAddonCompartmentClick(addonName, buttonName)

    if not loaded then return end
    Workbench.UI.MainWindow:toggle()
    
end

local function Initialize()
    
    Workbench.UI.MainWindow = Workbench.Classes.MainWindow.new()

    loaded = true

end

Initialize()