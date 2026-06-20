if (mission_curid==11) then
TrafficEnd();
			TrafficBegin();
			print("Traffic: mission_curid = ", mission_curid);
			TrafficNetwork(roadnetwork);

			TrafficMember(1, "models\\concept5", "chinamafiose"); --teen is bad idea--
			TrafficMember(1, "blackguy_with_bat"); --aka undercover cop--
			
			if (0==1) then
				
			TrafficMember(100, "bom1");
				TrafficMember(20, "bom2");
				TrafficMember(20, "bom3");
				TrafficMember(200, "girl1");
				TrafficMember(20, "girl2");
			end
			
			TrafficEnd();
			print(" I DID THE THING ");
end