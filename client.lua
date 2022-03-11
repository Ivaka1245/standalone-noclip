local noclip = false
local noclip_speed = 1.0

CreateThread(function()
	while true do
		sleep = 500
		if(noclip)then
			sleep = 0
		    local ped = PlayerPedId()
            local x,y,z = getPosition()
            local dx,dy,dz = getCamDirection()
            local speed = noclip_speed
		    SetEntityVisible(PlayerPedId(), false, false)
		    SetEntityInvincible(PlayerPedId(), true)
            SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
    
            if IsControlPressed(0, 21) then
            	speed = speed + 3
            end

            if IsControlPressed(0, 19) then
            	speed = speed - 0.5
            end
    
            if IsControlPressed(0,32) then
                x = x+speed*dx
                y = y+speed*dy
                z = z+speed*dz
			end

      	    if IsControlPressed(0,269) then
                x = x-speed*dx
                y = y-speed*dy
                z = z-speed*dz
      	    end

            SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
      	else
      	    SetEntityVisible(PlayerPedId(), true, false)
      	    SetEntityInvincible(PlayerPedId(), false)
	    end
		Wait(sleep)
	end
end)

RegisterNetEvent("noclip:active")
AddEventHandler("noclip:active", function()
	local msg = "disabled"

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)

function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    return x,y,z
end

function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)
    local len = math.sqrt(x*x+y*y+z*z)

    if len ~= 0 then
      x = x/len
      y = y/len
      z = z/len
    end

    return x,y,z
end