RegisterNUICallback('action', function (data,cb)
    local npc = findNpcByName(data.name)
    local menu = findActionByLabel(npc, data.label)
    destroyCamera(_cam)
    SetNuiFocus(false, false)
    menu.action()
    cb('ok')
end)

RegisterNUICallback('closeDialog', function(data, cb)
    destroyCamera(_cam)
    cb('ok')
end)

findActionByLabel = function(npc, label)
    for i = 1, #npc.menu do
        local action = npc.menu[i]
        if action.label == label then
            return action
        end
    end
end

findNpcByName = function(name)
    for i = 1, #_npcs do
        local npc = _npcs[i]
        if npc.name == name then
            return npc
        end
    end
end