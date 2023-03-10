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

function findField(obj, fname)
  for i = 0, getNumClassFields(obj) - 1 do
    local fn = getClassField(obj, i)
    if tostring(fn) == fname then
      return fn
    end
  end
end

local OOB_X_1 = 11700
local OOB_X_2 = 15000
local OOB_Y_1 = 4800
local OOB_Y_2 = 900
local DRIFT_VARIANCE = 5
local TOO_CLOSE_NUMBER = 80
local QUAD_DIST = 80

function GetRandomPlayer()
	local chosenPlayer;
	
	if isServer() then
		local players = getOnlinePlayers();
		local chosenOne = ZombRand(#onlinePlayers)+1;
		chosenPlayer = onlinePlayers[chosenOne];
	else
		chosenPlayer = getPlayer();
	end
	
	return chosenPlayer;
end

function IsInBounds(x1, y1, x2, y2)
	if x1 > x and y1 > y then
		return true;
	else
		return false;
	end
end

function GetQuad(n)
	local toReturn
	
	if ZombRand(2) == 1 then
		toReturn = n - QUAD_DIST;
	else
		toReturn = n + QUAD_DIST;
	end
	
	return toReturn;
end

function GetDriftCoord()
	local toReturn
	
	if ZombRand(2) == 1 then
		toReturn = ZombRand(DRIFT_VARIANCE);
	else
		toReturn = -ZombRand(DRIFT_VARIANCE);
	end
	
	return toReturn;
end

function GetRandomCoord(n)
	local toReturn
	
	local q = GetQuad(n)
	local d = GetDriftCoord();
	
	toReturn = q + d;
	
	return toReturn;
end

function GetNearPlayer(pX, pY, zN)
	if not isServer() then
		return false;
	end
	
	local players = getOnlinePlayers();
	
	for i=1,#players,1
	do
		--Right Side
		local aX = pX + TOO_CLOSE_NUMBER;
		--Top Side
		local aY = pY - TOO_CLOSE_NUMBER;
		--Left Side
		local bX = pX - TOO_CLOSE_NUMBER;
		--Bot Side
		local bY = pY + TOO_CLOSE_NUMBER;
		
		--This is confusing
		if (zX < aX and zY < bY) or (zX > bX and zY > aY)then
			return players[i];
		end
	end
	
	return nil;
end

function GetNewCoordForNearPlayer(pX, pY, zN)
	local toReturn = false
	
	local possP = GetNearPlayer(pX, pY, zN);
	
	if possP ~= nil then
		coords = GetCoordForNearPlayer(pX, pY, zX, zY);
	end
	
	return toReturn;
end

--I would rather not update stats for no reason on already spawned zombies.
--So I'm trying to spawn them at intervals I wonder though if this will
--Create zombies like I want it to.
function CreateASpecial()
	local rP = GetRandomPlayer();
	
	local rX = GetRandomCoord(rP:getX());
	local rY = GetRandomCoord(rP:getY());
	
	spclZ = createZombie(rX, rY, 0 , nil, 0, IsoDirections.E);
	
	local zStuff = spclZ:getModData();

	local specialRandNum = ZombRand(SPECIAL_TOTAL)+1;
	if specialRandNum == CHARGER_NUM then
		spclZ:dressInPersistentOutfit(CHARGER_OUTFIT_NAME);
		zStuff.abilityTicker = 0;
	elseif specialRandNum == BOOMER_NUM then
		spclZ:dressInPersistentOutfit(BOOMER_OUTFIT_NAME);
		zStuff.abilityTicker = 0;
	elseif specialRandNum == RECLAIMER_NUM then
		spclZ:dressInPersistentOutfit(RECLAIMER_OUTFIT_NAME);
		zStuff.abilityTicker = 0;
	end
	
	print(tostring(spclZ:getOutfitName()), " Spawned at: ", spclZ:getX(), ",", spclZ:getY())
	
	--local speedType = findField(spclZ, "public int zombie.characters.IsoZombie.speedType")
	--local speedTypeVal = getClassFieldVal(spclZ, speedType)
end

Events.EveryTenMinutes.Add(CreateASpecial)