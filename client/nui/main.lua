--Functions
---Displays UI
---@param name string UI Name
---@param display boolean Display UI
function displayUI(name, display)
    if display then
        local json = {action = 'closeUI', ui = name, args = {display = display}}
        SendNUIMessage(json)
        SetNuiFocus(true, true)
    else
        local json = {action = 'closeUI', ui = name, args = {display = display}}
        SendNUIMessage(json)
        SetNuiFocus(false, false)
    end
end

---Send data to Interface
---@param ui string Component Name
---@param args table {data}
function sendToUI(ui, args)
    local jsonas = {action = ui, args = args}
    SendNUIMessage(jsonas)
end