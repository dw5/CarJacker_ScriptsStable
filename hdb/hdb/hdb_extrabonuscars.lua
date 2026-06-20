if (mission_curid==11) then
SetRenderable(FindObject("Water"), 1);
Water("enable");
SetSetting("TrafficDensity", "300");

		id=InsertObject("models\\rgirl", 496662,5381,392840);
		--SetVector(id, "target",  496519, 5188, 407490);
		SetUpdateFunction(id, "chinamafiose"); --medic etc = nothing :c
		SetRoadNetwork(id, roadnetwork);
		--SetClipFactor(id, 40);
		GenNormals(id, 1);

		id=InsertObject("models\\bus", (493018.40625), (5234.857421875), (408619.84375)); -- bus :)
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		--SetDriver(id, player, roadnetwork);
		--Cmd(player, "StartEngine");
		
		--local cmd=format("spawn %d %d %d 1", 371887,4047,401271);
		--Cmd(player, cmd);--
		
		--CreatePlayer(496519, (5015 + 250), (407990 - 500), roadnetwork);--

		id=InsertObject("models\\concept5", (496256), (5188), (407518)); -- concept 3 purple one
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		id=InsertObject("models\\concept4", (495904), (5188), (407646)); -- concept6 blue viper --
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		
		id=InsertObject("models\\concept", (497142), (5154), (409650)); -- porty "19th century taxi" --
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		
		id=InsertObject("models\\concept2", (496256), (5154), (409562));  -- porty "SPY" --
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		
		id=InsertObject("models\\universal", (495884), (5154), (410450));  -- porty --
		SetNumber(id, "playerhavekey", 1);
		GenNormals(id, 1);
		Cmd(id, "defmaxspd 60");
		
		id=InsertObject("models\\pikap", (497151), (5188), (408006)); -- SCUMBAG the CAR --
		SetNumber(id, "playerhavekey", 1);
		Cmd(id, "skin 1");
		Cmd(id, "defmaxspd 70");
		Cmd(id, "lock2surface 1");
		SetClipFactor(id, 70);
		GenNormals(id, 1);
end
print("HDB: bonus car done");