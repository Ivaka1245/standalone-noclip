RegisterCommand('noclip', function(source, args, rawCommand)
	local src = source
    if IsPlayerAceAllowed(src, "admin") then
		TriggerClientEvent("noclip:active", src)
    else 
		TriggerClientEvent('chatMessage', src, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
    end
end, false)