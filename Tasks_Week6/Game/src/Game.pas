Program Game;
uses SwinGame, sgTypes, sgUserInterface, math, sysutils;

const
    COLUMNS = 25;
    ROWS = 7;
    CELL_WIDTH = 51;
    CELL_GAP = 0;
    MAX_ITEMS = 50;
	
	C_FNAME = 'save.txt';
 

type
    // blocks
    blockTypes = (soft, hard, item);

    //array for blocks if true/false
    BlockGrid = array [0..COLUMNS - 1, 0..ROWS - 1] of Boolean;

    //item kind
    itemKind = (gpaddle, spaddle, gball, sball);

    BlockData = record
        kind: blockTypes;
        bmp: Bitmap;
        x, y: Integer;
        //score: Integer;
        Bcolor: color;
        item: Boolean;
        //sound: blocks;
    end;

    PlayerData = record
        
        playerName: String;
        x, y: Single;
        dx, dy: Single;
        bmp: Bitmap;
        score: Integer;
        lives: Integer;
        

    end;

    BallData = record
        bmp: Bitmap;
        x, y: Single;
        dx, dy: Single;
        

    end;

    itemData = record
        bmp: Bitmap;
        x, y: integer;
        kind: itemKind;
    end;

    BlockArray = array of BlockData;
    PlayerArray = array of PlayerData;

    GameData = record
        time: Timer;
        player: PlayerData;
        blocks: BlockArray;
        ball: BallData;
        grid: BlockGrid;
        items: array of itemData;
    end;


    
    
////////////////////////
//LOADING ASSETS
///////////////////////
procedure LoadData();
begin

	LoadBitmapNamed('soft',   'soft.png');
	LoadBitmapNamed('hard',   'hard.png');
	LoadBitmapNamed('item',   'item.png');

	LoadBitmapNamed('gpaddle', 'gpaddle.png');
	LoadBitmapNamed('spaddle', 'spaddle.png');
	LoadBitmapNamed('gball', 'gball.png');
	LoadBitmapNamed('sball', 'sball.png');
	
	LoadBitmapNamed('Yes',   'hard.png');
	LoadBitmapNamed('No',   'item.png');

	LoadBitmapNamed('background', 'background.jpg');

	LoadBitmapNamed('pause', 'pause.jpg');

	//ball hitting wall
	LoadSoundEffectNamed('ballWall', 'ballWall.wav');

	//player hitting ball
	LoadSoundEffectNamed('playerBall', 'playerball_1.wav');

	//player hitting wall
	LoadSoundEffectNamed('playerWall', 'playerWall.wav');

	//ball hitting blocks
	LoadSoundEffectNamed('ballBlock', 'ballblock.wav');

	//player dying
	LoadSoundEffectNamed('loseLive', 'loseLive.wav');

	//hitting item
	LoadSoundEffectNamed('item', 'item.wav');
end;

/////////////////////////////
//WIDTHS
////////////////////////////

Function BallWidth(var ball: BallData): Integer;
begin
    result := BitmapWidth(ball.bmp);
end;

Function BallHeight(var ball: BallData): Integer;
begin
    result := BitmapHeight(ball.bmp);
end;

Function BlockWidth(var block: BlockData): Integer;
begin
    result := BitmapWidth(block.bmp);
end; 

Function BlockHeight(var block: BlockData): Integer;
begin
    result := BitmapHeight(block.bmp);
end; 

Function PlayerWidth(var player: PlayerData): Integer;
begin
    result := BitmapWidth(player.bmp);
end; 

Function PlayerHeight(var player: PlayerData): Integer;
begin
    result := BitmapHeight(player.bmp);
end; 

Function itemHeight(var item: itemData): Integer;
begin
    result := BitmapHeight(item.bmp);
end; 
////////////////
//END OF WIDTHS
/////////////////

///////////////////////////////
////BLOCK FUNCTIONS/PROCEDURES
///////////////////////////////

/////////////////////////////////////
//sets certain blockTypes to their specific bitmap 

function blockBitmap(kind: blockTypes): Bitmap;
begin
    case kind of 
        soft:   result := BitmapNamed('soft');
        hard:   result := BitmapNamed('hard');
        item:   result := BitmapNamed('item');
    else
        result := nil;
    end;
end;

////////////////////////////////////
//randomly selecting a blockType 

function RandomBlockType(): blockTypes;
begin
    result := blockTypes(Rnd(3));
end;

////////////////////////////////////
//random block creator

function RandomBlock() : BlockData;
begin
    result.kind := RandomBlockType();
    // matching bitmap with blocktype
    result.bmp := blockBitmap(result.kind);
    result.Bcolor := RandomColor();
    result.item := Rnd() > 0.80;
    

end;


//////////////////////////////////
//drawing blocks bitmap/Rectangles

procedure FillBlock(const block: BlockData; x, y, CELL_WIDTH: Integer);
begin
   //bitmap
   DrawBitmap(block.bmp, x, y);
   //FillRectangle(block.Bcolor, x, y, CELL_WIDTH, CELL_WIDTH);

end;

////////////////////////////////
//checking whether block exists in specific row and column

function isBlock(const grid:BlockGrid; col, row: Integer): Boolean;
begin
    result := grid[col, row];
    
end;

/////////////////////////////
//SETS UP BLOCKS FOR USE

procedure GenerateBlocks(var game: GameData; numBlocks: Integer);
var
    col, row: Integer;
begin
   //setting length of the blocks to a value passed in the parameters
   SetLength(game.blocks, numBlocks);

    for col := 0 to COLUMNS - 1 do
    begin
        for row := 0 to ROWS - 1 do
        begin
            // Randomly set each cell to true/false
            game.grid[col, row] := Rnd() > 0.5 ;
             
            //if the block is set it is randomising the type of block and setting location                                                 
            if isBlock(game.grid, col, row) then
            begin
                //not assigning game.blocks the random value but executing random value sum
                game.blocks[col] := RandomBlock();
                
                //giving the blocks their x and y positions    
                game.blocks[col].x := col * (CELL_WIDTH + CELL_GAP);
                game.blocks[row].y := row * (CELL_WIDTH + CELL_GAP);
                end;
            end;
        end;
end;



////////////////////////////////////////////
//rendering blocks on screen to update them

Procedure DrawBlocks(var game: GameData);
var
    col, row: Integer;
begin
    //for each column
    for col := 0 to COLUMNS - 1 do
    begin
        // For each row
        for row := 0 to ROWS - 1 do
        begin
            if isBlock(game.grid, col, row) then
            begin
                //draws block on screen in either a bitmap or rectangle
                FillBlock(game.blocks[col],  game.blocks[col].x, game.blocks[row].y, CELL_WIDTH);
            end;
        end;
    end;      
end;

////////////////////////
//END OF BLOCK
////////////////////////

///////////////////////
//START OF ITEM
///////////////////////

///////////////////////
//SETTING item bitmaps for each type
function itemBitmap(kind: itemKind): Bitmap;
begin
    case kind of 
        gpaddle: result := BitmapNamed('gpaddle');
        spaddle: result := BitmapNamed('spaddle');
        gball:   result := BitmapNamed('gball');
        sball:   result := BitmapNamed('sball');
        
    else
        result := nil;
    end;
end;

///////////////////////
//randomising item type
function RandomItemType():itemKind;
begin
    result := itemKind(Rnd(4));
end;

////////////////////////
//randomising item
Function RandomiseItem(var x, y:Integer):itemData;
begin
    result.kind := RandomItemType();
    result.bmp := itemBitmap(result.kind);
    result.x := x;
    result.y := y;
end;

/////////////////////////
//updating item to move down the screen
procedure UpdateItem(var game: gameData);
var 
    i: Integer;
begin
    for i:= 0 to high(game.items) do
    begin
        game.items[i].y += 1;
        
    end;

end;

//////////////////////////
//draw item on the screen
procedure drawItem(var game: gameData);
var 
    i: Integer;
begin
    for i:= 0 to High(game.items) do
    begin
        DrawBitmap(game.items[i].bmp, game.items[i].x, game.items[i].y);
        //FillRectangle(colorblue, game.item.x, game.item.y, CELL_WIDTH, CELL_WIDTH);
    end;
end;

/////////////////////////
//setup item
procedure initilizeItem(var game: gameData);
begin
    SetLength(game.items, MAX_ITEMS);
    
    game.items[0].x := -50;
    game.items[0].y := -50;
    game.items[0].kind := RandomItemType();
    game.items[0].bmp := itemBitmap(game.items[0].kind);
end;

//////////////////////
//END OF ITEM
//////////////////////


////////////////////////
//START OF PLAYER
////////////////////////

//////////////////////////////////////
//drawing player bitmap

procedure drawPlayer(const player: PlayerData);
begin
    //skin
    DrawBitmap(player.bmp, player.x, player.y);

end;

/////////////////////////////////////////
//setting up player acceleration, position, lives and bitmap

procedure SetupPlayer(var player: PlayerData);
begin
    player.bmp := LoadBitmap('player_default.png');
	
	
	
    //position
    player.dx := 0;
    player.dy := 0;
    player.x := (ScreenWidth() - PlayerWidth(player)) / 2;
    player.y := ScreenHeight() - PlayerHeight(player) - 10;

    //live/score
    player.score := 0;
    player.lives := 3;
end;

/////////////////////////////
//handles player controls

procedure HandleInput(var game: GameData);
begin

    ProcessEvents();

     if KeyDown(vk_Right) then
    begin
        game.player.dx += 0.3;
    end;

    if KeyDown(vk_Left) then
    begin
         game.player.dx -= 0.3;
    end;

    if KeyDown(vk_Up) then
    begin
         game.player.dy -= 0.3;
    end;

    if KeyDown(vk_Down) then
    begin
         game.player.dy += 0.3;
    end;
end;

function PlayerName( player: PlayerData):String;
var
	s: string;
begin
	writeln('enter name please');
	readln(s);
	player.playerName := s;
	writeLn('Your entered name is: ',player.playerName);
	result := s;
end;

///////////////////////////
//END OF PLAYER
/////////////////////////

////////////////////////
//START OF BALL
///////////////////////

////////////////////////////
//rendering ball bitmap on screen

procedure drawBall(const ball: BallData);
begin
    DrawBitmap(ball.bmp, ball.x, ball.y);
end;

//////////////////////////////////////
//teleporting player and ball back to center for when ball goes out of bounds

procedure RespawnBall(var game: GameData);
begin
    game.player.lives -= 1;

    game.ball.dx := 0;
    game.ball.dy := 0;

    game.player.dx := 0;
    game.player.dy := 0;

    game.player.x := (ScreenWidth() - PlayerWidth(game.player)) / 2;
    game.player.y := ScreenHeight() - PlayerHeight(game.player) - 10;


    game.ball.x := (game.player.x) + (PlayerWidth(game.player))/2-(BallWidth(game.ball));
    game.ball.y := (game.player.y) - (PlayerHeight(game.player)); 
end;

///////////////////////////////////////////
//setting up balls position, bitmap and acceleration

procedure setUpBall(var game: GameData);
begin
    game.ball.bmp := LoadBitmap('ball_d.png');

    game.ball.dx := 0;
    game.ball.dy := 0;

    game.ball.x := (game.player.x) + (PlayerWidth(game.player))/2-(BallWidth(game.ball));
    game.ball.y := (game.player.y) - (PlayerHeight(game.player));
end;

/////////////////////
//END OF BALL
/////////////////////

////////////////////
//START OF COLLISIONS
/////////////////////

procedure PlayerCollisions(var game: GameData);
begin
     //left
    if game.player.x >= ScreenWidth() - PlayerWidth(game.player) then
    begin
        game.player.dx := -2;
        PlaySoundEffect('playerWall');
    end;

    //right
     if game.player.x <= 0 then
    begin
        game.player.dx := +2;
        PlaySoundEffect('playerWall');
    end;

    //up
    if game.player.y <= 400 then
    begin
        game.player.dy := +2;
        PlaySoundEffect('playerWall');
    end;

    //down
    if game.player.y >= ScreenHeight() - PlayerHeight(game.player) then
    begin
        game.player.dy := -2;
        PlaySoundEffect('playerWall');
    end;



     //ball collides with paddle here
     //if ball is greater than players x pos, stopping ball if left onwards
    if (game.player.x <= game.ball.x + BallWidth(game.ball)) AND (game.ball.x <= game.player.x + PlayerWidth(game.player)) then
    begin
        
       
            //top 
            if game.player.y <= game.ball.y + BallHeight(game.ball) then
            begin
                
                //making sure it isn't below the bottom of the player
                if game.player.y + PlayerHeight(game.player) >=  game.ball.y + BallHeight(game.ball) then
                begin
                    //sends ball up
                    game.ball.dy += -3;
                    PlaySoundEffect('playerBall');
                    //right side
                    if (PlayerWidth(game.player) + game.player.x >=  game.ball.x + BallWidth(game.ball)/2) AND ((game.player.x + (PlayerWidth(game.player) * (2/3))) <= game.ball.x + BallWidth(game.ball)/2) then
                    begin
                        game.ball.dx += 2;
                        
                    end;
                    //center
                    if (game.player.x + 1/3 * PlayerWidth(game.player) <=  game.ball.x + BallWidth(game.ball)/2) AND (game.player.x + 2/3 * PlayerWidth(game.player) >= game.ball.x + BallWidth(game.ball)/2) then
                    begin
                        game.ball.dx := 0;
                        
                    end;

                    //left
                     if (game.player.x  <=  game.ball.x + BallWidth(game.ball)/2) AND (game.player.x + PlayerWidth(game.player) * 1/3 >= game.ball.x + BallWidth(game.ball)/2) then
                    begin
                        game.ball.dx -= 2;
                        
                    end;

                    //game.ball.dx += -1;
                end;
                
               




               //bottom
                if game.player.y + PlayerHeight(game.player) <= game.ball.y then
                begin
                    //minimum boundary
                    if game.player.y + PlayerHeight(game.player) + BallHeight(game.ball)/4 >= game.ball.y then
                    begin
                    game.ball.dy += 3;
                    game.ball.dx += 1;
                    PlaySoundEffect('playerBall');
                    end;
 
                end;
            end;
            
    end; 


end;

procedure BallCollisions(var game: GameData);
begin
     //left
    if game.ball.x >= ScreenWidth() - BallWidth(game.ball) then
    begin
        game.ball.dx := -3;
        PlaySoundEffect('ballWall');
    end;

    //right
     if game.ball.x <= 0 then
    begin
        game.ball.dx := +3;
        PlaySoundEffect('ballWall');
    end;

    //up
    if game.ball.y <= 0 then
    begin
        game.ball.dy := +3;
        PlaySoundEffect('ballWall');
    end;

    //down
    if game.ball.y >= ScreenHeight() - ballHeight(game.ball) then
    begin
       //loss of life
       RespawnBall(game);
       PlaySoundEffect('loseLive');
    end;




end;

procedure BlockCollisions (var game: GameData);
var
    i, j: Integer;
    col, row: Integer;
   // x, y: Integer;
   // item: itemData;
    //rndm : Boolean;
begin
     i:=0;
    for col := 0 to COLUMNS - 1 do
    begin

        // For each row
        for row := 0 to ROWS - 1 do
        begin
           
            if(game.blocks[col].x + CELL_WIDTH >= game.ball.x) AND (game.blocks[col].x <= game.ball.x + BallWidth(game.ball))  then
            begin
                if (game.blocks[row].y + CELL_WIDTH >= game.ball.y) AND (game.blocks[row].y <= game.ball.y + BallHeight(game.ball)) AND (game.grid[col, row] = true) then
                begin
                    game.grid[col, row] := false;
                    game.player.score += 1;
                    
                    PlaySoundEffect('ballBlock');

                    // for i := 0 to High(game.blocks) do
                    // begin
                    //     if game.blocks[i].item then
                    //      game.items[col] := RandomiseItem(game.blocks[col].x, game.blocks[row].y);
                    // end;


                    //planning to use when I fix items
                    
                    if (game.blocks[col].item) then
                    begin
                        i+=1;
                        game.items[Random(MAX_ITEMS)] := RandomiseItem(game.blocks[col].x, game.blocks[row].y);
                        
                    end;
                    
                   
                end;
            end;


        end;
    end;
    
end;


Procedure itemCollision(var game: gameData);
var 
    i: integer;
begin
    for i := 0 to High(game.items) do
    begin
        if (game.player.x + playerWidth(game.player) >= game.items[i].x) AND (game.player.x <= game.items[i].x) AND (game.player.y <= game.items[i].y + itemHeight(game.items[i])) then
        begin
            PlaySoundEffect('item');
            game.items[i].x := -50;

            if game.items[i].kind = gpaddle then game.player.bmp := LoadBitmap('player_default_1.png');
            if game.items[i].kind = spaddle then game.player.bmp := LoadBitmap('player_default_2.png');
            if game.items[i].kind = gball then game.ball.bmp := LoadBitmap('ball_d_1.png');
            if game.items[i].kind = sball then game.ball.bmp := LoadBitmap('ball_d_2.png');
        end;
    end;
end;

////////////////////////
//END OF COLLISIONS
////////////////////////

//////////////////////////
//File IO
/////////////////////////

////////////////////////
//creating the highscore save file
procedure createFile();
var
  myFile: TextFile;
 
begin
	// Set the name of the file that will be created
	AssignFile(myFile, C_FNAME);
 
	// Use exceptions to catch errors (this is the default so not absolutely requried)
	//{$I+}
 
  
    // Create the file, write some text and close it.
    rewrite(myFile);
 
    writeln(myFile, 'HighScores');
    writeln(myFile, '###########################');
 
    CloseFile(myFile);
 
end;

////////////////////
//adds new highscores to file
procedure updateFile(game: GameData);
var
	myFile: TextFile;
 
begin
  // Set the name of the file that will receive some more text
  AssignFile(myFile, C_FNAME);
 
  
    // Open the file for appending, write some more text to it and close it.
    append(myFile);
 
    writeln(myFile, '#', game.player.playerName, ' : ', game.player.score);
    writeln(myFile, ' ');
 
    CloseFile(myFile);
	
	WriteLn('updated Highscores');
end;
/////////////////
//displays content of file
procedure loadFile();
var
	myFile: TextFile;
	s: string;
	i,j:Integer;
	x,y: Integer;
	a: Array[0..100] of string;
begin
	j := 0;
	i := 0;
	
	// Give some feedback
	writeln('Reading the contents of file: ', C_FNAME);
	writeln('=========================================');
 
	// Set the name of the file that will be read
	AssignFile(myFile, C_FNAME);
 
   
	// Open the file for reading
    reset(myFile);
 
    // Keep reading lines until the end of the file is reached
    while not eof(myFile) do
    begin
		readln(myFile, s);
		
		writeln(s);
		
		a[j] := s;
		
		j+=1;
		
    end;
	
	for i:=0 to j do
	begin
		x := ROund(ScreenWidth()/2);
		y := Round(15*i + 5);
		
		DrawText(a[i], ColorBlack, x, y);
		
		
	end;
	
    // Done so close the file
    CloseFile(myFile);
 
  
 
  // Wait for the user to end the program
  writeln('=========================================');
  
end;

////////////////////
//checks to see if file exists
function checkFile(): boolean;
begin
	if FileExists(C_FNAME) then
	result := true;
	if not FileExists(C_FNAME) then
	result := false;
end;

//////////////////////////
//END OF File IO
/////////////////////////

/////////////////////////
//Interface
///////////////////////// 
function MouseOverPause(): Boolean;
var
	bmp: Bitmap;
begin
    bmp := BitmapNamed('pause');
	result := BitmapPointCollision(bmp, (ScreenWidth()-50), (ScreenHeight()-50), MouseX(), MouseY());
end;

procedure pause();
begin
	WriteLn('pause active');
	
	
end;

procedure HUD(var game: GameData);
begin
	//score and lives
	DrawText('Score: ' + IntToStr(game.player.Score) + ' Lives: ' + IntToStr(game.player.lives), ColorBlack, 0, 0);
	//pause button
	DrawBitmap('pause', ScreenWidth()-50, ScreenHeight()-50);
end;

procedure UpdateHUD();
begin
	
	//pause button
	if (MouseDown(LeftButton) and MouseOverPause()) or  (KeyDown(vk_escape))then
    begin
		pause();
	end;
	
end;

/////////////////////////////
//highscore button

function MouseOverButton(name: String; x, y :Integer): Boolean;
var
	bmp: Bitmap;
begin
    bmp := BitmapNamed(name);
	result := BitmapPointCollision(bmp, (x), (y), MouseX(), MouseY());
end;


//remove pass
procedure HighScore(var game: GameData);
begin
	//score and lives
	DrawText('DO you want to save your score to the highscore board?', ColorBlack, ScreenWidth()/2, ScreenHeight()/2);
	//pause button
	DrawBitmap('Yes', ScreenWidth()/2 - 50, ScreenHeight()/2+50);
	DrawBitmap('No', ScreenWidth()/2 + 50, ScreenHeight()/2+50);
end;

procedure ViewHS();
begin
	
	WriteLn('viewing hs');
	loadFile();
end;

function UpdateHS(game: GameData): boolean;
var 
	x, y, x2, y2: Integer;
begin
	
	x := Round(ScreenWidth()/2 - 50);
	y := Round(ScreenHeight()/2+50);
	
	x2 := Round(ScreenWidth()/2 + 50);
	y2 := Round(ScreenHeight()/2+50);
	
	//pause button
	if (MouseDown(LeftButton)) and (MouseOverButton('Yes',x , y)) then
    begin
		//save highscore
		
		
		game.player.playerName := PlayerName(game.player);
		WriteLn(game.player.playerName);
		updateFile(game);
		result := true;
		
	end;
	if (MouseDown(LeftButton)) and (MouseOverButton('No', x2, y2)) then
    begin
		//don't save highscore
		result := true;
		
		
	end
	else
		result := false;
	
end;



//END OF HS
///////////////////////////////




/////////////////////////
//END OF Interface
///////////////////////// 

procedure HandleCollisions(var game: GameData);
begin
    PlayerCollisions(game);
    BallCollisions(game);
    BlockCollisions(game);
    itemCollision(game);
end;

procedure UpdatePlayer(var player:GameData);
begin
    HandleInput(player);
   
   player.player.x += player.player.dx;
    player.player.y += player.player.dy;
end;

////////////////////////////////////////
//updating ball acceleration

procedure UpdateBall(var game: GameData);
var 
    clicked: Boolean;

begin
    game.ball.x += game.ball.dx;
    game.ball.y +=game.ball.dy;
end;

procedure DisplayGame(var game: GameData);
begin
    ClearScreen(colorWhite);
    DrawBitmap('background', 0, 0);
	
    drawPlayer(game.player);
    drawBall(game.ball);
    DrawBlocks(game);
    drawItem(game);
    HUD(game);

    RefreshScreen(60);
end;






//for timers and score collision detections etc

procedure UpdateGame(var game: GameData);
begin
    ProcessEvents();
    UpdatePlayer(game);
    UpdateBall(game);
    DisplayGame(game);
    HandleCollisions(game);
	UpdateItem(game);
	UpdateHUD();
end;




//open graphics window etc

procedure SetUpGame(var game: GameData);
begin
    OpenGraphicsWindow('Blocken', 1280, 720);
    //ShowSwinGameSplashScreen();
    LoadData();
    SetupPlayer(game.player);
    setUpBall(game);
    GenerateBlocks(game, COLUMNS);

	if checkFile() = false then
    createFile();
	

	//loadFile();
    initilizeItem(game);
  


end;


Procedure Main();
var
    game: GameData;
	hs: boolean;
begin
	hs := false;
    SetUpGame(game);

	repeat 
        
		while (game.player.lives >= 0) AND  NOT (WindowCloseRequested()) DO
		begin
			UpdateGame(game);
		end;
		
		while (game.player.lives < 0) AND NOT (WindowCloseRequested()) do
		begin
			ProcessEvents();
			ClearScreen(colorWhite);
			DrawBitmap('background', 0, 0);
			
			
			
			if(hs = false) then
			begin
				Highscore(game);
				
				UpdateHS(game);
				
				if (UpdateHS(game) = true) then
				begin
					hs := true;
				end;
			end;
			
			
				
			if hs then
			begin
				ViewHS();
			
				WriteLn('VIewing HS');
			end;
			
			RefreshScreen(60);
			
		
			
		end;
		
        
		
	until WindowCloseRequested();

end;

begin
	Main();
end.