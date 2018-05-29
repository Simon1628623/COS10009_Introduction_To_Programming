program FruitPunch;
uses SwinGame, sgTypes, SysUtils;

type
    // 9 different kinds of fruit
    FruitKind = ( Cherry, Blackberry, Pomegranate, Gooseberry, Currant, Apricot, Raspberry, Blueberry, Strawberry);

    FruitData = record
        kind: FruitKind;
        bmp: Bitmap;
        fruitx, fruity: Integer;
        endTime: Integer;
    end;

    GameData = record
        target: FruitData;
        time: Timer;
        score: Integer;
        

    end;

procedure LoadResources();
begin
    // Load the 9 different bitmaps for the fruit
    LoadBitmapNamed('Cherry',       'Cherry.png');
    LoadBitmapNamed('Blackberry',   'Blackberry.png');
    LoadBitmapNamed('Pomegranate',  'Pomegranate.png');
    LoadBitmapNamed('Gooseberry',   'Gooseberry.png');
    LoadBitmapNamed('Currant',   'Currant.png');
    LoadBitmapNamed('Apricot',   'Apricot.png');
    LoadBitmapNamed('Raspberry',    'Raspberry.png');
    LoadBitmapNamed('Blueberry',    'Blueberry.png');
    LoadBitmapNamed('Strawberry',      'Strawberry.png');
    
    

    LoadSoundEffectNamed('Splat', 'Splat-SoundBible.com-1826190667.wav'); // Recorded by Mike Koenig - http://soundbible.com/642-Splat.html
end;

function FruitBitmap(kind: FruitKind): Bitmap;
begin
    // Return the bitmap that matches the kind of fruit asked for
    case kind of 
        Cherry:         result := BitmapNamed('Cherry');
        Blackberry:     result := BitmapNamed('Blackberry');
        Pomegranate:    result := BitmapNamed('Pomegranate');
        Gooseberry:     result := BitmapNamed('Gooseberry');
        Currant:        result := BitmapNamed('Currant');
        Apricot:        result := BitmapNamed('Apricot');
        Raspberry:      result := BitmapNamed('Raspberry');
        Blueberry:      result := BitmapNamed('Blueberry');
        Strawberry:     result := BitmapNamed('Strawberry');
        
        
        
    else
        result := nil;  // Did not match a known fruit, so return nil = no bitmap
    end;
end;



function RandomFruit(endTime: Integer) : FruitData;
begin

    result.endTime := endTime;
    

    // Randomly pick one of the 9 fruit types
    result.kind := FruitKind(Rnd(9));
    // Get its matching bitmap - remember it for this fruit
    result.bmp := FruitBitmap(result.kind);

    result.Fruitx := Rnd(ScreenWidth()-BitmapWidth(result.bmp));
    result.Fruity := Rnd(ScreenHeight()-BitmapWidth(result.bmp));
end;

procedure UpdateGame(var game: GameData);
begin
   
    if ((TimerTicks(game.time)) > (game.target.endTime)) then
    begin
        game.target := RandomFruit(TimerTicks(game.time) + 500 + Rnd(1500));
    end;
end;

procedure DrawGame(const game: GameData);
begin


    ClearScreen(ColorWhite);
    DrawBitmap(game.target.bmp, game.target.Fruitx, game.target.Fruity);
    DrawText('Score: ' + IntToStr(game.Score), ColorBlack, 0, 0);
    RefreshScreen(60);
end;

procedure HandleInput(var game: GameData);
begin
    ProcessEvents();

    if MouseClicked(LeftButton) AND (BitmapPointCollision(game.target.bmp, game.target.Fruitx, game.target.Fruity, MouseX(), MouseY())) then
    begin
        PlaySoundEffect('Splat');
        game.Score += 1;
        game.target := RandomFruit(TimerTicks(game.time) + 500 + Rnd(1500));
    end;
end;

procedure Main();
var
    mainGameData: GameData;
begin
    OpenAudio();
    OpenGraphicsWindow('Fruit Punch', 600, 600);
    LoadDefaultColors();
    LoadResources();

    
    // First fruit has 2 seconds on screen
    mainGameData.target := RandomFruit(2000);
    mainGameData.time := CreateTimer();
    mainGameData.Score := 0;
    StartTimer(mainGameData.time);

    repeat
        HandleInput(mainGameData);
        UpdateGame(mainGameData);
        DrawGame(mainGameData);
    until WindowCloseRequested();
end;


begin
    Main();
end.
