MENU_NOTAVAILABLE="Not available in demo";
MENU_YES="Yes";
MENU_NO="No";
MENU_HIGH="High";
MENU_MED="Med";
MENU_LOW="Low";
MENU_APPLY="Apply Changes";
MENU_DETAIL="Detail: ";
MENU_VIDEO="Video";
MENU_FULLSCREEN="Fullscreen:";
SCANNING="Scanning";
BLOOD=1;
QUIT_YES=89;
QUIT_NO=78;
RAMTHATCAR="Ram the car!";
CONTROL_FORWARD="Forward";
CONTROL_BACKWARD="Backward";
CONTROL_TURNLEFT="Turn Left";
CONTROL_TURNRIGHT="Turn Right";
CONTROL_HANDBRAKE="Handbrake";
CONTROL_FIRE="Fire/Fight";
CONTROL_ACTION="Action";
CONTROL_BRIBE="Bribe";
CONTROL_ENGINE="Start Engine";
MENU_CONTROLS="Controls";
CONTROL_FPS="Camera";
CONTROL_MAP="Map zoom";
CONTROL_ILLUMINATION="Headlights";
LOGOTEXTURE="GUI\\logo";
LOGOTEXTURE1="GUI\\logo1";
BACK="Back";
ABOUT="Credits";
BONUSMISSION="Bonus";
MISSION="Mission ";
BESTRATING="Best Rating: ";
STEALTHMODE="Theft Mode";
STORYMODE="Story Mode";
SGAMMA="Gamma";
SMUSIC="Music";
SSOUND="Sound";
LAUNCH="Launch";
MARKERINSTALLED="%d of 5 markers are installed!";
RATINGBEST=" % - best! ";
MISSIONCOMPLETE=" Mission complete! ";
YOURRATING="Your Rating: ";
ONEMORECARLEFT="One more car remaining! Hurry!";
COOL="COOL!";
COOLFIRSTCAR="Cool! This is the first car";
LEAVECAR="Leave the car!";
MISSIONFAILED="Mission failed!";
BUSTED="You've been busted!";
KILLS=" %d of 30! ";
DOUBLEKILL="Double kill!";
STOLENCAR="Attention! The police are looking for this car! ";
HELP0="Hold 'E' to start the engine";
HELP1="Press 'ENTER' to get in the car";
HELP2="Hold 'ENTER' to install a radio-marker";
HELP3="Hold 'ENTER' to remove a wheel ";
HELP4="Press 'ENTER' to put the wheel in the boot";
HELP5="Press 'B' to bribe";
HELP6="Hold 'E' to scan for the alarm code";
HELP6A="and if the driver has enabled or disabled the alarm.";
HELP7="Press 'ENTER' to leave the car";
PRESSENTER="Press ENTER";
SSTARTENGINE="Starting...";
SDISALARM="Switching the alarm off ...";
DISALARMFAILED="Can't switch off the alarm";
DISALARMED="Alarm is switched off";
SREMOVEWHEEL="Removing...";
SUSEPICKLOCK="Opening...";
SPUTMARKER="Installing marker...";
COOLFIRSTCAR="Cool! First car! ";
GREATONEMORECAR="Cool! One more car!";
NOTENOUGHMONEY="You don't have enough money!";
OUTOFFUEL="You have run out of petrol!";
QUIT2MMENU="Quit to the main menu? (Y/N)";
LOADING="Loading ...";
CLIP="You've picked up an ammo clip";
HUNDRED="You've picked up $100";
ADDUZI="You've picked up an Uzi";
ADDPISTOL="You've picked up a pistol";
FIRSTKIT="You've picked up a first aid kit";
HEALTH="Health";
FELONY="Felony";
DAMAGE="Damage";
NEWGAME="New game";
CONTINUEGAME="Continue";
OPTIONS="Options";
QUIT="Quit";
OUTOFLEVEL="Return to the city!";
PRESSBACKSPACE="Press BACKSPACE to flip the car";
PUTMARKER="PLACE MARKER";
BRIBE="BRIBE";
HIDE="HIDE";
OPENDOOR="OPEN THE DOOR";
CLOSEDOOR="CLOSE THE DOOR";
GETOUT="GET OUT";
TOGGLEILLUM="HEADLIGHTS";
TOGGLESIREN="SIREN";
STARTENGINE="START";
MUFFLEENGINE="MUFFLE";
CANTSTART=" I can't start the engine";
TAXI="TAXI!! ";
GETIN="GET IN";
REMOVEWHEEL="REMOVE THE WHEEL";
LOADWHEEL="LOAD THE WHEEL";
DOORLOCKED="Door is locked";
DOORUNLOCKED="Door is unlocked";
WHEELCOUNT="Total loaded wheels: %d";
WHEELLOADED="The wheel is loaded.";
E_COPYRIGHT1="\\I2006 (c) All rights reserved\\i";
E_COPYRIGHT2="\\IKozmogames Inc. - www.kozmogames.com\\i";
function MissionShortInfo(misid, gamemode)
	misid=MissionRemap(misid);
	if (misid==3) then
		do return "Earn $350 working as taxi driver" end;

	end

	if (misid==9) then
		do return "Take the Chinese man to China Town" end;

	end

	if (misid==2) then
		do return "Install radio markers on the police cars" end;

	end

	if (misid==0) then
		do return "Remove 16 wheels from parked cars" end;

	end

	if (misid==4) then
		do return "Find and steal a luxury car" end;

	end

	if (misid==7) then
		do return "Beat the Chinese girl in a one-on-one race" end;

	end

	if (misid==1) then
		do return "Steal three police cars" end;

	end

	if (misid==6) then
		do return "Deliver the truck to its destination" end;

	end

	if (misid==5) then
		do return "Hunt down the killer of the Chinese girl" end;

	end

	if (misid==10) then
		do return "Destroy the rival gang" end;

	end

	if (misid==11) then
		do return "Bonus: free mission" end;

	end

	return "";

end

function MissionStealthInfo(misid, gamemode)
	StartIntro("Sounds\\rap" .. random(1, 2) .. ".wav", StealthArg(1), "intro\\slippy", nil, "There is an order out for a special luxury car. You need to find and steal this car and then take it to a junkyard hideout. Finding the car will not be easy, but it was last seen in the yellow area marked on your map. You only have 20 minutes to complete the task. When you find the car, use your alarm scanner - it will help you open the car quickly and quietly.", 10, 10, 10);
end

function MissionInfo(misid, gamemode)
	misid=MissionRemap(misid);
	if (misid==3) then
		StartIntro("Sounds\\rap1.wav", "intro\\taxi", "intro\\slippy", nil, "You start the game as a taxi driver who must earn $350 within 15 minutes. The faster you manage to earn the money, the higher your rating will be.  Don't forget to refuel your car before running out of petrol.  Always watch out for the police!", 0, 0, 100);
	end

	if (misid==9) then
		StartIntro("Sounds\\rap2.wav", "intro\\chinatown", "intro\\slippy", "intro\\mob", "When returning from work one day, a well dressed Chinese man approaches you in the street.  He offers you a job as his driver and bodyguard. The following day you need to pick him up from the cemetery and drive him to Chinatown.", 50, 50, 50);
	end

	if (misid==2) then
		StartIntro("Sounds\\rap1.wav", "intro\\bar", "intro\\slippy", "intro\\mob2", "After saving the life of your boss, he decides it’s time to have a little chat.  He tells you he is one of the biggest crime bosses in town and offers you to join him. You accept. Your first job is to install radio trackers on 5 police cars around town.  You have to put markers on the police cars while policemen are still in them.  Put the markers on the back of the cars, near the boot.  You will now be able to track the police on your radar.", 50, 50, 50);
	end

	if (misid==0) then
		StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy", "intro\\mob", "You soon discover that your mafia friends are involved in a serious car jacking operation.  They decide to check out your skills in the fine art of carjacking.  Your first task is simple, but you must be careful.  You have 15 minutes to steal 16 wheels from any parked cars you find.  Use the wrench to remove the tyres and then load them into the back of your van.  After you finish the job, return to the agreed meeting point.", 50, 50, 50);
	end

	if (misid==1) then
		StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy", "intro\\mob", "The mob needs some police cars, fast!  You have 15 minutes to steal 3 police cars.  Use the lock-pick to break into the cars. ", 50, 50, 50);
	end

	if (misid==4) then
		STEALTHID=1;
		MissionStealthInfo(0, 1);
	end

	if (misid==7) then
		StartIntro("Sounds\\rap1.wav", "intro\\race", "intro\\slippy", nil, "As you are cruising in the stolen luxury car, you spot a beautiful Chinese woman in a cool looking car – she seems to want to race you. Take on the challenge, and make sure you win.", 0, 0, 0);
	end

	if (misid==6) then
		StartIntro("Sounds\\rap1.wav", "intro\\van", "intro\\slippy", "intro\\mob", "You need to deliver a hot truck to its destination. You only have 5 minutes, and there is a very big problem: the police is after you!", 20, 20, 20);
	end

	if (misid==5) then
		StartIntro("Sounds\\rap2.wav", "intro\\dead_girl", "intro\\slippy", nil, "Disaster has struck! The Asian girl you raced was the daughter of your boss, and she was killed while you were supposed to be protecting her. You are in big trouble!  After a few days investigating, you discover who killed her - the boss of a rival gang.  To clear your name, you must now hunt him down to avenge the daughter’s death.", 20, 20, 20);
	end

	if (misid==10) then
		StartIntro("Sounds\\rap1.wav", "intro\\slum", "intro\\slippy2", "intro\\braker", "It’s the final stand-off. You have to beat the entire rival gang before they beat you. Rumours suggest there are about 30 of them. If you live through this day you will be richly rewarded by your boss.", 20, 20, 20);
	end

	if (misid==11) then
		StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy1", "intro\\mob3", "Congratulations! You've successfully destroyed the enemy gang.  Your boss has given you keys to all the best stolen cars as a reward.  They are now yours to race!", 20, 20, 20);
	end

end

function page_credits()
	menu_displayBegin(300, 353);
	menu_addMenuString("", 1, 255, 255, 255);
	menu_addMenuString("", 1, 255, 255, 255);
	menu_addMenuString(E_COPYRIGHT1, 0.5, 255, 255, 255);
	menu_addMenuString(E_COPYRIGHT2, 0.5, 255, 255, 255);
	menu_addMenuString("Programming", 0.6, 255, 0, 0);
	menu_addMenuString("Ilia Stepanov", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Graphics", 0.6, 255, 0, 0);
	menu_addMenuString("Ilia Stepanov", 0.5, 255, 255, 255);
	menu_addMenuString("Dmitri Lykov", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Music", 0.6, 255, 0, 0);
	menu_addMenuString("Michail Kostylev", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Special Thanks", 0.6, 255, 0, 0);
	menu_addMenuString("Joel Breton", 0.5, 255, 255, 255);
	menu_addMenuString("Olga Breton", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.8, 255, 255, 100);
	menu_fontscale=0.8;
	menu_addMenuItem(BACK);
end

