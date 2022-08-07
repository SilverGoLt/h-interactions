_Blips = {}

---comment
---@param data table @{pos,sprite,display,scale,color,name}
---@return integer id
RegisterBlip = function(data)
    id = #_Blips + 1
    local blip = AddBlipForCoord(data.pos.x, data.pos.y, data.pos.z)
    SetBlipSprite(blip, data.sprite)
    SetBlipDisplay(blip, data.display)
    SetBlipScale(blip, data.scale)
    SetBlipColour(blip, data.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.name)
    EndTextCommandSetBlipName(blip)
    _Blips[id] = data
    return id
end

DeleteBlip = function(id)
    if _Blips[id] then
        RemoveBlip(_Blips[id])
        _Blips[id] = nil
        return true
    else
        return false
    end
end

-- Registers blip
exports('RegisterBlip', function(data)
    return RegisterBlip(data)
end)

-- Deletes blip
exports('DeleteBlip', function(id)
    return DeleteBlip(id)
end)