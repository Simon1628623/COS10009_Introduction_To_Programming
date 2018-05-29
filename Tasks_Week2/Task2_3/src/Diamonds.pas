program GameMain;
uses SwinGame, sgTypes;
//all future calls to Fill Diamonds will need these values to be entered

Procedure FillDiamond(clr: Color; x, y: Single; width, height: Integer);
//varibles/identifiers for points to calculate

var 
	midX, rightX, midY, bottomY: Single;

begin
	//middle point X
	midX := x + width / 2;
	//right point X
	rightX := x + width;
	//Middle point Y
	midY := y + height / 2;
	//Bottom Y
	bottomY := y + height;

	//filling triangles
	FillTriangle(clr, x, midY, midX, y, rightX, midY);
	FillTriangle(clr, x, midY, midX, bottomY, rightX, midY);

	

end;
//call to draw outline of diamond 

Procedure DrawDiamond(clr: Color; x, y: Single; width, height: Integer);
var 
	leftX, rightX, midX, topY, bottomY, midY: Single;

begin
	//left X point
	leftX := x;
	//right X point
	rightX := x + width;
	//middle X point for top/bottom Y
	midX := x + width / 2;
	//top y
	topY := y;
	//bottom Y
	bottomY := y + height;
	//middle Y for left/rightx
	midY := y + height / 2;
	

	//left side
	//top
	DrawLine(clr, leftX, midY, midX, topY);
	//bottom
	DrawLine(clr, leftX, midY, midX, bottomY);
	//right side
	//top
	DrawLine(clr, rightX, midY, midX, topY);
	//bottom
	DrawLine(clr, rightX, midY, midX, bottomY);
	

end;

Procedure Main();
begin
	OpenGraphicsWindow('Diamonds', 400, 400);
	LoadDefaultColors();
	ClearScreen(ColorWhite);
	
	FillDiamond(ColorRed, 0, 0, 100, 100);
	FillDiamond(ColorGreen, 350, 350, 50, 50);
	FillDiamond(ColorBlue, 300, 0, 100, 50);
	FillDiamond(ColorSkyBlue, 77, 77, 77, 77);
	FillDiamond(ColorOrange, 200, 300, 100, 50);

	DrawDiamond(ColorGreen, 50, 300, 100, 50);
	DrawDiamond(ColorPurple, 150, 100, 70, 50);
	DrawDiamond(ColorOrange, 250, 250, 50, 50);
	DrawDiamond(ColorBlack, 200, 350, 100, 50);
	DrawDiamond(ColorYellow, 300, 200, 100, 50);
	
	RefreshScreen();
	Delay(5000);
end;

begin
	Main();
end.
