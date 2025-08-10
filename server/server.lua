local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

--------------------------------------
-- register shop
--------------------------------------
CreateThread(function() 
    exports['rsg-inventory']:CreateShop({
        name = 'research',
        label = locale('sv_lang_1'),
        slots = #Config.ResearchShopItems,
        items = Config.ResearchShopItems,
        persistentStock = Config.PersistStock,
    })
end)

--------------------------------------
-- open shop
--------------------------------------
RegisterNetEvent('rex-research:server:openshop', function() 
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local playerjobtype = Player.PlayerData.job.type
    print(playerjobtype)
    if playerjobtype == 'blacksmith' or playerjobtype == 'weaponsmith' then
        exports['rsg-inventory']:OpenShop(src, 'research')
    else
        TriggerClientEvent('ox_lib:notify', source, {title = locale('sv_lang_2'), type = 'error', duration = 7000 }) 
    end
end)

--------------------------------------
-- cash callback
--------------------------------------
RSGCore.Functions.CreateCallback('rex-research:server:moneycallback', function(source, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local playermoney = Player.PlayerData.money['cash']
    if playermoney then
        cb(playermoney)
    else
        cb(nil)
    end
end)

--------------------------------------
-- finish copy give bpcs & remove money
--------------------------------------
RegisterNetEvent('rex-research:server:finishcopy', function(data, amount, totaldue) 
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveMoney('cash', totaldue)
    Player.Functions.AddItem(data.receive, amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[data.receive], 'add', amount)
end)
