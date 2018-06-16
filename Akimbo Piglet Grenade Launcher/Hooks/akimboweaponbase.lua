Hooks:PostHook(AkimboWeaponBase, "init", "AkimboLauncherWeaponBase_init", function(self)
	if tostring(self.class_alt) == "AkimboLauncherWeaponBase" then
		self._adjust_throw_z = function()
		end
		self._get_spawn_offset = function ()
			return 0
		end
		self.charge_multiplier = function ()
			return 1
		end
		self.projectile_speed_multiplier = function ()
			return 1
		end
		self.should_reload_immediately = function ()
			return true
		end
		self.charge_fail = function ()
			return false
		end
		self._client_authoritative = true
		self._projectile_type = self:weapon_tweak_data().projectile_type
	else
		self.class_alt = nil
	end
end)

local AkimboLauncherWeaponBase_fire_raycast = AkimboWeaponBase._fire_raycast

function AkimboWeaponBase:_fire_raycast(...)
	if self.class_alt and self.class_alt == "AkimboLauncherWeaponBase" then
		if self._fire_second_gun_next and self._second_gun and alive(self._second_gun) then
			self._second_gun:base().super.fire(self._second_gun:base(), ...)
			self._fire_second_gun_next = false
		else
			if self._second_gun and alive(self._second_gun) then
				self._second_gun:base()._projectile_type = self.alt_projectile_type
			end
			self._fire_second_gun_next = true
		end
		return ProjectileWeaponBase._fire_raycast(self, ...)
	end
	return AkimboLauncherWeaponBase_fire_raycast(self, ...)
end