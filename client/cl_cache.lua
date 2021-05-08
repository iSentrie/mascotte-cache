AddEventHandler("playerSpawned", function ()
	loadAfterSpawn()

	if Cache.ClientPedId then
		print('^1[^0CACHE^1]^0 Player ped just received an ID:'..Cache.ClientPedId)
	end
end)

-- Created by Mascotte45
-- Default cache data 
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
		Citizen.Wait(750)
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
	if Cache.ClientPedId then
		print('^1[^0CACHE^1]^0 Loaded after resource start.')
		loadAfterSpawn()
	end
end)
