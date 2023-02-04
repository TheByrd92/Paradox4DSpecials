--Function to be used elsewhere inside this "class"
local function GetHypotenuse(zX, zY, pX, pY)
    return math.abs((zX-pX)^2 + math.abs(zY-pY)^2)^0.5;
end

local SPEED_SPRINTER = 1
local SPEED_FAST_SHAMBLER = 2
local SPEED_SHAMBLER = 3

--Meant to change behavior of specials.
function SpecialZombieAbilities(zombie)
	local spclZ = zombie;
	local outfit = tostring(zombie:getOutfitName());
	
	local zStuff = zombie:getModData();
	local player = getPlayer();
	local rangeToPlayer = GetHypotenuse(spclZ:getX(), spclZ:getY(), player:getX(), player:getY());

	if outfit == CHARGER_OUTFIT_NAME then
		getSandboxOptions():set("ZombieLore.Speed", SPEED_SPRINTER);
		zombie:makeInactive(true);
		zombie:makeInactive(false);
		zombie:DoZombieStats();
		if rangeToPlayer < CHARGER_MAX_RANGE_CHECK then
			zStuff.abilityTicker = zStuff.abilityTicker + 1;
			if rangeToPlayer <= CHARGER_ABILITY_RANGE then
				if zStuff.abilityTicker >= CHARGER_CD then
					player:setKnockedDown(true);
					zStuff.abilityTicker = 0;
				end
			end
		end
	elseif outfit == BOOMER_OUTFIT_NAME then
		getSandboxOptions():set("ZombieLore.Speed", SPEED_FAST_SHAMBLER);
		zombie:makeInactive(true);
		zombie:makeInactive(false);
		zombie:DoZombieStats();
		if rangeToPlayer < BOOMER_MAX_RANGE_CHECK then
			zStuff.abilityTicker = zStuff.abilityTicker + 1;
			if rangeToPlayer <= BOOMER_ABILITY_RANGE then
				if zStuff.abilityTicker >= BOOMER_CD then
					zombie:getCurrentSquare():explode()
					zombie:playSound("BigExplosion")			
					WorldFlares.launchFlare(750, zombie:getX(), zombie:getY(), 5, 0, 1, 0, 0, 1, 0, 0);
					zombie:setHealth(0)
				end
			end
		end
	elseif outfit == RECLAIMER_OUTFIT_NAME then
		getSandboxOptions():set("ZombieLore.Speed", SPEED_SHAMBLER);
		zombie:makeInactive(true);
		zombie:makeInactive(false);
		zombie:DoZombieStats();
	else
		getSandboxOptions():set("ZombieLore.Speed", SPEED_SPRINTER);
		zombie:makeInactive(true);
		zombie:makeInactive(false);
		zombie:DoZombieStats();
	end
	
end

Events.OnZombieUpdate.Add(SpecialZombieAbilities)