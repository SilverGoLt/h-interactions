--Vec 3 pos with heading
RegisterCommand('vec3', function(source)
    local ped = GetPlayerPed(source)
    local pos = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    print(string.format('vec3(%s, %s, %s), heading = %s', pos.x, pos.y, pos.z, heading))
end)
