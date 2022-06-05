local inMemConfig

local this = {}

--Static Config (stored right here)
this.static = {
    modName = "Realistic Archery",
    modDescription =
    [[Projectiles always do damage when they hit the target, but the accuracy of their trajectory is now based on the shooter's marksman skill.]],
}

--MCM Config (stored as JSON)
this.configPath = "realisticArchery"
this.mcmDefault = {
    enabled = true,
    logLevel = "INFO",
    maxNoise = 15,
    minDistanceFullDamage = 1000,
    sneakReduction = 25,
    maxCloseRangeDamageReduction = 90,
}
this.save = function(newConfig)
    inMemConfig = newConfig
    mwse.saveConfig(this.configPath, inMemConfig)
end

this.mcm = setmetatable({}, {
    __index = function(_, key)
        inMemConfig = inMemConfig or mwse.loadConfig(this.configPath, this.mcmDefault)
        return inMemConfig[key]
    end,
    __newindex = function(_, key, value)
        inMemConfig = inMemConfig or mwse.loadConfig(this.configPath, this.mcmDefault)
        inMemConfig[key] = value
        mwse.saveConfig(this.configPath, inMemConfig)
    end
})

return this