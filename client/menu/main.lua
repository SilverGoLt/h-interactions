local menus = {}

---Creates the menu for a job or civilian interaction
---@param name string Menu Name
---@param job string Job Name
createMenu = function(name, dist, job)
    if not menus[name] then
        menus[name] = {
            name = name,
            job = job or nil,
            items = {},
            dist = dist or 3,
        }
    end
end

---Adds an item to the specified menu
---@param menu string Menu Name
---@param data table {title, description, action = function(entity) end}
addMenuItem = function(menu, data)
    if menus[menu] then
        main = menus[menu]
        main.items[#main.items + 1] = data
    end
end

---Returns job menu
---@param job string Job Name
---@return table Menu
getMenuByJob = function(job)
    local menu = nil
    for k, v in pairs(menus) do
        if v.job == job then
            menu = v
        end
    end
    return menu
end

---Opens the menu for a job or civlian interaction
openMenu = function()
    local job = nil
    local menu = getMenuByJob(job)
    if menu then
        sendToUI('showMenu', {
            name = menu.name,
            items = menu.items
        })
    end
end

---Returns closest player from defined area
---@param area number Area Size
---@diagnostic disable-next-line: undefined-doc-name
---@return player
getClosestPlayer = function(area)
    local _ped = PlayerPedId()
    local _pedPos = GetEntityCoords(_ped)
    local _player = nil
    local _dist = area
    local _players = GetActivePlayers()
    for i = 1, #_players do
        local player = _players[i]
        local pPos = GetEntityCoords(player.entity)
        local tPed = GetPlayerPed(player)
        local dist = #(pPos - _pedPos)
        if dist < _dist then
            _player = GetPlayerServerId(tPed)
        end
    end
    return _player or nil
end

exports('createMenu', createMenu)
exports('addMenuItem', addMenuItem)

RegisterNUICallback('itemAction', function(data, cb)
    local menu = menus[data.menu]
    if menu then
        local item = menu.items[data.item]
        if item then
            item.action(data.entity)
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterCommand('interactionMenu', function()
    openMenu()
end)

RegisterKeyMapping('interactionMenu','Player quick menu', 'keyboard', 'F5')
