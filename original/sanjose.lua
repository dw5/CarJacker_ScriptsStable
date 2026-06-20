mission_curid=0;
Fade(1, 1);
if (GetSetting("HighDetail")=="true") or (GetSetting("HighDetail")=="1") then
	SetSetting("TrafficDensity", "10");
else
	SetSetting("TrafficDensity", "8");
end

ClassForName("models\\van1", "car");
ClassForName("models\\tcar2", "car");
ClassForName("models\\pikap2", "car");
ClassForName("models\\tcar3", "car");
ClassForName("models\\furgon2", "car");
ClassForName("models\\chinamafiose", "character");
ClassForName("models\\teen", "character");
SKIPMISSION=0;
MusicRush=0;
MusicTimeOut=5;
CurrentGreenLight=0;
CurrentGreenLight3=0;
gui_raceMsgTimeout=0;
msg_alpha=0;
msg_minalpha=0;
gui_NumMessages=0;
MissionInfoTimeOut=0;
MBALPHA=0.7;
rebelMode=-1;
totalKills=0;
lastKillTime=-10;
LoadingPic=random(0, 2);
lastProgress=0;
MaxLoadTemplate=67;
TemplatesLoaded=0;
if (ACTIVEMISSION==11) then
	MaxLoadTemplate=(67 + 24);
end

function template_OnLoad()
	TemplatesLoaded=(TemplatesLoaded + 1);
	ShowLoadProgressBar(lastProgress);
end

prev_progress=-100;
function ShowLoadProgressBar(tprogress)
	local wait=0;
	if (tprogress==1000) then
		wait=1;
		tprogress=100;
	end

	local display=1;
	local anim=0;
	while (display~=0) do
		ScrClip();
		local w, h=ScrSize();
		lastProgress=tprogress;
		local progress=tprogress;
		if (MaxLoadTemplate>0) then
			progress=((progress / 2) + ((50 * TemplatesLoaded) / MaxLoadTemplate));
		end

		if (wait==1) then
			progress=100;
		end

		if (wait==0) then
			if ((progress - prev_progress)<3) then
				do return end;

			end

		end

		prev_progress=progress;
		local res, palpha=ShowIntro(wait);
		progressbox(LOADING, progress, 1, 255, palpha);
		ScrRect("", 0, 0, w, h, 1, 0, 0, 0, (255 - palpha));
		ShowGUI(wait);
		if (wait==0) then
			display=0;
		end

		if (wait==1) and (res==-1) then
			display=0;
		end

	end

end

ShowLoadProgressBar(0);
SetRenderable(FindObject("Water"), 0);
SetFOVAndClipPlanes(55, 10, 50000);
SetBGColor(0, 0, 10);
function InitSkyDome()
	SkyDome("enable");
	local rndtime=random();
	Material("default", "ambient", (0.35 + (rndtime * 0.1)), (0.25 + (rndtime * 0.1)), 0.15, 0);
	Material("ground", "ambient", (0.45 + (rndtime * 0.1)), (0.35 + (rndtime * 0.1)), 0.25, 0);
	Material("wall", "ambient", (0.45 + (rndtime * 0.1)), (0.35 + (rndtime * 0.1)), 0.25, 0);
	SkyDome("time", ((rndtime * 2) + 19));
end

InitSkyDome();
Resume();
SetTimer(0);
terrain=InsertTerrain("city", "textures\\Terrain\\city\\cityHMap.bmp", "", "textures\\Terrain\\city\\cityDemographic.jpg", 800, 200, 16);
SetAsStatic(terrain);
SetName(terrain, "TERRAIN");
GenNormals(terrain, 1);
roadnetwork=InsertRoadNetwork(512, 0, 512, terrain, "city\\sanjose.city");
cmd=format("CreateGeometry %s %s %s %s", "textures\\city\\road", "textures\\city\\crossing", "textures\\city\\pavement", "textures\\city\\offroad");
ShowLoadProgressBar(10);
Cmd(roadnetwork, cmd);
Cmd(roadnetwork, "ExtrudeShapes");
ShowLoadProgressBar(20);
SetAsStatic(roadnetwork);
if (SPLATTERS==1) then
	CreateSplatters();
	if (GetSetting("HighDetail")=="true") or (GetSetting("HighDetail")=="1") then
		SpawnPapers();
	end

end

id=InsertMovableTris();
SetName(id, "MovableTris");
mission_curtime=0;
mission_curid=0;
mission_maxtime=0;
carCount=0;
girlpt={395669,
	4138,
	486315,
	415346,
	4204,
	492128,
	415653,
	3760,
	456225,
	408998,
	3473,
	365903,
	497094,
	2949,
	468720,
	395669,
	4138,
	486315};
curgirlpt=-1;
function StartMission(mission_id)
	if (_VL==0) and (mission_curid~=3) then
		console("exit");
	end

	mission_curid=mission_id;
	mission_curtime=0;
	if (mission_id==0) then
		CreatePlayer(496519, (5015 + 250), (407990 - 500), roadnetwork);
		local id=InsertObject("models\\furgon1", (496519 + 200), (5015 + 300), (407990 - 500));
		SetNumber(id, "CanLoad", 1);
		SetNumber(id, "playerhavekey", 1);
		SetName(id, "Truck");
		GenNormals(id, 1);
		local player=GetPlayer();
		SetDriver(id, player, roadnetwork);
		Cmd(player, "StartEngine");
		SetNumber(player, "haveweapon2", 1);
		Weather("cloudy", 1);
		SetActiveItem("thumbnail\\icon8", 0);
		mission_maxtime=(15 * 60);
	end

	if (mission_id==1) then
		CreatePlayer(393389, 4069, 488142, roadnetwork);
		SetNumber(GetPlayer(), "picklock", 1);
		SetNumber(GetPlayer(), "key", 1);
		Weather("overcast", 1);
		mission_maxtime=(15 * 60);
	end

	if (mission_id==2) then
		CreatePlayer(393389, 4069, (488142 + 500), roadnetwork);
		local id=InsertObject("models\\tcar1", 393389, 4069, 488142);
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		Cmd(id, "Lights 1");
		SetActiveItem("thumbnail\\icon7", 0);
		SetDriver(id, GetPlayer(), roadnetwork);
		Cmd(GetPlayer(), "StartEngine");
		Weather("overcast", 1);
		mission_maxtime=(15 * 60);
	end

	if (mission_id==3) then
		CreatePlayer((401512 + 200), 3648, 411554, roadnetwork);
		local taxi=InsertObject("models\\taxi", 401512, 3648, 411554);
		SetName(taxi, "taxi");
		SetNumber(taxi, "damagefactor", 0.7);
		SetNumber(taxi, "playerhavekey", 1);
		GenNormals(taxi, 1);
		Cmd(taxi, "camera 8 -200 0 -20 25");
		Cmd(taxi, "Lights 1");
		Weather("overcast", 1);
		local player=GetPlayer();
		SetDriver(taxi, player, roadnetwork);
		Cmd(player, "StartEngine");
		Cmd(player, "CanOutOfCar 0");
		mission_maxtime=(15 * 60);
	end

	if (mission_id==4) then
		driverpt=StealthArg(2);
		CreatePlayer(StealthArg(3), StealthArg(4), StealthArg(5), roadnetwork);
		local id=InsertObject("models\\tcar1", StealthArg(6), StealthArg(7), StealthArg(8));
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		SetDriver(id, GetPlayer(), roadnetwork);
		SetNumber(GetPlayer(), "picklock", 1);
		SetNumber(GetPlayer(), "scanner", 1);
		Cmd(GetPlayer(), "StartEngine");
		Weather("overcast", 1);
		id=InsertObject(StealthArg(9), StealthArg(10), StealthArg(11), StealthArg(12));
		SetName(id, "supercar");
		SetClipFactor(id, 60);
		GenNormals(id, 1);
		Cmd(id, "lock2surface 1");
		Cmd(id, "initsecuritycode");
		Cmd(id, "security 1");
		Cmd(id, "lock leftdoor");
		Cmd(id, "alarm 1 1");
		id=InsertObject(StealthArg(13), StealthArg(14), StealthArg(15), StealthArg(16));
		Cmd(id, "movementscale 1.3");
		Cmd(id, "afraid");
		Cmd(id, "idlewalk 0");
		Cmd(id, "speedscale 3");
		SetUpdateFunction(id, "driver");
		SetName(id, "driver");
		SetRoadNetwork(id, roadnetwork);
		EnableClipDistance(id, 0);
		GenNormals(id, 1);
		mission_maxtime=(20 * 60);
	end

	if (mission_id==5) then
		CreatePlayer((418453 + 900), 3730, 460280, roadnetwork);
		id=InsertObject("models\\pikap", 413065, 3751, (456398 + 500));
		Cmd(id, "spawn 413065 3751 458000 0.9 1");
		SetNumber(id, "damagefactor", 1);
		EnableClipDistance(id, 0);
		SetName(id, "Truck");
		GenNormals(id, 1);
		Cmd(id, "skin 1");
		Cmd(id, "defmaxspd 60");
		Cmd(id, "lock2surface 1");
		SetNumber(id, "CanKillPeople", 1);
		local id=InsertObject("models\\tcar1", 419453, 3730, 460280);
		Cmd(id, "spawn 418453 3730 460280 1.1 1");
		SetNumber(id, "damagefactor", 0.3);
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		Cmd(id, "Lights 1");
		local player=GetPlayer();
		SetNumber(player, "haveweapon0", 1);
		SetDriver(id, player, roadnetwork);
		Cmd(player, "StartEngine");
		id=InsertObject("models\\toolsaler", (419453 - 1500), 3730, 460280);
		Cmd(id, "movementscale 1.3");
		Cmd(id, "afraid");
		Cmd(id, "courage 100");
		SetUpdateFunction(id, "scumbag");
		SetRoadNetwork(id, roadnetwork);
		SetNumber(id, "health", 200);
		SetNumber(id, "badguy", 1);
		SetName(id, "scumbag");
		EnableClipDistance(id, 0);
		GenNormals(id, 1);
		id=InsertObject("models\\arrow", (419453 - 1500), (3730 + 100), 460280, 0, 0, 0, 1.5, 1.5, 1.5);
		SetName(id, "arrow");
		SetUpdatable(id, 0);
		EnableClipDistance(id, 0);
		GenNormals(id, 1);
		Weather("overcast", 1);
		mission_maxtime=(5 * 60);
	end

	if (mission_id==6) then
		CreatePlayer(445503, 3059, (415041 - 800), roadnetwork);
		id=InsertObject("models\\van1", 445503, 3059, 415041);
		Cmd(id, "spawn 445503 3059 415041 3 1");
		SetNumber(id, "playerhavekey", 1);
		SetNumber(id, "stolen", 1);
		SetName(id, "Truck");
		Cmd(id, "Lights 1");
		GenNormals(id, 1);
		local player=GetPlayer();
		SetDriver(id, player, roadnetwork);
		Cmd(player, "StartEngine");
		Cmd(player, "CanOutOfCar 0");
		Weather("overcast", 1);
		mission_maxtime=(5 * 60);
	end

	if (mission_id==7) then
		CreatePlayer(496519, (5015 + 250), (407990 - 500), roadnetwork);
		local id=InsertObject("models\\concept8", (496519 + 200), (5015 + 300), (407990 - 500));
		SetNumber(id, "playerhavekey", 1);
		SetName(id, "player_car");
		GenNormals(id, 1);
		local player=GetPlayer();
		Cmd(player, "CanOutOfCar 0");
		id=InsertObject("models\\concept7", (496519 - 200), (5015 + 300), (407990 + 500));
		SetNumber(id, "CanKillPeople", 1);
		SetName(id, "girl_car");
		GenNormals(id, 1);
		id=InsertObject("models\\rgirl", girlpt[1], (girlpt[2] + 20), girlpt[3]);
		SetRoadNetwork(id, roadnetwork);
		SetClipFactor(id, 40);
		SetName(id, "rgirl");
		Cmd(id, "checkfelony 0");
		GenNormals(id, 1);
		id=InsertObject("models\\checkpoint", race_finish["x"], race_finish["y"], race_finish["z"], 0, ((18 * PI) / 180), 0, 1.4, 0.7, 1.4);
		SetUpdatable(id, 0);
		SetRenderable(id, 0);
		SetName(id, "finish");
		EnableClipDistance(id, 0);
		GenNormals(id, 1);
		id=InsertObject("models\\checkpoint", race_checkpoint["x"], race_checkpoint["y"], race_checkpoint["z"], 0, ((95 * PI) / 180), 0, 1, 0.7, 1);
		SetUpdatable(id, 0);
		SetRenderable(id, 0);
		SetName(id, "checkpoint");
		EnableClipDistance(id, 0);
		GenNormals(id, 1);
		mission_maxtime=(5 * 60);
	end

	if (mission_id==9) then
		CreatePlayer((401512 + 200), 3648, 411554, roadnetwork);
		local car=InsertObject("models\\tcar3", 401512, 3648, 411554);
		SetNumber(car, "damagefactor", 0.6);
		SetName(car, "car");
		SetNumber(car, "playerhavekey", 1);
		SetName(car, "Car");
		Cmd(car, "Lights 1");
		GenNormals(car, 1);
		Cmd(car, "camera 8 -200 0 -20 25");
		local player=GetPlayer();
		SetDriver(car, player, roadnetwork);
		Cmd(player, "StartEngine");
		Cmd(player, "CanOutOfCar 0");
		local id=InsertObject("models\\pikap", 389876.3125, 4159.4580078125, 487578.5625);
		SetClipFactor(id, 70);
		SetName(id, "pikap");
		Cmd(id, "skin 1");
		Cmd(id, "defmaxspd 70");
		Cmd(id, "lock2surface 1");
		SetNumber(id, "CanKillPeople", 1);
		GenNormals(id, 1);
		Cmd(id, "enable 0");
		local hx, hy, hz=GetHelper(id, "shooter", 1);
		local teen=InsertObject("models\\teen", hx, hy, hz);
		SetClipFactor(teen, 40);
		SetName(teen, "shooter");
		Cmd(teen, "checkfelony 0");
		Cmd(teen, "hate");
		Cmd(teen, "courage 100");
		Cmd(teen, "attackrange 3000");
		Cmd(teen, "idlewalk 0");
		GenNormals(teen, 1);
		SetParent(teen, id);
		Cmd(teen, "enable 0");
		id=InsertObject("models\\toolsaler", (401512 + 700), 3648, 411554);
		SetUpdateFunction(id, "gangpikap");
		Cmd(id, "movementscale 1.3");
		Cmd(id, "AutoOutOfCar 0");
		SetName(id, "gangpikap");
		SetRoadNetwork(id, roadnetwork);
		EnableClipDistance(id, 0);
		GenNormals(id, 1);
		Cmd(id, "enable 0");
		id=InsertObject("models\\chinamafiose", 314499, 4528, 325738);
		SetVector(id, "target", 314499, 4528, 325738);
		SetUpdateFunction(id, "chinamafiose");
		SetRoadNetwork(id, roadnetwork);
		SetClipFactor(id, 40);
		SetName(id, "chinamafiose");
		SetNumber(id, "updatemarker", 1);
		Cmd(id, "checkfelony 0");
		Cmd(id, "idlewalk 0");
		GenNormals(id, 1);
		Weather("cloudy", 1);
		mission_maxtime=(10 * 60);
	end

	if (mission_id==10) then
		CreatePlayer(445503, 3059, (415041 - 800), roadnetwork);
		id=InsertObject("models\\concept6", 445503, 3059, 415041);
		SetNumber(id, "damagefactor", 0.7);
		Cmd(id, "spawn 445503 3059 415041 3 1");
		SetNumber(id, "damagefactor", 0.7);
		SetNumber(id, "playerhavekey", 1);
		SetName(id, "car");
		GenNormals(id, 1);
		Cmd(id, "Lights 1");
		local player=GetPlayer();
		SetDriver(id, player, roadnetwork);
		Cmd(player, "StartEngine");
		SetNumber(player, "haveweapon0", 1);
		Weather("overcast", 1);
		mission_maxtime=(10 * 60);
	end

	if (mission_id==11) then
		CreatePlayer(496519, (5015 + 250), (407990 - 500), roadnetwork);
		SetNumber(GetPlayer(), "picklock", 1);
		SetNumber(GetPlayer(), "scanner", 1);
		SetNumber(GetPlayer(), "haveweapon0", 1);
		SetNumber(GetPlayer(), "haveweapon1", 1);
		Weather("overcast", 1);
		id=InsertObject("models\\concept3", (496519 + 200), (5015 + 300), (407990 - 500));
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		id=InsertObject("models\\concept6", (496519 - 600), (5015 + 300), (407990 + 500));
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		id=InsertObject("models\\concept7", (496519 - 200), (5015 + 300), (407990 + 500));
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		id=InsertObject("models\\concept8", (496519 + 200), (5015 + 300), (407990 + 500));
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
	end

end

function MissionCalculateRating()
	MissionPassed((CURRENTMISSIONID + 2));
	CURRENTMISSIONID=(CURRENTMISSIONID + 1);
	local rating=((mission_maxtime - mission_curtime) / mission_maxtime);
	rating=rating;
	local felony=GetNumber(PLAYER, "felony");
	local money=GetNumber(PLAYER, "money");
	rating=((rating * (100 - felony)) / 100);
	rating=(rating + (money / 5000));
	if (rating>1) then
		rating=1;
	end

	rating=ceil((rating * 100));
	local original_rating=ReadRegistry("BESTRATING" .. tostring(mission_curid));
	if not (original_rating) then
		original_rating="0";
	end

	original_rating=tonumber(original_rating);
	if (rating>original_rating) then
		print("New record: ", rating, " Old record: ", original_rating);
		rating=tostring(rating);
		WriteRegistry("BESTRATING" .. tostring(mission_curid), rating);
		do return rating .. RATINGBEST end;

	end

	rating=tostring(rating);
	return rating .. "%";

end

function MissionUpdate()
	local mission_prevtime=mission_curtime;
	if (IsPaused()==0) then
		mission_curtime=(mission_curtime + DT);
	end

	if (mission_curid==-1) then
		if (mission_curtime>1) then
			Fade(0, 0);
		end

		if (mission_curtime>2) then
			guit2menu();
			do return end;

		end

	end

	if (mission_curid==-2) then
		if (mission_curtime>4) then
			Fade(0, 0);
		end

		if (mission_curtime>5) then
			mission_curid=0;
			guit2menu();
			do return end;

		end

	end

	if (mission_curid==0) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		local truck=FindObject("Truck");
		local truckLoadedWheels=GetNumber(truck, "LoadedWheels");
		if (GetNumber(truck, "health")<=0) or (timeleft<=0) or (GetNumber(PLAYER, "health")<=0) or (GetNumber(PLAYER, "felony")>=90) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		local sx=(496519 + 200);
		local sy=(5015 + 300);
		local sz=(407990 - 500);
		AddMarker(Animate("marker\\checkpoint", 3), sx, sy, sz, 24, 24, -12, -12);
		if (truckLoadedWheels>=16) or (SKIPMISSION==1) then
			local x, y, z=GetPosition(truck);
			local dist2=((((x - sx) * (x - sx)) + ((y - sy) * (y - sy))) + ((z - sz) * (z - sz)));
			if (dist2<(500 * 500)) or (SKIPMISSION==1) then
				MissionCalculateRating();
				StartIntro("Sounds\\rap1.wav", "intro\\bar", "intro\\slippy1", "intro\\mob1", MISSIONCOMPLETE, 50, 50, 50, 1);
				mission_curid=-1;
				mission_curtime=0;
				SetTimer(0);
				do return end;

			end

		end

	end

	if (mission_curid==1) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		local player=PLAYER;
		local player_car=GetVehicle(player);
		ParkedChance=(40 - (carCount * 10));
		if (timeleft<=0) or (GetNumber(player, "health")<=0) or (GetNumber(player, "felony")>=10) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		local x=(496519 + 200);
		local y=(5015 + 300);
		local z=(407990 - 500);
		AddMarker(Animate("marker\\checkpoint", 3), x, y, z, 24, 24, -12, -12);
		local player=PLAYER;
		local px, py, pz=GetPosition(player);
		local dist=VectorLength((px - x), (py - y), (pz - z));
		if (SKIPMISSION==1) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap1.wav", "intro\\bar", "intro\\slippy1", "intro\\mob1", MISSIONCOMPLETE, 50, 50, 50, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		if (dist<800) then
			local car=GetVehicle(player);
			if (car>0) then
				if (GetNumber(car, "counted")==0) then
					if (GetNumber(car, "police")==1) then
						carCount=(carCount + 1);
						if (carCount==1) then
							message2(1.5, COOLFIRSTCAR);
						end

						if (carCount==2) then
							message2(1.5, COOL);
						end

						if (carCount==3) then
							message2(1.5, ONEMORECARLEFT);
						end

						SetNumber(car, "counted", 1);
						if (carCount>=3) then
							MissionCalculateRating();
							StartIntro("Sounds\\rap1.wav", "intro\\bar", "intro\\slippy1", "intro\\mob1", MISSIONCOMPLETE, 50, 50, 50, 1);
							mission_curid=-1;
							mission_curtime=0;
							SetTimer(0);
							do return end;

						end

					end

				end

			end

		end

		if (dist>3000) then
			local car=GetVehicle(player);
			if (car>0) then
				if (GetNumber(car, "counted")==1) then
					if (GetNumber(car, "police")==1) then
						carCount=(carCount - 1);
						message2(1.5, LEAVECAR);
						SetNumber(car, "counted", 0);
					end

				end

			end

		end

	end

	if (mission_curid==2) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		if (timeleft<=0) or (GetNumber(PLAYER, "health")<=0) or (GetNumber(PLAYER, "felony")>=90) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		if (carCount>=5) or (SKIPMISSION==1) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy1", "intro\\mob1", MISSIONCOMPLETE, 50, 50, 50, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

	end

	if (mission_curid==3) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		if (timeleft<=0) or (GetNumber(PLAYER, "health")<=0) or (GetNumber(FindObject("taxi"), "health")<=0) or (GetNumber(FindObject("taxi"), "fuel")<=0) or (GetNumber(PLAYER, "felony")>=90) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		if (GetNumber(PLAYER, "money")>=350) or (SKIPMISSION==1) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap1.wav", "intro\\taxi", "intro\\slippy1", nil, MISSIONCOMPLETE, 0, 0, 100, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

	end

	if (mission_curid==4) or (mission_curid==8) then
		local timeleft=(mission_maxtime - mission_curtime);
		local truck=FindObject("supercar");
		local player=PLAYER;
		local player_car=GetVehicle(player);
		SetTimer(timeleft);
		if (timeleft<=0) or (GetNumber(player, "health")<=0) or (GetNumber(player, "felony")>=10) or (GetNumber(truck, "health")<50) or (GetNumber(FindObject("driver"), "health")<100) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		if (player_car>0) then
			if (GetNumber(player, "copcarnear")==1) then
				if (GetNumber(player_car, "stolen")==1) then
					local hiding=GetNumber(player, "hiding");
					if (hiding==1) then
						local outsideroad=GetNumber(player, "outsideroad");
						if (GetSpeed(player_car)>5) or (outsideroad==0) then
							hiding=0;
						end

					end

					if (hiding==0) then
						local felony=GetNumber(player, "felony");
						if (1==1) then
							message2(1.5, MISSIONFAILED, BUSTED);
							mission_curid=-2;
							mission_curtime=0;
							SetTimer(0);
							felony=20;
							SetNumber(player, "felony", felony);
						end

					end

				end

			end

		end

		local ptx=347749;
		local pty=4871;
		local ptz=500828;
		local tx, ty, tz=GetPosition(truck);
		local dist2=(((ptx - tx) * (ptx - tx)) + ((ptz - tz) * (ptz - tz)));
		if (SameObjects(player_car, truck)==1) then
			AddMarker(Animate("marker\\checkpoint", 3), ptx, pty, ptz, 24, 24, -12, -12);
		end

		for i=0, 3 do
			local x=driverpt[((i * 3) + 1)];
			local y=driverpt[((i * 3) + 2)];
			local z=driverpt[((i * 3) + 3)];
			AddMarker("marker\\area", x, y, z, 96, 96, -48, -48, 0, 1);
		end

		if (dist2<=(300 * 300)) or (SKIPMISSION==1) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy1", nil, MISSIONCOMPLETE, 50, 50, 50, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

	end

	if (mission_curid==5) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		if (timeleft<=0) or (GetNumber(PLAYER, "health")<=0) or (GetNumber(PLAYER, "felony")>=90) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		local scumbag=FindObject("scumbag");
		local sx, sy, sz=GetPosition(scumbag);
		if (GetNumber(scumbag, "health")<=0) then
			message2(1.5, MISSIONCOMPLETE, YOURRATING .. MissionCalculateRating());
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		AddMarker(Animate("marker\\checkpoint", 3), sx, sy, sz, 24, 24, -12, -12);
	end

	if (mission_curid==10) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		if (timeleft<=0) or (GetNumber(PLAYER, "health")<=0) or (timeleft<=0) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		if (SKIPMISSION==1) or (totalKills>=30) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy1", "intro\\mob1", MISSIONCOMPLETE, 50, 50, 50, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
		end

	end

	if (mission_curid==11) then
		if (GetNumber(PLAYER, "health")<=0) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

	end

	if (mission_curid==6) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		local truck=FindObject("Truck");
		local player=PLAYER;
		local player_car=GetVehicle(player);
		if (timeleft<=0) or (GetNumber(player, "health")<=0) or (GetNumber(truck, "health")<=0) or (GetNumber(player, "felony")>=90) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		if (GetNumber(player, "copcarnear")==1) then
			if (SameObjects(truck, player_car)==1) then
				local hiding=GetNumber(player, "hiding");
				if (hiding==1) then
					local outsideroad=GetNumber(player, "outsideroad");
					if (GetSpeed(player_car)>5) or (outsideroad==0) then
						hiding=0;
					end

				end

				if (hiding==0) then
					local felony=GetNumber(player, "felony");
					if (1==1) then
						message2(1.5, MISSIONFAILED, BUSTED);
						mission_curid=-2;
						mission_curtime=0;
						SetTimer(0);
						felony=20;
						SetNumber(player, "felony", felony);
					end

				end

			end

		end

		local ptx=347749;
		local pty=4871;
		local ptz=500828;
		local marker=FindObject("Marker");
		if (marker==0) then
			local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
			local tx, ty, tz=IntersectLine(roadnetwork, ptx, (pty + 10000), ptz, ptx, (pty - 10000), ptz);
			id=InsertParticleSource("ParticleSystems\\marker.psf", tx, (ty + 10), tz, 0, 0, 0, 10, 10, 10);
			SetName(id, "Marker");
		end

		AddMarker(Animate("marker\\checkpoint", 3), ptx, pty, ptz, 24, 24, -12, -12);
		local tx, ty, tz=GetPosition(truck);
		local dist2=(((ptx - tx) * (ptx - tx)) + ((ptz - tz) * (ptz - tz)));
		if (dist2<=(500 * 500)) or (SKIPMISSION==1) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy1", "intro\\mob1", MISSIONCOMPLETE, 50, 50, 50, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

	end

	if (mission_curid==7) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		local player=PLAYER;
		local girl=FindObject("rgirl");
		local player_car=GetVehicle(player);
		if (timeleft<=0) or (GetNumber(PLAYER, "health")<=0) or (GetNumber(girl, "health")<=0) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		if (SKIPMISSION==1) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy1", nil, MISSIONCOMPLETE, 50, 50, 50, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
		end

	end

	if (mission_curid==9) then
		local timeleft=(mission_maxtime - mission_curtime);
		SetTimer(timeleft);
		local player=PLAYER;
		local chinamafiose=FindObject("chinamafiose");
		local player_car=FindObject("car");
		local pikap=FindObject("pikap");
		if (timeleft<=0) or (GetNumber(PLAYER, "health")<=0) or (GetNumber(player, "felony")>=90) or (GetNumber(chinamafiose, "health")<=0) or (GetNumber(player_car, "health")<=0) or (GetNumber(player_car, "fuel")<=0) then
			message2(1.5, MISSIONFAILED);
			mission_curid=-2;
			mission_curtime=0;
			SetTimer(0);
			do return end;

		end

		if (SKIPMISSION==1) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap2.wav", "intro\\chinatown", "intro\\slippy1", "intro\\mob1", MISSIONCOMPLETE, 50, 50, 50, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
		end

		local marker=FindObject("Marker");
		if (marker==0) then
			marker=InsertParticleSource("ParticleSystems\\marker.psf", 0, 0, 0, 0, 0, 0, 3, 3, 3);
			SetName(marker, "Marker");
		end

		local tx, ty, tz=GetVector(chinamafiose, "target");
		if (GetNumber(chinamafiose, "updatemarker")==1) then
			local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
			tx, ty, tz=IntersectLine(roadnetwork, tx, (ty + 1000), tz, tx, (ty - 1000), tz);
			SetPosition(marker, tx, (ty + 10), tz);
			SetNumber(chinamafiose, "updatemarker", 0);
		end

		AddMarker(Animate("marker\\checkpoint", 3), tx, ty, tz, 24, 24, -12, -12);
	end

end

function gangpikap_Damage(this)
	character_Damage(this);
end

function gangpikap_Die(this)
	character_Die(this);
end

function gangpikap_Update(this)
	local selfcar=GetVehicle(this);
	if (selfcar==0) then
		selfcar=FindObject("pikap");
		if (GetRenderable(selfcar)==0) then
			do return end;

		end

		local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
		SetDriver(selfcar, this, roadnetwork);
		Cmd(selfcar, "StartEngine");
		if (LEVEL_TIME>20) or (LEVEL_TIME<9) then
			Cmd(selfcar, "Lights 1");
		end

		Cmd(this, "hate");
		Cmd(this, "checkfelony 0");
		Cmd(selfcar, "slide 0");
		do return end;

	end

	local chinamafiose=FindObject("chinamafiose");
	local car=GetVehicle(PLAYER);
	local px, py, pz=GetPosition(PLAYER);
	local x, y, z=GetPosition(this);
	local dist2=(((px - x) * (px - x)) + ((pz - z) * (pz - z)));
	local timeout=GetNumber(this, "timeout");
	local dx, dy, dz=TransDir(selfcar, 0, 1, 0);
	if (dy<0) then
		timeout=(timeout + DT);
	end

	if (GetSpeed(selfcar)<1) then
		timeout=(timeout + DT);
	end

	if (dist2<(3000 * 3000)) then
		MusicRush=(MusicRush + 20);
	end

	if (dist2>(10000 * 10000)) then
		Cmd(this, "speedscale 0");
		Cmd(selfcar, "Lights 0");
	else
		if (dist2<(5000 * 5000)) then
			Cmd(this, "speedscale 1.5");
			Cmd(selfcar, "Lights 1");
		else
			Cmd(this, "speedscale 2");
		end

	end

	if (dist2>(15000 * 15000)) or ((timeout>5) and (dist2>(5000 * 5000))) then
		timeout=0;
		local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
		local tx, ty, tz=TransDir(car, 0, 0, -1);
		local length=10000;
		tx=((tx * length) + px);
		ty=0;
		tz=((tz * length) + pz);
		tx, ty, tz=GetPointOnNetwork(roadnetwork, tx, ty, tz);
		local length=VectorLength((tx - px), 0, (tz - pz));
		if (length<14000) then
			local angle=-Vector2Angle((px - x), 0, (pz - z));
			Cmd(selfcar, format("spawn %d %d %d %f", tx, (ty + 150), tz, angle));
			Cmd(this, "reset");
			Cmd(selfcar, "restore");
			Cmd(selfcar, "Lights 0");
		end

	end

	SetNumber(this, "timeout", timeout);
	character_Update(this);
end

StartMission(ACTIVEMISSION);
if (1==1) then
	TrafficBegin();
	print("Traffic: mission_curid = ", mission_curid);
	TrafficNetwork(roadnetwork);
	TrafficMember(1, "models\\bus", "bom1");
	TrafficMember(1, "models\\taxi", "bom3");
	TrafficMember(1, "models\\furgon2", "bom3");
	TrafficMember(1, "models\\furgon", "bom1");
	TrafficMember(1, "models\\furgon1", "bom3");
	TrafficMember(1, "models\\tcar1", "girl2");
	TrafficMember(1, "models\\van1", "girl1");
	TrafficMember(1, "models\\tcar2", "girl2");
	TrafficMember(1, "models\\pikap", "girl2");
	TrafficMember(1, "models\\pikap2", "bom1");
	TrafficMember(1, "models\\tcar3", "girl1");
	if (mission_curid==1) then
		TrafficMember(5, "models\\police", "cop");
		print("5 police cars");
	end

	if (mission_curid==0) then
		TrafficMember(5, "models\\police", "cop");
		print("5 police cars");
	end

	if (mission_curid==6) then
		TrafficMember(3, "models\\police", "cop");
		print("3 police cars");
	end

	if (mission_curid~=0) and (mission_curid~=6) and (mission_curid~=1) then
		TrafficMember(3, "models\\police", "cop");
		print("3 police cars");
	end

	TrafficMember(1, "worker");
	TrafficMember(1, "oldsaler");
	TrafficMember(2, "cop");
	if (ACTIVEMISSION==10) then
		TrafficMember(5, "teen");
		TrafficMember(1, "bom1");
		TrafficMember(1, "bom2");
		TrafficMember(1, "bom3");
		TrafficMember(1, "girl1");
		TrafficMember(1, "girl2");
	else
		TrafficMember(2, "bom1");
		TrafficMember(2, "bom2");
		TrafficMember(2, "bom3");
		TrafficMember(2, "girl1");
		TrafficMember(2, "girl2");
	end

	TrafficEnd();
end

ShowLoadProgressBar(60);
Cmd(roadnetwork, "BuildTree");
ShowLoadProgressBar(80);
InitializeSpawnItems();
ShowLoadProgressBar(90);
LEVEL_TIME=0;
function _tmp_Update()
	_sanjose_Update();
end

function _sanjose_SwitchLevel(active)
	if (active==1) then
	end

end

function _sanjose_InitialUpdate()

end

FadeTimeout=2;
MusicReadyTimeout=0;
function _sanjose_Update()
	PLAYER=GetPlayer();
	DT=GetDT();
	FadeTimeout=(FadeTimeout - DT);
	local time=GetTime();
	if (FadeTimeout>0) then
		Fade(0, 1);
	end

	if (FadeTimeout<=0) then
		if ((FadeTimeout + DT)>0) then
			Fade(1, 0);
		end

	end

	WeatherUpdate();
	local iSeconds=floor(GetTime());
	CurrentGreenLight=floor(mod((iSeconds / 8), 4));
	CurrentGreenLight3=floor(mod((iSeconds / 4), 3));
	MissionUpdate();
end

for i=1, 15 do
	id=InsertObject("models\\dollar");
	SetName(id, "dollar" .. i);
end

Weather("enable");
ShowLoadProgressBar(1000);
Fade(0, 1);
