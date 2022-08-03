_npcs = {}

function registerNPC(data)
    local key = #_npcs + 1

    _npcs[key] = {
        name = data.name,
        text = data.text,
        details = data.details,
        menu = data.menu,
        spawned = false,
        entity = 0
    }

    return key
end

function deleteNPC(id)
    local npc = _npcs[id]
    if npc then
        if npc.spawned then
            DeleteEntity(npc.entity)
        end
        _npcs[id] = nil
        return true
    else
        return false
    end
end

function modifyNpcDescription(id, text)
    local npc = _npcs[id]

    if npc then
        npc.text = text
        return true
    else
        return false
    end
end

function modifyNpcMenu(id, menu)
    local npc = _npcs[id]

    if npc then
        npc.menu = menu
    end

end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(1000)
        for k,v in pairs(_npcs) do
            if v.entity ~= 0 then
                while DoesEntityExist(v.entity) do
                    Citizen.Wait(0)
                    DeleteEntity(v.entity)
                end
            end
        end
    end
end)


-- NPC Creation Thread
local _nSleep = 5000
npcThread = function()
    CreateThread(function ()
        while true do
            for i = 1, #_npcs do
                local npc = _npcs[i]
                local pos = npc.details.pos
                dist = #(GetEntityCoords(PlayerPedId()) - vec3(pos.x, pos.y, pos.z))
                if dist < 150 then
                    if not npc.spawned then
                        -- Load NPC Model
                        while not HasModelLoaded(joaat(npc.details.model)) do
                            Wait(0)
                            RequestModel(joaat(npc.details.model))
                        end

                        npc.entity = CreatePed(4, joaat(npc.details.model), npc.details.pos, npc.details.heading)
                        SetEntityHeading(npc.entity, npc.details.heading)
                        SetEntityAsMissionEntity(npc.entity, true, true)
                        FreezeEntityPosition(npc.entity, true)
                        SetEntityInvincible(npc.entity, true)
                        SetBlockingOfNonTemporaryEvents(npc.entity, true)
                        SetModelAsNoLongerNeeded(joaat(npc.details.model))

                        npc.spawned = true
                    end
                elseif dist > 150 then -- Delete NPC's that are out of range to save memory
                    if npc.spawned then
                        DeleteEntity(npc.entity)
                        npc.spawned = false
                        npc.entity = 0
                    end
                end
            end
            Wait(_nSleep)
        end
    end)
end

exports('registerNPC', function(data)
    return registerNPC(data)
end)

exports('deleteNPC', function(id)
    return deleteNPC(id)
end)

exports('modifyNpcMenu', function(id, menu)
    modifyNpcMenu(id, menu)
end)

exports('modifyNpcDescription', function(id, text)
    modifyNpcDescription(id, text)
end)
