local pull = getObjectFromGUID("3037ac")
local t = pull.getValue()

function onLoad()
    tick()
end

function tick()
    t = pull.getValue()
    if t > 0 then
        self.setValue(t)
    end
    Wait.time(tick, 0.1)
end
