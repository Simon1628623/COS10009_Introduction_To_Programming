program PictureDrawing;
uses SwinGame, sgTypes;

begin

	OpenGraphicsWindow('xp', 800, 600);

	ClearScreen(ColorBlue);

	//FillRectangle(ColorBlue, 0, 0, 800, 600);

	//clouds
	FillEllipse (ColorWhite, 700, 100, 100, 60);
	FillEllipse (ColorWhite, 500, 220, 77, 44);
	FillEllipse (ColorWhite, 600, 250, 50, 10);
	FillEllipse (ColorWhite, 400, 150, 100, 60);
	FillEllipse (ColorWhite, 200, 300, 60, 20);
	FillEllipse (ColorWhite, 350, 250, 50, 35);
	FillEllipse (ColorWhite, 150, 40, 250, 77);
	FillEllipse (ColorWhite, 100, 140, 150, 90);
	FillEllipse (ColorWhite, -30, -30, 100, 60);
	FillEllipse (ColorWhite, 600, -40, 250, 77);


	
	//mountains
	FillEllipse (ColorGreen, -200, 300, 1200, 600);

	FillEllipse (ColorGreen, 300, 300, 1200, 600);

	
	//internet tab
	FillRectangle(ColorWhite, 150, 100, 500, 350);
	FillRectangle(ColorSkyBlue, 150, 100, 500, 50);
	FillRectangle(ColorWhite, 170, 110, 350, 35);

	DrawHorizontalLineOnScreen(ColorBlack, 150, 150, 650);

	DrawHorizontalLineOnScreen(ColorBlack, 100, 150, 650);
	DrawHorizontalLineOnScreen(ColorBlack, 100, 500, 650);

	DrawVerticalLineOnScreen(ColorBlack, 150, 100, 450);
	DrawVerticalLineOnScreen(ColorBlack, 650, 100, 450);

	//cross
	FillRectangle(ColorWhite, 620, 120, 25, 25);
	FillRectangle(ColorRed, 620, 133, 25, 5);
	FillRectangle(ColorRed, 630, 120, 5, 25);


	//taskbar
	FillRectangle(ColorOrange, 0, 525, 800, 5);
	FillRectangle(ColorSlateBlue, 0, 530, 800, 70);


	//start button
	FillRectangle(ColorWhite, 10, 540, 50, 50);
	FillRectangle(ColorSlateBlue, 35, 540, 2, 50);
	FillRectangle(ColorSlateBlue, 10, 565, 50, 2);

	FillRectangle(ColorSlateBlue, 35, 540, 50, 2);
	FillRectangle(ColorSlateBlue, 10, 588, 25, 2);

	//triangle test           left     right       up
	FillTriangle (ColorWhite, 70, 580, 120, 580, 95, 540);
	
	//ps
	FillRectangle(ColorSkyBlue, 140, 540, 50, 50);
	FillRectangle(ColorBlue, 145, 545, 40, 40);
	DrawText ('PS', ColorSkyBlue, 160, 560); 

	//AI
	FillRectangle(ColorYellow, 200, 540, 50, 50);
	FillRectangle(ColorBrown, 205, 545, 40, 40);
	DrawText ('AI', ColorWhite, 220, 560); 
	//DrawText ('AI', ColorWhite, 'AI', 15, 210, 550);

	
	//CB
	FillRectangle(ColorRed, 260, 540, 25, 25);
	FillRectangle(ColorYellow, 260, 565, 25, 25);
	FillRectangle(ColorGreen, 285, 540, 25, 25);
	FillRectangle(ColorBlue, 285, 565, 25, 25);

	//Skype
	FillCircle(ColorSkyBlue, 360, 565, 25);
	FillEllipse (ColorSkyBlue, 325, 550, 70, 30);
	DrawText ('S', ColorWhite, 350, 560); 

	//steam
	FillCircle(ColorBlack, 430, 565, 25);
	FillCircle(Colorwhite, 415, 575, 5);
	FillCircle(Colorwhite, 440, 560, 5);

	//sublime
	FillRectangle(ColorWhite, 480, 540, 50, 50);
	FillRectangle(ColorDarkGray, 485, 540, 40, 40);
	DrawText ('S', ColorOrange, 505, 555); 


	
	//time etc          
	FillTriangle (ColorWhite, 710, 555, 705, 545, 700, 555);
	DrawText ('7:77 pm', ColorWhite, 725, 550);
	DrawText ('7/7/7777', ColorWhite, 725, 570);



	//double buffering to load picture together
	RefreshScreen(60);

	//delay to keep picture displayed for time in ms
	Delay(15000);

	
end.
