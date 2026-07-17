local pull = getObjectFromGUID("3037ac")
local t = pull.getValue()
local clock = 0

function onLoad()
    tick()
end

function tick()
    -- Clock Update
    t = pull.getValue()
    if t > 0 then
        self.setValue(t)
    end

    -- UI Update
    clock = os.date("%H:%M:%S")
    UI.setAttribute("time", "text", clock)

    if t == 0 then
        UI.setAttribute("timer", "color", "#FFFF33AA")
    else
        UI.setAttribute("timer", "color", "#FFFFFFAA")
    end

    UI.setAttribute("timer", "text", "Pull in "..t)
    UI.setAttribute("timerBar", "percentage", t / 727.0 * 100)

    Wait.time(tick, 1/10)
end
