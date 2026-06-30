-- This script is retired. For its successor, see playerCard.lua. --

local C_COLOR = "Black"

function onPlayerChangeColor(c)
if Player[C_COLOR].steam_name ~= nil then
    self.setName("[i][aaaaaa][sup]chips[/sup] [666666]~ "..Player[C_COLOR].steam_name)
    else
        self.setName("[666666][sup]nil")
        end
        end
