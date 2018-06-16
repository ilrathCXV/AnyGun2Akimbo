local AkimboPigletGrenadeLauncher_WeaponFactoryManager_get_part_desc_by_part_id_from_weapon = WeaponFactoryManager.get_part_desc_by_part_id_from_weapon

function WeaponFactoryManager:get_part_desc_by_part_id_from_weapon(part_id, factory_id, blueprint)
	return AkimboPigletGrenadeLauncher_WeaponFactoryManager_get_part_desc_by_part_id_from_weapon(self, part_id, factory_id:gsub("_beakimbo", ""), blueprint)
end

local AkimboPigletGrenadeLauncher_WeaponFactoryManager_part_data = WeaponFactoryManager._part_data

function WeaponFactoryManager:_part_data(part_id, factory_id, override)
	return AkimboPigletGrenadeLauncher_WeaponFactoryManager_part_data(self, part_id, factory_id:gsub("_beakimbo", ""), override)
end

local AkimboPigletGrenadeLauncher_WeaponFactoryManager_add_part = WeaponFactoryManager._add_part

function WeaponFactoryManager:_add_part(p_unit, factory_id, part_id, forbidden, override, parts, third_person, ...)
	local part = self:_part_data(part_id, factory_id, override)
	local unit_name = third_person and part.third_unit or part.unit
	if not unit_name then
		return
	end
	return AkimboPigletGrenadeLauncher_WeaponFactoryManager_add_part(self, p_unit, factory_id, part_id, forbidden, override, parts, third_person, ...)
end

local AkimboPigletGrenadeLauncher_WeaponFactoryManager_preload_part = WeaponFactoryManager._preload_part

function WeaponFactoryManager:_preload_part(factory_id, part_id, forbidden, override, parts, third_person, ...)
	local part = self:_part_data(part_id, factory_id, override)
	local unit_name = third_person and part.third_unit or part.unit
	if not unit_name then
		return
	end
	return AkimboPigletGrenadeLauncher_WeaponFactoryManager_preload_part(self, factory_id, part_id, forbidden, override, parts, third_person, ...)
end