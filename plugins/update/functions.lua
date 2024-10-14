function Update_CheckVersion()
	if not g_Version then
		return
	end
	
	local l_Url = string.format("http://api.steampowered.com/ISteamApps/UpToDateCheck/v1/?appid=730&version=%s", g_Version)
	
	PerformHTTPRequest(l_Url, function(p_Status, p_Body, p_Headers, p_Error)
		if p_Status ~= 200 then
			return
		end
		
		local l_Response = json.decode(p_Body)
		
		if type(l_Response) ~= "table" or l_Response["response"]["up_to_date"] then
			return
		end
		
		Update_RestartServer()
	end)
end

function Update_LoadConfig()
	config:Reload("update")
	
	g_Config = {}
	g_Config["update.tag"] = config:Fetch("update.tag")
	
	if not g_Config["update.tag"] or type(g_Config["update.tag"]) ~= "string" then
		g_Config["update.tag"] = "[Update]"
	end
end

function Update_LoadVersion()
	if not files:ExistsPath("steam.inf") then
		return l_Config
	end
	
	local l_Content = files:Read("steam.inf")
	local l_Content = string.split(l_Content, "\n")
	
	for i = 1, #l_Content do
		if string.sub(l_Content[i], 1, 13) == "PatchVersion=" then
			g_Version = string.sub(l_Content[i], 14)
			break;
		end
	end
end

function Update_ResetVars()
	g_Version = nil
end

function Update_RestartServer()
	if g_Timer_Think then
		StopTimer(g_Timer_Think)
		g_Timer_Think = nil
	end
	
	for i = 0, playermanager:GetPlayerCap() - 1 do
		local l_PlayerIter = GetPlayer(i)
		
		if l_PlayerIter and l_PlayerIter:IsValid() and not l_PlayerIter:IsFakeClient() then
			l_PlayerIter:SendMsg(MessageType.Chat, string.format("{lime}%s{default} The server is preparing for update", g_Config["update.tag"]))
			l_PlayerIter:SendMsg(MessageType.Chat, string.format("{lime}%s{default} The server is preparing for update", g_Config["update.tag"]))
			l_PlayerIter:SendMsg(MessageType.Chat, string.format("{lime}%s{default} The server is preparing for update", g_Config["update.tag"]))
			l_PlayerIter:SendMsg(MessageType.Chat, string.format("{lime}%s{default} The server is preparing for update", g_Config["update.tag"]))
			l_PlayerIter:SendMsg(MessageType.Chat, string.format("{lime}%s{default} The server is preparing for update", g_Config["update.tag"]))
			
			SetTimeout(3000, function()
				l_PlayerIter:SendMsg(MessageType.Console, string.format("%s The server is preparing for update\n", g_Config["update.tag"]))
				
				l_PlayerIter:SendMsg(MessageType.Console, string.format("%s\n", g_Config["update.tag"]))
				l_PlayerIter:SendMsg(MessageType.Console, string.format("%s\n", g_Config["update.tag"]))
				l_PlayerIter:SendMsg(MessageType.Console, string.format("%s\n", g_Config["update.tag"]))
				l_PlayerIter:SendMsg(MessageType.Console, string.format("%s\n", g_Config["update.tag"]))
				l_PlayerIter:SendMsg(MessageType.Console, string.format("%s\n", g_Config["update.tag"]))
				
				SetTimeout(100, function()
					if not l_PlayerIter:IsValid() then
						return
					end
					
					l_PlayerIter:Drop(DisconnectReason.Kicked)
				end)
			end)
		end
	end
	
	SetTimeout(5000, function()
		server:Execute("quit")
	end)
end