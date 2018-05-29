program TestUserInput;
uses TerminalUserInput, SysUtils;


procedure Main();
var
	name: String;
	friend: String;
	age: Integer;
	guess: Integer;
	percent: Double;
	again: Boolean;
begin
	
	name := ReadString('Enter name: ');
	age := ReadInteger('Enter your age: ');

	//Displays a prompt and reads value inputted and if not inbetween 1 and 10 is repeats function until ones is inputted
	guess := ReadIntegerRange('Enter a number between 1 and 10: ', 1, 10);

	percent := ReadSingleRange('Enter percent value (0 to 1.0 for 100%): ', 0.0, 1.0);
	//percent := ReadSingle('yoyoyyoy');

	again := ReadBoolean('Play again [y/n]? ');

	friend := ReadString('Enter a friend''s name: ');


	WriteLn('Your Name: ', name);
	WriteLn('Your Friend''s Name: ', friend);
	WriteLn('Age: ', age);
	WriteLn('Guess: ', guess);
	WriteLn('Percent: ', percent:4:2);
	WriteLn('Again: ', again);
end;

begin
	Main();
end.