local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('moneySpawner:spawnMoney')
AddEventHandler('moneySpawner:spawnMoney', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addAccountMoney('money', amount)
        MySQL.Async.execute('INSERT INTO ' .. Config.DBTable .. ' (player_id, amount) VALUES (@player_id, @amount)', {
            ['@player_id'] = xPlayer.identifier,
            ['@amount'] = amount
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('moneySpawner:notify', source, 'You have spawned $' .. amount .. ' into your inventory.')
            else
                TriggerClientEvent('moneySpawner:notify', source, 'Failed to log the money spawn.')
            end
        end)
    else
        TriggerClientEvent('moneySpawner:notify', source, 'Player not found.')
    end
end)