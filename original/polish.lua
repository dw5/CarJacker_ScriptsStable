BLOOD=1;
QUIT_YES=84;
QUIT_NO=78;
LOGOTEXTURE="GUI\\plogo";
LOGOTEXTURE1="GUI\\nlogo1";
E_COPYRIGHT1="\\I2006 (c) Wszelkie prawa zastrzeøone\\i";
E_COPYRIGHT2="\\IKozmogames Inc. - www.kozmogames.com\\i";
MENU_NOTAVAILABLE="Opcja niedostÍpna w wersji demo";
MENU_YES="Tak";
MENU_NO="Nie";
MENU_HIGH="Wysokie";
MENU_MED="årednie";
MENU_LOW="Niskie";
MENU_APPLY="Akceptuj";
MENU_DETAIL="SzczegÛ≥y:";
MENU_VIDEO="Ekran";
MENU_FULLSCREEN="Pe≥ny ekran:";
SCANNING="Skanowanie";
RAMTHATCAR="Staranuj go!";
CONTROL_FORWARD="Do przodu";
CONTROL_BACKWARD="Do ty≥u";
CONTROL_TURNLEFT="SkrÍÊ w lewo";
CONTROL_TURNRIGHT="SkrÍÊ w prawo";
CONTROL_HANDBRAKE="Hamulec rÍczny";
CONTROL_FIRE="Strza≥/walka";
CONTROL_ACTION="Akcja";
CONTROL_BRIBE="£apÛwka";
CONTROL_ENGINE="Uruchom silnik";
MENU_CONTROLS="Sterowanie";
CONTROL_FPS="Kamera";
CONTROL_MAP="Zbliøenie mapy";
CONTROL_ILLUMINATION="Reflektory";
BACK="WrÛÊ";
ABOUT="TwÛrcy";
BONUSMISSION="Bonus";
MISSION="Misja ";
BESTRATING="Najlepsze wyniki:";
STEALTHMODE="Tryb kradzieøy";
STORYMODE="Tryb fabu≥y";
SGAMMA="Gamma";
SMUSIC="Muzyka";
SSOUND="DüwiÍk";
LAUNCH="Uruchom";
MARKERINSTALLED="Zainstalowano %d z 5 nadajnikÛw!";
RATINGBEST=" % - najlepszy! ";
MISSIONCOMPLETE=" Misja zakoÒczona sukcesem! ";
YOURRATING="TwÛj wynik:";
ONEMORECARLEFT="Potrzebny jeszcze jeden samochÛd! Szybciej!";
COOL="åwietnie!";
COOLFIRSTCAR="åwietnie! Oto pierwszy samochÛd";
LEAVECAR="OpuúÊ samochÛd";
MISSIONFAILED="Misja nieudana!";
BUSTED="Zosta≥eú z≥apany!";
KILLS=" %d z 30! ";
DOUBLEKILL="PodwÛjne morderstwo!";
STOLENCAR="Uwaøaj! Policja szuka tego samochodu! ";
HELP0="Naciúnij 'E', by uruchomiÊ silnik";
HELP1="Naciúnij 'ENTER', by wsiπúÊ do samochodu";
HELP2="Naciúnij 'ENTER', by zainstalowaÊ wskaünik radiowy";
HELP3="Naciúnij 'ENTER', by usunπÊ ko≥o ";
HELP4="Naciúnij 'ENTER', by schowaÊ ko≥o w bagaøniku";
HELP5="Naciúnij 'B', by daÊ ≥apÛwkÍ";
HELP6="Naciúnij 'E', by wy≥πczyÊ alarm,";
HELP6A="jeúli kierowca go w≥πczy≥";
HELP7="Naciúnij 'Enter', by opuúciÊ samochÛd";
PRESSENTER="Naciúnij 'ENTER'";
SSTARTENGINE="Rozruch...";
SDISALARM="Wy≥πczanie alarmu...";
DISALARMFAILED="Nie moøna wy≥πczyÊ alarmu";
DISALARMED="Alarm zosta≥ wy≥πczony";
SREMOVEWHEEL="Usuwanie...";
SUSEPICKLOCK="Otwieranie...";
SPUTMARKER="Instalowanie nadajnika...";
COOLFIRSTCAR="åwietnie! Pierwsza fura! ";
GREATONEMORECAR="Super! Jeszcze jeden! ";
NOTENOUGHMONEY="Nie masz wystarczajπcej iloúci pieniÍdzy!";
OUTOFFUEL="KoÒczy ci siÍ benzyna!";
QUIT2MMENU="WyjúÊ do menu g≥Ûwnego? (T/N)";
LOADING="Wczytywanie...";
CLIP="Zdoby≥eú magazynek";
HUNDRED="Zdoby≥eú $100";
ADDUZI="Zdoby≥eú UZI";
ADDPISTOL="Zdoby≥eú pistolet";
FIRSTKIT="Zdoby≥eú apteczkÍ";
HEALTH="Zdrowie";
FELONY="Poziom przestÍpczoúci";
DAMAGE="Zniszczenia";
NEWGAME="Nowa gra";
CONTINUEGAME="Kontynuuj";
OPTIONS="Opcje";
QUIT="Wyjúcie";
OUTOFLEVEL="PowrÛÊ do miasta!";
PRESSBACKSPACE="Naciúnij BACKSPACE, by przewrÛciÊ samochÛd";
PUTMARKER="WSKAèNIK MIEJSCA";
BRIBE="£AP”WKA";
HIDE="CHOWAJ";
OPENDOOR="OTW”RZ DRZWI";
CLOSEDOOR="ZAMKNIJ DRZWI";
GETOUT="WYSI•Dè";
TOGGLEILLUM="REFLEKTORY";
TOGGLESIREN="KLAKSON";
STARTENGINE="START";
MUFFLEENGINE="T£UMIK";
CANTSTART=" Nie mogÍ uruchomiÊ silnika";
TAXI="TAXI!! ";
GETIN="WSIADAJ";
REMOVEWHEEL="USU— SAMOCH”D";
LOADWHEEL="ZA£ADUJ KO£O DO CI ØAR”WKI";
DOORLOCKED="Drzwi sπ zamkniÍte";
DOORUNLOCKED="Drzwi sπ otwarte";
WHEELCOUNT="Liczba za≥adowanych kÛ≥: %d";
WHEELLOADED="Ko≥o zosta≥o za≥adowane";
FIRSTCOPCAR="åwietnie! Pierwszy samochÛd dostarczony!";
SECONDCOPCAR="Znakomicie! Zosta≥ jeszcze jeden";
FINISHRACE="META!";
STARTRACEGO="START!!";
function MissionShortInfo(misid, gamemode)
	misid=MissionRemap(misid);
	if (misid==3) then
		do return "Prowadzπc limuzynÍ, zdobπdü 500 dolarÛw w 20 minut." end;

	end

	if (misid==9) then
		do return "Odbierz øonÍ Don Caravaggia z zakupÛw." end;

	end

	if (misid==2) then
		do return "Przyczep do samochodÛw policyjnych urzπdzenia úledzπce." end;

	end

	if (misid==0) then
		do return "Masz 15 minut, aby zdjπÊ 16 kÛ≥ z samochodÛw rodziny Gianni." end;

	end

	if (misid==4) then
		do return "Znajdü samochÛd opancerzony Don Gianniego i ukradnij go." end;

	end

	if (misid==7) then
		do return "WrÛÊ do siedziby przed zabÛjcami Don Gianniego!" end;

	end

	if (misid==1) then
		do return "Masz 15 minut, øeby zabraÊ trzy radiowozy do kryjÛwki." end;

	end

	if (misid==6) then
		do return "Musisz pod≥oøyÊ bombÍ w domu Freda w ciπgu 5 minut!" end;

	end

	if (misid==5) then
		do return "Masz 30 minut, øeby wyeliminowaÊ Don Gianniego." end;

	end

	if (misid==10) then
		do return "Rozpraw siÍ z 25 cz≥onkami rodziny Gianni." end;

	end

	if (misid==11) then
		do return "Utrzymaj siÍ przy øyciu z policjπ i ca≥π rodzinπ Caravaggio na karku!" end;

	end

	return "";

end

function MissionStealthInfo(misid, gamemode)
	StartIntro("Sounds\\rap" .. random(1, 2) .. ".wav", "intro\\06m", nil, nil, "W niewyjaúniony sposÛb kilka samochodÛw Gianniego wybuch≥o, a kilka rozbi≥o siÍ, przez co biedaczysko ma spore k≥opoty. Wielu wiernych Don Gianniemu policjantÛw zaczÍ≥o siÍ martwiÊ, øe moøe on straciÊ kontrolÍ nad swoim terytorium. Pojawi≥y siÍ pog≥oski o m≥odych wilkach w mieúcie.  Czas poinformowaÊ rodzinÍ Gianni, kto stoi za ostatnimi wydarzeniami. Don Caravaggio chce, øebyú ukrad≥ prywatny samochÛd opancerzony Don Gianniego. Czas przejπÊ w≥adzÍ! Ten samochÛd, tak jak i ca≥e miasto, powinien byÊ w rÍkach Don Caravaggia. Czas na zmiany! Znajdü i ukradnij opancerzony samochÛd Don Gianniego i przywieü go siedziby.", 10, 10, 10);
end

function MissionInfo(misid, gamemode)
	misid=MissionRemap(misid);
	if (misid==3) then
		StartIntro("Sounds\\rap1.wav", "intro\\01m", nil, nil, "To mia≥ byÊ kolejny nudny dzieÒ za kierownicπ limuzyny, jednak szczÍúcie chyba siÍ do ciebie uúmiechnÍ≥o: masz przewieüÊ po mieúcie cz≥onkÛw rodziny Caravaggio rywalizujπcej z rodzinπ Gianni. Jeúli bÍdπ zadowoleni z twoich us≥ug i dojadπ na umÛwione spotkania bez glin na ogonie, to moøe zdobÍdziesz ich zaufanie. Do≥πczenie do rodziny Caravaggio zagwarantowa≥oby ci bezpieczeÒstwo i wiele nowych, interesujπcych zleceÒ. Prowadzπc limuzynÍ, zdobπdü 500 dolarÛw w 20 minut.", 0, 0, 100);
	end

	if (misid==9) then
		StartIntro("Sounds\\rap2.wav", "intro\\02m", nil, nil, "Dobrze ci posz≥o! Sta≥eú siÍ najbardziej zaufanym kierowcπ Don Caravaggia, ale jeszcze nie moøesz czuÊ siÍ pewnie. Teraz masz odebraÊ jego øonÍ z zakupÛw i odstawiÊ jπ do siedziby bossa.  Don Caravaggio wszÍdzie wÍszy podstÍp, wiÍc lepiej dostarcz jego øonÍ na czas i w jednym kawa≥ku!", 50, 50, 50);
	end

	if (misid==2) then
		StartIntro("Sounds\\rap1.wav", "intro\\03m", nil, nil, "To, øe masz na pieÒku z rodzinπ Gianni, czyni ciÍ idealnym wykonawcπ bardziej delikatnych, a tak naprawdÍ bardziej ryzykownych zleceÒ. Twoim zadaniem jest namierzenie kilku policjantÛw, ktÛrzy zdaniem Don Caravaggia nie pracujπ ani dla policji, ani dla rodziny Caravaggio, tylko dla Gianniego. Przyczep do bagaønikÛw samochodÛw policyjnych nadajniki, ktÛre umoøliwiπ ich úledzenie za pomocπ radaru. DziÍki tobie rodzina Caravaggio odkryje, ktÛrzy gliniarze sπ na liúcie p≥ac Don Gianniego.", 50, 50, 50);
	end

	if (misid==0) then
		StartIntro("Sounds\\rap2.wav", "intro\\05m", nil, nil, "Po Ñmi≥ejî pogawÍdce trzej policjanci wyúpiewali wszystko. Okaza≥o siÍ, øe Gianni nie oszczÍdza na ≥apÛwkach, a w jego kieszeni siedzi wiÍkszoúÊ policjantÛw w mieúcie! To by≥o do przewidzenia, w koÒcu rodzina Gianni, to najwiÍksza mafia w mieúcie i moøe sobie pozwoliÊ na takie cwaniactwa.  Don Caravaggio chcia≥by wyrÛwnaÊ trochÍ szanse, psujπc opiniÍ rodziny Gianni. Kilka wypadkÛw samochodowych, nieprzewidzianych wybuchÛw i spartolonych robÛtek powinno przylepiÊ Gianniemu ≥atkÍ idioty i niedorajdy. Masz ukraúÊ 16 kÛ≥ z samochodÛw naleøπcych do rodziny Gianni, øeby moøna by≥o nafaszerowaÊ je detonowanymi zdalnie bombami.  Na wykonanie zadania masz 15 minut.", 50, 50, 50);
	end

	if (misid==1) then
		StartIntro("Sounds\\rap2.wav", "intro\\04m", nil, nil, "Za≥oøenie nadajnikÛw szybko przynios≥o oczekiwane efekty i ujawni≥o zwiπzki policji z rodzinπ Gianni. Don Caravaggio wybra≥ trzech policjantÛw, ktÛrych trzeba ÑzaprosiÊî na rozmowÍ. Twoi wspÛ≥pracownicy zajmπ siÍ gliniarzami i wsadzπ ich do bagaønikÛw, a ty doprowadü ich samochody do siedziby rodziny, gdzie zostanπ przes≥uchani.  Przyprowadü ich w ciπgu 15 minut!", 50, 50, 50);
	end

	if (misid==4) then
		STEALTHID=1;
		MissionStealthInfo(0, 1);
	end

	if (misid==7) then
		StartIntro("Sounds\\rap1.wav", "intro\\07m", nil, nil, "Jeden z zabÛjcÛw Don Gianniego wrobi≥ ciÍ w coú, czego nie zrobi≥eú. BÍdzie prÛbowa≥ dostaÊ siÍ do Don Caravaggia przed tobπ i zakoÒczyÊ twojπ b≥yskotliwπ karierÍ. Musisz wyprzedziÊ go i dostaÊ siÍ do siedziby jako pierwszy. Czyøbyú sta≥ siÍ zbyt waøny, øeby mÛc niezauwaøenie jeüdziÊ po mieúcie?  Teraz czeka ciÍ wyúcig o øycie!", 0, 0, 0);
	end

	if (misid==6) then
		StartIntro("Sounds\\rap1.wav", "intro\\08m2", nil, nil, "Najwyraüniej draÒ, ktÛry usi≥owa≥ wrobiÊ ciÍ w jakieú úwiÒstwo, nie by≥ zwyczajnym zabÛjcπ. To krewny Don Gianniego imieniem Fredo. Poniewaø nie chcesz, øeby Don Gianni dowiedzia≥ siÍ o twoich dzia≥aniach na rzecz dojúcia rodziny Caravaggio do w≥adzy, bÍdziesz musia≥ ÑzajπÊ siÍî Fredem.  Fredo Gianni mieszka w domu z kuloodpornymi oknami, wiÍc konieczne bÍdzie podjÍcie bardziej drastycznych úrodkÛw: musisz wysadziÊ ca≥y budynek w powietrze.  Masz tylko 5 minut, aby pod≥oøyÊ uzbrojonπ bombÍ w domu Freda. Po tym czasie bomba wybuchnie. Na domiar z≥ego, gliny dosta≥y od kogoú cynk o twoim chytrym i przebieg≥ym planie.  Musisz teø jechaÊ ostroønie ó nie chcesz skoÒczyÊ, jako mokra plama w kraterze na úrodku ulicy!", 20, 20, 20);
	end

	if (misid==5) then
		StartIntro("Sounds\\rap2.wav", "intro\\10m", nil, nil, "DopÛki Don Gianni øyje, nie moøesz czuÊ siÍ bezpiecznie. Wiedzia≥eú o tym jeszcze zanim zwiπza≥eú siÍ z rodzinπ Caravaggio, ale teraz moøesz zdobyÊ prawdziwy szacunek Don Caravaggia i zapewniÊ sobie spokÛj do koÒca øycia.  Wystarczy, øeby nastÍpne 30 minut by≥o ostatnimi chwilami øycia Don Gianniego.", 20, 20, 20);
	end

	if (misid==10) then
		StartIntro("Sounds\\rap1.wav", "intro\\09m", nil, nil, "ChoÊ w czasie, kiedy by≥eú zwiπzany z rodzinπ Gianni, Fredo nie mia≥ najwyøszych notowaÒ, teraz okazuje siÍ, øe by≥ doúÊ lubiany. 25 cz≥onkÛw rodziny chce ciÍ zabiÊ za jego úmierÊ.  Lepiej znajdü ich i rozpraw siÍ z nimi, zanim oni dorwπ ciebie. Gdyby ciÍ dopadli, nie by≥by to mi≥y widok.", 20, 20, 20);
	end

	if (misid==11) then
		StartIntro("Sounds\\rap2.wav", "intro\\11bonus", nil, nil, "Don Caravaggio doszed≥ do wniosku, øe posunπ≥eú siÍ za daleko w swojej prywatnej wojnie z rodzinπ Gianni. Zosta≥eú wrogiem numer jeden wszystkich cz≥onkÛw rodziny! NiewdziÍczne bydlaki! Po tym wszystkim, co zrobi≥eú dla rodziny Caravaggio!  Okazuje siÍ jednak, øe zrobi≥eú piorunujπce wraøenie na rodzinie Gianni, albo raczej tych, ktÛrzy pozostali przy øyciu. Masz szansÍ staÊ siÍ ojcem chrzestnym tej rodziny! Czujesz na swoich plecach gorπcy oddech ca≥ej policji i rodziny Caravaggio! BÍdziesz musia≥ wykazaÊ siÍ niezwyk≥ymi umiejÍtnoúciami w kierowaniu samochodem i strzelaniu, øeby utrzymaÊ siÍ przy øyciu jako wyjÍty spod prawa.  Zatem powodzenia!", 20, 20, 20);
	end

end

function page_credits()
	menu_displayBegin(300, 353);
	menu_addMenuString("", 1, 255, 255, 255);
	menu_addMenuString("", 1, 255, 255, 255);
	menu_addMenuString(E_COPYRIGHT1, 0.5, 255, 255, 255);
	menu_addMenuString(E_COPYRIGHT2, 0.5, 255, 255, 255);
	menu_addMenuString("Programowanie", 0.6, 255, 0, 0);
	menu_addMenuString("Ilia Stepanov", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Grafika", 0.6, 255, 0, 0);
	menu_addMenuString("Ilia Stepanov", 0.5, 255, 255, 255);
	menu_addMenuString("Dmitri Lykov", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Muzyka", 0.6, 255, 0, 0);
	menu_addMenuString("Michail Kostylev", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Specjalne podziÍkowania", 0.6, 255, 0, 0);
	menu_addMenuString("Joel Breton", 0.5, 255, 255, 255);
	menu_addMenuString("Olga Breton", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.8, 255, 255, 100);
	menu_fontscale=0.8;
	menu_addMenuItem(BACK);
end

