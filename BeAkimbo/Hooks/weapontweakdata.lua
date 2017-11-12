Hooks:PostHook(weapontweakdata, "init", "BeAkimbo_WPTweakDatainit", function(wP)	
	for k, v in pairs(wP or {}) do
		if k:find('_beakimbo') then
			wP[k].animations = deep_clone(wP.x_usp.animations)
		end
	end
end)