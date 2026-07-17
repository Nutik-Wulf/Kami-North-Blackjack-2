--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]
local timeIn = 727

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
