Hooks:PostHook(PlayerTweakData, "init", "AkimboHeavyCrossbow_PlayerTweakData", function(self)
	self.stances.arblast_beakimbo = deep_clone(self.stances.arblast)
end) 
