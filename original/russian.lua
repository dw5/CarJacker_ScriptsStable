RAMTHATCAR="Тарань!";
CONTROL_FORWARD="Вперед";
CONTROL_BACKWARD="Назад";
CONTROL_TURNLEFT="Налево";
CONTROL_TURNRIGHT="Направо";
CONTROL_HANDBRAKE="Ручной тормоз";
CONTROL_FIRE="Выстрел";
CONTROL_ACTION="Действие";
CONTROL_BRIBE="Взятка";
CONTROL_ENGINE="Двигатель";
CONTROL_FPS="Вид из глаз";
CONTROL_MAP="Масштаб";
CONTROL_ILLUMINATION="Фары";
MENU_CONTROLS="Управление";
LOGOTEXTURE="GUI\\logorus";
LOGOTEXTURE1="GUI\\logorus1";
PROGRAMMING="Программирование";
ILIASTEPANOV="Илья Степанов";
GRAPHICS="Графика";
DMITRILYKOV="Дмитрий Лыков";
BACK="Назад";
BONUSMISSION="Бонус";
MISSION="Миссия ";
STEALTHMODE="Угон";
STORYMODE="Миссии";
BESTRATING="Лучший рейтинг: ";
SGAMMA="Гамма";
SMUSIC="Музыка";
SSOUND="Звук";
MARKERINSTALLED="Жучок [%d из 5] установлен!";
RATINGBEST="% - лучший!";
MISSIONCOMPLETE="Миссия успешно выполнена!";
YOURRATING="Твой рейтинг: ";
ONEMORECARLEFT="Еще одна машина осталась! Поторопись!";
LAUNCH="Угнать!";
COOL="Отлично!";
COOLFIRSTCAR="Отлично! Первая машина!";
LEAVECAR="Поставь машину на место!";
MISSIONFAILED="Миссия провалена!";
BUSTED="Teбя заметила полиция!";
KILLS="%d из 30!";
DOUBLEKILL="Двойное убийство!";
STOLENCAR="Внимание! Полиция разыскивает эту машину!";
HELP0="Держи 'E' для запуска двигателя";
HELP1="Нажми 'ENTER' чтобы сесть в машину";
HELP2="Держи 'ENTER' для установки маячка";
HELP3="Держи 'ENTER' чтобы скрутить колесо";
HELP4="Нажми 'ENTER' чтобы погрузить колесо";
HELP5="Нажми 'B' для того чтобы дать взятку";
HELP6="Для того чтобы определить код, держи 'E'";
HELP6A="во время включения или отключения сигнализации";
HELP7="Нажми 'ENTER' для того чтобы вылезти из машины";
PRESSENTER="Нажми ENTER";
SSTARTENGINE="Завожу...";
SDISALARM="Отключение сигнализации...";
DISALARMFAILED="Не могу отключить сигнализацию!";
DISALARMED="Сигнализация отключена!";
SREMOVEWHEEL="Cнимаю колесо...";
SUSEPICKLOCK="Вскрываю авто...";
SPUTMARKER="Установка жучка...";
COOLFIRSTCAR="Отлично! Первая ласточка!";
GREATONEMORECAR="Отлично! Ты пригнал еще одну машину!";
NOTENOUGHMONEY="У тебя нет столько денег!";
OUTOFFUEL="У тебя закончился бензин!";
QUIT2MMENU="Выйти в главное меню ? (Yes/No)";
LOADING="Загрузка...";
CLIP="Ты подобрал обойму патронов";
HUNDRED="Ты подобрал 100$";
ADDUZI="Ты подобрал узи";
ADDPISTOL="Ты подобрал пистолет";
FIRSTKIT="Ты подобрал аптечку";
HEALTH="Жизнь";
FELONY="Розыск";
DAMAGE="Повреждения";
NEWGAME="Новая игра";
CONTINUEGAME="Продолжить";
ABOUT="Авторы";
OPTIONS="Опции";
QUIT="Выход";
OUTOFLEVEL="Вернись обратно в город!";
PRESSBACKSPACE="Нажми BACKSPACE чтобы перевернуть машину";
PUTMARKER="ПОСТАВИТЬ ЖУЧОК";
BRIBE="ДАТЬ ВЗЯТКУ";
HIDE="СПРЯТАТЬСЯ";
OPENDOOR="ОТКРЫТЬ ДВЕРЬ";
CLOSEDOOR="ЗАКРЫТЬ ДВЕРЬ";
GETOUT="ВЫЛЕЗТИ";
TOGGLEILLUM="ВКЛ\\ВЫКЛ ФАРЫ";
TOGGLESIREN="ВКЛ\\ВЫКЛ СИРЕНУ";
STARTENGINE="ЗАВЕСТИ";
MUFFLEENGINE="ЗАГЛУШИТЬ";
CANTSTART="Не могу завести";
TAXI="ТАКСИ!!";
GETIN="ВЛЕЗТЬ";
REMOVEWHEEL="СНЯТЬ КОЛЕСО";
LOADWHEEL="ЗАГРУЗИТЬ КОЛЕСО";
DOORLOCKED="Дверь закрыта";
DOORUNLOCKED="Дверь открыта";
WHEELCOUNT="Всего загружено колес: %d";
WHEELLOADED="Колесо загружено";
E_COPYRIGHT1="\\I2004 (c) Все права защищены.\\i";
E_COPYRIGHT2="\\IKozmogames Inc. - www.kozmogames.com\\i";
E_COPYRIGHT3="\\INew Media Generation - www.nmg.ru\\i";
function MissionShortInfo(misid, gamemode)
	misid=MissionRemap(misid);
	if (misid==3) then
		do return "Заработать 350$ работая таксистом" end;

	end

	if (misid==9) then
		do return "Доставить китайца в Чайна Таун." end;

	end

	if (misid==2) then
		do return "Установить жучки на полицейские машины" end;

	end

	if (misid==0) then
		do return "Снять 16 колес с припаркованных автомобилей" end;

	end

	if (misid==4) then
		do return "Найти и угнать спортивный автомобиль" end;

	end

	if (misid==7) then
		do return "Выиграть гоночный заезд у китаянки" end;

	end

	if (misid==1) then
		do return "Угнать 3 полицейских машины" end;

	end

	if (misid==6) then
		do return "Доставить пикап до пункта назначения" end;

	end

	if (misid==5) then
		do return "Наказать убийцу дочери босса мафии" end;

	end

	if (misid==10) then
		do return "Уничтожить конкурирующую группировку" end;

	end

	if (misid==11) then
		do return "Бонус: Свободная миссия" end;

	end

	return "";

end

function MissionInfo(misid, gamemode)
	misid=MissionRemap(misid);
	if (misid==3) then
		StartIntro("Sounds\\rap1.wav", "intro\\taxi", "intro\\slippy", nil, "Ты начинаешь игру простым таксистом. Тебе нужно заработать 350$ за 15 мин. Чем быстрее ты заработаешь эти деньги, тем выше будет твой рейтинг. Пользуйся заправками, ведь машине нужен бензин. Не нарушай правила и лучше держись подальше от копов.", 0, 0, 100);
	end

	if (misid==9) then
		StartIntro("Sounds\\rap2.wav", "intro\\chinatown", "intro\\slippy", "intro\\mob", "В конце рабочего дня, ты как обычно, уставший, возвращался домой. Неожиданно тебе проголосовал хорошо одетый плотный китаец. Разговорившись он предложил тебе работу водителем и по совместительству телохранителем. На следующий день тебе нужно забрать его от кладбища и доставить целым и невредимым обратно в Чайна Таун.", 50, 50, 50);
	end

	if (misid==2) then
		StartIntro("Sounds\\rap1.wav", "intro\\bar", "intro\\slippy", "intro\\mob2", "После того как ты спас жизнь этому китайцу пришлось поговорить начистоту. Все просто китаец оказался боссом  мафии, и теперь ты часть их клана. Вот тебе задание. У тебя есть 15 мин чтобы установить 5 жучков на полицейские машины. Тебе нужно искать машины только с водителем. Устанавливай жучки около багажника, и следи за тем чтобы водитель тебя не заметил. В дальнейшем эти жучки помогут прохождению всей игры, т.к. ты сможешь отслеживать перемещение полиции на своем радаре. Для перемещения по городу воспользуйся машиной.", 50, 50, 50);
	end

	if (misid==0) then
		StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy", "intro\\mob", "Китайская мафия занимается угонами. Тебя решили проверить на пригодность. Задание очень простое, но тебе надо действовать аккуратно. Если полиция тебя заметит, миссия будет провалена. У тебя есть 15 мин чтобы снять 16 колес с любых припаркованных машин. Используй для этого балонный ключ (клавиша 3). Грузи все колеса в грузовичек. После того как закончишь - возвращайся в ангар.", 50, 50, 50);
	end

	if (misid==4) then
		STEALTHID=1;
		MissionStealthInfo(0, 1);
	end

	if (misid==7) then
		StartIntro("Sounds\\rap1.wav", "intro\\race", "intro\\slippy", nil, "Когда ты перегонял машину, на светофоре ты увидел девушку. Она была явно настроена погонять на авто и ее машина была как раз под стать твоей только что угнаной тачке. Твоя задача выиграть заезд у этой китаянки, тем более тебе тоже нужно в Чайна Таун.", 0, 0, 0);
	end

	if (misid==1) then
		StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy", "intro\\mob", "Мафиози понадобились полицейские машины. У тебя есть 15 мин чтобы угнать 3 полицейские машины. Ищи припаркованные машины. Помни что даже небольшое нарушение может провалить все задание, так что будь аккуратен. Перегоняй автомобили в ангар, который отмечен на твоей карте.", 50, 50, 50);
	end

	if (misid==6) then
		StartIntro("Sounds\\rap1.wav", "intro\\van", "intro\\slippy", "intro\\mob", "Тебе нужно доставить этот пикап до пункта назначения целым и невредимым. У тебя есть всего 5 мин. Только одна проблема - тебе нельзя попадаться копам в патрульных машинах на глаза. Все дело в том что в этом пикапе находится товар и полиция ищет именно эту машину.", 20, 20, 20);
	end

	if (misid==5) then
		StartIntro("Sounds\\rap2.wav", "intro\\dead_girl", "intro\\slippy", nil, "Китаянка оказалась дочерью босса, но случилось страшное!  Ее зверски убили. Через несколько дней тебе удалось выйти на след того подонка, который управлял грузовиком, переехавшим дочку босса. Он оказался боссом конкурирующей группировки. Догнать и убить - вот твоя задача.", 20, 20, 20);
	end

	if (misid==10) then
		StartIntro("Sounds\\rap1.wav", "intro\\slum", "intro\\slippy2", "intro\\braker", "Для того чтобы довершить начатое, тебе нужно уничтожить все вражескую группировку. Ищи их прямо на улице. Их всего 30 человек. Месть будет жестокой, но справедливой.", 20, 20, 20);
	end

	if (misid==11) then
		StartIntro("Sounds\\rap2.wav", "intro\\bar", "intro\\slippy1", "intro\\mob3", "Поздравляю! Ты успешно уничтожил конкурирующую группировку. Город полностью в твоем распоряжении. Босс мафиози подарил тебе несколько машин, в добавок к тем, что ты уже угнал. Они полностью в твоем распоряжении. Теперь тебе не надо никуда спешить.", 20, 20, 20);
	end

end

function MissionStealthInfo(misid, gamemode)
	StartIntro("Sounds\\rap" .. random(1, 2) .. ".wav", StealthArg(1), "intro\\slippy", nil, "Тебе нужно найти и угнать эту машину и после этого доставить ее на автосвалку. Найти ее будет не так просто, но на карте отмечена желтая область где видели эту машину. Используй клавишу M для смены масштаба карты. Когда найдешь ее используй сканер кода сигнализации (клавиша E) для вычисления кода сигнализации. Используй отмычку - подойди вплотную к двери и удерживай клавишу ENTER.  Избегай полиции.", 10, 10, 10);
end

function page_credits()
	menu_displayBegin(300, 353);
	menu_addMenuString("Авторы", 1, 255, 255, 255);
	menu_addMenuString(E_COPYRIGHT1, 0.5, 255, 255, 255);
	menu_addMenuString(E_COPYRIGHT2, 0.5, 255, 255, 255);
	menu_addMenuString(E_COPYRIGHT3, 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 255);
	menu_addMenuString("Программирование", 0.6, 255, 0, 0);
	menu_addMenuString("Илья Степанов", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Графика", 0.6, 255, 0, 0);
	menu_addMenuString("Илья Степанов", 0.5, 255, 255, 255);
	menu_addMenuString("Дмитрий Лыков", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Музыка", 0.6, 255, 0, 0);
	menu_addMenuString("Михаил Костылев", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.3, 255, 255, 100);
	menu_addMenuString("Отдельное спасибо", 0.6, 255, 0, 0);
	menu_addMenuString("Джоэл Бретон", 0.5, 255, 255, 255);
	menu_addMenuString("Ольга Бретон", 0.5, 255, 255, 255);
	menu_addMenuString("", 0.8, 255, 255, 100);
	menu_fontscale=0.8;
	menu_addMenuItem(BACK);
end

