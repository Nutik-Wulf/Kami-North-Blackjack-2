local player = getObjectFromGUID("947c62")

local bal = 0
local log = 0
local belt = 0
local nextBelt = 1

-- Hex color for XML
local unbelt = "#AAAAAA"
local belts = {"#FFFFFF", "#FFBB33", "#33BB33", "#BB33FF", "#3333BB", "#BB3333", "#995533", "#333333"}

-- Vector3 Color for Tinting
local untint = {2/3, 2/3, 2/3}
local tints = {
    {1, 1, 1},
    {1, 0.8, 0.2},
    {0.2, 0.8, 0.2},
    {0.8, 0.2, 1},
    {0.2, 0.2, 0.8},
    {0.8, 0.2, 0.2},
    {0.6, 0.4, 0.2},
    {0.2, 0.2, 0.2},
}

function onLoad()
    belts[0] = unbelt
    tints[0] = untint
    run()
end

function onObjectEnterZone()
    run()
end

function run()
    -- Reset
    bal = 0
    log = 0
    belt = 0

    -- Parse
    for _, o in ipairs(self.getObjects()) do
        local note = tonumber(o.getGMNotes())
        if o.hasTag("Chip") then
            bal = bal + (note * math.abs(o.getQuantity()))
        elseif o.hasTag("Log") then
            log = log + math.max(1, o.getQuantity())
        elseif o.hasTag("Belt") then
            if note > belt then
                belt = note
            end
        end
    end

    -- Update
    updateBelt(belt)
    updateBal(bal, log)
end

function updateBelt(belt)
    -- Progress Bar
    nextBelt = (belt + 1) ^ 2

    -- Color Theming
    local col = belts[belt]
    player.setColorTint(tints[belt])
    player.UI.setAttribute("name", "color", col)
    player.UI.setAttribute("bal", "color", col)
    player.UI.setAttribute("next", "color", col)
    player.UI.setAttribute("belt", "fillImageColor", belts[belt+1])
end

function updateBal(bal, log)
    -- Set Text
    if log > 0 then
        player.UI.setAttribute("bal", "text", bal .. "e" .. log)
    else
        player.UI.setAttribute("bal", "text", bal)
    end

    -- Progress Bar
    local progress = math.log(bal + 1, 10) + log
    player.UI.setAttribute("belt", "percentage", progress / (nextBelt + 2) * 100) -- +2 as you need 1K for next log
end
