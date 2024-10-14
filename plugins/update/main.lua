g_Function_Think = function()
	Update_CheckVersion()
end

AddEventHandler("OnPluginStart", function(p_Event)
	Update_ResetVars()
	Update_LoadConfig()
	Update_LoadVersion()
	
	if not g_Timer_Think then
		g_Timer_Think = SetTimer(60000, g_Function_Think)
	end
end)

AddEventHandler("OnMapLoad", function(p_Event, p_Map)
	Update_ResetVars()
	Update_LoadConfig()
	Update_LoadVersion()
	
	if not g_Timer_Think then
		g_Timer_Think = SetTimer(60000, g_Function_Think)
	end
end)