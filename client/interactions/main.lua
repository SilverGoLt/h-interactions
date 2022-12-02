_interactions = {}
_ped = nil

---Interaction via Ui
---@param name string Interaction Name
---@param text string Interaction Label
---@param pos any vec3(0,0,0)
---@param action any Function
registerInteraction = function(name, text, pos, action, secondText, dist)
    local id = #_interactions + 1

	local distance = 3

	if dist and dist > -1 then
		distance = dist
	end

	if secondText then
		_interactions[id] = {
			name = name,
			text = text,
			pos = pos,
			action = action,
			secondText = secondText,
			distance = distance
		}
	else
		_interactions[id] = {
			name = name,
			text = text,
			pos = pos,
			action = action,
			secondText = '',
			distance = distance
		}
	end

	return id
end

-- Remove Interaction
removeInteraction = function(id)
    if _interactions[id] ~= nil then
        _interactions[id] = nil
    end
end

modifySecondText = function(id, value)
	if _interactions[id] ~= nil then
		_interactions[id].secondText = value
	end
end

-- Lets fucking go bois and check for a local interaction :hehe:

function executeInteraction()
    local pos = GetEntityCoords(PlayerPedId())
    local vehicle = IsPedInAnyVehicle(PlayerPedId(), false)

    if vehicle then return end

    for _,v in pairs(_interactions) do
        local intPos = v.pos
       dist = #(pos - intPos)
        if dist < 3 then
            v.action()
            return
       end
    end
end

RegisterCommand('executeInteraction', function()
    executeInteraction()
end)

RegisterKeyMapping('executeInteraction', 'Interaction keybind', 'keyboard', 'E')

local isLoaded = false
RegisterNetEvent('ox:playerLoaded', function()
    if not isLoaded then
        isLoaded = true
        _ped = PlayerPedId()
        _startInteractionThread()
        _startNpcThread()
        npcThread()
    end
end)

--- Interaction Thread
local _iSleep = 1000
_startInteractionThread = function()
 CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        for k,v in pairs(_interactions) do
            local interaction = v
            dist = #(pos - vec3(interaction.pos.x, interaction.pos.y, interaction.pos.z))
            if dist < interaction.distance then
				-- Show interaction prompt via UI
                local scale = (100 - dist) / 100
                retval, screenX, screenY = GetScreenCoordFromWorldCoord(interaction.pos.x, interaction.pos.y, interaction.pos.z)

                sendToUI('showInteraction', {
                    x = screenX,
                    y = screenY,
                    scale = scale,
                    text = interaction.text,
					secondText = interaction.secondText,
                    display = true
                })
                _iSleep = 20
                break
            else
                _iSleep = 1000
            end
        end
        Wait(_iSleep)
    end
 end)
end

-- NPC Interaction Thread
local _niSleep = 1000
_startNpcThread = function ()
 CreateThread(function()
	local showing = false
    while true do
        local pos = GetEntityCoords(PlayerPedId())
		local inZone = false
        for i = 1, #_npcs do
            local npc = _npcs[i]
            local nPos = npc.details.pos
            dist = #(nPos - pos)
            if dist < 3 and npc.spawned then
				inZone = true
                -- Show interaction prompt via UI
                local headID = GetPedBoneIndex(npc.entity, 31086)
                local headPos = GetWorldPositionOfEntityBone(npc.entity, headID)
                retval, screenX, screenY = GetScreenCoordFromWorldCoord(headPos.x, headPos.y, headPos.z)
                local scale = (100 - dist) / 100
				showing = true
                sendToUI('showInteraction', {
                    x = screenX,
                    y = screenY,
                    scale = scale,
                    display = true
                })

                _niSleep = 25
                break
            end
        end
		if not inZone and showing then
			showing = false
			sendToUI('showInteraction', {
                display = false
            })
			_niSleep = 1000
		end
        Wait(_niSleep)
    end
 end)
end

exports('registerInteraction', function(data)
    return registerInteraction(data.name, data.text, data.pos, data.action, data.secondText, data.dist)
end)

exports('modifySecond', function(id, value)
	modifySecondText(id, value)
end)

exports('removeInteraction', function(id)
    return removeInteraction(id)
end)
