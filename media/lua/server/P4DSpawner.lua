--Charger Defaults
chargerChnc = 10
chargerMinHP = 1000
chargerMaxHP = 1000
--Boomer Defaults
boomerChnc = 10
boomerMinHP = 1000
boomerMaxHP = 1000
--Reclaimer Defaults
reclaimerChnc = 10
reclaimerMinHP = 1000
reclaimerMaxHP = 1000

--Where I would put a config file settings import...
--IF I HAD ONE!!! (unused for now until I get better at this.)
function LoadZSettings()
	--Charger Defaults
	chargerChnc = 10
	chargerMinHP = 1000
	chargerMaxHP = 1000
	--Boomer Defaults
	boomerChnc = 10
	boomerMinHP = 1000
	boomerMaxHP = 1000
	--Reclaimer Defaults
	reclaimerChnc = 10
	reclaimerMinHP = 1000
	reclaimerMaxHP = 1000
end

--This seems really janky or slow. I'll have to look into what
--makeInactive(false) actually does.
local function ForceUpdateZombieStats()
	zombie:makeInactive(false)
	zombie:makeInactive(true)
	zombie:DoZombieStats()
end

--Meant to change normal Zs into the
--mutated Zs based off of the settings (probably) found above.
function CreateZsFromOtherZs()
	--Get that sweet zombibo data I think
	local allZs = zombie:getModData()

	allZs.

	ForceUpdateZombieStats()
end



Events.OnZombieUpdate.Add(CreateZsFromOtherZs)