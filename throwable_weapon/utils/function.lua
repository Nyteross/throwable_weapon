function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end

RegisterNetEvent("ShowNotification")
AddEventHandler("ShowNotification", function(msg)
    ShowNotification(msg)
end)

function GetDirectionFromRotation(rotation)
    local dm = (math.pi / 180)
    return vector3(-math.sin(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.cos(dm * rotation.z) * math.abs(math.cos(dm * rotation.x)), math.sin(dm * rotation.x))
    -- Function taken from https://github.com/PickleModifications/pickle_throwables/releases
end

function GetWeaponName(prop)
    local final_name = nil
    if prop ~= nil then
        local start, finish = nil, nil
        while start == nil and finish == nil do
            if start == nil and finish == nil then
                for k,v in pairs(Utils.WeaponCategory) do
                    start, finish = string.find(prop, v)
                    if start ~= nil and finish ~= nil then
                        break
                    end
                end
            else
                break
            end
            Wait(0)
        end
        if start ~= nil and finish ~= nil then
            final_name = "WEAPON_" .. string.upper(string.sub(prop, finish + 2))
        end
    else
        ShowNotification("~r~Erreur")
    end
    return(final_name)
end