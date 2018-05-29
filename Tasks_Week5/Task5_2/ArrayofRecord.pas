Program ArrayofRecord;
Uses TerminalUserInput, math, sysutils;

type 
	HighScoreData = record
	name: String;
	scores: Integer;
	end;

	//instead of saying array of HighScoreData everytime
	HighScoreDataArray = array of HighScoreData;

//built to swap scores for sort procedure

procedure Swap(var p1, p2: HighScoreData);
var
	temp: HighScoreData;
begin
	temp := p1;
	p1 := p2;
	p2 := temp;
end;

//sorts order of highscores

procedure Sort (var toSort: HighScoreDataArray);
var
	i, o: Integer;
begin
	//makes sure it goes through all the combinations to check if vlaue is higher
	for o:=0 to High(toSort) do
	begin
		for i:=0 to High(toSort) - 1 do
		begin
			if toSort[i].scores < toSort[i+1].scores then
			begin
				Swap(toSort[i], toSort[i+1]);
			end;
		end;
	end;
end;


procedure PrintHS(var Player: HighScoreDataArray);
var
	i:Integer;
begin
	WriteLn('HighScore chart');
	Sort(Player);
	for i := 0 to High(Player) do
	begin
		
		WriteLn(i+1,'. Name: ', Player[i].name,' Score: ', Player[i].scores);
		//i += 1;
	end; 

end;


//keep without array

function RandomPlayers():HighScoreData;
begin
	result.scores := Random(1000);
	result.name := 'Person' + IntToStr(Random(777));
end;

procedure PopulateContacts(var Player: HighScoreDataArray);
var
	i:Integer;
	
begin
	for i := 0 to High(Player) do
	begin
		Player[i]:= RandomPlayers();
		
	end; 

end;

function ReadPlayer(): HighScoreData;
begin
	Result.name := ReadString('Please enter Players name: ');
	Result.scores := ReadInteger('Please enter score: ');
	WriteLn('Player entered');
end;

procedure AddContact(var toAdd: HighScoreDataArray);
begin
	SetLength(toAdd, Length(toAdd) + 1);
	toAdd[High(toAdd)] := ReadPlayer();

end;

procedure HasContent(var toFind: HighScoreDataArray);
var
	find: String;
	i: Integer;
begin
	find := ReadString('Which contact name: ');
	for i := 0 to High(toFind) do
	begin
		if LowerCase(find) = LowerCase(toFind[i].name) then
		begin	
			WriteLn('Name found  in ', i+1, ' Position');
			WriteLn('Name: ', toFind[i].name,' Score: ', toFind[i].scores);
		end
		else
		begin
			WriteLn('Name not found in ', i+1, ' Position');
		end
	end;
end;



procedure Main();
var

	Player: HighScoreDataArray;
	numPlayers: Integer;
	option: Integer;
	
begin
	numPlayers := ReadInteger('Enter initial number of Players: ');
	SetLength(Player, numPlayers);

	PopulateContacts(Player);

	repeat
	WriteLn('#######################################');
	WriteLn('Welcome to the games HighScore Program!');
	option := ReadInteger('1. Add another contact'#10'2. Print all contacts'#10'3. Find a contact'#10'4. Exit'#10);

	Case option of
		1 :  AddContact(Player);
	 	2 :  PrintHS(Player);
	 	3 :  HasContent(Player);
		4 :  halt();
		end;
	until option = 4;

end;

begin
	Main();
end.