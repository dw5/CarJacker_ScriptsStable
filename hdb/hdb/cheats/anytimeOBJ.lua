-- NOTE: Anything thats in sanjose_s will be executed yet again, expect duplicates!!

local x, y, z=GetPosition(GetPlayer());
local player=GetPlayer();
local px, py, pz=GetPosition(PLAYER);

console("set level menu");
--SetDriver(FindObject("models\\bus"), player, roadnetwork);-- -- not good for traffic vechicles bc buggs out.. even if custom. should be ok if newly spawned one though

id=InsertObject("models\\teen", px, py, pz);
		Cmd(id, "movementscale 1.3");
		Cmd(id, "afraid");
		Cmd(id, "courage 100");
		SetUpdateFunction(id, "scumbag");
		--SetRoadNetwork(id, roadnetwork);
		SetNumber(id, "health", 200);
		SetNumber(id, "badguy", 1);
		
		EnableClipDistance(id, 0);
		GenNormals(id, 1);
		
console("set level sanjose");