local count = getObjectFromGUID("9d907b")
local sum = 0

function onLoad()
Wait.time(tick, 1)
end

function updateSum()
count.setValue(sum)
end

function tick()
sum = 0
for _, o in ipairs(self.getObjects()) do
    sum = sum + (o.getGMNotes() * math.abs(o.getQuantity()))
    end
    updateSum()
    Wait.time(tick, 1)
    end
