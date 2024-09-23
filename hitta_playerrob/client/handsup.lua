local handsUp, isDead = false, false

AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function()
    isDead = false
end)

RegisterCommand('handsup', function()
    if not handsUp and not isDead then
        animDict('missminuteman_1ig_2')
        playAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_enter')
        handsUp = true
    else
        ClearPedTasks(PlayerPedId())
        handsUp = false
    end
end)

TriggerEvent('chat:removeSuggestion', '/handsup')

RegisterKeyMapping('handsup', 'Hands Up', 'keyboard', 'X')