program GameMain;
uses SwinGame, sgTypes;

Procedure DrawRedBike();
begin
	DrawTriangle(ColorRed, 10, 20, 25, 5, 40, 20);
	DrawCircle(ColorRed, 10, 20, 10);
	DrawCircle(ColorRed, 40, 20, 10);
	DrawLine(ColorRed, 40, 20, 40, 0);

end;

Procedure DrawBlueBike();
begin
	DrawTriangle(ColorBlue, 10, 20, 25, 5, 40, 20);
	DrawCircle(ColorBlue, 10, 20, 10);
	DrawCircle(ColorBlue, 40, 20, 10);
	DrawLine(ColorBlue, 40, 20, 40, 0);

end;

Procedure DrawInvader();
begin

	//body and eyes
	FillRectangle(Colorgray, 50, 50, 70, 40);
	FillRectangle(Colorblack, 60, 60, 10, 10);
	FillRectangle(Colorblack, 100, 60, 10, 10);

	//hair
	FillRectangle(Colorgrey, 50, 30, 10, 10);
	FillRectangle(Colorgrey, 60, 40, 10, 10);

	FillRectangle(Colorgrey, 110, 30, 10, 10);
	FillRectangle(Colorgrey, 100, 40, 10, 10);
	
	//arms
	FillRectangle(Colorgrey, 40, 60, 10, 20);
	FillRectangle(Colorgrey, 30, 70, 10, 30);

	FillRectangle(Colorgrey, 120, 60, 10, 20);
	FillRectangle(Colorgrey, 130, 70, 10, 30);

	//legs
	FillRectangle(Colorgrey, 50, 90, 10, 10);
	FillRectangle(Colorgrey, 60, 100, 20, 10);

	FillRectangle(Colorgrey, 110, 90, 10, 10);
	FillRectangle(Colorgrey, 90, 100, 20, 10);

end;

Procedure Main();
begin


	OpenGraphicsWindow('Bike', 200, 200);
	LoadDefaultColors();
	ClearScreen(ColorWhite);
	DrawRedBike();
	RefreshScreen(60);
	Delay(5000);

	ClearScreen(ColorWhite);
	DrawBlueBike();
	RefreshScreen(60);
	Delay(5000);

	ClearScreen(ColorWhite);
	DrawInvader();
	RefreshScreen(60);
	Delay(5000);


end;

begin
	Main();
end.


