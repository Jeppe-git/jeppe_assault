-- Jesper "jeppe"
ESX = nil
local cooldown = false

Citizen.CreateThread(
	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end
			)
			Citizen.Wait(0)
		end
	end
)

RegisterCommand('slap', function() 
    local closestPlayer, closestPlayerDst = ESX.Game.GetClosestPlayer()
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.5))

    if closestPlayerDst <= 2 and not cooldown and not IsEntityDead(PlayerPedId()) and not IsEntityDead(closestPlayer) then
        while not HasAnimDictLoaded('melee@unarmed@streamed_variations') do
            RequestAnimDict('melee@unarmed@streamed_variations')
            Citizen.Wait(150)
        end
        TaskPlayAnim(PlayerPedId(), 'melee@unarmed@streamed_variations', 'plyr_takedown_front_slap', 2.0, -1, -1, 0, 0, false, false, false)
        SetEntityCoords(closestPlayer, x, y, z - 2)
        SetEntityHeading(closestPlayer, GetEntityHeading(PlayerPedId()) - 180)
        Wait(750)
        SetPedToRagdoll(closestPlayer, 5000, 5000, 0, 0, 0, 0)
        cooldown = true
        Wait(Config.CooldownTime)
        cooldown = false
    elseif cooldown then
        ESX.ShowNotification('Du är lite trött i armen...')
    elseif closestPlayerDst > 2 then
        ESX.ShowNotification('Kunde inte hitta en spelare nära...')
    else
        ESX.ShowNotification('Det gick ej att örfila någon')
    end
end)

RegisterCommand('skalla', function() 
    local closestPlayer, closestPlayerDst = ESX.Game.GetClosestPlayer()
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.5))

    if closestPlayerDst <= 2 and not cooldown and not IsEntityDead(PlayerPedId()) and not IsEntityDead(closestPlayer) then
        while not HasAnimDictLoaded('melee@unarmed@streamed_core_fps') do
            RequestAnimDict('melee@unarmed@streamed_core_fps')
            Citizen.Wait(150)
        end
        TaskPlayAnim(PlayerPedId(), 'melee@unarmed@streamed_core_fps', 'plyr_takedown_front_headbutt', 2.0, -1, -1, 0, 0, false, false, false)
        SetEntityCoords(closestPlayer, x, y, z - 2)
        SetEntityHeading(closestPlayer, GetEntityHeading(PlayerPedId()) - 180)
        Wait(700)
        SetPedToRagdoll(closestPlayer, 5000, 5000, 0, 0, 0, 0)
        cooldown = true
        Wait(Config.CooldownTime)
        cooldown = false
    elseif cooldown then
        ESX.ShowNotification('Du är lite snurrig i skallen fortfarande...')
    elseif closestPlayerDst > 2 then
        ESX.ShowNotification('Kunde inte hitta en spelare nära...')
    else
        ESX.ShowNotification('Det gick ej att skalla någon')
    end
end)