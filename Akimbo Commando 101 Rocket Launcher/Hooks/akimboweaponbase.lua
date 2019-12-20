Hooks:PostHook(AkimboWeaponBase, "create_second_gun", "AkimboRayLauncherWeaponBaseInit", function(self)
	if tostring(self.class_alt) == "AkimboRayLauncherWeaponBase" then
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
		self.shotgun_shell_data = function ()
			return nil
		end
		self._use_shotgun_reload = true
		self._client_authoritative = true
		self._projectile_type = self:weapon_tweak_data().projectile_type
		if self._second_gun and self._second_gun:base() then
			self._second_gun:base()._adjust_throw_z = function()
			end
			self._second_gun:base()._get_spawn_offset = function ()
				return 0
			end
			self._second_gun:base().charge_multiplier = function ()
				return 1
			end
			self._second_gun:base().projectile_speed_multiplier = function ()
				return 1
			end
			self._second_gun:base().should_reload_immediately = function ()
				return true
			end
			self._second_gun:base().charge_fail = function ()
				return false
			end
			self._second_gun:base().shotgun_shell_data = function ()
				return nil
			end
			self._second_gun:base()._use_shotgun_reload = true
			self._second_gun:base()._client_authoritative = true
			self._second_gun:base()._projectile_type = self.alt_projectile_type
		end
		local ply_unit = managers.player:player_unit()
		if not ply_unit or not alive(ply_unit) then
			
		else
			local PlyStandard = ply_unit:movement() and ply_unit:movement()._states.standard
			if not PlyStandard then
				
			else
				for _, loadme in pairs({self:weapon_tweak_data().projectile_type, self.alt_projectile_type}) do
					local data = tweak_data.blackmarket.projectiles[loadme]
					if data then
						local unit_name = Idstring(not Network:is_server() and data.local_unit or data.unit)
						if not managers.dyn_resource:is_resource_ready(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE) then
							managers.dyn_resource:load(Idstring("unit"), unit_name, managers.dyn_resource.DYN_RESOURCES_PACKAGE)
						end
					end
				end
			end
		end
	else
		self.class_alt = nil
	end
end)

local AkimboRayLauncherWeaponBase_fire_raycast = AkimboWeaponBase._fire_raycast

function AkimboWeaponBase:_fire_raycast(unit, from_pos, ...)
	local data = {...}
	if self.class_alt and self.class_alt == "AkimboRayLauncherWeaponBase" then
		if self._fire_second_gun_next and self._second_gun and alive(self._second_gun) then
			from_pos = self._second_gun:position()
			self._fire_second_gun_next = false
		else
			self._fire_second_gun_next = true
		end
		return ProjectileWeaponBase._fire_raycast(self, unit, from_pos, ...)
	end
	return AkimboRayLauncherWeaponBase_fire_raycast(self, ...)
end