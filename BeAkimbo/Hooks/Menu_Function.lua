Hooks:Add("LocalizationManagerPostInit", "BeAkimbo_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["BeAkimbo_menu_title"] = "Be Akimbo",
		["BeAkimbo_menu_desc"] = " ",
		["BeAkimbo_menu_forced_update_all_title"] = "Update",
		["BeAkimbo_menu_forced_update_all_desc"] = " "
	})
end)

Hooks:Add("MenuManagerSetupCustomMenus", "BeAkimboOptions", function( menu_manager, nodes )
	MenuHelper:NewMenu("BeAkimbo_menu")
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "BeAkimboOptions", function( menu_manager, nodes )
	MenuCallbackHandler.BeAkimbo_menu_forced_update_callback = function(self, item)
		local Version = 8
		local mysplit = function(inputstr, sep)
			if sep == nil then
				sep = "%s"
			end
			local t={} ; i=1
			for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
				t[i] = str
				i = i + 1
			end
			return t
		end
		local _file = io.open('assets/mod_overrides/BeAkimbo/main.xml', "w")
		local banned = {saw = true, saw_secondary = true}
		if _file then
			_file:write('<table name=\"BeAkimbo\"> \n')
			_file:write('	<Localization directory="Loc" default="english.txt"/> \n')
			_file:write('	<AssetUpdates id="21295" name="asset_updates" folder_name="BeAkimbo" version="'.. Version ..'" provider="modworkshop"/> \n')
			_file:write('	<Hooks directory="Hooks"> \n')
			_file:write('		<hook file="Menu_Function.lua" source_file="lib/managers/menumanager"/> \n')
			_file:write('		<hook file="blackmarketmanager.lua" source_file="lib/managers/blackmarketmanager"/> \n')
			_file:write('		<hook file="weaponfactorymanager.lua" source_file="lib/managers/weaponfactorymanager"/> \n')
			_file:write('		<hook file="menucomponentmanager.lua" source_file="lib/managers/menu/menucomponentmanager"/> \n')
			_file:write('		<hook file="weaponfactorytweakdata.lua" source_file="lib/tweak_data/weaponfactorytweakdata"/> \n')
			_file:write('		<hook file="blackmarketgui.lua" source_file="lib/managers/menu/blackmarketgui"/> \n')
			_file:write('		<hook file="weapontweakdata.lua" source_file="lib/tweak_data/weapontweakdata"/> \n')
			_file:write('		<hook file="playertweakdata.lua" source_file="lib/tweak_data/playertweakdata"/> \n')
			_file:write('	</Hooks> \n')
			local _factory_id = ""
			local _weapon_lists = {}
			local _new_named_ids = {}
			local _cloned = {}
			local _new_units = {}
			local _Use_AkimboShotgunBase = {}
			for _weapon_id, _ in pairs(tweak_data.weapon) do
				_factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(_weapon_id)
				if _factory_id then
					table.insert(_weapon_lists, _weapon_id)
				end
			end
			for _, _weapon_id in ipairs(_weapon_lists) do
				if not banned[_weapon_id] and not _weapon_id:find('beakimbo') then
					_factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(_weapon_id)
					if _factory_id then
						local _wd = tweak_data.weapon[_weapon_id] or nil
						local _wfd = tweak_data.weapon.factory[_factory_id] or nil
						if _wd and not _wd.custom and not table.contains(_wd.categories, 'akimbo') and table.contains_any(_wd.categories, {'assault_rifle', 'smg', 'pistol', 'shotgun', 'lmg', 'snp'}) and _wfd and _wfd.unit then
							_new_units[_weapon_id] = _wfd.unit .. '_beakimbo'
							local _hold_base_on = ''
							if table.contains(_wd.categories, 'pistol') then
								_hold_base_on = 'jowi_pistol'
							else
								_hold_base_on = 'x_akmsu'
							end
							if table.contains(_wd.categories, 'shotgun') then
								_Use_AkimboShotgunBase[_weapon_id] = true
							end
							local _locked = ''
							--Loc
							local _new_weapon_id = _weapon_id ..'_beakimbo'
							_new_named_ids['bm_'.._new_weapon_id..'_name'] = '[AB] ' .. managers.localization:to_upper_text(_wd.name_id)
							local _desc_id = managers.localization:to_upper_text(tostring(_wd.desc_id))
							if _desc_id:find('ERROR') then _desc_id = ' ' end
							local _description_id = managers.localization:to_upper_text(tostring(_wd.description_id))
							if _description_id:find('ERROR') then _description_id = ' ' end
							_new_named_ids['bm_'.._new_weapon_id..'_desc'] = _desc_id
							_new_named_ids['bm_'.._new_weapon_id..'_desc_long'] = _description_id
							--Base
							_base_states = string.format('%s %s %s %s',
								(_wd.DAMAGE and 'DAMAGE="'.. _wd.DAMAGE ..'"' or ''), 
								(_wd.CLIP_AMMO_MAX and 'CLIP_AMMO_MAX="'.. (_wd.CLIP_AMMO_MAX*2) ..'"' or ''), 
								(_wd.NR_CLIPS_MAX and 'NR_CLIPS_MAX="'.. (_wd.NR_CLIPS_MAX*2) ..'"' or ''), 
								(_wd.AMMO_MAX and 'AMMO_MAX="'.. (_wd.AMMO_MAX*2) ..'"' or '')
								)
							_locked = string.format('%s %s', (_wd.global_value and 'global_value="'.. _wd.global_value ..'"' or ''), (_wd.texture_bundle_folder and 'texture_bundle_folder="'.. _wd.texture_bundle_folder ..'"' or ''))
							_file:write('	<WeaponNew> \n')
							_file:write('		<weapon id="'.. _new_weapon_id ..'" based_on="'.. _weapon_id ..'" weapon_hold="'.. _hold_base_on ..'" name_id="bm_'.. _new_weapon_id..'_name" desc_id ="bm_'.. _new_weapon_id ..'_desc" description_id="bm_'.. _new_weapon_id ..'_desc_long" '.. _base_states..' '.. _locked..'> \n')
							--selection_index
							_file:write('			<use_data selection_index="2"/> \n')
							--categories
							_file:write('			<categories> \n')
							_file:write('				<value_node value="akimbo"/> \n')
							_file:write('				<value_node value="'.. _wd.categories[1] ..'"/> \n')
							_file:write('			</categories> \n')
							--stats
							if _wd.stats and type(_wd.stats) == "table" then
								local stats = ''
								for _stat, _value in ipairs(_wd.stats) do
									stats = stats .. ' '.. _stat ..'="'.. _value ..'"'
								end
								_file:write('			<stats'.. stats ..'/> \n')
							end
							--stats_modifiers
							if _wd.stats_modifiers and type(_wd.stats_modifiers) == "table" then
								local stats_modifiers = ''
								for _stat, _value in ipairs(_wd.stats_modifiers) do
									stats_modifiers = stats_modifiers .. ' '.. _stat ..'="'.. _value ..'"'
								end
								_file:write('			<stats_modifiers'.. stats_modifiers ..'/> \n')
							end
							--default_blueprint
							_file:write('		</weapon> \n')
							_cloned[Idstring(_factory_id ..'_beakimbo'):key()] = true
							_file:write('		<factory id="'.. _factory_id ..'_beakimbo" based_on="'.. _factory_id ..'" unit="'.. _wfd.unit ..'_beakimbo"> \n')
							_file:write('			<default_blueprint> \n')
							for _, _part in ipairs(_wfd.default_blueprint) do
								_file:write('				<value_node value="'.. _part ..'"/> \n')
							end
							_file:write('			</default_blueprint> \n')
							--uses_parts
							_file:write('			<uses_parts> \n')
							for _, _part in ipairs(_wfd.uses_parts) do
								_file:write('				<value_node value="'.. _part ..'"/> \n')
							end
							_file:write('			</uses_parts> \n')
							_file:write('		</factory> \n')
							_file:write('		<stance/> \n')
							_file:write('	</WeaponNew> \n')
						end
					end
				end
			end
			local _ptweak_file = io.open('assets/mod_overrides/BeAkimbo/Hooks/playertweakdata.lua', "w+")
			if _ptweak_file then
				_ptweak_file:write('Hooks:PostHook(PlayerTweakData, "init", "BeAkimboPlayerTweakData", function(self) \n')
				_ptweak_file:write('	local _standard = self.stances.x_usp.standard \n')
				_ptweak_file:write('	local _crouched = self.stances.x_usp.crouched \n')
				_ptweak_file:write('	local _steelsight = self.stances.x_usp.steelsight \n')
				for _weapon_id, _ in pairs(_new_units) do
					_ptweak_file:write('	self.stances.'.. _weapon_id ..'_beakimbo.standard = _standard \n')
					_ptweak_file:write('	self.stances.'.. _weapon_id ..'_beakimbo.crouched = _crouched \n')
					_ptweak_file:write('	self.stances.'.. _weapon_id ..'_beakimbo.steelsight = _steelsight \n')
				end
				_ptweak_file:write('end) \n')
				_ptweak_file:close()
			end
			local _mod_path = Application:base_path()..'assets/mod_overrides/BeAkimbo/'			
			_file:write('	<AddFiles directory="Assets"> \n')
			for _weapon_id, _nu in pairs(_new_units) do
				local _nus = mysplit(_nu, "/")
				local _nu_last = _nus[#_nus]
				_nus[#_nus] = nil
				local _nu_path = string.join('/', _nus)
				_file:write('		<unit path="'.. _nu ..'" force="true"/> \n')
				if true then
					os.execute('mkdir "'.. Application:nice_path(Application:base_path()..'assets/mod_overrides/BeAkimbo/Assets/'.. _nu_path, true) ..'"')
					local _unit_file = io.open('assets/mod_overrides/BeAkimbo/Assets/'.. _nu ..'.unit', "w+")					
					local _org_nu = _nu:gsub('_beakimbo', '')
					local xml_node = ''
					if DB:has('unit', _org_nu) then
						xml_node = DB:load_node('unit', _org_nu)
					end
					if _unit_file then
						if xml_node then
							local xml_node_children = xml_node:children()
							local _objectfile = ''
							local _bnk = ''
							local _ex = ''
							local _AkimboBase = 'AkimboWeaponBase'
							if _Use_AkimboShotgunBase[_weapon_id] then
								_AkimboBase = 'AkimboShotgunBase'
							end
							for node in xml_node_children do
								if node:name() == 'object' then
									_objectfile = tostring(node:parameter("file"))
								end
								if node:name() == 'dependencies' then
									for node_i in node:children() do
										_bnk = tostring(node_i:parameter("bnk"))
									end
								end
							end
							_unit_file:write('<unit type="wpn" slot="1" > \n')
							_unit_file:write('	<object file="'.. _objectfile ..'" /> \n')
							_unit_file:write('	<dependencies> \n')
							_unit_file:write('		<depends_on bnk="'.. _bnk ..'"/> \n')
							_unit_file:write('	</dependencies> \n')
							_unit_file:write('	<extensions> \n')
							_unit_file:write('		<extension name="unit_data" class="ScriptUnitData" /> \n')
							_unit_file:write('			<extension name="base" class="'.. _AkimboBase ..'" > \n')
							_unit_file:write('			<var name="name_id" value="'.. _weapon_id ..'_beakimbo" /> \n')
							_unit_file:write('		</extension> \n')
							_unit_file:write('	</extensions> \n')
							_unit_file:write('</unit> \n')
						end
						_unit_file:close()
					end
				end
			end
			_file:write('	</AddFiles> \n')
			_file:write('</table>')
			_file:close()
			_file = io.open('assets/mod_overrides/BeAkimbo/Loc/english.txt', "w+")
			_file:write(json.encode(_new_named_ids))
			_file:close()
			local _dialog_data = {
				title = "[Be Akimbo]",
				text = "Please reboot the game.",
				button_list = {{ text = "[OK]", is_cancel_button = true }},
				id = tostring(math.random(0,0xFFFFFFFF))
			}
			managers.system_menu:show(_dialog_data)
		end
	end
	MenuHelper:AddButton({
		id = "BeAkimbo_menu_forced_update_callback",
		title = "BeAkimbo_menu_forced_update_all_title",
		desc = "BeAkimbo_menu_forced_update_all_desc",
		callback = "BeAkimbo_menu_forced_update_callback",
		menu_id = "BeAkimbo_menu",
	})
end)

Hooks:Add("MenuManagerBuildCustomMenus", "BeAkimboOptions", function(menu_manager, nodes)
	nodes["BeAkimbo_menu"] = MenuHelper:BuildMenu( "BeAkimbo_menu" )
	MenuHelper:AddMenuItem(nodes["blt_options"], "BeAkimbo_menu", "BeAkimbo_menu_title", "BeAkimbo_menu_desc")
end)