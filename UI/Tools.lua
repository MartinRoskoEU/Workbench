local _, Workbench = ...

local Page = Workbench.Classes.Page

local Tools = setmetatable({}, {
    __index = Page
})

Tools.__index = Tools

function Tools.New(parent)

    local self = Page.New(
        Tools,
        parent,
        "Tools"
    )

    return self

end

Workbench.Classes.Tools = Tools