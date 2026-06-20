mission_curid=0;
Fade(1, 1);
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

SetRenderable(FindObject("Water"),  1);
SetFOVAndClipPlanes(55, 10, 50000);
SetBGColor(0, 0, 10);

function template_OnLoad()
	TemplatesLoaded=(TemplatesLoaded + 1);
	ShowLoadProgressBar(lastProgress);

end
prev_progress=-100;

print("LOAD");

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
		local res, palpha=wait();
		LOADING(progress, 1, 255, palpha);
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

print("LOAD E");

--ShowLoadProgressBar(0);

function InitSkyDome()
	SkyDome("enable");
	local rndtime=random();
	Material("default", "ambient", (0.35 + (rndtime * 0.1)), (0.25 + (rndtime * 0.1)), 0.15, 0);
	Material("ground", "ambient", (0.45 + (rndtime * 0.1)), (0.35 + (rndtime * 0.1)), 0.25, 0);
	Material("wall", "ambient", (0.45 + (rndtime * 0.1)), (0.35 + (rndtime * 0.1)), 0.25, 0);
	SkyDome("time", ((rndtime * 2) + 19));

end

print("SKY E");

InitSkyDome();
Resume();
SetTimer(0);
terrain=InsertTerrain("city", "textures\\Terrain\\city\\cityHMap.bmp", "", "textures\\Terrain\\city\\cityDemographic.jpg", 800, 200, 16);
SetAsStatic(terrain);
SetName(terrain, "TERRAIN");
print("terr E");
GenNormals(terrain, 1);
roadnetwork=InsertRoadNetwork(512, 0, 512, terrain, "city\\sanjose.city");
cmd=format("CreateGeometry %s %s %s %s", "textures\\city\\road", "textures\\city\\crossing", "textures\\city\\pavement", "textures\\city\\offroad");
--ShowLoadProgressBar(10);
Cmd(roadnetwork, cmd);
Cmd(roadnetwork, "ExtrudeShapes");
--ShowLoadProgressBar(20);
SetAsStatic(roadnetwork);

print("BASE E");

function StartMission(mission_id)
		CreatePlayer(496519, (5015 + 250), (407990 - 500), roadnetwork);
		SetNumber(GetPlayer(), "picklock", 1);
		SetNumber(GetPlayer(), "scanner", 1);
		SetNumber(GetPlayer(), "haveweapon0", 1);
		SetNumber(GetPlayer(), "haveweapon1", 1);
		Weather("overcast", 1);
	end
	
StartMission(14);

print("START MIS E");
	
		--ShowLoadProgressBar(60);
		Cmd(roadnetwork, "BuildTree");
		--ShowLoadProgressBar(80);
		InitializeSpawnItems();
		--ShowLoadProgressBar(90);
		LEVEL_TIME=0;
		
function _tmp_Update()
	_sanjose_Update();

end

		
function _sanjose_SwitchLevel(active) end

		
function _sanjose_InitialUpdate() end

		FadeTimeout=2;
		MusicReadyTimeout=0;
		
function _sanjose_Update()
	PLAYER=GetPlayer();
	DT=GetDT();
	FadeTimeout=(FadeTimeout - DT);
	local player=PLAYER;
	local player_car=GetVehicle(player);
	if (player_car>0) then
		SetNumber(player_car, "fuel", 1);
	end
	
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
	end
	
	print("w");
			Weather("enable");
		ShowLoadProgressBar(1000);
		Fade(0, 1);
		
		print("MIN LOAD END E");