function shotflare_Update(this)
	SetSupportPauseMode(this, 1);
	if (GetRenderable(this)==0) then
		do return end;

	end

	local sx, sy, sz=GetScale(this);
	local x, y, z=GetPosition(this);
	AddLight(x, y, z, (100 * sx), 200, 200, 50, 2);
	if (IsPaused()==1) then
		do return end;

	end

	local time=GetNumber(this, "time");
	time=(time + 1);
	SetNumber(this, "time", time);
	if (time>2) then
		SetRenderable(this, 0);
	end

	SetScale(this, (sx / 2), (sy / 2), (sz / 2));
end

function GetBloodSplatter()
	return "sprite\\blood" .. random(1, 2);

end

function BulletShot(this, dispersion, damage, autoaimangle)
	local px, py, pz=GetHelper(this, "Point01");
	local px1, py1, pz1=TransDir(this, 0, 0, -1);
	py1=0;
	local obj, ax, ay, az=GetAutoAimTarget(GetParent(this), px1, py1, pz1, autoaimangle);
	if (obj~=0) then
		local cx, cy, cz=GetPosition(obj);
		cy=(cy + 100);
		px1, py1, pz1=SubVectors(cx, cy, cz, px, py, pz);
		px1, py1, pz1=Normalize(px1, py1, pz1);
		print("aimed! ", GetName(obj));
	end

	local disp_x=(random() - 0.5);
	local disp_y=(random() - 0.5);
	local disp_z=(random() - 0.5);
	disp_x, disp_y, disp_z=Normalize(disp_x, disp_y, disp_z);
	disp_x, disp_y, disp_z=MulVector(disp_x, disp_y, disp_z, dispersion);
	px1, py1, pz1=AddVectors(px1, py1, pz1, disp_x, disp_y, disp_z);
	px1, py1, pz1=Normalize(px1, py1, pz1);
	px1, py1, pz1=MulVector(px1, py1, pz1, 5000);
	px1, py1, pz1=AddVectors(px, py, pz, px1, py1, pz1);
	local deadguy, cx, cy, cz=IntersectLineClsID(GetParent(this), CLS_CHARACTER, px, py, pz, px1, py1, pz1);
	if (deadguy~=0) then
		print("hit! ", GetName(deadguy));
		local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
		local dx, dy, dz=TransDir(this, 0, 0, -600);
		if (GetNumber(deadguy, "health")>0) then
			local cmd=format("Damage %d %d %d %d", damage, px, py, pz);
			Cmd(deadguy, cmd);
			local gunowner=GetParent(this);
			local felony=GetNumber(gunowner, "felony");
			if (GetNumber(deadguy, "badguy")==0) then
				felony=(felony + ((10 * damage) / 100));
			end

			if (GetName(deadguy)=="models\\cop") then
				felony=(felony + ((20 * damage) / 100));
			end

			SetNumber(gunowner, "felony", felony);
			if (GetNumber(deadguy, "health")<=0) then
				CP_resetAcceleration(deadguy);
				CP_accelerateAll(deadguy, (dx * 2), 700, (dz * 2));
			end

		end

		if (BLOOD==1) then
			id=InsertParticleSource("ParticleSystems\\bloodExp.psf", cx, cy, cz, 0, 0, 0, 1, 1, 1);
			SetColor(id, 150, 0, 0, 100);
			AddSplash(splatter, GetBloodSplatter(), random(100, 150), random(100, 150), cx, cy, cz, dx, -400, dz);
		end

		do return end;

	end

	local deadcar, cx, cy, cz, triID=IntersectLineClsID(GetParent(this), CLS_CAR, px, py, pz, px1, py1, pz1);
	if (deadcar~=0) then
		print("hit! ", GetName(deadcar), " ", tostring(triID));
		car_Damage(deadcar, cx, cy, cz, 20, 0, 100, 0, 5, 1);
		local gunowner=GetParent(this);
		local driver=GetDriver(deadcar);
		if (driver<=0) or (GetNumber(driver, "badguy")~=1) or (GetNumber(gunowner, "copnear")==1) then
			local felony=GetNumber(gunowner, "felony");
			felony=(felony + 10);
			if (GetName(GetDriver(deadcar))=="models\\cop") then
				felony=(felony + 20);
			end

			SetNumber(gunowner, "felony", felony);
		end

		do return end;

	end

	local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
	local hx, hy, hz, dx, dy, dz=IntersectLine(roadnetwork, px, py, pz, px1, py1, pz1);
	if (hx~=px1) or (hy~=py1) or (hz~=pz1) then
		local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
		if (dy>0.99) then
			dx=(dx + 0.1);
			dx, dy, dz=Normalize(dx, dy, dz);
		end

		dx, dy, dz=MulVector(dx, dy, dz, 100);
		AddSplash(splatter, "sprite\\bullethole", 20, 20, (hx - (dx / 2)), (hy - (dy / 2)), (hz - (dz / 2)), dx, dy, dz);
		id=InsertParticleSource("ParticleSystems\\surfacehit.psf", hx, hy, hz, 0, 0, 0, 2, 2, 2);
		SetTraceParams(id, 1, "sprite\\trace", 4, 2);
		if (random(0, 3)==0) then
			PlaySound3D(hx, hy, hz, "Ricco\\BRicco0", 6, "channel1");
		end

	end

end

function HitTool(this, damage)
	local px, py, pz=GetHelper(this, "Point01");
	local dx, dy, dz=TransDir(this, 0, 0, -50);
	dy=0;
	local px1, py1, pz1=AddVectors(px, py, pz, dx, dy, dz);
	px, py, pz=AddVectors(px, py, pz, -dx, -dy, -dz);
	local deadguy, cx, cy, cz, triID=IntersectLineClsID(GetParent(this), CLS_CHARACTER, px, py, pz, px1, py1, pz1);
	if (deadguy~=0) then
		print("hit! ", GetString(deadguy, "name"));
		local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
		dx, dy, dz=TransDir(this, 0, 0, -600);
		if (GetNumber(deadguy, "health")>0) then
			local cmd=format("Damage %d %d %d %d", damage, px, py, pz);
			Cmd(deadguy, cmd);
			local gunowner=GetParent(this);
			local felony=GetNumber(gunowner, "felony");
			felony=(felony + 5);
			SetNumber(gunowner, "felony", felony);
			if (GetNumber(deadguy, "health")<=0) then
				CP_resetAcceleration(deadguy);
				CP_accelerateAll(deadguy, (dx * 2), 700, (dz * 2));
			end

		end

		if (BLOOD==1) then
			id=InsertParticleSource("ParticleSystems\\bloodExp.psf", cx, cy, cz, 0, 0, 0, 2, 2, 2);
			SetColor(id, 150, 0, 0, 100);
			AddSplash(splatter, GetBloodSplatter(), random(100, 150), random(100, 150), cx, cy, cz, dx, -400, dz);
			AddSplash(splatter, GetBloodSplatter(), random(150, 250), random(150, 250), cx, cy, cz, (-dx / 2), -800, (-dz / 2));
		end

		do return end;

	end

	local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
	local hx, hy, hz, dx, dy, dz, triID=IntersectLine(roadnetwork, px, py, pz, px1, py1, pz1);
	if (triID~=-1) then
		local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
		if (dy>0.99) then
			dx=(dx + 0.1);
			dx, dy, dz=Normalize(dx, dy, dz);
		end

		dx, dy, dz=MulVector(dx, dy, dz, 100);
		id=InsertParticleSource("ParticleSystems\\surfacehit.psf", hx, hy, hz, 0, 0, 0, 2, 2, 2);
		if (random(0, 3)==0) then
			PlaySound3D(hx, hy, hz, "Ricco\\BRicco0", 6, "channel1");
		end

	end

end

function HitHandLeg(this, name, damage, offx, offy, offz)
	local px, py, pz=GetBoneCenter(this, name);
	local px1, py1, pz1=AddVectors(px, py, pz, offx, offy, offz);
	px, py, pz=AddVectors(px, py, pz, -offx, -offy, -offz);
	py1=py;
	local dx, dy, dz=SubVectors(px1, py1, pz1, px, py, pz);
	dx, dy, dz=Normalize(dx, dy, dz);
	local deadguy, cx, cy, cz=IntersectLineClsID(this, CLS_CHARACTER, px, (py - 50), pz, px1, (py1 - 50), pz1);
	if (deadguy~=0) then
		print("hit! ", GetString(deadguy, "name"));
		PlaySound3D(px, py, pz, "karate\\hit", 1, "channel2");
		if (GetNumber(deadguy, "health")>0) then
			local cmd=format("Damage %d %d %d %d", damage, px, py, pz);
			Cmd(deadguy, cmd);
			local felony=GetNumber(this, "felony");
			if (GetNumber(deadguy, "badguy")==0) then
				felony=(felony + 5);
			end

			SetNumber(this, "felony", felony);
			if (GetNumber(deadguy, "health")<=0) then
				CP_resetAcceleration(deadguy);
				CP_accelerateAll(deadguy, (-offx * 8), 500, (-offz * 8));
			end

		end

		if (BLOOD==1) then
			local splatter=FindObjectByClsID(CLS_SPLATTERSYSTEM);
			id=InsertParticleSource("ParticleSystems\\bloodExp.psf", cx, cy, cz, 0, 0, 0, 1, 1, 1);
			SetColor(id, 150, 0, 0, 100);
			AddSplash(splatter, GetBloodSplatter(), random(100, 150), random(100, 150), cx, cy, cz, (dx * -600), -400, (dz * -600));
		end

		do return 1 end;

	end

	local roadnetwork=FindObjectByClsID(CLS_ROADNETWORK);
	local hx, hy, hz, dx, dy, dz, triID=IntersectLine(roadnetwork, px, py, pz, px1, py1, pz1);
	if (triID~=-1) then
		id=InsertParticleSource("ParticleSystems\\surfacehit.psf", hx, hy, hz, 0, 0, 0, 2, 2, 2);
		SetColor(id, 200, 50, 50, 100);
		PlaySound3D(hx, hy, hz, "karate\\hit", 1, "channel2");
		local health=GetNumber(this, "health");
		if (health>1) then
			SetNumber(this, "health", (health - 1));
		else
			local cmd=format("Damage %d %d %d %d", 2, hx, hy, hz);
			Cmd(this, cmd);
		end

		do return 1 end;

	end

	return 0;

end

function uzi_Update(this, name, damage, sx, sy, sz)
	if (GetRenderable(this)==0) then
		do return end;

	end

	local parent=GetParent(this);
	if not (parent) then
		do return end;

	end

	local prev_frame=GetPrevFrame(parent);
	local frame=GetFrame(parent);
	local anim=GetAnimation(parent);
	if (anim~="shotuzi") and (anim~="shot") then
		do return end;

	end

	if ((prev_frame<17) and (frame>=17)) or ((prev_frame>=14) and (prev_frame>17) and (frame>=14) and (frame<17)) then
		print("shooting!");
		local ammo=GetNumber(this, "ammo");
		if (ammo>0) then
			BulletShot(this, GetNumber(this, "dispersion"), GetNumber(this, "damage"), GetNumber(this, "autoaimangle"));
			ammo=(ammo - 1);
			SetNumber(this, "ammo", ammo);
			if (SameObjects(PLAYER, parent)==1) then
				SetActiveItem("thumbnail\\icon2", tostring(ammo));
			end

			local id=FindObject(GetString(parent, "SHOTFLARE"));
			if (id==0) then
				id=InsertParticleSource("ParticleSystems\\shotflare.psf");
				SetName(id, GetString(parent, "SHOTFLARE"));
				SetUpdateFunction(id, "shotflare_Update");
			end

			local px, py, pz=GetHelper(this, "Point01");
			SetEulerRotation(id, 0, 0, 0);
			SetScale(id, 1, 1, 1);
			SetPosition(id, 0, 0, 0);
			CopyTransform(id, this);
			SetRenderable(id, 1);
			SetNumber(id, "time", 0);
			SetEulerRotation(id, (PI / 2), 0, 0, 1);
			SetPosition(id, px, py, pz);
			SetScale(id, ((random() * 0.5) + 1.5), ((random() * 0.5) + 1.5), ((random() * 0.5) + 1.5));
			local al=FindObject("OpenAL");
			Cmd(al, "Open Sounds\\Weapon\\uzi.wav 0 0 uzi");
			Cmd(al, "Dist uzi 5000 5000");
			local s=format("Move uzi %d %d %d", px, py, pz);
			Cmd(al, s);
			Cmd(al, "Play uzi");
		end

	end

	SetNumber(this, "prev_frame", frame);
end

function pistol_Update(this)
	if (GetRenderable(this)==0) then
		do return end;

	end

	local parent=GetParent(this);
	if not (parent) then
		do return end;

	end

	local prev_frame=GetNumber(this, "prev_frame");
	local frame=GetFrame(parent);
	SetNumber(this, "prev_frame", frame);
	if (GetAnimation(parent)~="shot") then
		do return end;

	end

	if (prev_frame<16) and (frame>=16) then
		local ammo=GetNumber(this, "ammo");
		if (ammo>0) then
			BulletShot(this, GetNumber(this, "dispersion"), GetNumber(this, "damage"), GetNumber(this, "autoaimangle"));
			ammo=(ammo - 1);
			SetNumber(this, "ammo", ammo);
			if (SameObjects(PLAYER, parent)==1) then
				SetActiveItem("thumbnail\\icon1", tostring(ammo));
			end

			local id=FindObject(GetString(parent, "SHOTFLARE"));
			if (id==0) then
				id=InsertParticleSource("ParticleSystems\\shotflare.psf");
				SetName(id, GetString(parent, "SHOTFLARE"));
				SetUpdateFunction(id, "shotflare_Update");
			end

			local px, py, pz=GetHelper(this, "Point01");
			SetEulerRotation(id, 0, 0, 0);
			SetScale(id, 1, 1, 1);
			SetPosition(id, 0, 0, 0);
			CopyTransform(id, this);
			SetRenderable(id, 1);
			SetNumber(id, "time", 0);
			SetEulerRotation(id, (PI / 2), 0, 0, 1);
			SetPosition(id, px, py, pz);
			SetScale(id, ((random() * 0.5) + 1.5), ((random() * 0.5) + 1.5), ((random() * 0.5) + 1.5));
			local al=FindObject("OpenAL");
			Cmd(al, "Open Sounds\\Weapon\\pistol.wav 0 0 pistol");
			Cmd(al, "Dist pistol 5000 5000");
			local s=format("Move pistol %d %d %d", px, py, pz);
			Cmd(al, s);
			Cmd(al, "Play pistol");
		end

	end

	SetNumber(this, "prev_frame", frame);
end

function assembletool_Update(this)
	if (GetRenderable(this)==0) then
		do return end;

	end

	local parent=GetParent(this);
	if not (parent) then
		do return end;

	end

	local prev_frame=GetNumber(this, "prev_frame");
	local frame=GetFrame(parent);
	SetNumber(this, "prev_frame", frame);
	if (GetAnimation(parent)~="hitassemble") then
		do return end;

	end

	if (prev_frame<19) and (frame>=19) then
		HitTool(this, GetNumber(this, "damage"));
	end

	SetNumber(this, "prev_frame", frame);
end

function rush_OnBribe(this)
	local money=GetNumber(this, "money");
	local felony=GetNumber(this, "felony");
	local rmoney=(felony * 10);
	if (rmoney>money) then
		gui_AddMsg("GUI\\info", NOTENOUGHMONEY);
	else
		SetNumber(this, "money", (money - rmoney));
		SetNumber(this, "felony", 0);
	end

end

function rush_selectWeapon(this, weaponID)
	local pistol=FindObject("pistol");
	local uzi=FindObject("uzi");
	local assembletool=FindObject("assembletool");
	SetRenderable(pistol, 0);
	SetUpdatable(pistol, 0);
	SetRenderable(uzi, 0);
	SetUpdatable(uzi, 0);
	SetRenderable(assembletool, 0);
	SetUpdatable(assembletool, 0);
	SetActiveItem("", "");
	if (mission_curid==2) then
		SetActiveItem("thumbnail\\icon7", tostring(carCount));
	end

	if (mission_curid==0) then
		local truck=FindObject("Truck");
		local truckLoadedWheels=GetNumber(truck, "LoadedWheels");
		SetActiveItem("thumbnail\\icon8", tostring(truckLoadedWheels));
	end

	if (GetNumber(this, "haveweapon" .. tostring(weaponID))==0) then
		SetNumber(this, "weapon", -1);
		do return end;

	end

	SetNumber(this, "weapon", weaponID);
	if (weaponID==0) then
		SetRenderable(pistol, 1);
		SetUpdatable(pistol, 1);
		SetActiveItem("thumbnail\\icon1", tostring(GetNumber(pistol, "ammo")));
	end

	if (weaponID==1) then
		SetRenderable(uzi, 1);
		SetUpdatable(uzi, 1);
		SetActiveItem("thumbnail\\icon2", tostring(GetNumber(uzi, "ammo")));
	end

	if (weaponID==2) then
		SetRenderable(assembletool, 1);
		SetUpdatable(assembletool, 1);
		local truck=FindObject("Truck");
		local truckLoadedWheels=GetNumber(truck, "LoadedWheels");
		SetActiveItem("thumbnail\\icon8", tostring(truckLoadedWheels));
	end

end

function OnSelectUZI(this)
	rush_selectWeapon(this, 1);
end

function OnSelectPistol(this)
	rush_selectWeapon(this, 0);
end

function OnSelectAssembleTool(this)
	rush_selectWeapon(this, 2);
end

function rush_Damage(this)
	Scream(this, "SCREAM", 4);
end

function rush_Die(this)
	Scream(this, "SCREAM", 4);
end

function rush_PassengerOutOfMoney(this)
	local timeout=GetNumber(this, "timeout");
	timeout=(timeout - DT);
	if (timeout<=0) then
		gui_AddMsg("GUI\\info", NOTENOUGHMONEY);
		timeout=5;
	end

	SetNumber(this, "timeout", timeout);
end

function rush_Update(this)
	if (GetNumber(this, "health")<=0) then
		do return end;

	end

	if (mission_curid==10) then
		local disptimeout=GetNumber(this, "disptimeout");
		disptimeout=(disptimeout - DT);
		if (disptimeout<=0) then
			SetActiveItem("thumbnail\\braker", tostring((30 - totalKills)));
			disptimeout=2;
		end

		SetNumber(this, "disptimeout", disptimeout);
	end

	local car=GetVehicle(this);
	local anim=GetAnimation(this);
	local hiding=GetNumber(this, "hiding");
	if (hiding==1) then
		local outsideroad=GetNumber(this, "outsideroad");
		if (GetSpeed(car)>10) or (outsideroad==0) then
			hiding=0;
		end

	end

	if (car>0) then
		local dx, dy, dz=TransDir(car, 0, 1, 0);
		if (dy<0) then
			if (GetNumber(car, "fliptimeout")>3) then
				if (GetNumber(car, "flipped")==0) then
					gui_AddMsg("GUI\\info", PRESSBACKSPACE);
					SetNumber(car, "flipped", 1);
				end

				local money=GetNumber(this, "money");
				if (lastChar==8) then
					local x, y, z=GetPosition(car);
					y=(y + 150);
					local fx, fy, fz=TransDir(car, 0, 0, 1);
					local angle=Vector2Angle(fx, fy, fz);
					local str=format("spawn %d %d %d %f", x, y, z, angle);
					Cmd(car, str);
					Cmd(car, "alpha 1");
					SetNumber(this, "money", money);
					SetNumber(car, "flipped", 0);
				end

			end

		end

	end

	if (lastChar==8) then
		lastChar=0;
	end

	local felony=GetNumber(this, "felony");
	if (felony>3) then
		if ((felony - (DT / 4))<=3) then
			felony=0;
		end

	end

	felony=(felony - (DT / 4));
	if (felony<0) then
		felony=0;
	end

	if (felony>100) then
		felony=100;
	end

	SetNumber(this, "felony", felony);
	local weaponID=GetNumber(this, "weapon");
	if (lastChar>0) then
		if (anim=="idle1") or (anim=="idlefight") or (anim=="run") then
			if (lastChar==49) then
				rush_selectWeapon(this, 0);
				lastChar=0;
			end

			if (lastChar==50) then
				rush_selectWeapon(this, 1);
				lastChar=0;
			end

			if (lastChar==51) then
				rush_selectWeapon(this, 2);
				lastChar=0;
			end

			if (lastChar==96) then
				rush_selectWeapon(this, -1);
				lastChar=0;
			end

		end

	end

	if (anim=="run") or (anim=="stepright") or (anim=="walkback") or (anim=="walkcarry") then
		local frame=GetFrame(this);
		local prev_frame=GetPrevFrame(this);
		if ((prev_frame<12) and (frame>=12)) or ((prev_frame<27) and (frame>=27)) then
			local px, py, pz=GetPosition(this);
			local prev_stepID=GetNumber(this, "prev_stepID");
			local al=FindObject("OpenAL");
			local id=random(1, 6);
			while (id==prev_stepID) do
				id=random(1, 6);
			end

			SetNumber(this, "prev_stepID", id);
			local sx, sy, sz=ScrPos();
			local dist2=((((sx - px) * (sx - px)) + ((sy - py) * (sy - py))) + ((sz - sz) * (sz - pz)));
			if (dist2<(3000 * 3000)) then
				local sndid=GetNumber(this, "sndid");
				sndid=floor(mod((sndid + 1), 2));
				SetNumber(this, "sndid", sndid);
				local name="step_g" .. sndid;
				Cmd(al, "Close " .. name);
				local s=nil;
				if (CurrentRain<20) then
					s=format("Open Sounds\\Steps\\Asphalt\\%d.wav 0 0 %s", id, name);
				else
					s=format("Open Sounds\\Steps\\Wet\\%d.wav 0 0 %s", id, name);
				end

				Cmd(al, s);
				Cmd(al, format("Gain %s %f 0 1", name, (0.4 + (random() * 0.3))));
				Cmd(al, format("Dist %s 5000 500", name));
				py=(py + 100);
				s=format("Move %s %d %d %d", name, px, py, pz);
				Cmd(al, s);
				Cmd(al, "Play " .. name);
			end

		end

	end

	if (anim=="fightpunch") or (anim=="fightbacklegkick") then
		local frame=GetFrame(this);
		local prev_frame=GetPrevFrame(this);
		if (prev_frame<10) and (frame>=10) then
			local px, py, pz=GetPosition(this);
			PlaySound3D(px, py, pz, "karate\\whizz", 1, "channel2");
		end

		if (anim=="fightbacklegkick") and (prev_frame<16) and (frame>=16) then
			HitHandLeg(this, "Bip01 R Foot", 30, TransDir(this, -20, 0, -80));
		end

		if (anim=="fightbacklegkick") and (prev_frame<15) and (frame>=15) then
			HitHandLeg(this, "Bip01 R Foot", 30, TransDir(this, -20, 0, -80));
		end

		if (anim=="fightbacklegkick") and (prev_frame<17) and (frame>=17) then
			HitHandLeg(this, "Bip01 R Foot", 30, TransDir(this, -20, 0, -80));
		end

		if (anim=="fightpunch") and (prev_frame<9) and (frame>=9) then
			HitHandLeg(this, "Bip01 R Hand", 20, TransDir(this, 0, 0, -50));
		end

		if (anim=="fightpunch") and (prev_frame<10) and (frame>=10) then
			HitHandLeg(this, "Bip01 R Hand", 20, TransDir(this, 0, 0, -50));
		end

	end

	if (anim=="taxiwaiter") then
		local frame=GetFrame(this);
		local prev_frame=GetPrevFrame(this);
		if (prev_frame<8) and (frame>=8) then
			Scream(this, "hey", 1);
		end

	end

	local hx, hy, hz, hdepth, hobj, hspeed=GetHitDepth(this);
	if (hspeed>500) and (hdepth>20) then
		if (GetNumber(this, "health")>0) then
			local cmd=format("Damage %d %d %d %d", ((hdepth - 0.1) * 100), hx, hy, hz);
			Cmd(this, cmd);
			if (GetNumber(this, "health")<=0) then
				Scream(this, "SPLASH", 1);
			end

		end

	end

end

function rush_InitialUpdate(this)
	EnableClipDistance(this, 0);
	GenNormals(this, 1);
	if (0==1) then
		id=InsertObject("Models\\rush_head", 7, 0, -3, (PI / 2), (-PI / 2));
		SetParent(id, this);
		SetName(id, "rush_head");
		LinkWithBone(id, "Bip01 Neck");
		SetLODThresold(id, 20);
		EnableClipDistance(id, 0);
		GenNormals(id, 1);
	end

	id=InsertObject("Models\\pistol");
	SetParent(id, this);
	SetName(id, "pistol");
	SetLODThresold(id, 50);
	GenNormals(id, 1);
	LinkWithBone(id, "Bip01 R Hand");
	EnableClipDistance(id, 0);
	SetNumber(id, "dispersion", 0.03);
	SetNumber(id, "damage", 40);
	SetNumber(id, "autoaimangle", 0.97);
	SetNumber(id, "ammo", 50);
	id=InsertObject("Models\\uzi");
	SetName(id, "uzi");
	SetParent(id, this);
	SetLODThresold(id, 50);
	GenNormals(id, 1);
	LinkWithBone(id, "Bip01 R Hand");
	EnableClipDistance(id, 0);
	SetRenderable(id, 0);
	SetNumber(id, "dispersion", 0.2);
	SetNumber(id, "damage", 30);
	SetNumber(id, "autoaimangle", 0.97);
	SetNumber(id, "ammo", 100);
	id=InsertObject("Models\\assembletool", 0, 0, 5);
	SetScale(id, 0.8, 0.8, 0.8);
	SetName(id, "assembletool");
	SetParent(id, this);
	SetLODThresold(id, 50);
	GenNormals(id, 1);
	LinkWithBone(id, "Bip01 R Hand");
	EnableClipDistance(id, 0);
	SetNumber(id, "damage", 20);
	SetRenderable(id, 0);
	SetNumber(this, "scanner", 0);
	SetNumber(this, "picklock", 0);
	SetString(this, "SHOTFLARE", "PLAYERFLARE");
	if (mission_curid~=3) then
		SetNumber(this, "money", 100);
	end

	rush_selectWeapon(this, -1);
end

function rush_SwitchLevel(this, active)

end

function rush_head_InitialUpdate(this)
	head_InitialUpdate(this);
end

function rush_head_Update(this)
	local parent=GetParent(this);
	if (GetNumber(parent, "firstperson")==1) then
		SetRenderable(this, 0);
		return;

	else
		SetRenderable(this, 1);
	end

	if (GetNumber(parent, "health")<=0) then
		do return end;

	end

	if (random(1, 30)==1) then
		head_setEyeAngles(this, 0, ((((random() * 2) - 1) * PI) / 16));
	end

	if (random(1, 30)==1) then
		local s=(random() - 0.5);
		head_setEyebrows(this, s, s, 0);
	end

	if (random(1, 50)==1) then
		head_setAngles(this, ((((random() * 2) - 1) * PI) / 8), ((((random() * 2) - 1) * PI) / 8), 0);
	end

	if (random(1, 30)==1) then
		local smile=((random() * 2) - 1);
		head_setSmile(this, smile);
		head_setMouthAngles(this, ((smile * PI) / 64), ((smile * PI) / 64), ((((random() * 2) - 1) * PI) / 64));
	end

	local emotions=GetString(parent, "emotions");
	if (emotions=="angry") then
		head_setEyeAngles(this, 0, (PI / 32));
		head_setAngles(this, (PI / 16), 0, 0);
		head_setSmile(this, -0.5);
		head_setEyebrows(this, -1, -1, 0);
	end

	head_Update(this);
end

