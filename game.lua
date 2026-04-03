missionID=0;
callID=0;
callTimeOut=300;
carCount=0;
function car_OnLoadWheel(this)
	local wheelsNumber=GetNumber(this, "LoadedWheels");
	wheelsNumber=(wheelsNumber + 1);
	SetNumber(this, "LoadedWheels", wheelsNumber);
	message2(1.5, WHEELLOADED, format(WHEELCOUNT, wheelsNumber));
	SetActiveItem("thumbnail\\icon8", tostring(wheelsNumber));
end

function watertrail_Update(this)
	local x, y, z=GetPosition(this);
	local cx, cy, cz=ScrPos();
	local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
	if (dist2>(5000 * 5000)) then
		Destroy(this);
		alCmd("stop watertrail");
	else
		local s=format("Move watertrail %d %d %d", x, y, z);
		alCmd(s);
	end

end

function smoke_Update(this)
	local timeout=GetNumber(this, "timeout");
	timeout=(timeout + DT);
	SetNumber(this, "timeout", timeout);
	if (timeout>20) then
		Destroy(this);
	end

end

function fire_Update(this)
	local timeout=GetNumber(this, "timeout");
	timeout=(timeout + DT);
	SetNumber(this, "timeout", timeout);
	if (timeout>20) then
		Destroy(this);
	end

end

function fire_UpdateRender(this)
	local x, y, z=GetVector(this, "Pos");
	AddLight(x, y, z, 2000, random(200, 255), random(200, 255), 50, 1.5);
end

function firegidrant_carhit(this, car)
	SetRenderable(this, 0);
	local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
	Cmd(roadnetwork, "BuildDynamicTree");
	local cx, cy, cz=GetPosition(this);
	local id=InsertParticleSource("ParticleSystems\\watertrail.psf", cx, cy, cz, 0, 0, 0, 2, 2, 2);
	SetUpdateFunction(id, "watertrail_Update");
	local al=FindObject("OpenAL");
	Cmd(al, "Open Sounds\\watertrail.wav 1 0 watertrail");
	Cmd(al, "Gain watertrail 1 0 1");
	Cmd(al, "Dist watertrail 5000 500");
	Cmd(al, "Play watertrail");
end

function lamppost2_carhit(this, car)
	SetRenderable(this, 0);
	local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
	Cmd(roadnetwork, "BuildDynamicTree");
	local x, y, z=GetPosition(this);
	local cx, cy, cz=GetPosition(car);
	local dx, dy, dz=Normalize((x - cx), 0, (z - cz));
	local dynobject=DynObject(this, (dx * 500), (dy * 500), (dz * 500));
	SetUpdateFunction(dynobject);
end

function Leaf_Init(x, y, z, w, h, angle, dx, dy, dz, this)
	x=random(-200, 200);
	y=random(-200, 200);
	z=random(-200, 200);
	return x, y, z, w, h, angle, dx, dy, dz;

end

function tree_carhit(this, car, depth)
	if (depth<15) then
		do return end;

	end

	local cx, cy, cz=GetPosition(this);
	local id=InsertParticleSource("ParticleSystems\\leaf.psf", (cx + random(-100, 100)), ((cy + 500) + random(-100, 100)), (cz + random(-100, 100)), 0, 0, 0, 2, 2, 2);
	SetColor(id, 200, 220, 200, 200);
	SetCreationFunction(id, "Leaf_Init");
end

function lamppost4_carhit(this, car)
	lamppost2_carhit(this, car);
end

function can_carhit(this, car)
	lamppost2_carhit(this, car);
end

function mail_carhit(this, car)
	lamppost2_carhit(this, car);
end

function scumbag_Damage(this)
	character_Damage(this);
end

function scumbag_Die(this)
	character_Die(this);
	local arrow=FindObject("arrow");
	SetRenderable(arrow, 0);
end

function scumbag_Update(this)
	character_Update(this);
	if (GetNumber(this, "health")>0) then
		MusicRush=(MusicRush + 10);
		local mode=GetNumber(this, "mode");
		local timeout=GetNumber(this, "timeout");
		timeout=(timeout + DT);
		local arrow=FindObject("arrow");
		local x, y, z=GetPosition(this);
		local car=GetVehicle(this);
		if (car>0) then
			z, y, x=z, GetPosition(car);
		end

		SetPosition(arrow, x, ((y + 400) + (70 * sin((GetTime() * 200)))), z);
		SetEulerRotation(arrow, 0, (GetTime() * 5), 0);
		local ax, ay, az=GetPosition(arrow);
		AddFlare(ax, ay, az, 300, "sprite\\flare", 0, 0, 100, 100, 0);
		if (mode==0) then
			local truck=FindObject("Truck");
			Cmd(truck, "close leftdoor");
			local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
			SetDriver(truck, this, roadnetwork);
			Cmd(truck, "StartEngine");
			if (LEVEL_TIME>21) or (LEVEL_TIME<9) then
				Cmd(truck, "Lights 1");
			end

			mode=3;
			SetNumber(this, "timeout", timeout);
		end

		if (mode==3) then
			if (timeout>2) then
				local tx, ty, tz=GetPosition(PLAYER);
				local dist2=(((x - tx) * (x - tx)) + ((z - tz) * (z - tz)));
				if (dist2<(3000 * 3000)) then
					if (GetNumber(this, "msgram")==0) then
						gui_AddRaceMsg(RAMTHATCAR);
						SetNumber(this, "msgram", 1);
					end

					Cmd(this, "speedscale " .. tostring(((random() * 0.2) + 1)));
				else
					Cmd(this, "speedscale 0.9");
					if (dist2>(5000 * 5000)) then
						SetNumber(this, "msgram", 0);
					end

				end

				tx=(x + ((x - tx) * 100000));
				ty=(y + ((y - ty) * 100000));
				tz=(z + ((z - tz) * 100000));
				if (GetNumber(this, "init")==0) then
					local cmd=format("move %d %d %d 1 1", tx, ty, tz);
					Cmd(this, cmd);
					SetNumber(this, "init", 1);
				else
					local cmd=format("move %d %d %d 1", tx, ty, tz);
					Cmd(this, cmd);
				end

				timeout=0;
			end

			if (car>0) then
				if (GetNumber(car, "health")<10) then
					mode=4;
					timeout=0;
				end

			end

		end

		if (mode==4) then
			Cmd(car, "stop");
			if (timeout<=1) then
				if (GetSpeed(car)<1) then
				end

				Cmd(car, "StopEngine");
				Cmd(car, "Lights 0");
				timeout=0;
				mode=5;
			end

		end

		if (mode==5) and (timeout>1) then
			Cmd(this, "OutOfCar");
			Cmd(this, "movementscale 0.8");
			Cmd(this, "afraid");
			mode=3;
			EnableClipDistance(this, 0);
			timeout=0;
		end

		SetNumber(this, "timeout", timeout);
		SetNumber(this, "mode", mode);
	end

end

function minfelony(min)
	local player=PLAYER;
	local felony=GetNumber(player, "felony");
	if (felony<min) then
		felony=min;
	end

	SetNumber(player, "felony", felony);
end

function addfelony(min)
	local player=PLAYER;
	local felony=GetNumber(player, "felony");
	felony=(felony + min);
	SetNumber(player, "felony", felony);
end

function supercar_AlarmOn(this)
	local driver=FindObject(driver);
	if (GetNumber(driver, "nowarn")==0) then
		minfelony(10);
	end

end

driverpt1={380939,
	3634,
	336795,
	392776,
	3721,
	368053,
	377773,
	3647,
	342959,
	350587,
	4128,
	315907};
driverpt2={401918,
	4110,
	485162,
	396904,
	4084,
	470808,
	400396,
	3963,
	495358,
	434784,
	3662,
	476824};
driverpt3={418372,
	3578,
	422130,
	412219,
	3642,
	434967,
	417243,
	3498,
	404167,
	411686,
	3482,
	408327};
driverpt4={386197,
	3959,
	413743,
	411683,
	3460,
	408397,
	402553,
	3683,
	431860,
	404951,
	3709,
	387355};
driverpt=driverpt1;
stealth_size=16;
stealth_mission={"intro\\photo2",
	driverpt2,
	(348076 + 1000),
	4860,
	501275,
	348076,
	4860,
	501275,
	"models\\concept6",
	395637,
	4066,
	466447,
	"models\\girl1",
	(396429 + 700),
	4110,
	465311,
	"intro\\car8",
	driverpt1,
	383042,
	4715,
	477518,
	382438,
	4545,
	476965,
	"models\\concept8",
	391434,
	3736,
	329672,
	"models\\toolsaler",
	(391434 + 700),
	3736,
	329672,
	"intro\\photo3",
	driverpt3,
	383042,
	4715,
	477518,
	382438,
	4545,
	476965,
	"models\\concept7",
	424267,
	3473,
	429171,
	"models\\toolsaler",
	423680,
	3473,
	429302,
	"intro\\photo4",
	driverpt4,
	(348076 + 1000),
	4860,
	501275,
	348076,
	4860,
	501275,
	"models\\concept3",
	379188,
	4254,
	409577,
	"models\\girl1",
	379167, 4205,
	408937};
function StealthArg(id)
	return stealth_mission[((STEALTHID * stealth_size) + id)];

end

function driver_Damage(this)
	character_Damage(this);
end

function driver_Die(this)
	character_Die(this);
end

function driver_Update(this)
	character_Update(this);
	if (GetNumber(this, "health")>0) then
		local mode=GetNumber(this, "mode");
		local timeout=GetNumber(this, "timeout");
		timeout=(timeout + DT);
		local x, y, z=GetPosition(this);
		local car=GetVehicle(this);
		if (car>0) then
			z, y, x=z, GetPosition(car);
		end

		local supercar=FindObject("supercar");
		if (supercar>0) then
			if (GetNumber(this, "nowarn")==0) then
				local driver=GetDriver(supercar);
				local tx, ty, tz=GetPosition(supercar);
				local delta=(((tx - x) * (tx - x)) + ((tz - z) * (tz - z)));
				if (driver>0) then
					if (SameObjects(driver, this)==0) then
						if (delta<(4000 * 4000)) then
							minfelony(10);
						end

						if (GetNumber(supercar, "stolen")==0) then
							SetNumber(supercar, "stolen", 1);
							gui_AddMsg("GUI\\help", STOLENCAR);
						else
							if (delta>(5000 * 5000)) then
								if (GetNumber(supercar, "stolen")==0) then
									SetNumber(supercar, "stolen", 1);
									gui_AddMsg("GUI\\help", STOLENCAR);
								end

							end

						end

					end

				end

			end

			if (mode==0) then
				local truck=FindObject("supercar");
				local tx, ty, tz=GetHelper(truck, "Driver_outpt");
				local cmd=format("move %d %d %d", tx, ty, tz);
				Cmd(this, cmd);
				mode=1;
			end

			if (mode==1) then
				local truck=FindObject("supercar");
				local tx, ty, tz=GetHelper(truck, "Driver_outpt");
				local delta=(((tx - x) * (tx - x)) + ((tz - z) * (tz - z)));
				local cmd=format("move %d %d %d", tx, ty, tz);
				Cmd(this, cmd);
				if (delta<2500) then
					Cmd(this, "anim idle");
					Cmd(truck, "alarm 0");
					Cmd(truck, "unlock leftdoor");
					Cmd(truck, "lock rightdoor");
					timeout=0;
					mode=11;
				end

			end

			if (mode==11) and (timeout>2) then
				local truck=FindObject("supercar");
				Cmd(truck, "open leftdoor");
				timeout=0;
				mode=2;
			end

			if (mode==2) then
				if (timeout>1) then
					local truck=FindObject("supercar");
					local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
					local tx, ty, tz=GetHelper(truck, "Driver_outpt");
					local delta=(((tx - x) * (tx - x)) + ((tz - z) * (tz - z)));
					local cmd=format("move %d %d %d 0 1", tx, ty, tz);
					Cmd(this, cmd);
					if (delta<2500) then
						Cmd(truck, "close leftdoor");
						SetDriver(truck, this, roadnetwork);
						Cmd(truck, "StartEngine");
						Cmd(this, "reset");
						if (LEVEL_TIME>21) or (LEVEL_TIME<9) then
							Cmd(truck, "Lights 1");
						end

						mode=3;
					else
						timeout=0;
					end

				end

				SetNumber(this, "timeout", timeout);
			end

			if (mode==3) then
				if (timeout>1) then
					local currentpt=GetNumber(this, "currentpt");
					local firsttime=0;
					if (currentpt==0) then
						currentpt=-1;
						firsttime=1;
					end

					if (currentpt<0) then
						currentpt=-currentpt;
						if (currentpt>4) then
							currentpt=1;
						end

						SetNumber(this, "currentpt", currentpt);
						local ox=driverpt[((currentpt * 3) - 2)];
						local oy=driverpt[((currentpt * 3) - 1)];
						local oz=driverpt[(currentpt * 3)];
						SetVector(this, "target2", ox, oy, oz);
						local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
						local tx, ty, tz=GetPointOnNetwork(roadnetwork, ox, oy, oz);
						tz, ty, tx=tz, IntersectLine(roadnetwork, tx, (ty + 10000), tz, tx, (ty - 10000), tz);
						SetVector(this, "target", tx, ty, tz);
						local dx, dy, dz=SubVectors(ox, oy, oz, tx, ty, tz);
						dz, dy, dx=dz, Normalize(dx, dy, dz);
						SetVector(this, "target1", (ox - (dx * 400)), oy, (oz - (dz * 400)));
						if (firsttime==1) then
							local cmd=format("move %d %d %d 0 1", tx, ty, tz);
							Cmd(this, cmd);
						else
							local cmd=format("move %d %d %d", tx, ty, tz);
							Cmd(this, cmd);
						end

					end

					local tx, ty, tz=GetVector(this, "target");
					local dist2=(((x - tx) * (x - tx)) + ((z - tz) * (z - tz)));
					if (dist2<(3000 * 3000)) then
						tz, ty, tx=tz, GetVector(this, "target1");
						local cmd=format("target %d %d %d", tx, ty, tz);
						SetVector(this, "target", tx, ty, tz);
						Cmd(this, cmd);
						Cmd(car, "maxspd 0.3");
					end

					if (dist2<(300 * 300)) then
						SetNumber(this, "currentpt", -(currentpt + 1));
						mode=4;
					end

				end

				if (car>0) then
					if (GetNumber(car, "health")<20) then
						mode=4;
						timeout=0;
					end

				end

			end

			if (mode==4) then
				Cmd(car, "stop");
				if (timeout<=5) then
					if (GetSpeed(car)<1) then
					end

					Cmd(car, "StopEngine");
					Cmd(car, "maxspd 1");
					Cmd(car, "Lights 0");
					Cmd(car, "target 0 0 0");
					timeout=0;
					mode=5;
				end

			end

			if (mode==5) and (timeout>1) then
				Cmd(this, "OutOfCar");
				Cmd(this, "movementscale 0.8");
				mode=6;
				timeout=0;
			end

			if (mode==6) and (timeout>5) then
				Cmd(FindObject("supercar"), "close leftdoor");
				timeout=0;
				mode=7;
			end

			if (mode==7) and (timeout>1) then
				car=FindObject("supercar");
				Cmd(car, "alarm 1");
				Cmd(car, "lock leftdoor");
				Cmd(car, "lock leftdoor");
				timeout=0;
				mode=8;
			end

			if (mode==8) and (timeout>1) then
				local tx, ty, tz=GetVector(this, "target2");
				local cmd=format("move %d %d %d 0 1", tx, ty, tz);
				Cmd(this, cmd);
				timeout=0;
				mode=9;
			end

			if (mode==9) then
				local tx, ty, tz=GetVector(this, "target2");
				local dist2=(((tx - x) * (tx - x)) + ((tz - z) * (tz - z)));
				if (dist2<(200 * 200)) then
					SetNumber(this, "nowarn", 1);
					Cmd(this, "autoappear -1");
					Cmd(this, "anim idle");
				end

				if (timeout<=50) and (timeout>10) then
					if (dist2>(200 * 200)) then
						mode=0;
						SetNumber(this, "nowarn", 0);
						timeout=0;
						Cmd(this, "autoappear 1");
					end

				end

			end

			SetNumber(this, "timeout", timeout);
			SetNumber(this, "mode", mode);
		end

	end

end

function boss_SwitchLevel(this)
	missionID=0;
	callID=0;
	callTimeOut=300;
	carCount=0;
end

function boss_BeginDialog(this)
	if (missionID==0) then
		missionID=1;
		do return 1 end;

	end

	if (missionID==2) then
		missionID=3;
		do return 2 end;

	end

	if (missionID==4) then
		missionID=5;
		do return 4 end;

	end

	if (missionID==6) then
		missionID=7;
		do return 6 end;

	end

	return 0;

end

function boss_Update(this)
	character_Update(this);
	if (GetNumber(this, "health")<=0) then
		do return end;

	end

	if (missionID==0) then
		callTimeOut=(callTimeOut - DT);
		if (callTimeOut<0) then
			if (callID==0) then
				gui_AddMsg("GUI\\help", PRESSTAB);
			end

			callID=(callID + 1);
			PlaySound2D("cellphone", 1);
			callTimeOut=2;
		end

		if (lastChar==9) and (callID>0) then
			PlayerUseObject(this);
		end

	end

	if (missionID==2) then
		local x, y, z=GetPosition(this);
		AddMarker("marker\\junkyard", x, y, z);
		local player=PLAYER;
		local px, py, pz=GetPosition(player);
		local dist=VectorLength((px - x), (py - y), (pz - z));
		if (dist<500) then
			PlayerUseObject(this);
		end

	end

	if (missionID==4) then
		local x, y, z=GetPosition(this);
		AddMarker("marker\\junkyard", x, y, z);
		local player=PLAYER;
		local px, py, pz=GetPosition(player);
		local dist=VectorLength((px - x), (py - y), (pz - z));
		local truck=FindObject("bosstruck");
		if (truck~=0) then
			z, y, x=z, GetPosition(truck);
			local truckLoadedWheels=GetNumber(truck, "LoadedWheels");
			local dist2truck=VectorLength((px - x), (py - y), (pz - z));
			if (dist<500) and (dist2truck<5000) and (truckLoadedWheels>=20) then
				PlayerUseObject(this);
			end

		end

	end

	if (missionID==6) then
		local x, y, z=GetPosition(this);
		AddMarker("marker\\junkyard", x, y, z);
		local player=PLAYER;
		local px, py, pz=GetPosition(player);
		local dist=VectorLength((px - x), (py - y), (pz - z));
		if (dist<800) then
			local car=GetVehicle(player);
			if (car>0) then
				if (GetNumber(car, "counted")==0) then
					if (GetName(car)=="bosstruck") then
					else
						carCount=(carCount + 1);
						if (carCount==1) then
							gui_AddMsg("GUI\\info", COOLFIRSTCAR);
						else
							gui_AddMsg("GUI\\info", GREATONEMORECAR);
						end

						SetNumber(car, "counted", 1);
					end

				end

			end

			if (carCount>=5) then
				PlayerUseObject(this);
			end

		end

	end

end

function rgirl_InitialUpdate(this)
	SetClipFactor(this, 40);
end

function rgirl_BeginDialog(this)
	return 7;

end

function rgirl_StartRace(this)
	local car=FindObject("player_car");
	Cmd(car, "spawn 306583 4750 325544 -0.17");
	Cmd(car, "Lights 1");
	local player=GetPlayer();
	local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
	SetDriver(car, player, roadnetwork);
	Cmd(player, "StartEngine");
	car=FindObject("girl_car");
	Cmd(car, "spawn 305610 4750 325272 -0.17");
	SetDriver(car, this, roadnetwork, 1);
	SetNumber(car, "health", 10000);
	SetNumber(car, "damagefactor", 0);
	Cmd(car, "Lights 1");
	Cmd(car, "defmaxspd 120");
	Cmd(car, "lock2surface 1");
	EnableClipDistance(car, 0);
	SetNumber(this, "racemode", 1);
	SetNumber(this, "counter", -3);
	Cmd(this, "StartEngine");
	local cmd=format("move %f %f %f 1 1", race_checkpoint["x"], race_checkpoint["y"], race_checkpoint["z"]);
	Cmd(this, cmd);
	SetString(this, "TrafficDenisty", GetSetting("TrafficDensity"));
	SetSetting("TrafficDensity", "3");
	SetRenderable(FindObject("finish"), 1);
	SetRenderable(FindObject("checkpoint"), 1);
	SkyDome("time", 23);
	ChanceOfRain=0;
	WeatherTimeOut=0;
	NextWeather=6;
	TargetFog=40000;
	ChanceOfRain=2;
	WeatherTimeOut=5000;
	Weather("storm", 1);
end

function rgirl_StopRace()
	local this=FindObject("rgirl");
	local car=GetVehicle(this);
	SetDriver(car, 0);
	Cmd(this, "spawn 315388 4296 325064");
end

function Animate(str, frames)
	format("marker\\checkpoint%d", floor(mod((GetTime() * 16), frames)));
end

function rgirl_Update(this)
	character_Update(this);
	if (GetNumber(this, "health")<=0) then
		do return end;

	end

	local racemode=GetNumber(this, "racemode");
	if (racemode==0) then
		rgirl_StartRace(this);
		do return end;

	end

	local car=GetVehicle(this);
	if (car==0) then
		do return end;

	end

	if (racemode==1) then
		local counter=GetNumber(this, "counter");
		counter=(counter + (DT / 2));
		if (counter<0) then
			local angle=(((-counter / 3) * 100) + 130);
			local px=(race_finish["x"] + (800 * sin(angle)));
			local py=(race_finish["y"] + 200);
			local pz=(race_finish["z"] + (800 * cos(angle)));
			LookAt(px, py, pz, race_finish["x"], (race_finish["y"] + 50), race_finish["z"]);
		end

		if (counter>=3) then
			racemode=2;
		end

		SetNumber(this, "counter", counter);
		local iprevcounter=floor(prevcounter);
		local icounter=floor(counter);
		if (icounter~=iprevcounter) and (icounter>=0) then
			local str=format("%d", (3 - icounter));
			if (icounter==3) then
				str="GO!!";
			end

			gui_AddRaceMsg(str);
		end

		Cmd(car, "stop");
		Cmd(GetVehicle(PLAYER), "stop");
	end

	if (racemode==2) or (racemode==5) then
		local x, y, z=GetPosition(car);
		local dist2=(((x - race_checkpoint["x"]) * (x - race_checkpoint["x"])) + ((z - race_checkpoint["z"]) * (z - race_checkpoint["z"])));
		if (dist2<(800 * 800)) then
			if (racemode==5) then
				racemode=6;
			else
				racemode=4;
			end

		end

	end

	if (racemode==4) then
		Cmd(car, "stop");
	end

	if (racemode==5) then
		Cmd(GetVehicle(PLAYER), "stop");
	end

	if (racemode==6) then
		Cmd(car, "stop");
		Cmd(GetVehicle(PLAYER), "stop");
	end

	if (racemode==6) or (racemode==5) then
		local angle=(((GetTime() / 2) * 100) + 130);
		local px=(race_checkpoint["x"] + (800 * sin(angle)));
		local py=(race_checkpoint["y"] + 200);
		local pz=(race_checkpoint["z"] + (800 * cos(angle)));
		LookAt(px, py, pz, race_checkpoint["x"], (race_checkpoint["y"] + 50), race_checkpoint["z"]);
	end

	if (car>0) then
		local x, y, z=GetPosition(car);
		AddMarker("marker\\cars", x, y, z, 8, 8, -4, -4);
		if (racemode==2) or (racemode==5) then
			local speed=GetSpeed(car);
			local less50=GetNumber(this, "less50");
			if (speed<50) then
				less50=(less50 + DT);
				if (less50>2) then
					local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
					z, y, x=z, GetPointOnNetwork(roadnetwork, x, y, z);
					z, y, x=z, IntersectLine(roadnetwork, x, (y + 100000), z, x, (y - 100000), z);
					local fx, fy, fz=TransDir(car, 0, 0, 1);
					local angle=-Vector2Angle(fx, fy, fz);
					y=(y + 100);
					local str=format("spawn %d %d %d %f", x, y, z, angle);
					Cmd(car, str);
					Cmd(car, "reset");
					SetNumber(car, "health", 10000);
					SetNumber(car, "damagefactor", 0);
					less50=0;
				else
					less50=0;
				end

			end

			SetNumber(this, "less50", less50);
		end

	end

	if (racemode>0) then
		local player=PLAYER;
		local px, py, pz=GetPosition(player);
		local target=GetNumber(player, "racetarget");
		if (target==0) then
			AddMarker(Animate("marker\\checkpoint", 3), race_checkpoint["x"], 0, race_checkpoint["z"], 24, 24, -12, -12);
			local dist2=(((px - race_checkpoint["x"]) * (px - race_checkpoint["x"])) + ((pz - race_checkpoint["z"]) * (pz - race_checkpoint["z"])));
			if (dist2<(800 * 800)) then
				SetNumber(player, "racetarget", 1);
				gui_AddRaceMsg("FINISH!");
				if (racemode==4) then
					message2(1.5, MISSIONFAILED);
					mission_curid=-2;
					mission_curtime=0;
					SetTimer(0);
					racemode=6;
				else
					MissionCalculateRating();
					StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy1", nil, MISSIONCOMPLETE, 50, 50, 50, 1);
					mission_curid=-1;
					mission_curtime=0;
					racemode=5;
				end

			end

		end

	end

	SetNumber(this, "racemode", racemode);
end

missionIDBeforeDialog=0;
function toolsaler_BeginDialog(this)
	if (missionID==6) then
		do return 5 end;

	end

	return 0;

end

function toolsaler_Update(this)
	character_Update(this);
	if (GetHealth(this)<=0) then
		do return end;

	end

	if (missionID==6) then
		local x, y, z=GetPosition(this);
		AddMarker("marker\\tools", x, y, z);
		local player=PLAYER;
		local px, py, pz=GetPosition(player);
		local dist=VectorLength((px - x), (py - y), (pz - z));
		if (dist<500) then
			if (GetNumber(this, "plofrange")==1) then
				PlayerUseObject(this);
				SetNumber(this, "plofrange", 0);
			end

		end

		if (dist>1000) then
			SetNumber(this, "plofrange", 1);
		end

	end

end

ES_ID=0;
function EngineSmoke_Init(x, y, z, w, h, angle, dx, dy, dz, this)
	z, y, x=z, GetVector(this, "Pos");
	return x, y, z, w, h, angle, dx, dy, dz;

end

function car_InitialUpdate(this, name)
	SetNumber(this, "CanKillPeople", 0);
	SetNumber(this, "health", 100);
	SetString(this, "EngineSmoke", "None");
	SetString(this, "EngineFire", "None");
	SetString(this, "CarSmoke", "None");
	SetNumber(this, "prev_health", 100);
	SetName(this, name);
	if (name=="models\\taxi") then
		SetNumber(this, "taxi", 1);
	else
		SetNumber(this, "taxi", 0);
	end

	if (name=="models\\police") then
		SetNumber(this, "police", 1);
	else
		SetNumber(this, "police", 0);
	end

	SetUpdateFunction(this, "car");
	SetNumber(this, "damagefactor", 1);
end

function wheel_Skid(this, id, x, y, z)
	local psid=InsertParticleSource("ParticleSystems\\skid.psf", x, y, z);
	local intensity=random(20, 100);
	SetColor(psid, intensity, intensity, intensity, (intensity * 1.2));
	local name="skid" .. tostring(id);
	local px, py, pz=GetVector(this, name .. "pos");
	local dist=VectorLength((px - x), (py - y), (pz - z));
	if (dist>30) then
		local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
		local treadid=GetNumber(this, name .. "id");
		AddTreadPt(splatter, treadid, x, (y + 5), z);
		SetVector(this, name .. "pos", x, y, z);
	end

end

function wheel_SkidOn(this, id, x, y, z)
	local name="skid" .. tostring(id);
	local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
	local treadid=AddTread(splatter, "sprite\\tread", 30, x, (y + 5), z);
	SetNumber(this, name .. "id", treadid);
	SetVector(this, name .. "pos", x, y, z);
end

function wheel_SkidOff(this, id, x, y, z)
	wheel_Skid(this, id, x, y, z);
	local name="skid" .. tostring(id);
	SetNumber(this, name .. "id", -1);
end

function car_putMarker(this)
	SetNumber(this, "OnRadar", 1);
	if (mission_curid==2) then
		carCount=(carCount + 1);
		message2(1.5, format(MARKERINSTALLED, carCount));
		SetActiveItem("thumbnail\\icon7", tostring(carCount));
	end

end

spawnedTimes=0;
function car_TrafficSpawn(this, name, parked, x, y, z)
	if (parked==0) then
		Cmd(GetDriver(this), "speedscale 1.5");
	end

	if (mission_curid==1) and (parked==1) and (name=="models\\police") then
		local px=(496519 + 200);
		local pz=(407990 - 500);
		local delta=VectorLength((px - x), 0, (pz - z));
		if (delta<(30000 + (30000 * carCount))) then
			do return 0 end;

		end

	end

	if (mission_curid==0) and (parked==0) then
		spawnedTimes=(spawnedTimes - 1);
		if (spawnedTimes>0) then
			do return 0 end;

		end

		if (spawnedTimes<=0) then
			spawnedTimes=20;
		end

	end

	return 1;

end

function car_Spawn(this)
	SetNumber(this, "prev_health", 100);
	SetNumber(this, "counted", 0);
	SetNumber(this, "OnRadar", 1);
	SetNumber(this, "hittimeout", 0);
	SetNumber(this, "damagefactor", 1);
	if (mission_curid==2) then
		SetNumber(this, "OnRadar", 0);
		if (random(0, 5)<carCount) then
			SetNumber(this, "OnRadar", 1);
		end

	end

	if (mission_curid==3) or (mission_curid==9) then
		SetNumber(this, "OnRadar", -1);
	end

end

function car_Die(this)
	local hx, hy, hz=GetPosition(this);
	InsertParticleSource("ParticleSystems\\bigexplosion.psf", hx, hy, hz);
	local id=InsertParticleSource("ParticleSystems\\bigexplosion_particles.psf", hx, hy, hz);
	SetTraceParams(id, 1, "sprite\\trace2", 14, 30);
	local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
	AddSplash(splatter, "sprite\\explosiontrack", random(1000, 1500), random(1000, 1500), hx, hy, hz, 0, -800, 100);
	PlaySound3D(hx, hy, hz, "Explosions\\exp", 1, "channel2");
end

function car_OutOfFuel(this)
	gui_AddMsg("GUI\\info", OUTOFFUEL);
end

function car_HitSound(hx, hy, hz)

end

function car_Damage(this, hx, hy, hz, hdepth, hobj, hspeed, hstaticobj, dmgscale, sparks)
	if (hdepth>1) then
		if (GetTime()<5) then
			do return end;

		end

		local sx, sy, sz=ScrPos();
		sx=(sx - hx);
		sy=(sy - hy);
		sz=(sz - hz);
		local dist2=(((sx * sx) + (sy * sy)) + (sz * sz));
		if (hdepth>15) then
			local health=GetNumber(this, "health");
			local deltahealth=((dmgscale * hdepth) * 0.15);
			if (deltahealth<1) then
				deltahealth=1;
			end

			if (deltahealth>5) then
				deltahealth=5;
			end

			local t=((GetNumber(this, "damagefactor") * deltahealth) * 0.3);
			local playercar=SameObjects(GetVehicle(PLAYER), this);
			if (playercar==0) or (god==0) then
				health=(health - t);
			end

			SetNumber(this, "health", health);
		end

		if (hstaticobj>0) then
			local updateFncName=GetUpdateFunction(hstaticobj);
			local updateFnc=getglobal(updateFncName .. "_carhit");
			if not ((not updateFnc)) then
				updateFnc(hstaticobj, this, hdepth);
			end

		end

		if (hdepth>=15) then
			if (GetNumber(this, "damagefactor")>0) then
				if (dist2<(2000 * 2000)) then
					local cmd=format("BreakGlass %f %f %f %f", hx, hy, hz, 80);
					Cmd(this, cmd);
				end

				cmd=format("BreakLock %f %f %f %f", hx, hy, hz, 80);
				Cmd(this, cmd);
			end

		end

		if (hdepth>5) or (hstaticobj>0) then
			if (dist2<(2000 * 2000)) then
				PlaySound3D(hx, hy, hz, "Car\\carhit", 7, "channel1");
				local player=PLAYER;
				local sameobjects=SameObjects(GetVehicle(player), this);
				if (sameobjects==1) and (hdepth>20) then
					if (GetNumber(hobj, "police")==1) then
						if (GetDriver(hobj)>0) then
							local hittimeout=GetNumber(hobj, "hittimeout");
							hittimeout=(hittimeout + 1);
							if (hittimeout>2) then
								addfelony(5);
								hittimeout=0;
							end

							SetNumber(hobj, "hittimeout", hittimeout);
						end

					end

				end

				if (sameobjects==1) then
					Cmd(this, "outofcontrol 0.1");
				end

				if  ((not sparks)) and (sameobjects==1) then
					for i=0, random(0, 2) do
						local id=InsertParticleSource("ParticleSystems\\carhit.psf", (hx + random(-50, 50)), (hy + random(-50, 50)), (hz + random(-50, 50)), 0, 0, 0, 2, 2, 2);
						SetTraceParams(id, 1, "sprite\\trace", 4, 2);
					end

				end

			end

		end

	end

end

function car_Update(this)
	local health=GetNumber(this, "health");
	local dx, dy, dz=TransDir(this, 0, 1, 0);
	if (dy<0) then
		local flipTimeout=GetNumber(this, "fliptimeout");
		flipTimeout=(flipTimeout + DT);
		SetNumber(this, "fliptimeout", flipTimeout);
		if (health>30) or (flipTimeout>10) then
			health=(health - (DT * 5));
		end

	end

	if (health<50) and (health>0) then
		local ESName=GetString(this, "EngineSmoke");
		local id=FindObject(ESName);
		if (id==0) then
			id=InsertParticleSource("ParticleSystems\\enginesmoke.psf");
			SetUpdateFunction(id, "smoke_Update");
			SetCreationFunction(id, "EngineSmoke_Init");
			ES_ID=(ES_ID + 1);
			ESName=tostring(ES_ID);
			SetString(this, "EngineSmoke", ESName);
			SetName(id, ESName);
		end

		local hx, hy, hz=GetHelper(this, "EnginePt");
		SetVector(id, "Pos", hx, hy, hz);
	end

	if (health<=10) then
		local ESName=GetString(this, "EngineFire");
		local id=FindObject(ESName);
		if (id==0) then
			id=InsertParticleSource("ParticleSystems\\enginefire.psf");
			SetUpdateFunction(id, "fire_Update");
			SetCreationFunction(id, "EngineSmoke_Init");
			ES_ID=(ES_ID + 1);
			ESName=tostring(ES_ID);
			SetString(this, "EngineFire", ESName);
			SetName(id, ESName);
		end

		local hx, hy, hz=GetHelper(this, "EnginePt");
		health=(health - DT);
		SetVector(id, "Pos", hx, hy, hz);
	end

	if (health<=0) then
		local ESName="";
		local prev_health=GetNumber(this, "prev_health");
		if (prev_health>0) then
			SetNumber(this, "prev_health", health);
			Cmd(this, "ExplodeParts");
			damage_CloseObjects(this, 1000, 1500);
			ESName=GetString(this, "EngineSmoke");
			Destroy(FindObject(ESName));
		end

		ESName=GetString(this, "CarSmoke");
		local id=FindObject(ESName);
		if (id==0) then
			id=InsertParticleSource("ParticleSystems\\carsmoke.psf");
			SetUpdateFunction(id, "smoke_Update");
			SetCreationFunction(id, "EngineSmoke_Init");
			ES_ID=(ES_ID + 1);
			ESName=tostring(ES_ID);
			SetString(this, "CarSmoke", ESName);
			SetName(id, ESName);
		end

		SetVector(id, "Pos", GetPosition(this));
	end

	SetNumber(this, "health", health);
	if (dy>0) then
		local hx, hy, hz, hdepth, hobj, hspeed, hdot, hstaticobj=GetHitDepth(this);
		car_Damage(this, hx, hy, hz, hdepth, hobj, hspeed, hstaticobj, 1);
	end

end

function buy_item(price, type, help)
	local money=GetNumber(PLAYER, "money");
	if (money<price) then
		gui_AddMsg("GUI\\info", NOTENOUGHMONEY);
	else
		money=(money - price);
		SetNumber(PLAYER, "money", money);
		SetNumber(PLAYER, type, 1);
		if not ((not help)) then
			gui_AddMsg("GUI\\info", help);
		end

		if (type=="pistol") then
			SetNumber(PLAYER, "haveweapon0", 1);
		end

		if (type=="uzi") then
			SetNumber(PLAYER, "haveweapon1", 1);
		end

		if (type=="fuel") then
			local car=GetVehicle(PLAYER);
			SetNumber(car, "fuel", (GetNumber(car, "fuel") + (price / 150)));
		end

		if (type=="repair") then
			local car=GetVehicle(PLAYER);
			SetNumber(car, "health", (GetNumber(car, "health") + ((100 * price) / 300)));
			Cmd(car, "restore");
		end

	end

end

function gs_Update(this)
	local car=GetVehicle(PLAYER);
	if (car>0) then
		local x, y, z=GetPosition(this);
		AddMarker("marker\\gas", x, y, z);
		y=(y + 100);
		local cx, cy, cz=GetPosition(car);
		local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
		if (dist2<250000) then
			local dlgvalid=GetNumber(this, "dlgvalid");
			dlgvalid=(dlgvalid - DT);
			if (dlgvalid<=0) then
				if (GetSpeed(car)<100) then
					if (Window("Chat", "visible")==0) then
						ShowDialog(8);
						dlgvalid=5;
					end

				end

			end

			SetNumber(this, "dlgvalid", dlgvalid);
		else
			SetNumber(this, "dlgvalid", 0);
		end

		if (dist2<1000000) then
			if (Window("Chat", "visible")==1) then
				Cmd(car, "stop");
			end

		end

	end

end

function girl_Die(this)
	character_Die(this);
end

function girl_Damage(this)
	character_Damage(this);
end

function girl_InitialUpdate(this, name)
	character_InitialUpdate(this, name);
end

function girl_Afraid(this)
	character_Afraid(this);
end

function girl_Spawn(this)
	girl_Spawn(this);
end

function girl_Update(this)
	character_Update(this);
	local health=GetNumber(this, "health");
	local state=GetNumber(this, "state");
	local frame=GetFrame(this);
	local prevframe=GetPrevFrame(this);
	local player=PLAYER;
	local x, y, z=GetPosition(this);
	if (state==2) and (health>0) then
		local t=GetNumber(this, "delay");
		t=(t + DT);
		if (t>30) then
			SetNumber(this, "state", 0);
			SetRenderable(this, 1);
			local cx, cy, cz=GetPosition(player);
			local cmd=format("turn %d %d %d 1", cx, cy, cz);
			Cmd(this, cmd);
			Cmd(this, "autoappear 1");
			t=0;
		end

		if (t>10) and (curgirlpt==6) and (mission_curid~=-1) then
			message2(1.5, MISSIONCOMPLETE, YOURRATING .. MissionCalculateRating());
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
		end

		SetNumber(this, "delay", t);
	end

	if (state==1) and (health>0) and (prevframe<=1) and (frame>1) then
		local cx, cy, cz=GetVector(this, "target");
		local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
		local cmd=format("turn %d %d %d 1", cx, cy, cz);
		Cmd(this, cmd);
		if (dist2>=(200 * 200)) then
			cmd=format("move %d %d %d", cx, cy, cz);
			Cmd(this, cmd);
		end

		if (dist2<(300 * 300)) then
			Cmd(this, "autoappear -1");
		end

		if (dist2<(200 * 200)) then
			SetNumber(this, "state", 2);
		end

	end

	if (state==0) and (health>0) then
		local car=GetVehicle(player);
		local anim=GetAnimation(this);
		if (car>0) then
			if (GetNumber(car, "health")<=0) then
				Cmd(this, "anim idle");
			end

		end

		if (prevframe<=1) and (frame>1) and (car>0) and (anim=="idle1") then
			local speed=GetSpeed(car);
			local cx, cy, cz=GetHelper(car, "Passenger_outpt");
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			if (speed<50) and (dist2>3000) then
				if (dist2<(2500 * 2500)) then
					cmd=format("move %d %d %d", cx, cy, cz);
					Cmd(this, cmd);
				else
					if (dist2<(5000 * 5000)) then
						local cmd=format("turn %d %d %d 1", cx, cy, cz);
						Cmd(this, cmd);
					end

				end

			end

		end

		if (anim=="walk") and (car>0) then
			local cx, cy, cz=GetHelper(car, "Passenger_outpt");
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			if (dist2<3000) then
				Cmd(this, "anim idle");
				Cmd(car, "unlock rightdoor");
				Cmd(car, "open rightdoor");
				local px, py, pz=GetPosition(car);
				local cmd=format("turn %d %d %d 1", px, py, pz);
				Cmd(this, cmd);
			else
				local cmd=format("move %d %d %d", cx, cy, cz);
				Cmd(this, cmd);
			end

		end

		if (anim=="passenger") then
			local cx, cy, cz=GetVector(this, "target");
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			local pCar=GetVehicle(this);
			if (dist2<4000000) then
				if (GetSpeed(pCar)<50) then
					Cmd(this, "OutOfCar");
					EnableClipDistance(this, 0);
					SetNumber(this, "state", 1);
				end

			end

			if (car~=0) then
				if (GetNumber(car, "health")<=20) then
				end

				Cmd(this, "OutOfCar");
				EnableClipDistance(this, 0);
			end

		end

		if (frame>20) and (prevframe<=20) and (car>0) and (anim=="idle1") then
			local cx, cy, cz=GetHelper(car, "Passenger_outpt");
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			if (dist2<4000) then
				SetDriver(car, this, 0, 1, 1);
				Cmd(car, "close rightdoor");
				curgirlpt=(curgirlpt + 1);
				curgirlpt=-curgirlpt;
			end

		end

	end

end

function chinamafiose_Die(this)
	character_Die(this);
end

function chinamafiose_Damage(this)
	character_Damage(this);
end

function chinamafiose_InitialUpdate(this, name)
	character_InitialUpdate(this, name);
	SetClipFactor(this, 40);
end

function chinamafiose_Afraid(this)
	character_Afraid(this);
end

function chinamafiose_Spawn(this)
	chinamafiose_Spawn(this);
end

function chinamafiose_Update(this)
	character_Update(this);
	local health=GetNumber(this, "health");
	local state=GetNumber(this, "state");
	local frame=GetFrame(this);
	local prevframe=GetPrevFrame(this);
	local player=PLAYER;
	local x, y, z=GetPosition(this);
	if (state==1) and (health>0) and (prevframe<=1) and (frame>1) then
		local cx, cy, cz=GetVector(this, "target");
		local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
		local cmd=format("turn %d %d %d 1", cx, cy, cz);
		Cmd(this, cmd);
		if (dist2>=(200 * 200)) then
			cmd=format("move %d %d %d", cx, cy, cz);
			Cmd(this, cmd);
		end

		if (dist2<(200 * 200)) and (mission_curid~=-1) then
			MissionCalculateRating();
			StartIntro("Sounds\\rap2.wav", "intro\\chinatown", "intro\\slippy1", "intro\\mob1", MISSIONCOMPLETE, 50, 50, 50, 1);
			mission_curid=-1;
			mission_curtime=0;
			SetTimer(0);
		end

	end

	if (state==0) and (health>0) then
		local car=GetVehicle(player);
		local anim=GetAnimation(this);
		if (car>0) then
			if (GetNumber(car, "health")<=0) then
				Cmd(this, "anim idle");
			end

		end

		if ((prevframe<=1) and (frame>1)) or ((prevframe<=100) and (frame>100)) or ((prevframe<=200) and (frame>200)) then
			if (car>0) and (anim=="idle1") then
				local speed=GetSpeed(car);
				local cx, cy, cz=GetHelper(car, "Passenger_outpt");
				local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
				if (speed<50) and (dist2>3000) then
					if (dist2<(300 * 300)) then
						Cmd(car, "camera 5 -360 0");
						cmd=format("move %d %d %d", cx, cy, cz);
						Cmd(this, cmd);
					else
						if (dist2<(3000 * 3000)) then
							local cmd=format("turn %d %d %d 1", cx, cy, cz);
							Cmd(this, cmd);
						end

					end

				end

			end

		end

		if (anim=="walk") and (car>0) then
			local cx, cy, cz=GetHelper(car, "Passenger_outpt");
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			if (dist2<3000) then
				Cmd(this, "anim idle");
				Cmd(car, "unlock rightdoor");
				Cmd(car, "open rightdoor");
				local px, py, pz=GetPosition(car);
				local cmd=format("turn %d %d %d 1", px, py, pz);
				Cmd(this, cmd);
			else
				local cmd=format("move %d %d %d", cx, cy, cz);
				Cmd(this, cmd);
			end

		end

		if (anim=="passenger") then
			local cx, cy, cz=GetVector(this, "target");
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			local pCar=GetVehicle(this);
			if (dist2<4000000) then
				if (GetSpeed(pCar)<50) then
					Cmd(this, "OutOfCar");
					EnableClipDistance(this, 0);
					SetNumber(this, "state", 1);
				end

			end

			if (car~=0) then
				if (GetNumber(car, "health")<=20) then
				end

				Cmd(this, "OutOfCar");
				EnableClipDistance(this, 0);
			end

		end

		if (frame>20) and (prevframe<=20) and (car>0) and (anim=="idle1") then
			local cx, cy, cz=GetHelper(car, "Passenger_outpt");
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			if (dist2<4000) then
				SetDriver(car, this, 0, 1, 1);
				Cmd(car, "close rightdoor");
				SetVector(this, "target", 393717, 4069, 487937);
				SetNumber(this, "updatemarker", 1);
				Cmd(FindObject("pikap"), "enable 1");
				Cmd(FindObject("shooter"), "enable 1");
				Cmd(FindObject("gangpikap"), "enable 1");
			end

		end

	end

end

function lamppost2_Update(this)

end

function lamppost2_Render(this)
	if (GetRenderable(this)==0) then
		do return end;

	end

	SetSupportPauseMode(this, 1);
	if (LEVEL_TIME<6) or (LEVEL_TIME>20) then
		local x, y, z=TransPt(this, -173, 370, 0);
		AddLight(x, y, z, 2500, 255, 200, 150, 1.5);
		if (GetVisible(this)==1) then
			local intensity=255;
			AddFlare(x, y, z, 200, "sprite\\flare", 0, 0, intensity, intensity, intensity);
		end

	end

end

function lamppost3_Update(this)

end

function lamppost3_Render(this)
	if (GetRenderable(this)==0) then
		do return end;

	end

	SetSupportPauseMode(this, 1);
	if (LEVEL_TIME<6) or (LEVEL_TIME>20) then
		local x, y, z=TransPt(this, 0, 700, 0);
		AddLight(x, y, z, 2500, 255, 200, 150, 1.5);
		if (GetVisible(this)==1) then
			local intensity=140;
			AddFlare(x, y, z, 600, "sprite\\flare", 0, 0, intensity, intensity, intensity);
		end

	end

end

TL1={-1066,
	597,
	10};
TL2={-375,
	597,
	-10};
function lamppost4_Update(this)

end

function lamppost4_Render(this)
	if (GetRenderable(this)==0) then
		do return end;

	end

	SetSupportPauseMode(this, 1);
	local id=GetNumber(this, "id");
	if (CurrentGreenLight==id) then
		activeLight=0;
	else
		activeLight=2;
	end

	local r=255;
	local g=255;
	if (LEVEL_TIME<6) then
		activeLight=1;
		if (floor(mod((GetTime() * 2), 2))==0) then
			do return end;

		end

	end

	if (activeLight==0) then
		r=0;
	end

	if (activeLight==2) then
		g=0;
	end

	detecttimeout=GetNumber(this, "detecttimeout");
	detecttimeout=(detecttimeout - DT);
	local cameraside=GetNumber(this, "cameraside");
	if (detecttimeout<0) then
		detecttimeout=((random() * 0.2) + 0.2);
		local dx, dy, dz=TransDir(this, 0, 0, 1);
		local sx, sy, sz=ScrPos();
		local px, py, pz=GetPosition(this);
		local dotself=(((px * dx) + (py * dy)) + (pz * dz));
		local dotcam=(((sx * dx) + (sy * dy)) + (sz * dz));
		cameraside=0;
		if (dotcam<(dotself - 200)) then
			cameraside=1;
		end

		if (dotcam>(dotself + 200)) then
			cameraside=-1;
		end

		SetNumber(this, "cameraside", cameraside);
	end

	SetNumber(this, "detecttimeout", detecttimeout);
	local x, y, z=TransPt(this, TL1[1], (TL1[2] + (activeLight * 40)), TL1[3]);
	if (cameraside==-1) then
		if (GetVisible(this)==1) then
			AddFlare(x, y, z, 1000, "sprite\\flare", 0, 0, r, g, 0);
			AddFlare(x, y, z, 100, "sprite\\flare", 0, 0, r, g, 0);
		end

	end

	z1, y1, x1=TransPt(this, TL2[1], (TL2[2] + (activeLight * 40)), TL2[3]);
	if (cameraside==1) then
		if (GetVisible(this)==1) then
			AddFlare(x1, y1, z1, 1000, "sprite\\flare", 0, 0, r, g, 0);
			AddFlare(x1, y1, z1, 100, "sprite\\flare", 0, 0, r, g, 0);
		end

	end

	if (CurrentGreenLight~=id) then
		if (mod((CurrentGreenLight + 2), 4)==id) then
		end

		AddLight(((x + x1) / 2), ((y + y1) / 2), ((z + z1) / 2), 1500, (r / 2), (g / 2), 0);
	end

end

