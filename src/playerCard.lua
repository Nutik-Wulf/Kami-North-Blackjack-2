local C_COLOR = "Black"
local NIL_AVATAR = "https://avatars.steamstatic.com/b5bd56c1aa4644a474a2e4972be27ef9e82e517e_full.jpg"
local API_KEY = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
local icon = NIL_AVATAR -- fallback
local name = "(nil)"
local id = 0

function onLoad()
    onPlayerChangeColor()
end

function onPlayerChangeColor()
    name = Player[C_COLOR].steam_name
    id = Player[C_COLOR].steam_id

    if Player[C_COLOR].steam_name ~= nil then
        -- Fetch User Info via Steam API
        WebRequest.get("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key="..API_KEY.."&steamids="..id, function(request)
            if request.is_error then
                print(request.error)
            else
                local json = JSON.decode(request.text)
                name = json.response.players[1].personaname
                icon = json.response.players[1].avatarfull
            end
        end)

        -- Update Player Card after 1 second so API has time to process
        Wait.time(apiUpdate, 1)
    else
        -- No Player
        self.UI.setAttribute("icon", "image", NIL_AVATAR)
        self.UI.setAttribute("name", "text", "(nil)")
    end
end

function apiUpdate()
    self.UI.setAttribute("icon", "image", icon)
    self.UI.setAttribute("name", "text", name)
end
