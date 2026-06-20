function MusicUpdate()
	MusicReadyTimeout=(MusicReadyTimeout + DT);
	if (MusicReadyTimeout<2) then
		alCmd("GlobalGain "..tostring((MusicReadyTimeout / 2)));
		do return end;
		
	end
	
	MusicTimeOut=(MusicTimeOut - DT);
	MusicRush=(MusicRush - DT);
	local health=GetNumber(PLAYER, "health");
	local felony=GetNumber(PLAYER, "felony");
	local player_car=GetVehicle(PLAYER);
	local stolen_car=GetNumber(player_car, "stolen");
	if (player_car>0) then
		stolen_car=1;
	end
	
	if (MusicRush>20) then
		MusicRush=20;
	end
	
	if (felony>0) or (stolen_car==1) or (MusicRush>0) or (Music1TargetVolume>0) then
		Music1TargetVolume=0;
		MusicTimeOut=5;
	end
	
	if (Music1Volume<Music1TargetVolume) then
		Music1Volume=(Music1Volume + (DT * 0.5));
		if (Music1Volume>Music1TargetVolume) then
			Music1Volume=Music1TargetVolume;
		end
		
	end
	
	if (Music2Volume<Music2TargetVolume) then
		Music2Volume=(Music2Volume + (DT * 0.5));
		if (Music2Volume>Music2TargetVolume) then
			Music2Volume=Music2TargetVolume;
		end
		
	end
	

end