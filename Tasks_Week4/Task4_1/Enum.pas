program enum;
uses TerminalUserInput;

//enum creating a type
type 
	priority = (Low, Medium, High);


//record for storing variables 
type 
	BountyList = record
		name: String;
		reward: Integer;
		crime: string;
		priorityv: priority;

	end;

//ReadPriority created to validate fields to make sure proper value entered

function ReadPriority(prompt: String): priority;
var
	entered : string;
begin
	
	repeat
		Write(prompt);
		ReadLn(entered);
		entered := LowerCase(entered);

		Case entered of  
 			'low' : result := Low;  
 			'medium' : result := Medium;  
 			'high' : result := high;  

 		else  
  			WriteLn ('Please enter either low, medium or high, not: ',entered);  
  		end;

	until (entered = 'low') OR (entered = 'medium') OR (entered = 'high');

end;

//GetInfo used for inputtting values into program

function GetInfo(prompt: string): BountyList;
begin
	//calling field inside the record
	result.name := readString('enter criminals name: ');
	result.reward := readInteger('Enter reward value: $');
	result.crime := readString('Enter crime commited: ');
	result.priorityv := ReadPriority('Enter priority of capture: ');
end;

//printinfo used for displaying the values on the terminal

procedure PrintInfo(print:BountyList);
begin
	WriteLn('Bounty Details');
	WriteLn('Name: ', print.name);
	WriteLn('Reward: $ ', print.reward);
	WriteLn('Crime/s Commited: ', print.crime);
	WriteLn('Priority: ', print.priorityv);
end;



procedure Main();
var
	//declaring record
	BountyA: BountyList;
	
	selection: Integer;
begin
	selection:= 0;
	
	while selection = 0 DO
	begin
		selection := readInteger('BO$$$$$$$$$$$$$CRIMINALS$$$$$$'#10'$$UN$$$$$$$$$$$$$$CAUGHT$$$$$$'#10'$$$$TY$LIST$$$$$$$$$$$$$$$$$$$'#10'Enter 1 to get bounty info '#10'Enter 2 to print current bounties '#10'Enter 3 to quit ');

		if selection = 1 then
		begin
			BountyA := GetInfo('Enter Bounty Information');
			WriteLn('Data Entered');
			selection:= 0;
		end;

		if selection = 2 then
		begin
			
			PrintInfo(BountyA);
			
			selection:= 0;
		end;

		if selection = 3 then
		begin
			//ends program
			halt();
		end;

	end;

end;

begin
	Main();
end.