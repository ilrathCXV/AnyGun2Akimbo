Hooks:PostHook(PlayerTweakData, "init", "AkimboPigletGrenadeLauncher_PlayerTweakData", function(self)
	self.stances.m32_beakimbo = deep_clone(self.stances.m32)
end) 
