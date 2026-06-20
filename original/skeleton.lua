DefaultConstraints={"1",
	"2",
	"2",
	"4",
	"2",
	"3",
	"3",
	"5",
	"5",
	"6",
	"4",
	"7",
	"7",
	"8",
	"2",
	"9",
	"2",
	"10",
	"3",
	"4",
	"3",
	"9",
	"3",
	"10",
	"4",
	"9",
	"4",
	"10",
	"9",
	"10",
	"11",
	"12",
	"9",
	"11",
	"10",
	"12",
	"10",
	"11",
	"9",
	"12",
	"11",
	"13",
	"13",
	"14",
	"12",
	"15",
	"15",
	"16",
	"1",
	"3",
	"1",
	"4",
	"2",
	"17",
	"3",
	"11",
	"4",
	"12"};
DefaultSoftConstraints={"2",
	"14",
	1.2,
	"2",
	"16",
	1.2,
	"3",
	"14",
	0.8,
	"4",
	"16",
	0.8,
	"14",
	"16",
	1.5,
	"13",
	"15",
	0.8,
	"9",
	"17",
	1.2,
	"6",
	"8",
	1.5};
DefaultParticles={"Bip01 Head",
	5,
	"Bip01 Neck",
	5,
	"Bip01 R UpperArm",
	5,
	"Bip01 L UpperArm",
	5,
	"Bip01 R Forearm",
	1,
	"Bip01 R Hand",
	1,
	"Bip01 L Forearm",
	1,
	"Bip01 L Hand",
	1,
	"Bip01 Spine1",
	5,
	"Bip01 Spine1",
	5,
	"Bip01 R Thigh",
	1,
	"Bip01 L Thigh",
	1,
	"Bip01 R Calf",
	1,
	"Bip01 R Foot",
	5,
	"Bip01 L Calf",
	1,
	"Bip01 L Foot",
	5,
	"Bip01 Head",
	0.1};
function CP_explode(this, cx, cy, cz, radius, power, ax, ay, az)
	local id=1;
	while (id<=17) do
		local name=format("%d", id);
		local x, y, z=CP_getPos(this, name);
		local dx=(x - cx);
		local dy=(y - cy);
		local dz=(z - cz);
		local size=VectorLength(dx, dy, dz);
		if (size<radius) then
			dx, dy, dz=DivVector(dx, dy, dz, size);
			dx, dy, dz=MulVector(dx, dy, dz, (power * (1 - (size / radius))));
			dx, dy, dz=AddVectors(dx, dy, dz, ax, ay, az);
			CP_accelerate(this, name, dx, dy, dz);
		end

		id=(id + 1);
	end

end

function CP_accelerateAll(this, ax, ay, az)
	local id=1;
	while (id<=17) do
		local name=format("%d", id);
		CP_accelerate(this, name, ax, ay, az);
		id=(id + 1);
	end

end

function CP_findClosestPoint(this, x, y, z, min, max)
	local id=2;
	local ret_name=nil;
	local best_dist=max;
	local ret_x=0;
	local ret_y=0;
	local ret_z=0;
	while (id<=17) do
		if (id~=9) and (id~=10) and (id~=3) and (id~=4) and (id~=11) and (id~=12) then
			local tname=format("%d", id);
			local px, py, pz=CP_getPos(this, tname);
			local dx, dy, dz=SubVectors(px, py, pz, x, y, z);
			local size=VectorLength(dx, dy, dz);
			if (size>=min) and (size<=best_dist) then
				best_dist=size;
				ret_name=tname;
				ret_x=px;
				ret_y=py;
				ret_z=pz;
			end

		end

		id=(id + 1);
	end

	return ret_name, ret_x, ret_y, ret_z;

end

function CP_friction(this, friction)
	local id=1;
	while (id<=17) do
		local name=format("%d", id);
		CP_setFriction(this, name, friction);
		id=(id + 1);
	end

end

function CP_resetAcceleration(this)
	id=1;
	while (id<=17) do
		name=format("%d", id);
		CP_move(this, name, CP_getPos(this, name));
		id=(id + 1);
	end

end

function SkeletonMovePoints(this)
	local id=1;
	while (id<=17) do
		local x, y, z=GetBoneCenter(this, DefaultParticles[((id * 2) - 1)]);
		if (id==9) then
			x, y, z=GetBoneCenter(this, DefaultParticles[((id * 2) - 1)], -100, 0, 0);
		end

		if (id==10) then
			x, y, z=GetBoneCenter(this, DefaultParticles[((id * 2) - 1)], 100, 0, 0);
		end

		if (id==17) then
			x, y, z=GetBoneCenter(this, DefaultParticles[((id * 2) - 1)], 0, 0, -20);
		end

		local name=format("%d", id);
		CP_move(this, name, x, y, z);
		id=(id + 1);
	end

end

function SkeletonEnable(this)
	if (GetNumber(this, "skeletonEnabled")==1) then
		do return end;

	end

	CP_enable(this, 1);
	SkeletonMovePoints(this);
	SetNumber(this, "skeletonEnabled", 1);
end

function SkeletonDisable(this)
	CP_enable(this, 0);
	SetNumber(this, "skeletonEnabled", 0);
end

function InitializeSkeleton(this)
	CP_setGravity(this, 0, -150, 0);
	radius=10;
	local id=1;
	while (id<=17) do
		local x, y, z=GetBoneCenter(this, DefaultParticles[((id * 2) - 1)]);
		if (id==9) then
			x, y, z=GetBoneCenter(this, DefaultParticles[((id * 2) - 1)], -30, 0, 0);
		end

		if (id==10) then
			x, y, z=GetBoneCenter(this, DefaultParticles[((id * 2) - 1)], 30, 0, 0);
		end

		if (id==17) then
			x, y, z=GetBoneCenter(this, DefaultParticles[((id * 2) - 1)], 0, 0, -10);
		end

		local name=format("%d", id);
		local invmass=0.01;
		CP_addParticle(this, name, x, y, z, radius, invmass);
		id=(id + 1);
		CP_setFriction(this, name, 0.9);
	end

	local id=1;
	while (id<=58) do
		local a=DefaultConstraints[id];
		local b=DefaultConstraints[(id + 1)];
		local restlength=CP_getDist(this, a, b);
		local name=format("%s-%s", a, b);
		if (restlength<10) then
			restlength=10;
		end

		CP_addConstraint(this, name, a, b, restlength);
		id=(id + 2);
	end

	id=1;
	while (id<=24) do
		a=DefaultSoftConstraints[id];
		b=DefaultSoftConstraints[(id + 1)];
		max=CP_getDist(this, a, b);
		if (max<5) then
			max=5;
		end

		min=(max * DefaultSoftConstraints[(id + 2)]);
		name=format("%s-%s", a, b);
		CP_addSoftConstraint(this, name, a, b, min, max);
		id=(id + 3);
	end

	CP_addBone(this, "Head", "2", "2", "17", "9", "10");
	CP_assignVertices(this, "Head", "Bip01 Head");
	CP_assignVertices(this, "Head", "Bip01 Neck");
	CP_assignVertices(this, "Head", "Bip01 Neck1");
	CP_addBone(this, "Breast", "9", "9", "2", "9", "10");
	CP_assignVertices(this, "Breast", "Bip01 R Clavicle");
	CP_assignVertices(this, "Breast", "Bip01 L Clavicle");
	CP_assignVertices(this, "Breast", "Bip01 Spine3");
	CP_assignVertices(this, "Breast", "Bip01 Spine2");
	CP_addBone(this, "Body", "9", "9", "1", "9", "10");
	CP_assignVertices(this, "Body", "Bip01 Spine1");
	CP_assignVertices(this, "Body", "Bip01 Spine");
	CP_assignVertices(this, "Body", "Bip01 Pelvis");
	CP_addBone(this, "RUpperArm", "3", "3", "5", "9", "10");
	CP_assignVertices(this, "RUpperArm", "Bip01 R UpperArm");
	CP_addBone(this, "RForeArm", "5", "5", "6", "9", "10");
	CP_assignVertices(this, "RForeArm", "Bip01 R Forearm");
	CP_assignVertices(this, "RForeArm", "Bip01 R Hand");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger0");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger01");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger02");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger03");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger1");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger11");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger12");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger13");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger2");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger21");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger22");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger23");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger3");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger31");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger32");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger33");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger4");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger41");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger42");
	CP_assignVertices(this, "RForeArm", "Bip01 R Finger43");
	CP_addBone(this, "LUpperArm", "4", "4", "7", "9", "10");
	CP_assignVertices(this, "LUpperArm", "Bip01 L UpperArm");
	CP_addBone(this, "LForeArm", "7", "7", "8", "9", "10");
	CP_assignVertices(this, "LForeArm", "Bip01 L Forearm");
	CP_assignVertices(this, "LForeArm", "Bip01 L Hand");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger0");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger01");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger02");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger03");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger1");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger11");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger12");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger13");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger2");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger21");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger22");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger23");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger3");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger31");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger32");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger33");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger4");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger41");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger42");
	CP_assignVertices(this, "LForeArm", "Bip01 L Finger43");
	CP_addBone(this, "LThigh", "12", "12", "15", "9", "10");
	CP_assignVertices(this, "LThigh", "Bip01 L Thigh");
	CP_addBone(this, "LCalf", "15", "15", "16", "9", "10");
	CP_assignVertices(this, "LCalf", "Bip01 L Calf");
	CP_assignVertices(this, "LCalf", "Bip01 L Foot");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe0");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe01");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe02");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe1");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe11");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe12");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe2");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe21");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe22");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe3");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe31");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe32");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe4");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe41");
	CP_assignVertices(this, "LCalf", "Bip01 L Toe42");
	CP_addBone(this, "RThigh", "11", "11", "13", "9", "10");
	CP_assignVertices(this, "RThigh", "Bip01 R Thigh");
	CP_addBone(this, "RCalf", "13", "13", "14", "9", "10");
	CP_assignVertices(this, "RCalf", "Bip01 R Calf");
	CP_assignVertices(this, "RCalf", "Bip01 R Foot");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe0");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe01");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe02");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe1");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe11");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe12");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe2");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe21");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe22");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe3");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe31");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe32");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe4");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe41");
	CP_assignVertices(this, "RCalf", "Bip01 R Toe42");
	CP_setFriction(this, "17", 0.9);
end

function Scream(this, series, max)
	local al=FindObject("OpenAL");
	local id=random(1, max);
	local name=series .. id;
	Cmd(al, format("Close scream"));
	local s=format("Open Sounds\\People\\%s.wav 0 0 scream", name);
	Cmd(al, s);
	Cmd(al, "Gain scream 1 0 1");
	Cmd(al, "Pitch scream " .. tostring(((random() * 0.1) + 0.95)));
	Cmd(al, "Dist scream 5000 500");
	local px, py, pz=GetPosition(this);
	py=(py + 100);
	s=format("Move scream %d %d %d", px, py, pz);
	Cmd(al, s);
	Cmd(al, "Play scream");
end

function PlaySound3D(px, py, pz, series, max, bufname)
	local sx, sy, sz=ScrPos();
	local dist2=((((sx - px) * (sx - px)) + ((sy - py) * (sy - py))) + ((sz - sz) * (sz - pz)));
	if (dist2>(3000 * 3000)) then
		do return end;

	end

	local al=FindObject("OpenAL");
	local id=random(1, max);
	local name=series .. id;
	if not (bufname) then
		bufname=series;
	end

	Cmd(al, format("Close %s", bufname));
	local s=format("Open Sounds\\%s.wav 0 0 %s", name, bufname);
	Cmd(al, s);
	Cmd(al, format("Gain %s 1 0 1", bufname));
	Cmd(al, format("Dist %s 5000 500", bufname));
	s=format("Move %s %d %d %d", bufname, px, py, pz);
	Cmd(al, s);
	Cmd(al, "Play " .. bufname);
end

function PickFunction1(this)
	gui_AddMsg("GUI\\info", CLIP);
	local pistol=FindObject("pistol");
	SetNumber(pistol, "ammo", (GetNumber(pistol, "ammo") + 20));
	local uzi=FindObject("uzi");
	SetNumber(uzi, "ammo", (GetNumber(uzi, "ammo") + 50));
	local rush=PLAYER;
	rush_selectWeapon(rush, GetNumber(rush, "weapon"));
	PlaySound2D("pickup", 1, "channel1");
end

function PickFunction0(this)
	gui_AddMsg("GUI\\info", HUNDRED);
	SetNumber(this, "money", (GetNumber(this, "money") + 100));
	PlaySound2D("pickup", 1, "channel1");
end

function PickFunction2(this)
	gui_AddMsg("GUI\\info", FIRSTKIT);
	SetNumber(this, "health", (GetNumber(this, "health") + 20));
	PlaySound2D("pickup", 1, "channel1");
end

function PickFunction3(this)
	gui_AddMsg("GUI\\info", ADDUZI);
	local uzi=FindObject("uzi");
	SetNumber(uzi, "ammo", (GetNumber(uzi, "ammo") + 50));
	SetNumber(PLAYER, "haveweapon1", 1);
	rush_selectWeapon(this, 1);
	PlaySound2D("pickup", 1, "channel1");
end

function PickFunction4(this)
	gui_AddMsg("GUI\\info", ADDPISTOL);
	local pistol=FindObject("pistol");
	SetNumber(pistol, "ammo", (GetNumber(pistol, "ammo") + 30));
	SetNumber(PLAYER, "haveweapon0", 1);
	rush_selectWeapon(this, 0);
	PlaySound2D("pickup", 1, "channel1");
end

function item_Update(this)
	local x, y, z=GetPosition(this);
	local t=floor((sin((GetTime() * 360)) * 20));
	AddFlare(x, y, z, 100, "sprite\\flare", 0, 0, 0, 0, (50 + t));
	local collided=GetNumber(this, "collided");
	if (collided==0) then
		local dx, dy, dz=GetVector(this, "accel");
		local nx=(x + dx);
		local ny=(y + dy);
		local nz=(z + dz);
		dy=(dy - 2);
		SetVector(this, "accel", dx, dy, dz);
		local touch=0;
		nx, ny, nz, touch, collided=MoveBody(30, nx, ny, nz, x, y, z, 1);
		SetPosition(this, nx, ny, nz);
		SetNumber(this, "collided", collided);
	else
		local player=PLAYER;
		local px, py, pz=GetPosition(player);
		local dist2=((((x - px) * (x - px)) + ((y - py) * (y - py))) + ((z - pz) * (z - pz)));
		if (dist2<6000) then
			local anim=GetAnimation(player);
			if (anim=="idle1") or (anim=="run") then
				local fncname=GetNumber(this, "PickFunction");
				SetRenderable(this, 0);
				SetUpdatable(this, 0);
				local fnc=getglobal("PickFunction" .. tostring(fncname));
				fnc(player);
			end

		end

		if (dist2>(3000 * 3000)) then
			SetRenderable(this, 0);
			SetUpdatable(this, 0);
		end

	end

end

function AddSpawnItems(series, max, pickfnc, scale)
	for i=1, max do
		local id=InsertObject(series);
		SetName(id, series .. i);
		SetRenderable(id, 0);
		SetUpdatable(id, 0);
		SetUpdateFunction(id, "item");
		EnableClipDistance(id, 0);
		if not (scale) then
			scale=1;
		end

		SetScale(id, scale, scale, scale);
		GenNormals(id, 1);
		SetNumber(id, "PickFunction", pickfnc);
	end

end

function InitializeSpawnItems()
	AddSpawnItems("models\\money", 3, 0, 1);
	AddSpawnItems("models\\clip", 3, 1, 1);
	AddSpawnItems("models\\firstaid", 3, 2, 1);
	AddSpawnItems("models\\uzi", 1, 3, 1.5);
	AddSpawnItems("models\\pistol", 1, 4, 1.5);
end

function FindUnusedItem(series, max)
	local i=0;
	for i=1, max do
		local id=FindObject(series .. i);
		if (GetRenderable(id)==0) then
			do return id end;

		end

	end

	return 0;

end

function SpawnItem(this, x, y, z)
	SetRenderable(this, 1);
	SetUpdatable(this, 1);
	SetPosition(this, x, y, z);
	SetEulerRotation(this, 0, ((random() * PI) * 2), 0);
	SetVector(this, "accel", random(-5, 5), random(15, 30), random(-5, 5));
	SetNumber(this, "collided", 0);
end

function SpawnItems(this)
	if (random(0, 2)>0) then
		do return end;

	end

	local px, py, pz=GetPosition(this);
	local money=GetNumber(this, "money");
	local t=0;
	for t=1, money do
		local id=FindUnusedItem("models\\money", 3);
		SpawnItem(id, px, py, pz);
	end

	SetNumber(this, "money", 0);
	local bullets=GetNumber(this, "bullets");
	for t=1, bullets do
		local id=FindUnusedItem("models\\clip", 3);
		SpawnItem(id, px, py, pz);
	end

	SetNumber(this, "bullets", 0);
	local firstaidkit=GetNumber(this, "firstaidkit");
	for t=1, firstaidkit do
		local id=FindUnusedItem("models\\firstaid", 3);
		SpawnItem(id, px, py, pz);
	end

	SetNumber(this, "firstaidkit", 0);
	local uzi=GetNumber(this, "uzi");
	for t=1, uzi do
		local id=FindUnusedItem("models\\uzi", 1);
		SpawnItem(id, px, py, pz);
	end

	SetNumber(this, "uzi", 0);
	local uzi=GetNumber(this, "pistol");
	for t=1, uzi do
		local id=FindUnusedItem("models\\pistol", 1);
		SpawnItem(id, px, py, pz);
	end

	SetNumber(this, "pistol", 0);
end

function PlaySound2D(series, max, channel)
	local px, py, pz=ScrPos();
	PlaySound3D(px, py, pz, series, max, channel);
end

function dollar_InitialUpdate(this)
	GenNormals(this, 1);
	SetRenderable(this, 0);
	SetUpdatable(this, 0);
	EnableClipDistance(this, 0);
	SetScale(this, 1.2, 1.2, 1.2);
end

function SpawnDollar(this)
	for i=1, 15 do
		local id=FindObject("dollar" .. i);
		if (GetRenderable(id)==0) then
			SetRenderable(id, 1);
			local x, y, z=GetPosition(this);
			SetPosition(id, x, (y + 200), z);
			SetNumber(this, "dollar", i);
			do return end;

		end

	end

end

function UpdateDollar(this)
	local id=FindObject("dollar" .. GetNumber(this, "dollar"));
	if (id==0) then
		do return end;

	end

	local x, y, z=GetPosition(id);
	local cx, cy, cz=GetPosition(this);
	local time=GetTime();
	x=cx;
	y=((cy + (sin((time * 300)) * 50)) + 300);
	z=cz;
	SetEulerRotation(id, 0, time, 0);
	SetPosition(id, x, y, z);
	AddFlare(x, (y + 50), z, 200, "sprite\\flare", 0, 0, 0, 200, 0);
end

function KillDollar(this)
	local id=FindObject("dollar" .. GetNumber(this, "dollar"));
	SetNumber(this, "dollar", 0);
	SetRenderable(id, 0);
end

function character_Die(this)
	KillDollar(this);
	CP_enable(this, 1);
	InitializeSkeleton(this);
	SetEulerRotation(this, 0, 0, 0);
	CP_friction(this, 0.9);
	SetScale(this, 1, 1, 1);
	SetNumber(this, "death_time", 0);
	Cmd(this, "angle0 1");
	local sex=GetString(this, "sex");
	if (sex=="female") then
		Scream(this, "FSCREAM", 2);
	end

	if (sex=="male") then
		Scream(this, "SCREAM", 2);
	end

	SpawnItems(this);
	SetNumber(this, "taxiwaiter", 0);
	if (mission_curid==10) then
		if (GetNumber(this, "badguy")==1) then
			totalKills=(totalKills + 1);
			SetActiveItem("thumbnail\\braker", tostring((30 - totalKills)));
			local t=GetTime();
			if (t>(lastKillTime + 2)) then
				gui_AddRaceMsg(format(KILLS, totalKills));
			else
				gui_AddRaceMsg(format(DOUBLEKILL));
			end

			lastKillTime=t;
		end

	end

end

function character_Damage(this)
	if (GetVehicle(this)>0) then
		do return end;

	end

	local sex=GetString(this, "sex");
	if (sex=="female") then
		Scream(this, "FSCREAM", 2);
	end

	if (sex=="male") then
		Scream(this, "SCREAM", 2);
	end

end

function character_InitialUpdate(this, name)
	SetLODThresold(this, 1.5);
	SetName(this, name);
	if (name=="models\\rush") then
		do return end;

	end

	if (name=="models\\teen") then
		SetNumber(this, "badguy", 1);
	else
		SetNumber(this, "badguy", 0);
	end

	if (name~="models\\cop") and (name~="models\\teen") and (name~="models\\rgirl") then
		SetUpdateFunction(this, "character");
	end

end

function character_Afraid(this)
	if (GetVehicle(this)>0) then
		do return end;

	end

	local sex=GetString(this, "sex");
	if (sex=="female") then
		if (random()>0.5) then
			Scream(this, "woman", 4);
		end

	end

	if (sex=="male") then
		if (random()>0.5) then
			Scream(this, "manrun", 5);
		end

	end

end

function character_TrafficSpawn(this, name, x, y, z)
	if (mission_curid==10) and (name=="models\\teen") then
		if (random(0, 60)<totalKills) then
			do return 0 end;

		end

	end

	return 1;

end

function character_Spawn(this)
	local car=GetVehicle(PLAYER);
	SetNumber(this, "taxiwaiter", 0);
	SetNumber(this, "death_time", 0);
	KillDollar(this);
	Cmd(this, "idlewalk 1");
	if (random()>0.3) and (car>0) then
		if (GetNumber(car, "taxi")==1) then
			if (GetPassenger(car)==0) then
				local dist=GetDist(car, this, 1);
				if (dist>3000) then
					if (GetTime()>5) then
						if (FindObject("dollar1")>0) then
							SetAnimation(this, "taxiwaiter");
							if not ((not GetAnimation(this))) then
								Cmd(this, "anim taxiwaiter 1 0 24 0");
								SetNumber(this, "taxiwaiter", 1);
								SpawnDollar(this);
								Cmd(this, "idlewalk 0");
							end

						end

					end

				end

			end

		end

	end

	SetNumber(this, "money", random(0, 2));
end

function character_Update(this)
	local health=GetNumber(this, "health");
	local time=GetNumber(this, "death_time");
	if (health<=0) and (time<2) then
		local bs_time=GetNumber(this, "bs_time");
		bs_time=(bs_time + DT);
		if (bs_time>0.3) then
			bs_time=0;
			local px, py, pz=GetPosition(this);
			py=(py + 100);
			local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
			AddSplash(splatter, GetBloodSplatter(), random(100, 150), random(100, 150), px, py, pz, 0, -200, 20);
		end

		SetNumber(this, "bs_time", bs_time);
		CP_iterate(this, 0.015);
		SetPosition(this, CP_getPos(this, "9"));
		SetEulerRotation(this, 0, 0, 0);
		time=(time + DT);
		SetNumber(this, "death_time", time);
	end

	if (health<=0) then
		do return end;

	end

	local hx, hy, hz, hdepth, hobj, hspeed=GetHitDepth(this);
	if (hspeed>200) and (hdepth>15) and (health>0) then
		if (GetVehicle(this)==0) then
			if (SameObjects(GetDriver(hobj), PLAYER)==1) or (SameObjects(hobj, PLAYER)==1) or (GetNumber(hobj, "CanKillPeople")==1) then
				local cmd=format("Damage %d", ((hdepth - 5) * 1000));
				Cmd(this, cmd);
				local sex=GetString(this, "sex");
				if (sex=="female") then
					Scream(this, "FSCREAM", 2);
				end

				if (sex=="male") then
					Scream(this, "FSCREAM", 2);
				end

				if (GetNumber(this, "health")<=0) then
					local felony=GetNumber(hobj, "felony");
					felony=(felony + 10);
					if (GetName(this)=="models\\cop") then
						felony=(felony + 20);
					end

					SetNumber(hobj, "felony", felony);
					CP_resetAcceleration(this);
					local x, y, z=GetPosition(this);
					hx, y, hz=GetPosition(hobj);
					hx=(x - hx);
					hz=(z - hz);
					hx, hy, hz=Normalize(hx, 0, hz);
					hdepth=(hdepth / 100);
					CP_accelerateAll(this, ((hx * hspeed) * 2), 700, ((hz * hspeed) * 2));
					Scream(this, "SPLASH", 1);
					SpawnItems(this);
				end

			end

			do return end;

		end

	end

	local anim=GetAnimation(this);
	if (anim=="run") or ((anim=="walk") and (health>0)) then
		local frame=GetFrame(this);
		local prev_frame=GetPrevFrame(this);
		if ((prev_frame<12) and (frame>=12)) or ((prev_frame<25) and (frame>=25)) then
			local px, py, pz=ScrPos();
			local x, y, z=GetPosition(this);
			local dist2=((((px - x) * (px - x)) + ((py - y) * (py - y))) + ((pz - z) * (pz - z)));
			if (dist2<600000) then
				local px, py, pz=GetPosition(this);
				local prev_stepID=GetNumber(this, "prev_stepID");
				local al=FindObject("OpenAL");
				local id=random(1, 6);
				while (id==prev_stepID) do
					id=random(1, 6);
				end

				SetNumber(this, "prev_stepID", id);
				local sndid=GetNumber(this, "sndid");
				sndid=floor(mod((sndid + 1), 2));
				SetNumber(this, "sndid", sndid);
				local name="stepc_g" .. sndid;
				Cmd(al, "Close " .. name);
				local s=nil;
				if (CurrentRain<20) then
					s=format("Open Sounds\\Steps\\Asphalt\\%d.wav 0 0 %s", id, name);
				else
					s=format("Open Sounds\\Steps\\Wet\\%d.wav 0 0 %s", id, name);
				end

				Cmd(al, s);
				local car=GetVehicle(PLAYER);
				Cmd(al, format("Dist %s 1000 500", name));
				s=format("Move %s %d %d %d", name, x, y, z);
				Cmd(al, s);
				if (car==0) then
					Cmd(al, format("Gain %s %f 0 1", name, (0.2 + (random() * 0.2))));
					Cmd(al, "Play " .. name);
				else
					if (GetSpeed(car)<5) then
						Cmd(al, format("Gain %s %f 0 1", name, (0.1 + (random() * 0.1))));
						Cmd(al, "Play " .. name);
					end

				end

			end

		end

	end

	local taxiwaiter=GetNumber(this, "taxiwaiter");
	if (taxiwaiter>0) and (health>0) then
		UpdateDollar(this);
		local frame=GetFrame(this);
		local prevframe=GetPrevFrame(this);
		local player=PLAYER;
		local car=GetVehicle(player);
		if (GetNumber(player, "felony")>0) then
			if (GetVehicle(this)==0) then
				SetNumber(this, "taxiwaiter", 0);
				Cmd(this, "anim idle");
				KillDollar(this);
			end

		end

		if (car==0) then
			SetNumber(this, "taxiwaiter", 0);
			KillDollar(this);
			Cmd(this, "anim idle");
			Cmd(this, "OutOfCar 1");
		else
			if (GetNumber(car, "health")<=0) then
				SetNumber(this, "taxiwaiter", 0);
				KillDollar(this);
				Cmd(this, "anim idle");
			end

		end

		if (prevframe<=5) and (frame>5) and (anim=="taxiwaiter") then
			local px, py, pz=GetPosition(PLAYER);
			local x, y, z=GetPosition(this);
			local cmd=format("turn %d %d %d 1", px, py, pz);
			Cmd(this, cmd);
			local sex=GetString(this, "sex");
			SetNumber(this, "heytimes", (GetNumber(this, "heytimes") - 1));
			if (sex=="male") then
				if (random(0, 5)==0) then
					if (GetNumber(this, "heytimes")<-4) then
						SetNumber(this, "heytimes", 0);
						Scream(this, "hey", 2);
					end

				end

			end

			if (sex=="female") then
				if (random(0, 5)==0) then
					if (GetNumber(this, "heytimes")<-10) then
						SetNumber(this, "heytimes", 0);
						Scream(this, "fhey", 1);
					end

				end

			end

			local speed=GetSpeed(car);
			if (speed<50) then
				if (VectorLength((x - px), 0, (z - pz))<1500) then
					local cx, cy, cz=GetHelper(car, "Passenger_outpt");
					cmd=format("move %d %d %d 1", cx, cy, cz);
					Cmd(this, cmd);
					SetNumber(this, "taxiwaiter", 2);
				end

			end

		end

		if (anim=="run") and (taxiwaiter==2) then
			local cx, cy, cz=GetHelper(car, "Passenger_outpt");
			local x, y, z=GetPosition(this);
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			if (dist2<3000) then
				Cmd(this, "anim idle");
				Cmd(car, "unlock rightdoor");
				Cmd(car, "open rightdoor");
			else
				local cmd=format("move %d %d %d 1", cx, cy, cz);
				Cmd(this, cmd);
				if (dist2<(500 * 500)) then
					Cmd(car, "camera 3 -360 0");
					local run_timeout=GetNumber(this, "run_timeout");
					run_timeout=(run_timeout + DT);
					if (run_timeout>5) then
						run_timeout=0;
						SetNumber(this, "taxiwaiter", 0);
						Cmd(this, "anim idle");
						KillDollar(this);
					end

					SetNumber(this, "run_timeout", run_timeout);
				end

			end

			if (GetPassenger(car)>0) then
				SetNumber(this, "taxiwaiter", 0);
				KillDollar(this);
				Cmd(this, "anim idle");
			end

		end

		if (frame>10) and (prevframe<=10) and (taxiwaiter==2) and (anim=="idle1") then
			local cx, cy, cz=GetHelper(car, "Passenger_outpt");
			local x, y, z=GetPosition(this);
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			if (dist2<3000) then
				SetDriver(car, this, 0, 1, 1);
				anim=GetAnimation(this);
				KillDollar(this);
				if (anim~="driver") and (anim~="passenger") then
					SetNumber(this, "taxiwaiter", 0);
				else
					local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
					local angle=random(0, 360);
					local range=random(50000, 150000);
					local dx=(x + (sin(angle) * range));
					local dy=y;
					local dz=(z + (cos(angle) * range));
					local tx, ty, tz=GetPointOnNetwork(roadnetwork, dx, dy, dz);
					tx, ty, tz=IntersectLine(roadnetwork, tx, (ty + 100000), tz, tx, (ty - 100000), tz);
					SetVector(this, "target", tx, ty, tz);
					local dist=VectorLength((tx - x), 0, (tz - z));
					local money=(dist / 600);
					SetNumber(this, "rate", ceil(money));
					local id=InsertParticleSource("ParticleSystems\\marker.psf", tx, (ty + 10), tz, 0, 0, 0, 10, 10, 10);
					SetName(id, "TargetMarker");
				end

				Cmd(car, "close rightdoor");
			else
				local cx, cy, cz=GetHelper(car, "Passenger_outpt");
				local cmd=format("move %d %d %d 1", cx, cy, cz);
				Cmd(this, cmd);
			end

		end

		if (anim=="driver") or (anim=="passenger") then
			local cx, cy, cz=GetVector(this, "target");
			AddMarker(Animate("marker\\checkpoint", 3), cx, cy, cz, 24, 24, -12, -12);
			local x, y, z=GetPosition(this);
			local dist2=((((cx - x) * (cx - x)) + ((cy - y) * (cy - y))) + ((cz - z) * (cz - z)));
			local pCar=GetVehicle(this);
			if (dist2<4000000) then
				if (GetSpeed(pCar)<50) then
					Cmd(car, "camera 3 -360 0");
					Cmd(this, "OutOfCar 1");
					local id=FindObject("TargetMarker");
					Destroy(id);
					SetNumber(this, "taxiwaiter", 0);
					KillDollar(this);
					EnableClipDistance(this, 0);
					local player=PLAYER;
					SetNumber(player, "money", (GetNumber(player, "money") + GetNumber(this, "rate")));
					gui_AddRaceMsg(tostring(GetNumber(this, "rate")) .. "$");
					PlaySound2D("cashregister", 1, "channel1");
				end

			end

			if (GetNumber(car, "health")<=10) then
				Cmd(this, "OutOfCar 1");
				local id=FindObject("TargetMarker");
				Destroy(id);
				SetNumber(this, "taxiwaiter", 0);
				KillDollar(this);
				EnableClipDistance(this, 0);
			end

		end

	end

	local car=GetVehicle(this);
	if (health>0) and (car>0) then
		if (GetNumber(car, "taxi")==1) then
			local player=PLAYER;
			local px, py, pz=GetPosition(player);
			local x, y, z=GetPosition(this);
			local dist2=((((px - x) * (px - x)) + ((py - y) * (py - y))) + ((pz - z) * (pz - z)));
			if (dist2<(1000 * 1000)) then
				SetNumber(player, "taxinear", 1);
				local anim=GetAnimation(player);
				local wait=GetNumber(this, "wait");
				wait=(wait - DT);
				if (anim=="taxiwaiter") and (wait<0) then
					wait=20;
				end

				SetNumber(this, "wait", wait);
				if (wait>10) then
					Cmd(car, "stop");
					Cmd(car, "unlock rightdoor");
				end

			end

		end

	end

end

pistolID=0;
function cop_InitialUpdate(this)
	id=InsertObject("Models\\pistol");
	SetParent(id, this);
	SetLODThresold(id, 2);
	GenNormals(id, 1);
	LinkWithBone(id, "Bip01 R Hand");
	EnableClipDistance(id, 0);
	SetNumber(id, "ammo", 10000);
	SetRenderable(id, 0);
	SetName(id, "coppistol" .. tostring(pistolID));
	SetString(this, "weaponName", GetName(id));
	pistolID=(pistolID + 1);
	SetNumber(id, "dispersion", 0);
	SetNumber(id, "damage", 20);
	SetNumber(id, "autoaimangle", 0.97);
	SetString(this, "SHOTFLARE", "COPFLARE");
end

function cop_Spawn(this)
	SetRenderable(FindObject(GetString(this, "weaponName")), 0);
	SetNumber(this, "bullets", 1);
	SetNumber(this, "money", 1);
	SetNumber(this, "firstaidkit", 1);
	SetNumber(this, "pistol", 1);
	SetNumber(this, "death_time", 0);
end

function cop_Update(this)
	local anim=GetAnimation(this);
	if (anim=="hit") then
		local frame=GetFrame(this);
		local prev_frame=GetPrevFrame(this);
		if (prev_frame<10) and (frame>=10) then
			local px, py, pz=GetPosition(this);
			PlaySound3D(px, py, pz, "karate\\whizz", 1, "channel2");
		end

	end

	character_Update(this);
end

function cop_Attack(this)
	SetRenderable(FindObject(GetString(this, "weaponName")), 1);
end

function cop_CloseAttack(this)
	SetRenderable(FindObject(GetString(this, "weaponName")), 0);
end

chatter_timeout=0;
function cop_Hate(this)
	local time=GetTime();
	if (time>chatter_timeout) then
		PlaySound2D("chatter", 2, "channel3");
		chatter_timeout=(time + random(2, 5));
	end

	if (GetVehicle(this)>0) then
		Cmd(this, "speedscale 3");
		Cmd(GetVehicle(this), "lock2surface 1");
	end

end

function cop_Damage(this)
	character_Damage(this);
end

function cop_Die(this)
	character_Die(this);
	SetRenderable(FindObject(GetString(this, "weaponName")), 0);
end

function cop_TryToTalk(this)
	PlayerUseObject(this);
end

function cop_BeginDialog(this)
	return 3;

end

uziID=0;
function teen_TouchPlayer(this)
	rebelMode=(rebelMode + 1);
	if (rebelMode>=1) then
		Cmd(this, "hate");
		SetNumber(this, "hate", 1);
	end

end

function teen_InitialUpdate(this)
	id=InsertObject("Models\\uzi");
	SetParent(id, this);
	SetLODThresold(id, 2);
	GenNormals(id, 1);
	LinkWithBone(id, "Bip01 R Hand");
	EnableClipDistance(id, 0);
	SetNumber(id, "ammo", 10000);
	SetRenderable(id, 1);
	SetName(id, "teenuzi" .. tostring(uziID));
	SetString(this, "weaponName", GetName(id));
	uziID=(uziID + 1);
	SetNumber(id, "dispersion", 0);
	SetNumber(id, "damage", 10);
	SetNumber(id, "autoaimangle", 0.97);
	SetString(this, "SHOTFLARE", "TEENFLARE");
end

function teen_Spawn(this)
	SetRenderable(FindObject(GetString(this, "weaponName")), 1);
	SetNumber(this, "bullets", 1);
	SetNumber(this, "uzi", 1);
	SetNumber(this, "money", 1);
	Cmd(this, "hate");
	Cmd(this, "checkfelony 0");
	SetNumber(this, "death_time", 0);
end

function teen_Update(this)
	if (GetParent(this)==0) then
		character_Update(this);
	end

	Cmd(this, "hate");
end

function teen_Attack(this)

end

function teen_CloseAttack(this)

end

function teen_Damage(this)
	rebelMode=(rebelMode + 1);
	character_Damage(this);
end

function teen_Hate(this)

end

function teen_Die(this)
	rebelMode=(rebelMode + 1);
	character_Die(this);
	SetRenderable(FindObject(GetString(this, "weaponName")), 0);
end

