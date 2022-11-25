_cam = nil

RegisterCommand('TalkToNPC', function()
    talkNPC()
end)

RegisterKeyMapping('TalkToNPC', 'NPC Interaction', 'keyboard', 'E')

-- NPC Dialog Opener
talkNPC = function()
    local _ped = PlayerPedId()
    local _pedPos = GetEntityCoords(_ped)
    local npc = getClosestNPC()
    if npc then
        setCameraToNPC()

        SetNuiFocus(true, true)

        sendToUI('dialog', {
            display = true,
            name = npc.name,
            text = npc.text,
            menu = npc.menu
        })
    end
end

RegisterNUICallback('closeDialog', function(data, cb)
    SetNuiFocus(false, false)
    destroyCamera(_cam)
    cb('ok')
end)

setCameraToNPC = function()
    local _ped = PlayerPedId()
    local npc = getClosestNPC()
    if npc then
        local heading = GetEntityHeading(npc.entity)
        local forwardPos = GetOffsetFromEntityInWorldCoords(npc.entity, 0.0, 1.0, 0.5)

        _cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(_cam, forwardPos.x, forwardPos.y, forwardPos.z)
        SetCamRot(_cam, -5.0, 0.0, heading-180.0, 2)
        RenderScriptCams(true, true, 1000, true, true)
        SetCamActive(_cam, true)
        SetCamFov(_cam, 90.0)
    end
end

---Returns closest npc data
---@return table
getClosestNPC = function ()
    local _ped = PlayerPedId()
    local _pedPos = GetEntityCoords(_ped)
    local _npc = nil
    for i = 1, #_npcs do
        local npc = _npcs[i]
        local nPos = npc.details.pos
        local dist = #(nPos - _pedPos)
        if dist < 3 then
            _npc = npc
        end
    end
    return _npc
end
