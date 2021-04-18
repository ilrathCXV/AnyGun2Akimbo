function PlayerStandard:is_BEAKIMBO_goldeneye_weapon()
    local weapon_name_id = managers.player:equipped_weapon_unit():base():get_name_id()
    local is_goldeneye_reload = tweak_data.weapon[weapon_name_id] and tweak_data.weapon[weapon_name_id].animations.akimbo_goldeneye_reload
    return is_goldeneye_reload
end

Hooks:PostHook(PlayerStandard, "_start_action_reload", "BEAKIMBO_reload_start_action_reload", function(self, t)
    local weapon = self._equipped_unit:base()
    if weapon and weapon:can_reload() and self:is_BEAKIMBO_goldeneye_weapon() then
        self:_stance_entered()
    end
end)

local BEAKIMBO_PlayerStandard__update_reload_timers = PlayerStandard._update_reload_timers
function PlayerStandard:_update_reload_timers(t, dt, input)
    local is_reload_interrupted = self._queue_reload_interupt
    local is_reload_over_shotgun = self._state_data.reload_exit_expire_t and self._state_data.reload_exit_expire_t <= t
    local is_reload_over_normal = self._state_data.reload_expire_t and self._state_data.reload_expire_t <= t or is_reload_interrupted
    local is_goldeneye_reload = self:is_BEAKIMBO_goldeneye_weapon()
    local reset_stance = (is_reload_interrupted or is_reload_over_normal or is_reload_over_shotgun)and is_goldeneye_reload
    
    BEAKIMBO_PlayerStandard__update_reload_timers(self, t, dt, input)

    if reset_stance then
        log("is_reload_interrupted"..tostring(is_reload_interrupted))
        log("is_reload_over"..tostring(is_reload_over))
        log("is_goldeneye_reload"..tostring(is_goldeneye_reload))
    end
    if reset_stance then
        self:_stance_entered()
    end
end