program Mandelbrot;
uses SwinGame, sgTypes, math;
CONST
	MAX_ITERATION = 1000;

function IterationColor(iteration: Integer):color;
var 
	hue: Double;
begin 
	if iteration >= MAX_ITERATION then
	begin
		result := ColorBlack;
	end

	else
	begin
		hue := 0.5 + (iteration / MAX_ITERATION);
		if hue > 1 then
		begin
			hue -= 1;
		end;
		result := HSBColor(hue, 0.8, 0.9);
	end;
end;

function MandelbrotColor(mbX, mbY: Double):color;
var
	xtemp, x, y: Double;
	iteration: Integer;
begin
	x := mbX;
	y := mbY;
	iteration := 0;

	While(power(x,2) + power(y,2) <= 4) AND (iteration < MAX_ITERATION) Do
	begin	
		xtemp := power(x,2) - power(y,2) + mbX;
		y := 2 * x * y + mbY;
		x := xtemp;
		iteration += 1;
	end;
	result := IterationColor(iteration);
end;

procedure DrawMandelbrot(startMbX, startMbY, mbWidth, mbHeight: Double);
var
	scaleWidth, scaleHeight: Double;
	x, y: Integer;
	mx, my: Double;
	mbColor: Color;
begin
	scaleWidth := mbWidth / ScreenWidth();
	scaleHeight := mbHeight / ScreenHeight();
	x := 0;

	While x < ScreenWidth() Do
	begin
		y := 0;
	
		While y < ScreenHeight() Do
		begin
			mx := startMbX + x * scaleWidth;
			my := startMbY + y * scaleHeight;
			mbColor := MandelbrotColor(mx, my);
			DrawPixel(mbColor, x, y);
			y += 1;
		end;
	    
		x += 1;   
	end;
end;



procedure Main();
var
	startMbX, startMbY: Double;
	newStartMbx, newstartMbY: Double;
	mbWidth, mbHeight: Double;
	newmbWidth, newmbHeight: Double;
	scaleWidth, scaleHeight: Double;
begin
	OpenGraphicsWindow('Mandelbrot set', 800, 600);
	LoadDefaultColors();
	
	startMbX := -2.5;
	startMbY := -1.5;
	mbWidth := 4;
	mbHeight := 3;
	scaleWidth := mbWidth / ScreenWidth();
	scaleHeight := mbHeight / ScreenHeight();

	DrawMandelbrot(startMbX, startMbY, mbWidth, mbHeight);
	
	repeat
		ProcessEvents();

 		

		if MouseClicked(LeftButton) OR MouseDown(WheelUpButton) then
		begin
			
			//setting new widht/height
			newmbWidth := mbWidth / 2;
			newmbHeight := mbHeight / 2;

		
			
			newStartMbx := startMbX + (MouseX() / ScreenWidth() * mbWidth) - newMbWidth / 2;
			newstartMbY := startMbY + (MouseY() / ScreenHeight() * mbHeight) - newmbHeight / 2;
			
			//setting values
			mbWidth := newmbWidth;
			mbHeight := newmbHeight;
			startMbx := newstartMbx;
			startMby := newstartMbY;

			DrawMandelbrot(startMbX, startMbY, mbWidth, mbHeight);

		end;

		if MouseClicked(RightButton) OR MouseDown(WheelDownButton) then
		begin
			newmbWidth := mbWidth * 2;
			newmbHeight := mbHeight * 2;


			newStartMbx := startMbX + (MouseX() / ScreenWidth() * mbWidth) - newMbWidth / 2;
			newstartMbY := startMbY + (MouseY() / ScreenHeight() * mbHeight) - newmbHeight / 2;


			mbWidth := newmbWidth;
			mbHeight := newmbHeight;
			startMbx := newstartMbx;
			startMby := newstartMbY;

			DrawMandelbrot(startMbX, startMbY, mbWidth, mbHeight);
		end;

       
        RefreshScreen();
    until WindowCloseRequested();

end;


begin
	Main();
end.
