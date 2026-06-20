function indicators(x, y, health, felony, damage, visibility)
	progressbar((x + 14), (y + 10), 144, 15, health, 200, 110, 90, 150);
	progressbar((x + 14), (y + 37), 144, 15, felony, 224, 165, 69, 150);
	progressbar((x + 14), (y + 65), 144, 15, damage, 70, 130, 200, 150);
	ScrRect("GUI\\indicators", x, y, 256, 128, BLEND, 255, 255, 255, 150);

	ScrRect(format("#%d", health), (x + 88), (y + 10), 16, 16, BLEND, 0, 0, 0, 255);
	ScrRect(format("#%d", health), (x + 88), (y + 10), 16, 16, BLEND, 255, 255, 255, 255);
	
	ScrRect(format("#%d", felony), (x + 88), (y + 37), 16, 16, BLEND, 0, 0, 0, 255);
	ScrRect(format("#%d", felony), (x + 88), (y + 37), 16, 16, BLEND, 255, 255, 255, 255);
	
	ScrRect(format("#%d", damage), (x + 88), (y + 65), 16, 16, BLEND, 0, 0, 0, 255);
	ScrRect(format("#%d", damage), (x + 88), (y + 65), 16, 16, BLEND, 255, 255, 255, 255);
  
    local rating0=((mission_maxtime - mission_curtime) / mission_maxtime);
    local rating=(rating0 * 100);
	if (rating>=0) then
	progressbar((x + 14), (y + 93), 144, 15, rating, 80, 198, 53, 150);
  	ScrRect(format("#%d", rating), (x + 88), (y + 93), 16, 16, BLEND, 0, 0, 0, 255);
	ScrRect(format("#%d", rating), (x + 88), (y + 93), 16, 16, BLEND, 255, 255, 255, 255);
	end
	
  if (mission_curid>11) then
	if(health==0) then
	SetNumber (player,"health",1000)
	end
	end
	
	local v=(visibility / 100); if (v>1) then v=1; end if (v<0) then v=0; end
	ScrRect("GUI\\visibility", (x + 168), (y + 13), 32, 64, BLEND, (255 * v), (255 * (1 - v)), 0, 200);
	
	--ScrRect(format("#%d", visibility), (x + 88), (y + 93), 16, 16, BLEND, 0, 0, 0, 255);
	--ScrRect(format("#%d", visibility), (x + 88), (y + 93), 16, 16, BLEND, 255, 255, 255, 255);
	--progressbar((x + 14), (y + 93), 144, 15, visibility, 80, 198, 53, 150);
end