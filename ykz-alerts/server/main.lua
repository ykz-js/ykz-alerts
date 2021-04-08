ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ykz_alertas:carJackInProgress')
AddEventHandler('ykz_alertas:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender)
    mytype = 'police'
    data = {["code"] = 'QTH', ["name"] = 'Robo de vehiculo'   ..vehicleLabel..  '.', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('ykz_alertas:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('ykz_alertas:combatInProgress', -1, targetCoords)
    TriggerClientEvent('ykz_alertas:carJackInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('ykz_alertas:combatInProgress')
AddEventHandler('ykz_alertas:combatInProgress', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = 'QTH', ["name"] = 'Pelea en progreso', ["loc"] = streetName}
    length = 2500
    TriggerClientEvent('ykz_alertas:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('ykz_alertas:combatInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('ykz_alertas:gunshotInProgress')
AddEventHandler('ykz_alertas:gunshotInProgress', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = 'QTH', ["name"] = 'Tiroteo en progreso', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('ykz_alertas:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('ykz_alertas:gunshotInProgress', -1, targetCoords)
end, false)

ESX.RegisterServerCallback('ykz_alertas:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)
