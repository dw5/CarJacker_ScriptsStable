local x, y, z=GetPosition(GetPlayer());
local player=GetPlayer();
local px, py, pz=GetPosition(PLAYER);
print(px);
print(py);
print(pz);

print(GetVehicle (GetPlayer ()))

-- todo if angle then move that angle, plus new script just to get up in sky

if((GetVehicle (GetPlayer ()))==0) then
print("outcar");
local cmd=format("turn %d %d %d 1", (px+100), (py+100), (pz+100));
Cmd(player, cmd);--
local cmd=format("move %d %d %d 1", (px+100), (py+100), (pz+100));
Cmd(player, cmd);--
local cmd=format("spawn %d %d %d 1", (px+100), (py+100), (pz+100));
Cmd(player, cmd);--
else
print("incar");
local player=GetVehicle(GetPlayer());
local cmd=format("turn %d %d %d 1", (px+100), (py+100), (pz+100));
Cmd(player, cmd);--
local cmd=format("move %d %d %d 1", (px+100), (py+100), (pz+100));
Cmd(player, cmd);
local cmd=format("spawn %d %d %d 1", (px+1000), (py+1000), (pz+1000));
Cmd(player, cmd);--
SetNumber (GetVehicle (GetPlayer ()),"health",1000)
end