-- Created by Mascotte45
-- Edited by iSentrie

AddEventHandler("playerSpawned", function ()
	loadAfterSpawn()

	if Cache.ClientPedId then
		print('^1[^0CACHE^1]^0 Player ped just received an ID:'..Cache.ClientPedId)
	end
end)

AddEventHandler('mascotte-cache:getCacheData', function(cb)
	cb(Cache)
end)

function getCacheData()
	return Cache
end

Cache = {}
Cache.ClientPlayerId = PlayerId()
Cache.ClientPedId = PlayerPedId()
Cache.PlayerFromServerId = GetPlayerFromServerId(Cache.ClientPlayerId)
Cache.GetPlayerPed = GetPlayerPed(Cache.PlayerFromServerId)
Cache.ClientGetEntityCoords = GetEntityCoords(Cache.ClientPedId) -- Get the player coords
Cache.IsPedOnFoot = IsPedOnFoot(Cache.PlayerPedId) -- True/False Is the player on foot or in a vehicle
Cache.PlayersLastVehicle = GetPlayersLastVehicle() -- Last vehicle player was in
Cache.IsPedSittingInAnyVehicle = IsPedSittingInAnyVehicle(Cache.ClientPedId) -- True/False Is the player sitting in a vehicle?
Cache.GetVehiclePedIsCurrentlyIn = GetVehiclePedIsIn(Cache.ClientPedId, false) -- Vehicle Player is currently in 
Cache.IsPedInAnyVehicle = IsPedInAnyVehicle(Cache.PlayerPedId, false) -- True/False is player in any kind of vehicle

-- Data
-- It's ran through this thread so we can set it to the data above in the cache table
Citizen.CreateThread(function()
	while true do
		Cache.ClientPlayerId = PlayerId()
		Cache.ClientPedId = PlayerPedId()
		Cache.PlayerFromServerId = GetPlayerFromServerId(Cache.ClientPlayerId)
		Cache.GetPlayerPed = GetPlayerPed(Cache.PlayerFromServerId)
		Cache.ClientGetEntityCoords = GetEntityCoords(Cache.ClientPedId)
		Cache.GetVehiclePedIsCurrentlyIn = GetVehiclePedIsIn(Cache.ClientPedId, false)
		Cache.IsPedInAnyVehicle = IsPedInAnyVehicle(Cache.ClientPlayerPedId, false)
		Cache.IsPedOnFoot = IsPedOnFoot(Cache.PlayerPedId)
		Cache.IsPedSittingInAnyVehicle = IsPedSittingInAnyVehicle(Cache.ClientPedId)
		Cache.PlayersLastVehicle = GetPlayersLastVehicle()
		Citizen.Wait(500)
	end
end)

function loadAfterSpawn()
	Cache.ClientPlayerId = PlayerId()
	Cache.ClientPedId = PlayerPedId()
	Cache.PlayerFromServerId = GetPlayerFromServerId(Cache.ClientPlayerId)
	Cache.GetPlayerPed = GetPlayerPed(Cache.PlayerFromServerId)
	Cache.ClientGetEntityCoords = GetEntityCoords(Cache.ClientPedId)
	Cache.GetVehiclePedIsCurrentlyIn = GetVehiclePedIsIn(Cache.ClientPedId, false)
	Cache.IsPedInAnyVehicle = IsPedInAnyVehicle(Cache.ClientPlayerPedId, false)
	Cache.IsPedOnFoot = IsPedOnFoot(Cache.PlayerPedId)
	Cache.IsPedSittingInAnyVehicle = IsPedSittingInAnyVehicle(Cache.ClientPedId)
	Cache.PlayersLastVehicle = GetPlayersLastVehicle()
end

AddEventHandler('onResourceStart', function()
	loadAfterSpawn()
	print('^1[^0CACHE^1]^0 Loaded after resource start.')

	if not Cache.ClientPedId then
		print('^1[^0CACHE^1]^0 Your player ped ID is missing.')
	end
end)
