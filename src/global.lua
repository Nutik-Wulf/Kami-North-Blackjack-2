--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]
local timeIn = 728
local panicTime = 60
local panicActive = false
local panic = true

--[[ The onLoad event is called after the game save finishes loading. --]]
function onLoad()
    getMusic()
end

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
--[[ print('onUpdate loop!') --]]
end

function getMusic()
    local clip = MusicPlayer.getCurrentAudioclip()
    UI.setAttribute("playing", "text", "BGM: " .. clip.title)
    Wait.time(getMusic, 5)
end

function toggleGoldBounty()
    local clr = UI.getAttribute("goldBounty", "color")
    if clr == "#ff9911" then
        UI.setAttribute("goldBounty", "color", "#ff991133")
    else
        UI.setAttribute("goldBounty", "color", "#ff9911")
    end
end

function toggleSilverBounty()
    local clr = UI.getAttribute("silverBounty", "color")
    if clr == "#bbbbcc" then
        UI.setAttribute("silverBounty", "color", "#bbbbcc33")
    else
        UI.setAttribute("silverBounty", "color", "#bbbbcc")
    end
end

function toggleBronzeBounty()
    local clr = UI.getAttribute("bronzeBounty", "color")
    if clr == "#995511" then
        UI.setAttribute("bronzeBounty", "color", "#99551133")
    else
        UI.setAttribute("bronzeBounty", "color", "#995511")
    end
end

function timeInUpdate(pl, val, id)
    timeIn = tonumber(val)
end

function resetPullTimer()
    local clock = getObjectFromGUID("3037ac")
    clock.setValue(timeIn)
    clock.Clock.pauseStart()
end

function panicToggle()
    if panicActive then -- disable
        UI.setAttribute("panicText", "visibility", "Black")
        UI.setAttribute("panicText", "color", "#FF333333")
        UI.setAttribute("panicBar", "visibility", "Black")
        UI.setAttribute("panicBar", "fillImageColor", "#FF333333")
        panicActive = false
    else -- enable
        UI.setAttribute("panicText", "visibility", "")
        UI.setAttribute("panicText", "color", "#FF3333AA")
        UI.setAttribute("panicBar", "visibility", "")
        UI.setAttribute("panicBar", "fillImageColor", "#FF3333AA")
        panicActive = true
        panicReset()
    end
end

function panicReset()
    panicTime = 60
    if panic then panicTick() end
    panic = false
end

function panicTick()
    if panicTime > 0 then
        panicTime = math.floor((panicTime * 10) - 1) / 10
        UI.setAttribute("panicText", "text", panicTime)
        UI.setAttribute("panicBar", "percentage", panicTime / 60 * 100)
        Wait.time(function() panicTick() end, 0.1)
    else
        panic = true
    end
end
