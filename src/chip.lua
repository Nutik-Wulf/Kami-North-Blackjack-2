local num = -1
local chipValue = 5
local stackValue = chipValue

function onLoad()
self.setGMNotes(chipValue)
end

function onSpawn()
self.setGMNotes(chipValue)
end

function onHover()
num = self.getQuantity()
if num > 0 then
    stackValue = chipValue * num
    self.setName("$"..chipValue.." = $"..stackValue)
    else
        num = 1
        stackValue = chipValue
        self.setName("$"..chipValue)
        end
        end

        function onCollisionEnter(o)
        local check = o.collision_object.getGMNotes()
        if check == self.getGMNotes() then
            o.collision_object.setName(self.getName())
            self.putObject(o.collision_object)
            end
            end
