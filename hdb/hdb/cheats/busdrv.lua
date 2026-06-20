-- NOTE: Anything thats in sanjose_s will be executed yet again, expect duplicates!!

local x, y, z=GetPosition(GetPlayer());
local player=GetPlayer();
local px, py, pz=GetPosition(PLAYER);

console("set level menu");
SetDriver(FindObject("models\\bus"), player, roadnetwork);		
console("set level sanjose");