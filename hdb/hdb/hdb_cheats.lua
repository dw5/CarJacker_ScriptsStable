function hdbmsg(hdmsg, hdmsg2, hdmsg3)
print (hdmsg,hdmsg2, hdmsg3);
gui_AddMsg("GUI\\info", hdmsg,hdmsg2, hdmsg3);
end

function OnConsoleCmd(cmd)

if (cmd) and (strlen(cmd)<1) then do return end; end
local cmd=strlower(cmd); -- free improvement lol

	if (cmd=="skip") then SKIPMISSION=1; end
	
	if (cmd=="unlock") then SKIPMISSION=1; MISSIONS_PASSED=10; end
	
	if (cmd=="tp") then
		console("run scripts\\hdb\\cheats\\tp.lua");
		print((GetNumber(player, "modplacestp")));
		
		--if (GetNumber(player, "modplacestp")==nil) then
		--console("run m\\tp.lua");
		--print((GetNumber(player, "modplacestp")));
		--end
	end
	
	if (cmd=="tpp") then
		console("run scripts\\hdb\\cheats\\tp0.lua"); -- old tp --
	end
	if (cmd=="tppb") then
		console("run scripts\\hdb\\cheats\\tp2.lua"); -- tp "wallhack" by fast walk speed
	end
	if (cmd=="irun") then
		local player=GetPlayer();
		if(GetNumber(player, "modteleport2")==0) then
		print("modteleport2 is zero");
		print("GOOOOO!")
		Cmd(player, "movementscale 5");
		SetNumber(player, "modteleport2", 1);
		--Cmd(player, "anim run 1"); cant control unless move cmd--
		else
		print("modteleport2 is true");
		print("i deactivate myself")
		Cmd(player, "movementscale 1");
		SetNumber(player, "modteleport2", 0);
		--Cmd(player, "anim jump 1");--
		end
	end
	if (cmd=="guih") then
		gamegui_cmd("hide"); FPS=1;
	end
	if (cmd=="guis") then
		gamegui_cmd("show"); FPS=1;
	end
	if (cmd=="copfy") then SetNumber(GetVehicle (GetPlayer ()),   "police", 1); end
	if (cmd=="txfy") then
		SetNumber(GetVehicle (GetPlayer ()), "taxi", 1);
			Cmd(GetVehicle (GetPlayer ()), "unlock rightdoor");
			Cmd(GetVehicle (GetPlayer ()), "open rightdoor");
			Cmd(GetVehicle(GetPlayer ()), "reset");
			Cmd(GetVehicle(GetPlayer ()), "restore");
	end
	if (cmd=="turbofy") then
			Cmd(GetVehicle(GetPlayer ()), "defmaxspd 300");
			gui_AddMsg("GUI\\info", "Your car is now turbofast");
	end
	if (cmd=="moretime") then
		mission_curtime=0;
		print(mission_maxtime);
		print(mission_curtime); -- lowest or negative number = highest amount of time aka max time
	end
	if (cmd=="hdbheal") then
		console("run scripts\\hdb\\cheats\\he.al");
		--Cmd(GetVehicle(GetPlayer()), "reset");
		--Cmd(GetVehicle(GetPlayer()), "restore");
	end
	if (cmd=="hdbse") then
		Cmd(GetPlayer(), "StartEngine");
	end
	if (cmd=="mypos") or (cmd=="getpos") then
		local player=GetPlayer();
		local px, py, pz=GetPosition(PLAYER);
		print(px);
		print(py);
		print(pz);
	end
	if (cmd=="guifps") then
		console("FPS=1");
		gui_AddMsg("GUI\\info", "type 'FPS=0' to disable");
	end
	if (cmd=="imagod") or (cmd=="iamgod") then
		console("god=1");
		gui_AddMsg("GUI\\info", "just GOD");
	end
	if (cmd=="imagodd")or (cmd=="iamgodd") then
		mission_curid=87;
		console("god=1");
		gui_AddMsg("GUI\\info", "Super GOD");
	end
	if (cmd=="busdrv") then
		console("run scripts\\hdb\\cheats\\busdrv.lua");
	end
	if (cmd=="hdbgravity") then
		G_GRAVITY=-25; -- -25
		G_ITERATIONS=10; -- 10
		GAMEMODE=-1;
	end
	if (cmd=="hdbrdoor") then
		Cmd(cmd, "unlock rightdoor");
		Cmd(cmd, "open rightdoor");
	end
	
	if (cmd=="skydoff") then SkyDome("disable"); hdbmsg("skydome: disabled"); end
	if (cmd=="weatoff") then Weather("disable"); hdbmsg("weather: disabled"); end
	if (cmd=="skydon") then SkyDome("enable"); hdbmsg("skydome: enabled"); end
	if (cmd=="weaton") then Weather("enable"); hdbmsg("weather: enabled"); end
	if (cmd=="timlapon") then TimeSpeed=1; end
	if (cmd=="timlapoff") then TimeSpeed=0.01; end
	
	if (strfind (cmd, "hdbtime ")==1) then
	local addproprs = {n=0}
	gsub(cmd, "(%w+)", function (w) tinsert(%addproprs, w) end)
    print("set time to: ", addproprs[2]);
    SkyDome("time", addproprs[2]);
	end

	if (strfind (cmd, "hdbgrav ")==1) then
	gsub(cmd, "(%w+)", function (w) tinsert(%addproprs, w) end)
    print("set gravity to: ", addproprs[2]);
    G_GRAVITY=-addproprs[2];
	end
	
	if (cmd=="hdbw o") then Weather("overcast", 1); hdbmsg("set weather to: overcast"); end
	if (cmd=="hdbw c") then Weather("cloudy", 1); hdbmsg("set weather to: cloudy"); end
	if (cmd=="hdbw s") then Weather("storm", 1); hdbmsg("set weather to: storm"); end
	if (cmd=="hdbw f") then Weather("fine", 1); hdbmsg("set weather to: fine"); end
	if (cmd=="hdbw r") then Weather("reset", 1); hdbmsg("set weather to: reset"); end
	if (cmd=="hdbw clr") then Weather("clear", 1); hdbmsg("set weather to: clear"); end
	
	if (cmd=="giball") then
		--giveall();
			SetNumber(GetPlayer(), "picklock", 1);
			SetNumber(GetPlayer(), "key", 1);
			SetNumber(GetPlayer(), "haveweapon0", 1);
			SetNumber(GetPlayer(), "haveweapon1", 1);
			--SetNumber(GetPlayer(), "money", 5000);
			SetNumber(GetPlayer(), "felony", 0);
		gui_AddMsg("GUI\\info", "GIBBED ALL");
	end
	if (cmd=="lvcar") then
		Cmd(GetPlayer(), "CanOutOfCar 1");
	end
	if (cmd=="flvcar") then
	Cmd(GetPlayer(), "CanOutOfCar 1");
		Cmd(GetPlayer(), "AutoOutOfCar 1");
		Cmd(GetPlayer(), "OutOfCar");
		Cmd(GetPlayer(), "OutOfCar 1");
	end
	if (cmd=="hdbw x") then
	Weather("overcast", 1);
		TargetFog=90000;
        CurrentFog=90000;
		TargetRain=0;
		TargetRefl=9000;
	end
	if (cmd=="hdbhelp") then
	print("hdbeefup cheats | hdbhelp - it me! ");
	print("hdbw x - super clean weather | flvcar - force leave car | lvcar - leave car");
	print("giball - hdb edition of giveall() | hdbw [o/c/s] - weather Overcast/Cloudy/Storm | hdbgrav [x] - gravity | hdbtime [x] - set time");
	print("timlap[on/off] - timespeed | weaton[on/off] - weather feature | skyd[on/off] skydome feature | hdbrdoor right door side open");
	print("hdbgravity - default gravity | busdrv - force into a bus | imagodd OR iamgodd - supergod | imagod or iamgod - regular god");
	print("guifps - show FPS | mypos OR getpos - get player location | hdbse - instant engine start");
	print("hdbheal - heal, ammo, fuel, money, no felony | moretime - extend mission time | turbofy - faster current car (leave car and get back in)");
	print("txfy - taxify current car | copfy - copify current car | guis - gui show | guih - gui hide | irun - faster walking | tppb - teleport 2");
	print("tpp - teleport0 | tp - teleport to locations | unlock - 100 %game + level skip | skip - skips 99 % of levels\nDONE");
	end
end
print("HDB: cheats online");