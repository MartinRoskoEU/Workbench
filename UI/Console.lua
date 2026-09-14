local _, Workbench = ...

local Page = Workbench.Classes.Page

local Console = setmetatable({}, {
    __index = Page
})

Console.__index = Console

local function createSections(self)

    self.input = Workbench.Classes.ConsoleInput.New(
        self.frame
    )

    self.output = Workbench.Classes.ConsoleOutput.New(
        self.frame
    )

    -- Left half
    self.input.frame:SetPoint(
        "TOPLEFT",
        self.frame,
        "TOPLEFT",
        20,
        -75
    )

    self.input.frame:SetPoint(
        "BOTTOMRIGHT",
        self.frame,
        "BOTTOM",
        -8,
        20
    )

    -- Right half
    self.output.frame:SetPoint(
        "TOPLEFT",
        self.frame,
        "TOP",
        8,
        -75
    )

    self.output.frame:SetPoint(
        "BOTTOMRIGHT",
        self.frame,
        "BOTTOMRIGHT",
        -20,
        20
    )

end

function Console.New(parent)

    local self = Page.New(
        Console,
        parent,
        "Console"
    )

    createSections(self)

    return self

end

Workbench.Classes.Console = Console