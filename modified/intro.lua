intro={pic=nil,
r=20,
g=20,
b=20,
primary=nil,
secondary=nil,
text=nil,
line=0,
time=0,
fadeout=0,
enterpressed=0,
mode=0,
snd=nil};
function StartIntro(snd, pic, primary, secondary, text, r, g, b, mode)
	local w, h=ScrSize();
	local s=(w / 1024);
	if not (r) then
		r=20;
	end

	if not (g) then
		g=20;
	end

	if not (b) then
		b=20;
	end

	intro["snd"]="Sounds\\rap" .. random(1, 7) .. ".wav";
	intro["r"]=r;
	intro["g"]=g;
	intro["b"]=b;
	intro["pic"]=pic;
	intro["primary"]=primary;
	intro["secondary"]=secondary;
	intro["text"]=text;
	intro["line"]=((-30 * 2) * s);
	intro["time"]=0;
	intro["fadeout"]=0;
	intro["enterpressed"]=0;
	Fade(1, 0);
	if not (mode) then
		mode=0;
	end

	intro["mode"]=mode;
end

function ShowIntro(loadingcode)
	if not (intro["pic"]) then
		do return -1, 0 end;

	end

	local dt=GetDT();
	if not ((not intro["snd"])) then
		alCmd("Close rap");
		alCmd(format("Open %s 1 0 rap", intro["snd"]));
		alCmd("Dist rap 50000 50000");
		alCmd("Gain rap 0.5 0.5 0.5");
		alCmd("Pitch rap " .. tostring(((random() * 0.2) + 0.9)));
		alCmd("Move rap 270 231 373");
		alCmd("Play rap");
		intro["snd"]=nil;
	end

	local pic_fade=((intro["time"] - 2) / 2);
	if (pic_fade>1) then
		pic_fade=1;
	end

	if (pic_fade<0) then
		pic_fade=0;
	end

	local w, h=ScrSize();
	ScrClip(0, 0, w, h);
	local s=(w / 1024);
	ScrRect("", 0, 0, w, (h + 1), 1, 0, 0, 0, 255);
	if (intro["fadeout"]<0) then
		do return 1, 0 end;

	end

	local snd_fade=(intro["time"] / 1);
	if (snd_fade>1) then
		snd_fade=1;
	end

	if (snd_fade<0) then
		snd_fade=0;
	end

	local inv_snd_fade=(1 - snd_fade);
	if (intro["fadeout"]>0) then
		snd_fade=(snd_fade * intro["fadeout"]);
		inv_snd_fade=(inv_snd_fade * intro["fadeout"]);
	end

	local music_volume=((((MENU_MUSIC + 100) / 100) * menu_volume) * inv_snd_fade);
	local t=format("Gain traffic %f %f %f", music_volume, music_volume, music_volume);
	alCmd(t);
	music_volume=((((MENU_MUSIC + 100) / 100) * 0.6) * snd_fade);
	local t=format("Gain rap %f %f %f", music_volume, music_volume, music_volume);
	alCmd(t);
	ScrRect(intro["pic"], 0, 0, w, h, 1, 255, 255, 255, (pic_fade * 255));
	local dx=((sin((GetTime() * 300)) * 5) * s);
	local dy=((cos((GetTime() * 300)) * 5) * s);
	ScrRect(intro["pic"], dx, dy, w, h, 0, intro["r"], intro["g"], intro["b"], (pic_fade * 255));
	intro["time"]=(intro["time"] + dt);
	if not ((not intro["primary"])) then
		local delta=7;
		if (intro["mode"]==1) then
			delta=5;
		end

		local primary_fade=((intro["time"] - delta) / 2);
		if (primary_fade>1) then
			primary_fade=1;
		end

		if (primary_fade<0) then
			primary_fade=0;
		end

		ScrRect(intro["primary"], (w - (512 * s)), ((h * 0.9) - (512 * s)), (512 * s), (512 * s), 1, 255, 255, 255, (primary_fade * 255));
	end

	if not ((not intro["secondary"])) then
		local delta=12;
		if (intro["mode"]==1) then
			delta=5;
		end

		local secondary_fade=((intro["time"] - delta) / 2);
		if (secondary_fade>1) then
			if (secondary_fade>=5) then
				secondary_fade=(6 - secondary_fade);
			else
				secondary_fade=1;
			end

		end

		if (secondary_fade<0) then
			secondary_fade=0;
		end

		ScrRect(intro["secondary"], 0, ((h * 0.9) - (512 * s)), (512 * s), (512 * s), 1, 255, 255, 255, (secondary_fade * 255));
	end

	ScrRect("intro\\frame", 0, (h - (h * 0.35)), w, (h * 0.4), 1, 255, 255, 255, 255);
	local skip=GetComboStatus("A");
	if not (loadingcode) then
		if not ((not intro["text"])) then
			local cw=(20 * s);
			local ch=(30 * s);
			local line, maxLines=GetLine(intro["text"], 0, cw, (w - (64 * s)));
			local x=(16 * s);
			local y=(h - intro["line"]);
			local alpha=0;
			for i=0, (maxLines - 1) do
				line=GetLine(intro["text"], i, cw, (w - (64 * s)));
				alpha=((h - y) / (ch * 4));
				if (alpha<0) then
					alpha=0;
				end

				if (alpha>1) then
					alpha=1;
				end

				alpha=(1 - alpha);
				alpha=sin((alpha * 180));
				ScrRect("#\\I" .. line .. "\\i", x, y, cw, ch, 1, 255, 255, 255, (255 * alpha));
				y=(y + ch);
			end

			y=(y + (ch * 2));
			alpha=((h - y) / (ch * 4));
			if (alpha<0) then
				alpha=0;
			end

			if (alpha>1) then
				alpha=1;
			end

			alpha=(1 - alpha);
			alpha=sin((alpha * 180));
			if (GetComboStatus("U")>0) then
				intro["line"]=(intro["line"] - (dt * 100));
				if (intro["line"]<0) then
					intro["line"]=0;
				end

			end

			if (y>(h - (ch * 2))) then
				-- text still scrolling up: auto-scroll (hold Down to speed up)
				intro["line"]=(intro["line"] + ((dt * 15) * s));
				if (GetComboStatus("D")>0) then
					intro["line"]=(intro["line"] + (dt * 100));
				end
			else
				-- text has fully scrolled off the top -> auto-advance. The decompiler
				-- wrongly attached this skip=1 to the inner `if Down` (so it skipped
				-- instantly); it belongs on this OUTER else. Fixing it gives both:
				-- the long story scrolls AND brief mission-complete text auto-advances.
				skip=1;
			end

		end

	end

	if (skip>0) then
		if (intro["mode"]==0) then
			console("load empty level sanjose");
			console("set  level sanjose");
			menu_activeItem=CURRENTMISSIONID;
			game_init(CURRENTMISSIONID, MissionRemap(CURRENTMISSIONID));
			intro["time"]=100;
		end

	end

	if (skip>0) then
		if (intro["mode"]==1) then
			if (intro["fadeout"]==0) then
				intro["fadeout"]=1;
			end

		end

	end

	if (intro["fadeout"]==0) then
		if (loadingcode) and (loadingcode>0) then
			intro["fadeout"]=1;
		end

	end

	if (intro["fadeout"]>0) then
		intro["fadeout"]=(intro["fadeout"] - dt);
		local alpha=intro["fadeout"];
		if (alpha>1) then
			alpha=1;
		end

		if (alpha<0) then
			alpha=0;
		end

		alpha=(255 - (alpha * 255));
		ScrRect("", 0, 0, w, h, 1, 0, 0, 0, alpha);
		if (intro["mode"]==0) then
			alCmd("GlobalGain " .. tostring(intro["fadeout"]));
		end

		if (intro["fadeout"]<=0) then
			if (intro["mode"]==0) then
				alCmd("Close rap");
				alCmd("Close traffic");
				StartIntro();
				intro["fadeout"]=-1;
			else
				if (_VL==0) then
					guit2menu(0);
					menu_setfnc(page_exit_draw, page_exit_activate);
					StartIntro();
				else
					MissionInfo(CURRENTMISSIONID, 0);
				end

			end

		end

		do return 0, (255 - alpha) end;

	end

	return 0, 255;

end

