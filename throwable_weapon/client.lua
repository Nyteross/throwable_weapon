--#############################################################################
--##                            MADE By Nyteros                              ##
--#############################################################################

print("^6Throwable Weapon^7 - ^3https://github.com/Nyteros/throwable_weapon ^7- ^3Made By Nyteros")

RegisterCommand("throw_weapon", function()
    local player_ped = PlayerPedId()
    local ped_weapon = GetSelectedPedWeapon(player_ped)
    local unarmed_hash = GetHashKey("WEAPON_UNARMED")
    local ped_ammo = nil
    if ped_weapon ~= 0 and ped_weapon ~= unarmed_hash then
        local direction = GetDirectionFromRotation(GetGameplayCamRot(2))
        Citizen.CreateThread(function()
            RequestAnimDict("weapons@first_person@aim_rng@generic@projectile@shared@core") while not HasAnimDictLoaded("weapons@first_person@aim_rng@generic@projectile@shared@core") do Wait(0) end
            TaskPlayAnim(player_ped, "weapons@first_person@aim_rng@generic@projectile@shared@core", "throw_m_fb_stand", -8.0, 8.0, -1, 49, 1.0, false, false, false)
            Wait(600)
            ClearPedTasks(player_ped)
        end)
        Wait(550)
        local weapon_prop = GetWeaponObjectFromPed(player_ped, true)
        if Config.Inventory == "ox" then
            TriggerEvent('ox_inventory:disarm', true)
        elseif Config.Inventory == "esx" then
            ped_ammo = GetPedAmmoByType(player_ped, GetPedAmmoTypeFromWeapon(player_ped, ped_weapon))
            SetCurrentPedWeapon(player_ped, unarmed_hash, true)
        end
        SetEntityVelocity(weapon_prop, direction.x * 20, direction.y * 20, direction.z * 25)
        local old_coords = GetEntityCoords(weapon_prop)
        while true do
            Wait(100)
            local new_coords = GetEntityCoords(weapon_prop)
            if old_coords == new_coords then
                TriggerServerEvent("NyterosThrowWeapon:CreateDrop", GetWeaponName(GetEntityArchetypeName(weapon_prop)), GetEntityArchetypeName(weapon_prop), GetEntityCoords(weapon_prop), ped_ammo)
                DeleteEntity(weapon_prop)
                break
            end
            old_coords = GetEntityCoords(weapon_prop)
        end
    end
end)

RegisterKeyMapping("throw_weapon", "Throw Weapon", "keyboard", Config.Key)