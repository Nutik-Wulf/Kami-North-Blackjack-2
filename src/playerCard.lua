local C_COLOR = "Black"
local NIL_AVATAR = "https://avatars.steamstatic.com/b5bd56c1aa4644a474a2e4972be27ef9e82e517e_full.jpg"

function onLoad()
    onPlayerChangeColor()
end

function onPlayerChangeColor()
    local name = Player[C_COLOR].steam_name
    local id = Player[C_COLOR].steam_id

    if Player[C_COLOR].steam_name ~= nil then
        self.UI.setAttribute("icon", "image", "https://unavatar.io/steam/profile:" .. id)
        self.UI.setAttribute("name", "text", name)
    else
        self.UI.setAttribute("icon", "image", NIL_AVATAR)
        self.UI.setAttribute("name", "text", "(nil)")
    end
end
