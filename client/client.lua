local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

--------------------------------------
-- lab prompts and blips
--------------------------------------
Citizen.CreateThread(function()
    for _,v in pairs(Config.ResearchLocations) do
        if not Config.EnableTarget then
            exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds[Config.KeyBind], locale('cl_lang_1'), {
                type = 'client',
                event = 'rex-research:client:researchmenu',
            })
        end
        if v.showblip == true then
            local ResearchBlip = BlipAddForCoords(1664425300, v.coords)
            SetBlipSprite(ResearchBlip, joaat(Config.Blip.blipSprite), true)
            SetBlipScale(ResearchBlip, Config.Blip.blipScale)
            SetBlipName(ResearchBlip, Config.Blip.blipName)
        end
    end
end)

--------------------------------------
-- research menu
--------------------------------------
RegisterNetEvent('rex-research:client:researchmenu', function()
    lib.registerContext(
        {
            id = 'lab_menu',
            title = locale('cl_lang_2'),
            position = 'top-right',
            options = {
                {
                    title = locale('cl_lang_3'),
                    icon = 'fa-solid fa-basket-shopping',
                    serverEvent = 'rex-research:server:openshop'
                },
                {
                    title = locale('cl_lang_4'),
                    icon = 'fa-solid fa-copy',
                    event = 'rex-research:client:blueprintcopies',
                },
            }
        }
    )
    lib.showContext('lab_menu')
end)

--------------------------------------
-- select blueprint copies
--------------------------------------
RegisterNetEvent('rex-research:client:blueprintcopies', function()
    local options = {}
    for k,v in ipairs(Config.Blueprints) do
        options[#options + 1] = {
            title = RSGCore.Shared.Items[v.receive].label..' ($'..v.runcost..locale('cl_lang_5'),
            icon = 'fa-solid fa-copy',
            event = 'rex-research:client:makeblueprints',
            icon = "nui://" .. Config.Image .. RSGCore.Shared.Items[tostring(v.receive)].image,
            image = "nui://" .. Config.Image .. RSGCore.Shared.Items[tostring(v.receive)].image,
            args = {
                item = v.item,
                receive = v.receive,
                runcost = v.runcost,
                copytime = v.copytime
            },
            arrow = true,
        }
    end
    lib.registerContext({
        id = 'bluprint_copy',
        title = locale('cl_lang_6'),
        menu = 'lab_menu',
        position = 'top-right',
        options = options
    })
    lib.showContext('bluprint_copy')
end)

--------------------------------------
-- enter amount and copy
--------------------------------------
RegisterNetEvent('rex-research:client:makeblueprints', function(data)
    local input = lib.inputDialog(locale('cl_lang_7'), {
        { 
            label = locale('cl_lang_8'),
            type = 'input',
            icon = 'fa-solid fa-copy',
            required = true
        },
    })
    
    if not input then
        return 
    end

    local hasItem = RSGCore.Functions.HasItem(data.item, 1)
        
    if hasItem then
        RSGCore.Functions.TriggerCallback('rex-research:server:moneycallback', function(playermoney)
            local totaldue = data.runcost * input[1]
            if playermoney > totaldue then
                LocalPlayer.state:set("inv_busy", true, true) -- lock inventory
                lib.progressBar({
                    duration = tonumber(data.copytime * input[1]),
                    position = 'bottom',
                    useWhileDead = false,
                    canCancel = false,
                    disableControl = true,
                    disable = {
                        move = true,
                        mouse = false,
                    },
                    label = locale('cl_lang_9')..input[1]..' '..RSGCore.Shared.Items[data.receive].label,
                })
                TriggerServerEvent('rex-research:server:finishcopy', data, input[1], totaldue)
                LocalPlayer.state:set("inv_busy", false, true) -- unlock inventory
            else
                lib.notify({ title = locale('cl_lang_10'), type = 'error', duration = 7000 })
            end
        end)
    else
        lib.notify({ title = RSGCore.Shared.Items[data.item].label..locale('cl_lang_11'), type = 'error', duration = 7000 })
    end

end)
