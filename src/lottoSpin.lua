local spin = 0
local offset = 0
local spinSpeed = 0.25
local offSize = 0.5
local sine = 180.0 / math.pi
local baseX = -20
local baseY = 2.5
local baseZ = 22

function onLoad()
self.setLock(true)
self.setPosition({baseX, baseY, baseZ})
end

function onFixedUpdate()
self.setRotation({0, spin, 0})
self.setPosition({baseX, baseY+offset, baseZ})
spin = (spin - spinSpeed) % 360
offset = math.sin(spin / sine) * offSize
end
