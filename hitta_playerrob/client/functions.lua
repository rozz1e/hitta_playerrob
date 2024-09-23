ESX = exports["es_extended"]:getSharedObject()

local InAnim = false

animDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
end

playAnim = function(player, dict, clip)
    TaskPlayAnim(player, dict, clip, 8.0, 8.0, -1, 50, 0, false, false, false)
end

IsArmed = function()
    return IsPedArmed(PlayerPedId(), 4)
end

IsNearby = function()
    local closestPlayer, distance = ESX.Game.GetClosestPlayer()
    return closestPlayer ~= -1 and distance <= 1.5
end

IsArmedWithWeapon = function()
    local weaponHashes = Config.Weapons

    local weapon = GetSelectedPedWeapon(PlayerPedId())
    for _, hash in ipairs(weaponHashes) do
        if weapon == GetHashKey(hash) then
            return true
        end
    end

    return false
end