local _, Workbench = ...

local ConsoleInput = {}
ConsoleInput.__index = ConsoleInput

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

    title:SetText("Input")

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

    local scrollFrame = CreateFrame(
        "ScrollFrame",
        nil,
        content,
        "ScrollFrameTemplate"
    )

    scrollFrame:SetPoint(
        "TOPLEFT",
        content,
        "TOPLEFT",
        8,
        -8
    )

    scrollFrame:SetPoint(
        "BOTTOMRIGHT",
        content,
        "BOTTOMRIGHT",
        -28,
        8
    )

    scrollFrame:EnableMouse(true)

    local editBox = CreateFrame(
        "EditBox",
        nil,
        scrollFrame
    )

    editBox:SetMultiLine(true)
    editBox:SetAutoFocus(false)
    editBox:EnableMouse(true)

    editBox:SetFontObject("ChatFontNormal")
    editBox:SetJustifyH("LEFT")
    editBox:SetJustifyV("TOP")

    editBox:SetTextInsets(
        4,
        4,
        4,
        4
    )

    editBox:SetPoint(
        "TOPLEFT",
        scrollFrame,
        "TOPLEFT",
        0,
        0
    )

    editBox:SetWidth(1)
    editBox:SetHeight(1)

    scrollFrame:SetScrollChild(editBox)

    scrollFrame:SetScript(
        "OnMouseDown",
        function()
            editBox:SetFocus()
        end
    )

    scrollFrame:SetScript(
        "OnMouseUp",
        function()
            editBox:SetFocus()
        end
    )

    editBox:SetScript(
        "OnEscapePressed",
        function(editBox)
            editBox:ClearFocus()
        end
    )

    editBox:SetScript(
        "OnTextChanged",
        function(editBox)

            ScrollingEdit_OnTextChanged(
                editBox,
                scrollFrame
            )

        end
    )

    editBox:SetScript(
        "OnCursorChanged",
        function(editBox, x, y, width, height)

            ScrollingEdit_OnCursorChanged(
                editBox,
                x,
                y - 10,
                width,
                height
            )

        end
    )

    editBox:SetScript(
        "OnUpdate",
        function(editBox, elapsed)

            ScrollingEdit_OnUpdate(
                editBox,
                elapsed,
                scrollFrame
            )

        end
    )

    scrollFrame:HookScript(
        "OnSizeChanged",
        function(scrollFrame, width, height)

            editBox:SetWidth(width)

            if editBox:GetHeight() < height then
                editBox:SetHeight(height)
            end

        end
    )

    self.frame = frame
    self.title = title
    self.content = content
    self.scrollFrame = scrollFrame
    self.editBox = editBox

end

function ConsoleInput.New(parent)

    local self = setmetatable({}, ConsoleInput)

    createFrame(self, parent)

    return self

end

Workbench.Classes.ConsoleInput = ConsoleInput