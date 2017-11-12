Hooks:PostHook(WeaponFactoryTweakData, "init", "BeAkimbo_TweakDatainit", function(wFac)	
	for k, v in pairs(wFac.parts or {}) do
		wFac.parts[k..'_beakimbo'] = deep_clone(v)
	end
end)