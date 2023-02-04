--Function to be used elsewhere inside this "class"
local function GetHypotenuse(zX, zY, pX, pY)
    return math.abs((zX-pX)^2 + math.abs(zY-pY)^2)^0.5;
end

--Meant to change behavior of specials.
function SpecialZombieAbilities()
	local spclZ = zombie

	local zStuff = zombie:getModData();
	local player = getPlayer();
	local rangeToPlayer = GetHypotenuse(spclZ:getX(), spclZ:getY(), player:getX(), player:getY());

	if zStuff.customType == P4DZGlobals.CHARGER_NUM then
		range = GetHypotenuse(spclZ:getX(), spclZ:getY(), player:getX(), player:getY())
		if rangeToPlayer < P4DZGlobals.CHARGER_MAX_RANGE_CHECK then
			zStuff.abilityTicker = zStuff.abilityTicker + 1;
			if rangeToPlayer <= P4DZGlobals.CHARGER_ABILITY_RANGE then
				if zStuff.abilityTicker >= P4DZGlobals.CHARGER_CD then
					player:setKnockedDown(true);
					zStuff.abilityTicker = 0;
				end
			end
		end
	elseif zStuff.customType == P4DZGlobals.BOOMER_NUM then
		if isInRangeIncl(spclZ:getX(), spclZ:getY(), player:getX(), player:getY()) then
			
		end
	elseif zStuff.customType == P4DZGlobals.RECLAIMER_NUM then
		if isInRangeIncl(spclZ:getX(), spclZ:getY(), player:getX(), player:getY()) then
			
		end
	end
end

Events.OnZombieUpdate.Add(SpecialZombieAbilities)