Hooks:PostHook(PlayerTweakData, "init", "AkimboPigletGrenadeLauncher_PlayerTweakData", function(self)
	if self.stances.ray then
		self.stances.ray_beakimbo = deep_clone(self.stances.ray)
	end
end) 
