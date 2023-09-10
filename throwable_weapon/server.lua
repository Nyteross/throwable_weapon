if Config.Inventory == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
end

RegisterServerEvent("NyterosThrowWeapon:CreateDrop", function(weapon, prop, coords)
    if Config.Inventory == "ox" then
        local ox = exports.ox_inventory
        local item = ox:Search(source, "slots", weapon)[1]
        if item.count >= 1 then
            ox:RemoveItem(source, weapon, 1, item.metadata)
            ox:CustomDrop(item.label, {
                {weapon, 1, item.metadata},
            }, coords, 1, 10000, nil, prop)
        else
            TriggerClientEvent("ShowNotification", source, "You didn't got this weapon")
        end
    elseif Config.Inventory == "esx" then
        local xPlayer = ESX.GetPlayerFromId(source)
        local loadoutNum, weapon_info = xPlayer.getWeapon(weapon)
        if weapon_info then
            ESX.CreatePickup("item_weapon", weapon, xPlayer.loadout[loadoutNum].ammo, xPlayer.loadout[loadoutNum].label, coords, xPlayer.loadout[loadoutNum].components, xPlayer.loadout[loadoutNum].tintIndex)
            xPlayer.removeWeapon(weapon)
        else
            TriggerClientEvent("ShowNotification", source, "You didn't got this weapon")
        end
    end
end)