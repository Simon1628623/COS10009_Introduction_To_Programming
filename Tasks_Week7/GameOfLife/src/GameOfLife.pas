program GameOfLife;
uses SwinGame;

const 
	COLUMNS = 200; 	//across
	ROWS = 150;		//down
	CELL_WIDTH = 3;
	CELL_GAP = 1;

type LifeGrid = array [0..COLUMNS - 1, 0..ROWS - 1] of Boolean;




//
// Initialise the elements of the grid - some alive others not
//
procedure SetupGrid(var grid: LifeGrid);
var
	col, row: Integer;
begin
	for col := 0 to COLUMNS - 1 do
	begin
		for row := 0 to ROWS - 1 do
		begin
			// Randomly set each cell to true/false
			grid[col, row] := Rnd() > 0.5 ;

		end;
	end;
end;



function IsAlive(const grid: LifeGrid; col, row: Integer): Boolean;
begin
	// Check if row and col are in range (between 0 and COLUMNS - 1 or ROWS - 1)
	// if not return false...
	// if it is in range, return the value from the grid
	if (col > COLUMNS) OR (col < 0) OR (row > ROWS) OR (row < 0) then
	begin
	result := false;
	end
	
	else
	result := grid[col, row];
end;



function NeighbourCount(const grid: LifeGrid; col, row: Integer): Integer;
var
	nbrCol, nbrRow, count: Integer;
begin
	
	count := 0;

	for nbrCol := col - 1 to col + 1 do
	begin
		for nbrRow := row - 1 to row + 1 do
		begin
			if (col = nbrCol) and (row = nbrRow) then
			begin
				continue;
			end;
			if IsAlive(grid, nbrCol, nbrRow) then
			begin
			count += 1; 
			end;
		end;
		result := count;
	end;
end;


procedure UpdateGrid(var grid: LifeGrid);
var
	newGrid: LifeGrid;
	col, row: Integer;
begin
	
	// Copy the old grid data into the new grid
	newGrid := grid;

	for col := 0 to COLUMNS - 1 do
	begin
		for row := 0 to ROWS - 1 do
		begin
								
			if (IsAlive(grid, col, row)) then
			begin
				// ■ Any live cell with more than three live neighbours dies, as if by overcrowding.
				//Any live cell with fewer than two live neighbours dies, as if caused by loneliness.
				if (NeighbourCount(grid, col, row) < 2) OR (NeighbourCount(grid, col, row) > 3) then
				begin
					
					//newGrid[col,row] := not IsAlive(grid, col, row);
					newGrid[col,row] := false;
				end;
				
				// ■ Any live cell with two or three live neighbours lives on to the next generation.
				if (NeighbourCount(grid, col, row) = 3) OR (NeighbourCount(grid, col, row) = 2)  then
				begin
					
					//newGrid[col,row] := IsAlive(grid, col, row);
					newGrid[col,row] := true;
				end;

			end;
			
			if not IsAlive(grid, col, row) then
			begin
				// ■ Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
				if NeighbourCount(grid, col, row) = 3 then
				begin
					
					//newGrid[col,row] := IsAlive(grid, col, row);
					newGrid[col,row] := true;
				end;
			end;
			
		end;
	end;
	
	//Then copy the new values into the grid parameter
	grid := newGrid;
	
end;


procedure DrawGrid(const grid: LifeGrid);
var
	col, row: Integer;
	x, y: Integer;
begin
	ClearScreen(ColorWhite);
	// For each column
	for col := 0 to COLUMNS - 1 do
	begin
		// For each row
		for row := 0 to ROWS - 1 do
		begin
			if IsAlive(grid, col, row) then
			begin
				x := col * (CELL_WIDTH + CELL_GAP);
				y := row * (CELL_WIDTH + CELL_GAP);
				FillRectangle(ColorBlue, x, y, CELL_WIDTH, CELL_WIDTH);
				
			end;
		end;
	end;
	RefreshScreen();
end;

procedure Main();
var
	grid: LifeGrid;
begin
 // grid[0, 0] := false;
 // grid[0, 1] := true;
 // grid[0, 2] := true;
 // grid[1, 0] := true;
 // grid[1, 1] := true;
 // grid[1, 2] := true;
 // grid[2, 0] := true;
 // grid[2, 1] := false;
 // grid[2, 2] := false;
 // WriteLn('Expect 5 = ', NeighbourCount(grid, 1, 1));
 // WriteLn('Expect 3 = ', NeighbourCount(grid, 0, 0)); 

  OpenAudio();
  OpenGraphicsWindow('Game of Life', 800, 600);

  LoadDefaultColors();

  

  SetupGrid(grid);

  repeat
  	ProcessEvents();
  	
  	// Update the grid
  	UpdateGrid(grid);
  	//UpdateGame(grid);
  	//Delay(500);
  	// Redraw the grid
  	DrawGrid(grid);
  until WindowCloseRequested();
	
end;

begin
	Main();
end.
