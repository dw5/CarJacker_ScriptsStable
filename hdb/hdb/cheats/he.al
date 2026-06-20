--SkeletonEnable(GetPlayer());--
--InitializeSkeleton(GetPlayer());--
--SkeletonEnable(GetPlayer());--

local player=GetPlayer();
local uzi=FindObject("uzi");

--taxi(player, id);--

--local player=GetPlayer();--
--local uzi=FindObject("uzi");--
SetNumber(uzi, "ammo", (GetNumber(uzi, "ammo") + 500));
local pistol=FindObject("pistol");
SetNumber(pistol, "ammo", (GetNumber(pistol, "ammo") + 500));

local player = GetPlayer ()
local money = GetNumber (player,"money",0)
local car = GetVehicle (GetPlayer ())

     SetNumber (player,"money",money + 1111)--
     SetNumber (player,"felony",0)
	 SetNumber (player,"health",1000)
	 
buy_item (0,"pistol","You got pistol")
buy_item (0,"uzi","You got uzi")

buy_item (0,"signaljammer","You got sattelite jammer")

 buy_item (0,"picklock", "You got picklock")
 buy_item (0,"key", "You got universal key")
 buy_item (0,"freqscanner","You got frequency scanner")
 buy_item (0,"enginebox","You got engine control box")
 buy_item (0,"chipkey","You got chip-key")

local fuel = GetNumber (car,"fuel")
buy_item (100,"fuel","Your tank is now full!")
local health = GetNumber (car,"health")
--local cost = (1 - health/100) * 300--
buy_item (0,"repair","Your car has been repaired")