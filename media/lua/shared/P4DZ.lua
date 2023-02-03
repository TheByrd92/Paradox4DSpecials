--Author: Ian Byrd
--2/2/2023
--These comments are as I understand this lua crap. All information is probably wrong.
--I used https://www.tutorialspoint.com/execute_lua_online.php to test this online.

--Name of the "object/class"
P4DZ = { }

--Constructor
function P4DZ:new(sZ, nm, spwnChnc, hP, ablRng, ablCd, ablLngth)
    sZ = sZ or {}
    setmetatable(sZ, self)
    self.__index = self
    self.nm = nm
    self.spwnChnc = spwnChnc
    self.hP = hP
    self.ablRng = ablRng
    self.ablCd = ablCd
    self.ablLngth = ablLngth
    return sZ
end

--Function to be used elsewhere inside this "class"
local function getHypotenuse(zX, zY, pX, pY)
    return math.abs((zX-pX)^2 + math.abs(zY-pY)^2)^0.5;
end

--Inclusive range check for the zombibo returns true or false respectively.
function P4DZ:isInRangeIncl(zX, zY, pX, pY)
	return getHypotenuse(zX, zY, pX, pY) <= self.ablRng
end

--Exclusive range check for the zombibo returns true or false respectively.
function P4DZ:isInRangeExcl(zX, zY, pX, pY)
	return getHypotenuse(zX, zY, pX, pY) < self.ablRng
end

--Checks if a number is bigger than the ablCd (exclusive).
function P4DZ:isSpecialAblTime(updatePasses)
    return updatePasses > self.ablCd
end

--Checks if a number is smaller than ablLngth (exclusive).
function P4DZ:isAblActy(updatePasses)
    return updatePasses < self.ablLngth;  
end