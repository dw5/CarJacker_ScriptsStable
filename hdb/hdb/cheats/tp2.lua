local x, y, z=GetPosition(GetPlayer());
local player=GetPlayer();
local px, py, pz=GetPosition(PLAYER);
print(px);
print(py);
print(pz);

-- todo if angle then move that angle, plus new script just to get up in sky

if(GetNumber(player, "modteleport2")==0) then
print("modteleport2 is zero");
print("GOOOOO!")
Cmd(player, "movementscale 37");
SetNumber(player, "modteleport2", 1);
else
print("modteleport2 is true");
print("i deactivate myself")
Cmd(player, "movementscale 1");
SetNumber(player, "modteleport2", 0);
end