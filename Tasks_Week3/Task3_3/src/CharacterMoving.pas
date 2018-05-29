program CharacterMoving;
uses SwinGame, sgTypes;

procedure Main();
var
	x, y, collx, colly, Crad, radius:Integer;
begin

	x := 400;
	y := 300;
	collx := 0;
	colly := 0;
	Crad := 100;
	radius := 100;

	OpenGraphicsWindow('Character Moving', 800, 600);
	LoadDefaultColors();
	repeat
	ProcessEvents();
	ClearScreen(ColorWhite);
	

	FillCircle(ColorGreen, x, y, Crad);

	RefreshScreen(60);

	//controls
	if KeyDown(vk_Right) then
	begin
		x += 1;
	end;

	if KeyDown(vk_Left) then
	begin
		x -= 1;
	end;

	if KeyDown(vk_Up) then
	begin
		y -= 1;
	end;

	if KeyDown(vk_Down) then
	begin
		y += 1;
	end;
	//controls end

	//for collisions
	if x <= radius then
	begin
		x+=2;
	end;

	if y <= radius then
	begin
		y+=2;
	end;

	collx := x + Crad;
	if collx >= ScreenWidth() then
	begin
		
		x -= 2;
		

	end;

	colly := y + Crad;
	if colly >= ScreenHeight() then
	begin
		
		y -= 2;
		

	end;
	//collision end

	
	until WindowCloseRequested();

end;


begin
	Main();
end.
