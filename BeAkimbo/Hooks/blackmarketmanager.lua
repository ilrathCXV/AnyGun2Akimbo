local BeAkimbo_BlackMarketManager_get_weapon_icon_path = BlackMarketManager.get_weapon_icon_path

function BlackMarketManager:get_weapon_icon_path(weapon_id, ...)
	return BeAkimbo_BlackMarketManager_get_weapon_icon_path(self, weapon_id:gsub("_beakimbo", ""), ...)
end

local Locked_Bool = {true, true}

local function __BeAkimbo_Check_Lock_Again()
	for weapon_id, weapon_data in pairs(Global.blackmarket_manager.weapons) do
		if weapon_data.unlocked and weapon_id:find("_beakimbo") then
			local __base_wep = weapon_id:gsub("_beakimbo", "")
			local _wd = tweak_data.weapon[__base_wep] or nil
			if _wd then
				Global.blackmarket_manager.weapons[weapon_id].unlocked = Global.blackmarket_manager.weapons[__base_wep].unlocked
			end
		end
	end
end

Hooks:PostHook(BlackMarketManager, "_load_done", "__BeAkimbo_Check_Lock_Again2", function(...)
	if Locked_Bool[1] then
		Locked_Bool[1] = nil
		__BeAkimbo_Check_Lock_Again()
	end
end )

Hooks:PostHook(BlackMarketManager, "_setup", "__BeAkimbo_Check_Lock_Again1", function(...)
	if Locked_Bool[2] then
		Locked_Bool[2] = nil
		__BeAkimbo_Check_Lock_Again()
	end
end)