BLOOD=1;
QUIT_YES=84;
QUIT_NO=78;
LOGOTEXTURE="GUI\\plogo";
LOGOTEXTURE1="GUI\\nlogo1";
E_COPYRIGHT1="\\I2006 (c) Wszelkie prawa zastrze¿one\\i";
E_COPYRIGHT2="\\IKozmogames Inc. - www.kozmogames.com\\i";
MENU_NOTAVAILABLE="Opcja niedostêpna w wersji demo";
MENU_YES="Tak";
MENU_NO="Nie";
MENU_HIGH="Wysokie";
MENU_MED="rednie";
MENU_LOW="Niskie";
MENU_APPLY="Akceptuj";
MENU_DETAIL="Szczegó³y:";
MENU_VIDEO="Ekran";
MENU_FULLSCREEN="Pe³ny ekran:";
SCANNING="Skanowanie";
RAMTHATCAR="Staranuj go!";
CONTROL_FORWARD="Do przodu";
CONTROL_BACKWARD="Do ty³u";
CONTROL_TURNLEFT="Skrêæ w lewo";
CONTROL_TURNRIGHT="Skrêæ w prawo";
CONTROL_HANDBRAKE="Hamulec rêczny";
CONTROL_FIRE="Strza³/walka";
CONTROL_ACTION="Akcja";
CONTROL_BRIBE="£apówka";
CONTROL_ENGINE="Uruchom silnik";
MENU_CONTROLS="Sterowanie";
CONTROL_FPS="Kamera";
CONTROL_MAP="Zbli¿enie mapy";
CONTROL_ILLUMINATION="Reflektory";
BACK="Wróæ";
ABOUT="Twórcy";
BONUSMISSION="Bonus";
MISSION="Misja ";
BESTRATING="Najlepsze wyniki:";
STEALTHMODE="Tryb kradzie¿y";
STORYMODE="Tryb fabu³y";
SGAMMA="Gamma";
SMUSIC="Muzyka";
SSOUND="Dwiêk";
LAUNCH="Uruchom";
MARKERINSTALLED="Zainstalowano %d z 5 nadajników!";
RATINGBEST=" % - najlepszy! ";
MISSIONCOMPLETE=" Misja zakoñczona sukcesem! ";
YOURRATING="Twój wynik:";
ONEMORECARLEFT="Potrzebny jeszcze jeden samochód! Szybciej!";
COOL="wietnie!";
COOLFIRSTCAR="wietnie! Oto pierwszy samochód";
LEAVECAR="Opuæ samochód";
MISSIONFAILED="Misja nieudana!";
BUSTED="Zosta³e z³apany!";
KILLS=" %d z 30! ";
DOUBLEKILL="Podwójne morderstwo!";
STOLENCAR="Uwa¿aj! Policja szuka tego samochodu! ";
HELP0="Nacinij 'E', by uruchomiæ silnik";
HELP1="Nacinij 'ENTER', by wsi¹æ do samochodu";
HELP2="Nacinij 'ENTER', by zainstalowaæ wskanik radiowy";
HELP3="Nacinij 'ENTER', by usun¹æ ko³o ";
HELP4="Nacinij 'ENTER', by schowaæ ko³o w baga¿niku";
HELP5="Nacinij 'B', by daæ ³apówkê";
HELP6="Nacinij 'E', by wy³¹czyæ alarm,";
HELP6A="jeli kierowca go w³¹czy³";
HELP7="Nacinij 'Enter', by opuciæ samochód";
PRESSENTER="Nacinij 'ENTER'";
SSTARTENGINE="Rozruch...";
SDISALARM="Wy³¹czanie alarmu...";
DISALARMFAILED="Nie mo¿na wy³¹czyæ alarmu";
DISALARMED="Alarm zosta³ wy³¹czony";
SREMOVEWHEEL="Usuwanie...";
SUSEPICKLOCK="Otwieranie...";
SPUTMARKER="Instalowanie nadajnika...";
COOLFIRSTCAR="wietnie! Pierwsza fura! ";
GREATONEMORECAR="Super! Jeszcze jeden! ";
NOTENOUGHMONEY="Nie masz wystarczaj¹cej iloci pieniêdzy!";
OUTOFFUEL="Koñczy ci siê benzyna!";
QUIT2MMENU="Wyjæ do menu g³ównego? (T/N)";
LOADING="Wczytywanie...";
CLIP="Zdoby³e magazynek";
HUNDRED="Zdoby³e $100";
ADDUZI="Zdoby³e UZI";
ADDPISTOL="Zdoby³e pistolet";
FIRSTKIT="Zdoby³e apteczkê";
HEALTH="Zdrowie";
FELONY="Poziom przestêpczoci";
DAMAGE="Zniszczenia";
NEWGAME="Nowa gra";
CONTINUEGAME="Kontynuuj";
OPTIONS="Opcje";
QUIT="Wyjcie";
OUTOFLEVEL="Powróæ do miasta!";
PRESSBACKSPACE="Nacinij BACKSPACE, by przewróciæ samochód";
PUTMARKER="WSKANIK MIEJSCA";
BRIBE="£APÓWKA";
HIDE="CHOWAJ";
OPENDOOR="OTWÓRZ DRZWI";
CLOSEDOOR="ZAMKNIJ DRZWI";
GETOUT="WYSI¥D";
TOGGLEILLUM="REFLEKTORY";
TOGGLESIREN="KLAKSON";
STARTENGINE="START";
MUFFLEENGINE="T£UMIK";
CANTSTART=" Nie mogê uruchomiæ silnika";
TAXI="TAXI!! ";
GETIN="WSIADAJ";
REMOVEWHEEL="USUÑ SAMOCHÓD";
LOADWHEEL="ZA£ADUJ KO£O DO CIÊ¯ARÓWKI";
DOORLOCKED="Drzwi s¹ zamkniête";
DOORUNLOCKED="Drzwi s¹ otwarte";
WHEELCOUNT="Liczba za³adowanych kó³: %d";
WHEELLOADED="Ko³o zosta³o za³adowane";
FIRSTCOPCAR="wietnie! Pierwszy samochód dostarczony!";
SECONDCOPCAR="Znakomicie! Zosta³ jeszcze jeden";
FINISHRACE="META!";
STARTRACEGO="START!!";
function MissionShortInfo(misid, gamemode)
	misid=MissionRemap(misid);
	if (misid==3) then
		do return "Prowadz¹c limuzynê, zdob¹d 500 dolarów w 20 minut." end;

	end

	if (misid==9) then
		do return "Odbierz ¿onê Don Caravaggia z zakupów." end;

	end

	if (misid==2) then
		do return "Przyczep do samochodów policyjnych urz¹dzenia ledz¹ce." end;

	end

	if (misid==0) then
		do return "Masz 15 minut, aby zdj¹æ 16 kó³ z samochodów rodziny Gianni." end;

	end

	if (misid==4) then
		do return "Znajd samochód opancerzony Don Gianniego i ukradnij go." end;

	end

	if (misid==7) then
		do return "Wróæ do siedziby przed zabójcami Don Gianniego!" end;

	end

	if (misid==1) then
		do return "Masz 15 minut, ¿eby zabraæ trzy radiowozy do kryjówki." end;

	end

	if (misid==6) then
		do return "Musisz pod³o¿yæ bombê w domu Freda w ci¹gu 5 minut!" end;

	end

	if (misid==5) then
		do return "Masz 30 minut, ¿eby wyeliminowaæ Don Gianniego." end;

	end

	if (misid==10) then
		do return "Rozpraw siê z 25 cz³onkami rodziny Gianni." end;

	end

	if (misid==11) then
		do return "Utrzymaj siê przy ¿yciu z policj¹ i ca³¹ rodzin¹ Caravaggio na karku!" end;

	end

	return "";

end

function MissionStealthInfo(misid, gamemode)
	StartIntro("Sounds\\rap" .. random(1, 2) .. ".wav", "intro\\06m", nil, nil, "W niewyjaniony sposób kilka samochodów Gianniego wybuch³o, a kilka rozbi³o siê, przez co biedaczysko ma spore k³opoty. Wielu wiernych Don Gianniemu policjantów zaczê³o siê martwiæ, ¿e mo¿e on straciæ kontrolê nad swoim terytorium. Pojawi³y siê pog³oski o m³odych wilkach w miecie.  Czas poinformowaæ rodzinê Gianni, kto stoi za ostatnimi wydarzeniami. Don Caravaggio chce, ¿eby ukrad³ prywatny samochód opancerzony Don Gianniego. Czas przej¹æ w³adzê! Ten samochód, tak jak i ca³e miasto, powinien byæ w rêkach Don Caravaggia. Czas na zmiany! Znajd i ukradnij opancerzony samochód Don Gianniego i przywie go siedziby.", 10, 10, 10);
end

function MissionInfo(misid, gamemode)
	misid=MissionRemap(misid);
	if (misid==3) then
		StartIntro("Sounds\\rap1.wav", "intro\\01m", nil, nil, "To mia³ byæ kolejny nudny dzieñ za kierownic¹ limuzyny, jednak szczêcie chyba siê do ciebie umiechnê³o: masz przewieæ po miecie cz³onków rodziny Caravaggio rywalizuj¹cej z rodzin¹ Gianni. Jeli bêd¹ zadowoleni z twoich us³ug i dojad¹ na umówione spotkania bez glin na ogonie, to mo¿e zdobêdziesz ich zaufanie. Do³¹czenie do rodziny Caravaggio zagwarantowa³oby ci bezpieczeñstwo i wiele nowych, interesuj¹cych zleceñ. Prowadz¹c limuzynê, zdob¹d 500 dolarów w 20 minut.", 0, 0, 100);
	end

	if (misid==9) then
		StartIntro("Sounds\\rap2.wav", "intro\\02m", nil, nil, "Dobrze ci posz³o! Sta³e siê najbardziej zaufanym kierowc¹ Don Caravaggia, ale jeszcze nie mo¿esz czuæ siê pewnie. Teraz masz odebraæ jego ¿onê z zakupów i odstawiæ j¹ do siedziby bossa.  Don Caravaggio wszêdzie wêszy podstêp, wiêc lepiej dostarcz jego ¿onê na czas i w jednym kawa³ku!", 50, 50, 50);
	end

	if (misid==2) then
		StartIntro("Sounds\\rap1.wav", "intro\\03m", nil, nil, "To, ¿e masz na pieñku z rodzin¹ Gianni, czyni ciê idealnym wykonawc¹ bardziej delikatnych, a tak naprawdê bardziej ryzykownych zleceñ. Twoim zadaniem jest namierzenie kilku policjantów, którzy zdaniem Don Caravaggia nie pracuj¹ ani dla policji, ani dla rodziny Caravaggio, tylko dla Gianniego. Przyczep do baga¿ników samochodów policyjnych nadajniki, które umo¿liwi¹ ich ledzenie za pomoc¹ radaru. Dziêki tobie rodzina Caravaggio odkryje, którzy gliniarze s¹ na licie p³ac Don Gianniego.", 50, 50, 50);
	end

	if (misid==0) then
		StartIntro("Sounds\\rap2.wav", "intro\\05m", nil, nil, "Po mi³ej pogawêdce trzej policjanci wypiewali wszystko. Okaza³o siê, ¿e Gianni nie oszczêdza na ³apówkach, a w jego kieszeni siedzi wiêkszoæ policjantów w miecie! To by³o do przewidzenia, w koñcu rodzina Gianni, to najwiêksza mafia w miecie i mo¿e sobie pozwoliæ na takie cwaniactwa.  Don Caravaggio chcia³by wyrównaæ trochê szanse, psuj¹c opiniê rodziny Gianni. Kilka wypadków samochodowych, nieprzewidzianych wybuchów i spartolonych robótek powinno przylepiæ Gianniemu ³atkê idioty i niedorajdy. Masz ukraæ 16 kó³ z samochodów nale¿¹cych do rodziny Gianni, ¿eby mo¿na by³o nafaszerowaæ je detonowanymi zdalnie bombami.  Na wykonanie zadania masz 15 minut.", 50, 50, 50);
	end

	if (misid==1) then
		StartIntro("Sounds\\rap2.wav", "intro\\04m", nil, nil, "Za³o¿enie nadajników szybko przynios³o oczekiwane efekty i ujawni³o zwi¹zki policji z rodzin¹ Gianni. Don Caravaggio wybra³ trzech policjantów, których trzeba zaprosiæ na rozmowê. Twoi wspó³pracownicy zajm¹ siê gliniarzami i wsadz¹ ich do baga¿ników, a ty doprowad ich samochody do siedziby rodziny, gdzie zostan¹ przes³uchani.  Przyprowad ich w ci¹gu 15 minut!", 50, 50, 50);
	end

	if (misid==4) then
		STEALTHID=1;
		MissionStealthInfo(0, 1);
	end

	if (misid==7) then
		StartIntro("Sounds\\rap1.wav", "intro\\07m", nil, nil, "Jeden z zabójców Don Gianniego wrobi³ ciê w co, czego nie zrobi³e. Bêdzie próbowa³ dostaæ siê do Don Caravaggia przed tob¹ i zakoñczyæ twoj¹ b³yskotliw¹ karierê. Musisz wyprzedziæ go i dostaæ siê do siedziby jako pierwszy. Czy¿by sta³ siê zbyt wa¿ny, ¿eby móc niezauwa¿enie jedziæ po miecie?  Teraz czeka ciê wycig o ¿ycie!", 0, 0, 0);
	end

	if (misid==6) then
		StartIntro("Sounds\\rap1.wav", "intro\\08m2", nil, nil, "Najwyraniej drañ, który usi³owa³ wrobiæ ciê w jakie wiñstwo, nie by³ zwyczajnym zabójc¹. To krewny Don Gianniego imieniem Fredo. Poniewa¿ nie chcesz, ¿eby Don Gianni dowiedzia³ siê o twoich dzia³aniach na rzecz dojcia rodziny Caravaggio do w³adzy, bêdziesz musia³ zaj¹æ siê Fredem.  Fredo Gianni mieszka w domu z kuloodpornymi oknami, wiêc konieczne bêdzie podjêcie bardziej drastycznych rodków: musisz wysadziæ ca³y budynek w powietrze.  Masz tylko 5 minut, aby pod³o¿yæ uzbrojon¹ bombê w domu Freda. Po tym czasie bomba wybuchnie. Na domiar z³ego, gliny dosta³y od kogo cynk o twoim chytrym i przebieg³ym planie.  Musisz te¿ jechaæ ostro¿nie  nie chcesz skoñczyæ, jako mokra plama w kraterze na rodku ulicy!", 20, 20, 20);
	end

	if (misid==5) then
		StartIntro("Sounds\\rap2.wav", "intro\\10m", nil, nil, "Dopóki Don Gianni ¿yje, nie mo¿esz czuæ siê bezpiecznie. Wiedzia³e o tym jeszcze zanim zwi¹za³e siê z rodzin¹ Caravaggio, ale teraz mo¿esz zdobyæ prawdziwy szacunek Don Caravaggia i zapewniæ sobie spokój do koñca ¿ycia.  Wystarczy, ¿eby nastêpne 30 minut by³o ostatnimi chwilami ¿ycia Don Gianniego.", 20, 20, 20);
	end

	if (misid==10) then
		StartIntro("Sounds\\rap1.wav", "intro\\09m", nil, nil, "Choæ w czasie, kiedy by³e zwi¹zany z rodzin¹ Gianni, Fredo nie mia³ najwy¿szych notowañ, teraz okazuje siê, ¿e by³ doæ lubiany. 25 cz³onków rodziny chce ciê zabiæ za jego mieræ.  Lepiej znajd ich i rozpraw siê z nimi, zanim oni dorw¹ ciebie. Gdyby ciê dopadli, nie by³by to mi³y widok.", 20, 20, 20);
	end

	if (misid==11) then
		StartIntro("Sounds\\rap2.wav", "intro\\11bonus", nil, nil, "Don Caravaggio doszed³ do wniosku, ¿e posun¹³e siê za daleko w swojej prywatnej wojnie z rodzin¹ Gianni. Zosta³e wrogiem numer jeden wszystkich cz³onków rodziny! Niewdziêczne bydlaki! Po tym wszystkim, co zrobi³e dla rodziny Caravaggio!  Okazuje siê jednak, ¿e zrobi³e piorunuj¹ce wra¿enie na rodzinie Gianni, albo raczej tych, którzy pozostali przy ¿yciu. Masz szansê staæ siê ojcem chrzestnym tej rodziny! Czujesz na swoich plecach gor¹cy oddech ca³ej policji i rodziny Caravaggio! Bêdziesz musia³ wykazaæ siê niezwyk³ymi umiejêtnociami w kierowaniu samochodem i strzelaniu, ¿eby utrzymaæ siê przy ¿yciu jako wyjêty spod prawa.  Zatem powodzenia!", 20, 20, 20);
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
	menu_addMenuString("Specjalne podziêkowania", 0.6, 255, 0, 0);
	menu_addMenuString("Joel Breton", 0.5, 255, 255, 255);
	menu_addMenuString("Olga Breton", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.8, 255, 255, 100);
	menu_fontscale=0.8;
	menu_addMenuItem(BACK);
end

