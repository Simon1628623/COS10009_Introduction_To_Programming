Program HelloUser;
uses TerminalUserInput;

Procedure Main();
var
	name: String;
	age, year, yearBorn: Integer; 
	


begin
	name := ReadString('Please enter your name: ');
	age := ReadInteger('How old will you be this year?');
	
	year := ReadInteger('What year is it?');



	yearBorn := year - age;
	



	WriteLn('Hello ', name);
	WriteLn('You were born in ', yearBorn);

end;

begin 
	Main();
end.

