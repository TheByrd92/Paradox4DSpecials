P4DRecipe = 
{
	local lewt = 
	{ 
		"Base.Axe",
		"Base.BallPeenHammer", 
		"Base.ClubHammer", 
		"Base.CarBatteryCharger", 
		"Base.Crowbar", 
		"Base.GardenSaw", 
		"Base.Hammer", 
		"Base.HandAxe", 
		"Base.Jack", 
		"Base.LugWrench", 
		"Base.Paintbrush", 
		"Base.PipeWrench", 
		"Base.BlowTorch", 
		"Base.AxeStone", 
		"Base.Saw", 
		"Base.Screwdriver", 
		"Base.Sledgehammer", 
		"Base.HammerStone", 
		"Base.TirePump", 
		"Base.WoodAxe", 
		"Base.WoodenMallet", 
		"Base.Spanner"
	}

	local hiLewt =
	{

	}

	function GetLootFromSkin(_, _, player)
		rndItmNum = ZombRand(#lewt)+1
		player:getInventory():AddItems(lewt[rndItmNum])
	end

	function GetHighLootFromSkin(_, _, player)
		rndItmNum = ZombRand(#hiLewt)+1
		player:getInventory():AddItems(hiLewt[rndItmNum])
	end
}