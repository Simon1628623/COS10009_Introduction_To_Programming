program GameMain;
uses SwinGame, sgTypes;


function ButtonClicked(btnX, btnY: Single; btnWidth, btnHeight: Integer): Boolean;
var
  mX, mY: Single;
  btnRight, btnBottom: Single;
begin
  mX := MouseX();
  mY := MouseY();
  btnRight := btnX + btnWidth;
  btnBottom := btnY + btnHeight;

  result := false;

  if MouseClicked( LeftButton ) then
  begin
    if (mX >= btnX) and (mX <= btnRight) and (mY <= btnBottom) and (mY >= btnY) then
    begin
      result := true;
    end;
  end;
end;

procedure Main();
var
  clr: Color;
begin
  OpenGraphicsWindow('Hello World', 800, 600);
  LoadDefaultColors();
  ShowSwinGameSplashScreen();

  clr := ColorWhite;
  
  repeat // The game loop...
    ProcessEvents();
    
    ClearScreen(clr);
    DrawFramerate(0,0);

    FillRectangle(ColorGrey, 50, 50, 100, 30);
    DrawText('Click Me', ColorBlack, 'arial.ttf', 14, 55, 55);

    if ButtonClicked(50, 50, 100, 30) then
    begin
      clr := RandomRGBColor(255);
    end;
    
    RefreshScreen();
  until WindowCloseRequested();
  
  CloseAudio();
  ReleaseAllResources();
end;

begin
  Main();
end.
