local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand(Config.Command, function(source, args)
    local amount = tonumber(args[1]) or Config.DefaultAmount
    TriggerServerEvent('moneySpawner:spawnMoney', amount)
end, false)

RegisterNetEvent('moneySpawner:notify')
AddEventHandler('moneySpawner:notify', function(message)
    ESX.ShowNotification(message)
end)