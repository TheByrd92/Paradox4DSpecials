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

--Meant to change behavior of specials.
--mutated Zs based off of the settings (probably) found above.
function SpecialZombieAbilities()
	--Get that sweet zombibo data I think
	local allZs = zombie:getModData()

	ForceUpdateZombieStats()
end

function findField(obj, fname)
  for i = 0, getNumClassFields(obj) - 1 do
    local fn = getClassField(obj, i)
    if tostring(fn) == fname then
      return fn
    end
  end
end

local SPEED_SPRINTER        = 1
local SPEED_FAST_SHAMBLER   = 2
local SPEED_SHAMBLER        = 3

--I would rather not update stats for no reason on already spawned zombies.
--So I'm trying to spawn them at intervals I wonder though if this will
--Create zombies like I want it to.
function CreateASpecial()
	local p = getPlayer();
	
	
	spclZ = createZombie(p:getX(), p:getY(), p:getZ(), nil, 0, IsoDirections.E)
	
	local extraStuff = spclZ:getModData()
	extraStuff.customType = "Charger"
	print(extraStuff.customType)
	
	getSandboxOptions():set("ZombieLore.Speed", SPEED_SHAMBLER)
	spclZ:makeInactive(true)
	spclZ:makeInactive(false)
	getSandboxOptions():set("ZombieLore.Speed", SPEED_SPRINTER)
	
	print(spclZ:getX() , " : " , spclZ:getY())
	
	local speedType = findField(spclZ, "public int zombie.characters.IsoZombie.speedType")
	local speedTypeVal = getClassFieldVal(spclZ, speedType)
	
	print(speedTypeVal)
	
	spclZ:dressInPersistentOutfit()
end


Events.EveryTenMinutes.Add(CreateASpecial)
--Events.OnZombieUpdate.Add(SpecialZombieAbilities)