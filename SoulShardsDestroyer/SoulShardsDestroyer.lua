
--[[	AUTHOR: Zjadlbymc0s
		GitHub: https://github.com/Zjadlbymc0s
		Commands for Addon: 
			/ssd 
				(display help info)
			/ssd set X
				(instead of X insert Your limit)
			/ssd check
				(check the limit)
 ]]

local limit = 5

local frameLoad = CreateFrame("Frame")
frameLoad:RegisterEvent("ADDON_LOADED")
frameLoad:RegisterEvent("PLAYER_LOGOUT")

frameLoad:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "SoulShardsDestroyer" then
        -- Our saved variable, if they exist, have been loaded at this point.
        if not LimitSoulShards then
            -- This is the first time this addon is loaded; set to default values
            LimitSoulShards = 5
			limit = LimitSoulShards
		else
			limit = LimitSoulShards
        end

    elseif event == "PLAYER_LOGOUT" then
            -- Save the variable at which the character logs out
            LimitSoulShards = limit
    end
end)

local soulShardID = 6265

local frame = CreateFrame('FRAME',nil, UIParent)
frame:RegisterEvent('BAG_UPDATE')

frame:SetScript('OnEvent', function(self, event, ...)
  local counter = 0 
  for i = 0, 4 do 
    for j = 1, GetContainerNumSlots(i) do 
      local itemID = GetContainerItemID(i, j) 
      if itemID == soulShardID then 
        counter = counter + 1 
        if counter > limit then 
		  ClearCursor();
          PickupContainerItem(i, j) 
          DeleteCursorItem() 
        end 
      end 
    end
  end
end)

SlashCmdList["SOULSHARDSDESTROYER"] = function(msg, editbox)
	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
	if cmd == "set" and args ~= '' then
		check = tonumber(args)
		if not check then
			print('\|cFF6EFF91[SoulShardDestroyer]\|r \|cFFFF0000Error! The entered data is not correct.\|r')
		else
			limit = check
			PlaySoundFile("Sound/Creature/Illidan/BLACK_Illidan_04.wav")
			print("\|cFFE5E500Shard limit changed to: "..limit.."\|r")
		end
	elseif cmd == "check" and args == '' then
		print("\|cFFE5E500Shard limit is set to: "..limit.."\|r")
	else
		print("\|cFFE5E500############################\|r")
		print("\|cFFE5E500You can use the following commands:\|r")
		print("\|cFFE5E500\/ssd set 5\|r - Set the limit")
		print("\|cFFE5E500\/ssd check\|r - Check the limit")
		print("\|cFFE5E500############################\|r")
	end

end

SLASH_SOULSHARDSDESTROYER1 = "/ssd"