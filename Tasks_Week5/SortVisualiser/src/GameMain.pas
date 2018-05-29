program GameMain;
uses SwinGame, sysutils;

Procedure ShowNumbersInList(var data: array of Integer);
var
	i:Integer;
begin
	ListClearItems('NumbersList');
	for i:=0 to High(data) Do
	begin
		ListAddItem('NumbersList', IntToStr(data[i]));
	end;
end;

Procedure PopulateArray(var data: array of Integer);
var
	i: Integer;
begin
	for i:=0 to High(data) Do
	begin
		data[i] := Rnd(ScreenHeight());
	end;
end;

Procedure Swap (var v1, v2: Integer);
var
	temp: Integer;
begin
	temp := v1;
	v1 := v2;
	v2 := temp;
end;



Procedure PlotBars(var data: Array of Integer);
var 
	width, ScreenWid, i: Integer;
begin
	ScreenWid := ScreenWidth()-PanelWidth('NumberPanel');
	width := Round(ScreenWid/Length(data));
	ClearScreen(ColorWhite);
	DrawInterface();
	for i:=0 to High(data) do
	begin
		
		FillRectangle(colorRed, width * i, ScreenHeight()-data[i], width, data[i]);
		
		
	end;
	RefreshScreen(60);
	
end;

Procedure Sort(var data: array of Integer);
var 
	i, j, b: Integer;
	swapped: Boolean;
begin
	j := length(data);
	Repeat
		b := 0;
		for i := 1 to j - 1 do
		if data[i-1] > data[i] Then
		begin
			Swap(data[i-1], data[i]);
			b := 1;
			PlotBars(data);
			Delay(100);
		end;
	Until j = 0;

end;

Procedure DoSort();
var
	data: array[1..25] of Integer;
begin
	PopulateArray(data);
	ShowNumbersInList(data);
	PlotBars(data);
	Sort(data);
end;



Procedure Main();
begin
	OpenGraphicsWindow('Sort Visualiser', 800, 600);
  	LoadResourceBundle( 'NumberBundle.txt' );
  	GUISetForegroundColor( ColorBlack );
  	GUISetBackgroundColor( ColorWhite );
  
  	ShowPanel( 'NumberPanel' );
  
  	ClearScreen(ColorWhite);
  
  	Repeat
	  	ProcessEvents();
	  	UpdateInterface();
	  	DrawInterface();
	 	RefreshScreen(60);

	 	if ButtonClicked('SortButton') Then
	 		begin
	 			DoSort();
	 		end;
 	Until WindowCloseRequested();
  
  
end;

begin
	Main();
end.
