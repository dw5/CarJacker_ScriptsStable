local x, y, z=GetPosition(GetPlayer());
local player=GetPlayer();
local px, py, pz=GetPosition(PLAYER);

if (0>=1) then
print("START DEBUG");
print(px);
print(py);
print(pz);

print(GetVehicle (GetPlayer ()))
print(GetNumber(player, "modplacestp"));
print("END DEBUG");
end

local maxplacesarray=9;
local curplaceid=GetNumber(player, "modplacestp");
if (curplaceid < 1 or curplaceid > maxplacesarray) then
	curplaceid = 1;
end
print("WAS PLACE ID ".. curplaceid);

places = {
"306583 4750 325544 4",      --// 1 cementary
"496519 5265 407490",            --// 2 hangar
"401512 3648 411554",            --// 3 mission 1 taxi spawn
"445503 3059 415041 -2.8",            --// 4 blacktruck
"419453 3730 460280",            --// 5 hunt down the freeman
"371887 4047 401271 -2.8",            --// 6 glitched street (epic car physics)
"400306 3632 444727",            --// 7 glitched street (walk collision)
"393389 4069 488142",            --// 8 CHINATOWN
"380989.5625 3569.9375 337396.71875"            --// Mission 5 "first spot"
}

--for i = 0, 2 do
--   print(places[i])
--end

print("spawn ", places[7]);

-- todo if angle then move that angle, plus new script just to get up in sky

if((GetVehicle (GetPlayer ()))==0) then
print("outcar");
plcteleportthe=GetPlayer();

else

print("incar");
plcteleportthe=GetVehicle(GetPlayer());

end

local exeme="spawn ".. places[curplaceid];
--local exeme="spawn ".. places[curplaceid];
Cmd(plcteleportthe, exeme)

local nextplaceid = curplaceid + 1;
if (nextplaceid > maxplacesarray) then
	nextplaceid = 1;
end
SetNumber(player, "modplacestp", nextplaceid);

--print(GetNumber(player, "modplacestp"));--
print("thank you for using planet express services~ <3");