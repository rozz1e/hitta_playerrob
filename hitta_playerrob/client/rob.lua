local InRobbing = false

RobPlayer = function()
    if not (IsArmed() or IsArmedWithWeapon()) then
        ESX.ShowNotification(Strings.needweapon)
        return
    end

    if IsNearby() then
        local closestPlayer, distance = ESX.Game.GetClosestPlayer()

        if distance <= 1.5 then
            local closestPlayerPed = GetPlayerPed(closestPlayer)
            local closestPlayerHasHandsUp = IsEntityPlayingAnim(closestPlayerPed, 'missminuteman_1ig_2', 'handsup_enter', 3)

            if closestPlayerHasHandsUp or IsPlayerDead(closestPlayer) then
                if exports.ox_inventory:openInventory('player', GetPlayerServerId(closestPlayer)) then
                    InRobbing = true
                    Citizen.Wait(8500)
                    ClearPedTasks(PlayerPedId())
                    InRobbing = false
                end
            else
                ESX.ShowNotification(Strings.handsup)
            end
        else
            ESX.ShowNotification(Strings.nonearby)
        end
    end
end


RegisterCommand('rob', function()
    if not InRobbing then
        RobPlayer()
    else
        ESX.ShowNotification(Strings.robbing)
    end
end)

RegisterKeyMapping('rob', 'Rob Player', 'keyboard', 'G')