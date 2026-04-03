SetSetting("LimitFPS", "30");
MENU_SOUND=0;
MENU_MUSIC=0;
MENU_GAMMA=0;
function UpdateSettings()
	SetGamma(((MENU_GAMMA / 100) + 0.5));
	SetMasterVolume(((MENU_SOUND + 100) / 100));
	local music_volume=(((MENU_MUSIC + 100) / 100) * 0.8);
	local t=format("Gain traffic %f %f %f", music_volume, music_volume, music_volume);
	alCmd(t);
end

function ReadSettings()
	local tmp=ReadRegistry("SOUND");
	if not ((not tmp)) then
		MENU_SOUND=tonumber(tmp);
	end

	tmp=ReadRegistry("MUSIC");
	if not ((not tmp)) then
		MENU_MUSIC=tonumber(tmp);
	end

	tmp=ReadRegistry("GAMMA");
	if not ((not tmp)) then
		MENU_GAMMA=tonumber(tmp);
	end

end

function WriteSettings()
	WriteRegistry("SOUND", tostring(MENU_SOUND));
	WriteRegistry("MUSIC", tostring(MENU_MUSIC));
	WriteRegistry("GAMMA", tostring(MENU_GAMMA));
end

ReadSettings();
UpdateSettings();
menu_displayFnc=nil;
menu_updateFnc=nil;
menu_displayPosY=0;
menu_displayPosX=0;
menu_scale=1;
menu_fontscale=1;
menu_activeItem=0;
menu_prevActiveItem=0;
menu_itemSwitchAlpha=0;
menu_currentItem=0;
menu_width=0;
menu_hidingfactor=1;
menu_showingmode=0;
menu_fadeonactivation=0;
menu_volume=0;
menu_logoalpha=0;
MENU_ENTER=0;
MENU_LEFT=1;
MENU_RIGHT=2;
MENU_BACK=3;
MENU_CANACTIVATE=4;
function menu_setfnc(dispFnc, updateFnc)
	menu_displayFnc=dispFnc;
	menu_updateFnc=updateFnc;
	menu_activeItem=0;
	menu_prevActiveItem=menu_activeItem;
	menu_itemSwitchAlpha=0;
	menu_fadeonactivation=0;
end

function menu_displayBegin(width, height, scale)
	local w, h=ScrSize();
	menu_scale=(w / 640);
	if not (scale) then
		scale=1;
	end

	menu_scale=(menu_scale * scale);
	width=(width * menu_scale);
	height=(height * menu_scale);
	menu_fontscale=1;
	local w, h=ScrSize();
	menu_displayPosY=(((h / 2) - (height / 2)) + (8 * menu_scale));
	menu_currentItem=0;
	menu_displayPosX=(w / 2);
	menu_width=width;
end

function menu_addMenuItemWrap(title, s)
	local w, h=ScrSize();
	local s=(w / 1024);
	local cw=((20 * menu_scale) * menu_fontscale);
	local line, maxLines=GetLine(title, 0, cw, (menu_width - (48 * s)));
	for i=0, (maxLines - 1) do
		line=GetLine(title, i, cw, (menu_width - (48 * s)));
		menu_addMenuItem(line, s);
	end

end

function menu_addMenuStringWrap(title, width, s, r, g, b, a)
	local w, h=ScrSize();
	local s=(w / 1024);
	local cw=((20 * menu_scale) * menu_fontscale);
	local line, maxLines=GetLine(title, 0, cw, (width * s));
	for i=0, (maxLines - 1) do
		menu_addMenuPhoto("sprite\\flare", (width * 1.3), 40, 0, 0, 200, 100, 200, a);
		menu_displayPosY=(menu_displayPosY + (6 * s));
		line=GetLine(title, i, cw, (width * s));
		menu_addMenuString(line, s, r, g, b, a);
	end

end

function menu_addMenuItem(title, s)
	local w, h=ScrSize();
	local ds=(menu_scale * menu_fontscale);
	local cw=(18 * ds);
	local ch=(30 * ds);
	local strw=(strlen(title) * cw);
	local posx=menu_displayPosX;
	if (test(menu_currentItem, 1)>0) then
		posx=(posx + ((menu_hidingfactor * w) / 2));
	else
		posx=(posx - ((menu_hidingfactor * w) / 2));
	end

	local texture="GUI\\emptyselection";
	local alpha=(255 - (menu_hidingfactor * 255));
	local px=((posx - ((menu_width - (32 * ds)) / 2)) + (8 * ds));
	local py=(menu_displayPosY - (menu_scale * 2));
	local pw=(menu_width - (32 * ds));
	local ph=(ch + (8 * menu_scale));
	local pa=(64 + (128 * menu_hidingfactor));
	local dx=((sin(((GetTime() * 300) + menu_displayPosY)) * 2) * ds);
	ScrRect(texture, px, py, pw, ph, 1, 255, 255, 255, alpha);
	ScrRect(texture, (px + dx), py, pw, ph, 0, pa, pa, pa, alpha);
	if (menu_currentItem==menu_activeItem) and not (s) then
		texture="GUI\\selected";
		if (menu_prevActiveItem==menu_activeItem) then
			ScrRect(texture, px, py, pw, ph, 1, 255, 255, 255, alpha);
			ScrRect(texture, (px + dx), py, pw, ph, 0, pa, pa, pa, alpha);
		else
			ScrRect(texture, px, py, pw, ph, 1, 255, 255, 255, (alpha * (1 - menu_itemSwitchAlpha)));
			ScrRect(texture, (px + dx), py, pw, ph, 0, pa, pa, pa, (alpha * (1 - menu_itemSwitchAlpha)));
		end

	end

	if (menu_prevActiveItem~=menu_activeItem) and (menu_currentItem==menu_prevActiveItem) and not (s) then
		texture="GUI\\selected";
		ScrRect(texture, px, py, pw, ph, 1, 255, 255, 255, (alpha * menu_itemSwitchAlpha));
		ScrRect(texture, (px + dx), py, pw, ph, 0, pa, pa, pa, (alpha * menu_itemSwitchAlpha));
		menu_itemSwitchAlpha=(menu_itemSwitchAlpha - (GetDT() * 4));
		if (menu_itemSwitchAlpha<0) then
			menu_itemSwitchAlpha=0;
			menu_prevActiveItem=menu_activeItem;
		end

	end

	local text="#\\I\\I\\I" .. title .. "\\i\\i\\i";
	ScrRect(text, ((posx - (strw / 2)) + (2 * ds)), (menu_displayPosY + (2 * ds)), cw, ch, 1, 0, 0, 0, (alpha * 0.5));
	ScrRect(text, (posx - (strw / 2)), menu_displayPosY, cw, ch, 1, 255, 255, 255, alpha);
	ScrRect(text, ((posx - (strw / 2)) + dx), menu_displayPosY, cw, ch, 0, pa, pa, pa, alpha);
	menu_displayPosY=((menu_displayPosY + ch) + (ch / 2));
	menu_currentItem=(menu_currentItem + 1);
end

function menu_addMenuString(title, s, r, g, b, a)
	local w, h=ScrSize();
	local cw=(((20 * menu_scale) * menu_fontscale) * s);
	local ch=(((30 * menu_scale) * menu_fontscale) * s);
	local strw=(strlen(title) * cw);
	if not (a) then
		a=255;
	end

	local posx=menu_displayPosX;
	if (test(menu_currentItem, 1)>0) then
		posx=(posx - ((menu_hidingfactor * w) / 2));
	else
		posx=(posx + ((menu_hidingfactor * w) / 2));
	end

	local alpha=(a - (menu_hidingfactor * a));
	ScrRect("#" .. title, ((posx - (strw / 2)) + 1), (menu_displayPosY + 1), cw, ch, 1, 0, 0, 0, (alpha * 0.5));
	ScrRect("#" .. title, (posx - (strw / 2)), menu_displayPosY, cw, ch, 1, r, g, b, alpha);
	menu_displayPosY=((menu_displayPosY + ch) + (ch / 4));
end

function menu_addMenuSlider(progress)
	local w, h=ScrSize();
	local cw=((20 * menu_scale) * menu_fontscale);
	local ch=((30 * menu_scale) * menu_fontscale);
	local strw=(menu_width * 0.8);
	local alpha=(255 - (menu_hidingfactor * 255));
	local posx=menu_displayPosX;
	if (test(menu_currentItem, 1)>0) then
		posx=(posx - ((menu_hidingfactor * w) / 2));
	else
		posx=(posx + ((menu_hidingfactor * w) / 2));
	end

	progressbar((posx - (strw / 2)), menu_displayPosY, strw, cw, progress, 255, 0, 0, alpha);
	menu_displayPosY=((menu_displayPosY + ch) + (ch / 4));
end

function menu_addMenuPhoto(path, pw, ph, movey, mode, r, g, b, a)
	local w, h=ScrSize();
	local s=(w / 1024);
	if not (mode) then
		mode=1;
	end

	pw=(pw * s);
	ph=(ph * s);
	if not (movey) then
		menu_displayPosY=(menu_displayPosY + (4 * s));
	end

	if not (r) then
		r=255;
	end

	if not (g) then
		g=255;
	end

	if not (b) then
		b=255;
	end

	if not (a) then
		a=255;
	end

	if (mode==1) then
		ScrRect(path, ((menu_displayPosX - (pw / 2)) + 2), (menu_displayPosY + 2), pw, ph, 1, 0, 0, 0, 128);
		ScrRect(path, (menu_displayPosX - (pw / 2)), menu_displayPosY, pw, ph, 1, 255, 255, 255, 255);
	else
		ScrRect(path, (menu_displayPosX - (pw / 2)), menu_displayPosY, pw, ph, 0, r, g, b, a);
	end

	if not (movey) then
		menu_displayPosY=((menu_displayPosY + ph) + (4 * s));
		menu_currentItem=(menu_currentItem + 1);
	end

end

function menu_subdisplayBegin(width, height, x, y, scale)
	menu_fontscale=scale;
	width=(width * menu_scale);
	height=(height * menu_scale);
	x=(x * menu_scale);
	y=(y * menu_scale);
	local w, h=ScrSize();
	ScrRect("GUI\\menuBGShadow", (x + 4), (y + 4), width, height, 1, 255, 255, 255, 150);
	rect(x, y, width, height, 150);
	menu_displayPosY=(y + (8 * menu_scale));
	menu_displayPosX=(x + (width / 2));
	menu_currentItem=0;
	menu_width=width;
end

function MissionRemap(misid)
	if (_VL==0) then
		do return 3 end;

	end

	if (misid==0) then
		do return 3 end;

	end

	if (misid==1) then
		do return 9 end;

	end

	if (misid==2) then
		do return 2 end;

	end

	if (misid==3) then
		do return 0 end;

	end

	if (misid==4) then
		do return 4 end;

	end

	if (misid==5) then
		do return 7 end;

	end

	if (misid==6) then
		do return 1 end;

	end

	if (misid==7) then
		do return 6 end;

	end

	if (misid==8) then
		do return 5 end;

	end

	if (misid==9) then
		do return 10 end;

	end

	if (misid==10) then
		do return 11 end;

	end

	return misid;

end

function ReadAndDisplayBestRating(misid)
	local s=ReadRegistry("BESTRATING" .. tostring(misid));
	if not (s) then
		s="0";
	end

	s=s .. "%";
	menu_addMenuItem("<" .. BESTRATING .. s .. ">", 1);
	menu_addMenuItem("", 1);
end

function GetBestRating(misid)
	local s=ReadRegistry("BESTRATING" .. tostring(misid));
	if not (s) then
		s="0";
	end

	s=s .. "%";
	return s;

end

function page2_activate(id, cmd)
	local maxmissions=MISSIONS_PASSED;
	if (maxmissions==10) then
		maxmissions=11;
	end

	if (cmd==MENU_CANACTIVATE) then
		if (_VL==1) or (id==0) or (id==maxmissions) then
			do return 1 end;

		end

		do return 0 end;

	end

	if (id>=0) and (id<maxmissions) and (cmd==MENU_ENTER) then
		if (_VL==1) or (menu_activeItem==0) then
			CURRENTMISSIONID=id;
			MissionInfo(id, 0);
		end

	end

	if (id~=maxmissions) or (cmd==MENU_ENTER) or (cmd==MENU_BACK) then
		menu_setfnc(page1, page1_activate);
	end

end

function page2()
	local w, h=ScrSize();
	menu_displayBegin(270, (280 + (32 * MISSIONS_PASSED)), 0.55);
	local t=MISSIONS_PASSED;
	if (t>10) then
		t=10;
	end

	for i=1, t do
		menu_addMenuItem(MISSION .. i);
	end

	if (MISSIONS_PASSED==10) then
		menu_addMenuItem(BONUSMISSION);
	end

	menu_addMenuItem(BACK);
	menu_addMenuString("", 0.5, 255, 255, 255);
	menu_fadeonactivation=0;
	local maxmissions=MISSIONS_PASSED;
	if (maxmissions==10) then
		maxmissions=11;
	end

	local ds=(menu_scale * menu_fontscale);
	local ch=(30 * ds);
	menu_displayPosY=(h - (4 * (ch + (ch / 2))));
	if (menu_hidingfactor==0) and (menu_activeItem<maxmissions) then
		menu_fadeonactivation=1;
		local alpha=255;
		if (menu_activeItem~=menu_prevActiveItem) then
			alpha=(255 - (menu_itemSwitchAlpha * 255));
		end

		if (_VL==1) or (menu_activeItem==0) then
			local s=MissionShortInfo(menu_activeItem, 0);
			local misid=MissionRemap(menu_activeItem);
			local rating=BESTRATING .. GetBestRating(misid);
			menu_addMenuStringWrap("\\I" .. rating .. " | " .. s .. "\\i", 400, 1.1, 255, 255, 255, alpha);
		else
			menu_addMenuStringWrap("\\ILocked. Buy full version to unlock.\\i", 400, 1.1, 255, 255, 255, alpha);
		end

	end

end

function pagestealth_activate(id, cmd)
	if (id==0) and (cmd==MENU_ENTER) then
		GAMEMODE=1;
		console("load empty level sanjose");
		console("set  level sanjose");
		game_init(4);
		alCmd("Close traffic");
	end

	if (id~=1) or (cmd==MENU_ENTER) or (cmd==MENU_BACK) then
		menu_setfnc(pagemode, pagemode_activate);
	end

end

menu_controls={"U",
	CONTROL_FORWARD,
	87,
	"D",
	CONTROL_BACKWARD,
	83,
	"L",
	CONTROL_TURNLEFT,
	65,
	"R",
	CONTROL_TURNRIGHT,
	68,
	"A",
	CONTROL_ACTION,
	13,
	"S",
	CONTROL_FIRE,
	162,
	"O",
	CONTROL_HANDBRAKE,
	32,
	"E",
	CONTROL_ENGINE,
	69,
	"B",
	CONTROL_BRIBE,
	66,
	"G",
	CONTROL_FPS,
	86,
	"M",
	CONTROL_MAP,
	77,
	"I",
	CONTROL_ILLUMINATION,
	73};
menu_maxcontrols=12;
menu_controls_stride=3;
function readcontrols()
	for i=1, menu_maxcontrols do
		local str=ReadRegistry(menu_controls[((i * menu_controls_stride) - 2)]);
		if not ((not str)) then
			menu_controls[(i * menu_controls_stride)]=tonumber(str);
			SetCombo(menu_controls[((i * menu_controls_stride) - 2)], menu_controls[(i * menu_controls_stride)]);
		end

	end

end

function pagecontrols()
	local w, h=ScrSize();
	menu_displayBegin(300, 480, 0.55);
	menu_displayPosX=((w / 4) + (w / 8));
	for i=1, menu_maxcontrols do
		menu_addMenuItem(menu_controls[((i * menu_controls_stride) - 1)]);
	end

	menu_displayBegin(200, 480, 0.55);
	menu_displayPosX=(((w / 2) + (w / 8)) + (w / 16));
	for i=1, menu_maxcontrols do
		if (menu_controls[(i * menu_controls_stride)]==0) and (LastKeyDown>0) then
			menu_controls[(i * menu_controls_stride)]=LastKeyDown;
			SetCombo(menu_controls[((i * menu_controls_stride) - 2)], LastKeyDown);
			WriteRegistry(menu_controls[((i * menu_controls_stride) - 2)], tostring(LastKeyDown));
			print("Key ", LastKeyDown, " assigned to ", menu_controls[((i * menu_controls_stride) - 1)]);
			LastKeyDown=-1;
		end

		local key_name=GetKeyName(menu_controls[(i * menu_controls_stride)]);
		if not (key_name) then
			key_name="...";
		end

		menu_addMenuItem(key_name);
	end

	local old_menu_displayPosY=menu_displayPosY;
	local old_menu_currentItem=menu_currentItem;
	local old_menu_currentItem=menu_currentItem;
	menu_displayBegin(270, 400, 0.8);
	menu_displayPosY=old_menu_displayPosY;
	menu_currentItem=old_menu_currentItem;
	menu_currentItem=old_menu_currentItem;
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuItem(BACK);
end

LastKeyDown=-1;
function OnKeyDn(key)
	LastKeyDown=key;
end

function pagecontrols_activate(id, cmd)
	if (id<menu_maxcontrols) and (cmd==MENU_CANACTIVATE) then
		LastKeyDown=-1;
		menu_controls[((id + 1) * menu_controls_stride)]=0;
		do return 0 end;

	end

	if (id~=menu_maxcontrols) or (cmd==MENU_ENTER) or (cmd==MENU_BACK) then
		menu_setfnc(page_options, page_options_activate);
	end

end

function page_options_activate(id, cmd)
	if (cmd==MENU_CANACTIVATE) then
		if (id==4) then
			do return 1 end;

		end

		if (id==3) then
			do return 1 end;

		end

		do return 0 end;

	end

	if (id==3) and (cmd==MENU_ENTER) then
		menu_setfnc(pagecontrols, pagecontrols_activate);
	end

	if (id~=4) or (cmd==MENU_ENTER) or (cmd==MENU_BACK) then
		menu_setfnc(page1, page1_activate);
	end

	if (cmd==MENU_LEFT) then
		if (id==0) then
			MENU_SOUND=(MENU_SOUND - 9);
			if (MENU_SOUND<-100) then
				MENU_SOUND=-100;
			end

		end

		if (id==1) then
			MENU_MUSIC=(MENU_MUSIC - 9);
			if (MENU_MUSIC<-100) then
				MENU_MUSIC=-100;
			end

		end

		if (id==2) then
			MENU_GAMMA=(MENU_GAMMA - 9);
			if (MENU_GAMMA<-50) then
				MENU_GAMMA=-50;
			end

		end

		UpdateSettings();
		WriteSettings();
	end

	if (cmd==MENU_RIGHT) then
		if (id==0) then
			MENU_SOUND=(MENU_SOUND + 9);
			if (MENU_SOUND>0) then
				MENU_SOUND=0;
			end

		end

		if (id==1) then
			MENU_MUSIC=(MENU_MUSIC + 9);
			if (MENU_MUSIC>0) then
				MENU_MUSIC=0;
			end

		end

		if (id==2) then
			MENU_GAMMA=(MENU_GAMMA + 9);
			if (MENU_GAMMA>50) then
				MENU_GAMMA=50;
			end

		end

		UpdateSettings();
		WriteSettings();
	end

end

function page_options()
	menu_displayBegin(270, 220);
	menu_fontscale=0.8;
	menu_addMenuItem(SSOUND);
	menu_addMenuSlider((MENU_SOUND + 100));
	menu_addMenuItem(SMUSIC);
	menu_addMenuSlider((MENU_MUSIC + 100));
	menu_addMenuItem(SGAMMA);
	menu_addMenuSlider((MENU_GAMMA + 50));
	menu_addMenuItem(MENU_CONTROLS);
	menu_addMenuItem(BACK);
end

function page_credits_draw()
	page_credits();
end

function page_credits_activate(id, cmd)
	if (id~=0) or (cmd==MENU_ENTER) or (cmd==MENU_BACK) then
		menu_setfnc(page1, page1_activate);
	end

end

function page_exit_draw()
	local w, h=ScrSize();
	ScrRect("GUI\\sheet", 0, 0, w, h, 1, 255, 255, 255, 255);
	menu_displayBegin(256, 64, 0.55);
	menu_displayPosY=(h - (h / 9));
	menu_displayPosX=((w / 2) + (w / 4));
	menu_addMenuItem("Buy Now!");
	menu_addMenuItem("Quit");
end

function page_exit_activate(id, cmd)
	if (id~=0) or (cmd==MENU_ENTER) or (cmd==MENU_BACK) then
		WinExec("cmd.exe /q /c buyonline.url");
		console("exit");
	end

	if (id~=1) or (cmd==MENU_ENTER) or (cmd==MENU_BACK) then
		console("exit");
	end

end

function page1_activate(id, cmd)
	if (id==0) and (cmd==MENU_ENTER) then
		GAMEMODE=0;
		if (MISSIONS_PASSED==1) then
			CURRENTMISSIONID=(MISSIONS_PASSED - 1);
			MissionInfo((MISSIONS_PASSED - 1), 0);
		else
			menu_setfnc(page2, page2_activate);
			menu_activeItem=(MISSIONS_PASSED - 1);
			menu_prevActiveItem=(MISSIONS_PASSED - 1);
		end

	end

	if (id==1) and (cmd==MENU_ENTER) then
		menu_setfnc(page_options, page_options_activate);
	end

	if (id==2) and (cmd==MENU_ENTER) then
		menu_setfnc(page_credits_draw, page_credits_activate);
	end

	if (id==3) and (cmd==MENU_ENTER) then
		if (_VL==0) then
			menu_setfnc(page_exit_draw, page_exit_activate);
		else
			console("exit");
		end

	end

end

function page1()
	menu_displayBegin(256, 157);
	if ((menu_activeItem==0) and (MISSIONS_PASSED==1)) or ((_VL==1) and (menu_activeItem==3)) then
		menu_fadeonactivation=1;
	else
		menu_fadeonactivation=0;
	end

	if (MISSIONS_PASSED==1) then
		menu_addMenuItem(NEWGAME);
	else
		menu_addMenuItem(CONTINUEGAME);
	end

	menu_addMenuItem(OPTIONS);
	menu_addMenuItem(ABOUT);
	menu_addMenuItem(QUIT);
end

function pagemode_activate(id, cmd)
	if (id==1) and (cmd==MENU_ENTER) then
		menu_setfnc(page2, page2_activate);
	end

	if (id==0) and (cmd==MENU_ENTER) then
		STEALTHID=(STEALTHID + 1);
		if (STEALTHID>=4) then
			STEALTHID=0;
		end

		menu_setfnc(pagestealth, pagestealth_activate);
	end

	if (id~=2) or (cmd==MENU_ENTER) or (cmd==MENU_BACK) then
		menu_setfnc(page1, page1_activate);
	end

end

function pagemode()
	menu_fontscale=0.8;
	menu_displayBegin(280, 120);
	menu_addMenuItem(STEALTHMODE);
	menu_addMenuItem(STORYMODE);
	menu_addMenuItem(BACK);
end

function menu_init()
	Fade(0, 1);
	Fade(1, 0);
	SkyDome("disable");
	Weather("disable");
	gamegui_cmd("hide");
	gui_Update=menu_Update;
	menu_setfnc(page1, page1_activate);
	if (GAMEMODE==0) then
	end

	if (GAMEMODE==1) then
	end

	local w, h=ScrSize();
	menu_scale=(w / 640);
	UpdateSettings();
	alCmd("Open Sounds\\traffic2.wav 1 1 traffic");
	alCmd("Dist traffic 50000 50000");
	alCmd("Gain traffic 0 0 0");
	alCmd("Move traffic 270 231 373");
	alCmd("Play traffic");
	menu_volume=0;
	SetSetting("LimitFPS", "30");
end

function menu_display()
	if (menu_showingmode==0) then
		menu_hidingfactor=(menu_hidingfactor - (GetDT() * 2));
		if (menu_hidingfactor<0) then
			menu_hidingfactor=0;
		end

	end

	if (menu_showingmode==1) or (menu_showingmode==2) then
		menu_hidingfactor=(menu_hidingfactor + (GetDT() * 2));
		if (menu_hidingfactor>2) then
			menu_hidingfactor=1;
			if (menu_showingmode==1) then
				menu_updateFnc(menu_activeItem, MENU_BACK);
			end

			if (menu_showingmode==2) then
				menu_updateFnc(menu_activeItem, MENU_ENTER);
			end

			menu_showingmode=0;
		end

	end

	if not ((not menu_displayFnc)) then
		local oldhidingfactor=menu_hidingfactor;
		if (menu_hidingfactor>1) then
			menu_hidingfactor=1;
		end

		menu_displayFnc();
		menu_hidingfactor=oldhidingfactor;
	end

	if ((menu_hidingfactor==0) and (menu_prevActiveItem==menu_activeItem)) or (menu_itemSwitchAlpha<0.2) then
		if (LastKeyDown==menu_controls[(1 * menu_controls_stride)]) or (LastKeyDown==38) then
			menu_prevActiveItem=menu_activeItem;
			menu_itemSwitchAlpha=1;
			menu_activeItem=(menu_activeItem - 1);
			if (menu_activeItem<0) then
				menu_activeItem=(menu_currentItem - 1);
			end

			PlaySound2D("menu", 1);
		end

		if (LastKeyDown==menu_controls[(2 * menu_controls_stride)]) or (LastKeyDown==40) then
			menu_prevActiveItem=menu_activeItem;
			menu_itemSwitchAlpha=1;
			menu_activeItem=(menu_activeItem + 1);
			if (menu_activeItem>(menu_currentItem - 1)) then
				menu_activeItem=0;
			end

			PlaySound2D("menu", 1);
		end

		if (LastKeyDown==menu_controls[(3 * menu_controls_stride)]) or (LastKeyDown==37) then
			menu_updateFnc(menu_activeItem, MENU_LEFT);
			PlaySound2D("menu", 1);
		end

		if (LastKeyDown==menu_controls[(4 * menu_controls_stride)]) or (LastKeyDown==39) then
			menu_updateFnc(menu_activeItem, MENU_RIGHT);
			PlaySound2D("menu", 1);
		end

		if (LastKeyDown==27) and not ((not menu_updateFnc)) then
			PlaySound2D("menue", 1);
			menu_showingmode=1;
		end

		if (LastKeyDown~=13) then
		end

		if (LastKeyDown==menu_controls[(5 * menu_controls_stride)]) and not ((not menu_updateFnc)) then
			local res=menu_updateFnc(menu_activeItem, MENU_CANACTIVATE);
			if (res==1) or not (res) then
				PlaySound2D("menue", 1);
				menu_showingmode=2;
				if (menu_fadeonactivation==1) then
					Fade(0, 0);
				end

			end

		end

		LastKeyDown=-1;
	end

end

lastChar=0;
function OnConsoleCmd(cmd)
	if (cmd=="skip") then
		SKIPMISSION=1;
	end

	if (cmd=="unlock") then
		SKIPMISSION=1;
		MISSIONS_PASSED=10;
	end

end

function OnChar(char)
	lastChar=char;
end

function menu_Update()
	gamegui_cmd("hide");
	local res=ShowIntro();
	if (res~=-1) then
		do return end;

	end

	alCmd(format("Gain traffic %f %f %f", menu_volume, menu_volume, menu_volume));
	menu_volume=(menu_volume + (GetDT() / 2));
	if (menu_volume>0.8) then
		menu_volume=0.8;
	end

	MBALPHA=0.2;
	local t=((sin((GetTime() * 50)) * 40) + 40);
	local t1=((sin((GetTime() * 100)) * 100) + 100);
	SetBGColor(t, t, t, 1);
	ScrClip();
	local w, h=ScrSize();
	ScrRect("GUI\\city", 0, 0, w, h, 1, 150, 150, 150, 255);
	ScrRect(LOGOTEXTURE, 0, 0, w, (h / 8), 1, 255, 255, 255, 255);
	local a=abs(sin((menu_logoalpha * 10)));
	menu_logoalpha=((menu_logoalpha + ((random() * DT) * 2)) + DT);
	ScrRect(LOGOTEXTURE1, 0, 0, w, (h / 8), 1, 255, 255, 255, (200 * a));
	local x=270;
	local y=231;
	local z=373;
	LookAt(x, y, z, (x + 0.1168), (y - 0.1632), (z - 0.9741));
	if (lastChar>0) then
		lastChar=0;
	end

	menu_display();
	if (menu_volume<0.8) then
		ScrRect("", 0, 0, w, h, 1, 0, 0, 0, (255 - ((255 * menu_volume) / 0.8)));
	end

end

SetFOVAndClipPlanes(65, 10, 500000);
SetBGColor(0, 0, 0);
Resume();
function HeadlightTrace_Init(x, y, z, w, h, angle, dx, dy, dz, this)
	x=random(-5, 5);
	return x, y, z, w, h, angle, dx, dy, dz;

end

function Smoke_Init(x, y, z, w, h, angle, dx, dy, dz, this)
	x=random(-100, 100);
	return x, y, z, w, h, angle, dx, dy, dz;

end

id=InsertParticleSource("ParticleSystems\\smoke1.psf", 200, 0, -2000, 0, 0, 0, 10, 4, 10);
SetColor(id, 100, 100, 100, 100);
SetCreationFunction(id, "Smoke_Init");
id=InsertParticleSource("ParticleSystems\\backlighttracelight.psf", 40, 0, 0);
SetColor(id, 100, 0, 0, 255);
SetCreationFunction(id, "HeadlightTrace_Init");
id=InsertParticleSource("ParticleSystems\\headlighttracelight.psf", 550, 0, -5000, 0, 0, 0, 1.8);
SetCreationFunction(id, "HeadlightTrace_Init");
openal=EnableOpenAL();
SetName(openal, "OpenAL");
menu_init();
readcontrols();
