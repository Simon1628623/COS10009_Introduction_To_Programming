Program NameTester;
uses TerminalUserInput;

procedure PrintSillyName(name: String);
var 
	i : Integer;

begin
i := 0;
WriteLn(name, ' is a ');

while i < 100 do
begin
Write(' Silly ');
i += 1;
end;
Write('name!');


end;

procedure Main();
var
	name: String;
begin
	name := ReadString('Please enter your name: ');

	if name = 'Andrew' then
	begin
		WriteLn('Awesome name!');
	end;

	if name = 'Luke' then
	begin
		WriteLn('Awesome name!');
	end;

	if name = 'Simon' then
	begin
		WriteLn('Awesome name!');
	end

	else
	PrintSillyName(name);
end;

begin
	Main();
end.