local STANCE_MOD_GOLDENEYE = {translation = Vector3(0, 0, -100), rotation = Rotation(0, 0, 0)}
local BEAKIMBO_goldeneye_reload_clbk_stance_entered = FPCameraPlayerBase.clbk_stance_entered
function FPCameraPlayerBase:clbk_stance_entered(new_shoulder_stance, new_head_stance, new_vel_overshot, new_fov, new_shakers, stance_mod, ...)
    local weapon_name_id = managers.player:equipped_weapon_unit():base():get_name_id()
    local is_goldeneye_reload = tweak_data.weapon[weapon_name_id] and tweak_data.weapon[weapon_name_id].animations.akimbo_goldeneye_reload
    local is_reloading = managers.player:player_unit():movement()._current_state:_is_reloading()
    local stance_mod = (is_reloading and is_goldeneye_reload) and STANCE_MOD_GOLDENEYE or stance_mod
    BEAKIMBO_goldeneye_reload_clbk_stance_entered(self, new_shoulder_stance, new_head_stance, new_vel_overshot, new_fov, new_shakers, stance_mod, ...)
end