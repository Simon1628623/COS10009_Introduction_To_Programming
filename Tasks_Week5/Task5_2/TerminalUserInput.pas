unit TerminalUserInput;

interface

///
/// Displays a prompt to the user, and reads in the string
/// they reply with. The string entered is then returned.
///
function ReadString(prompt: String): String;

///
/// Displays a prompt to the user, and reads in the number (whole)
/// they reply with. The function ensures that the user's entry
/// is a valid Integer. The Integer entered is then returned.
///
function ReadInteger(prompt: String): Integer;

///
/// Displays a prompt to the user, and reads in the number (real)
/// they reply with. The function ensures that the user's entry
/// is a valid Double. The Double entered is then returned.
///
function ReadDouble(prompt: String): Double;

//Displays a prompt for the user
//the prompt must be within the minimum and maximum values listed in the parameters
//type integer
function ReadIntegerRange(Prompt: string; min, max:Integer): Integer;

//Will display a prompt 
//user must enter values between the minimum and maximum paramters
//type single
function ReadSingleRange(Prompt: string; min, max:Single): Single;

//
//displays a prompt to tell user what to enter
//type single
function ReadSingle(Prompt: string): Single;

//
//Boolean value that displays text for what to do
//type Boolean
function ReadBoolean(Prompt: string ): Boolean;




implementation
uses SysUtils;

function ReadString(prompt: String): String;
begin
	Write(prompt);
	ReadLn(result);
end;

function ReadInteger(prompt: String): Integer;
var
	line: String;
begin
	line := ReadString(prompt);
	while not TryStrToInt(line, result) do
	begin
		WriteLn(line, ' is not an integer.');
		line := ReadString(prompt);
	end;
end;

function ReadDouble(prompt: String): Double;
var
	line: String;
begin
	line := ReadString(prompt);
	while not TryStrToFloat(line, result) do
	begin
		WriteLn(line, ' is not a double.');
		line := ReadString(prompt);
	end;
end;


function ReadSingle(prompt: String): Single;
var
	line: String;
begin
	line := ReadString(prompt);
	while not TryStrToFloat(line, result) do
	begin
		WriteLn(line, ' is not an Single.');
		line := ReadString(prompt);
	end;
end;

//percent range

function ReadSingleRange(Prompt: string; min, max:Single): Single;
var
	num: Single;

begin

	repeat
		num := ReadSingle(Prompt);
	until (num >= min) AND (num <= max);

	Result := num;
end;


//for age

function ReadIntegerRange(Prompt: string; min, max:Integer): Integer;
var
	num: Integer;

begin
	num := 0;

	While(num < min) OR (num > max) do
		num := ReadInteger(Prompt);
		Result := num;
end;


//again?

function ReadBoolean(Prompt: string ): Boolean;
var
	num: String;
	Again, Continue: Boolean;


begin
	Continue := false;
	
	While Continue = false do
	Begin
		num := ReadString(Prompt);
		num := LowerCase(num);
		

		if num = 'true' THen
		begin
			Again := true;
			Continue :=true;
		end;

		if num = 'yes' Then
		begin
			Again := true;
			Continue :=true;
		end;

		if num = 'y' Then
		begin
			Again := true;
			Continue :=true;
		end;

		if num = 't' THen
		begin
			Again := true;
			Continue :=true;
		end;
		//negative
		if num = 'false' THen
		begin
			Again := false;
			Continue :=true;
		end;

		if num = 'no' Then
		begin
			Again := false;
			Continue :=true;
		end;

		if num = 'n' Then
		begin
			Again := false;
			Continue :=true;
		end;

		if num = 'f' THen
		begin
			Again := false;
			Continue :=true;
		end;
		Result := Again;
	End;
	
	
end;



end.