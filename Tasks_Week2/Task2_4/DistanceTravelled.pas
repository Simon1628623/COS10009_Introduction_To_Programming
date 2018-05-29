program DistanceTravelled;
uses TerminalUserInput, Math;


function Distance (Velocity, time, accel: Double):Double;
begin
	result := Velocity * time + 0.5 * Power(accel * time, 2);

end;


procedure Main();
Var 
	V, T, A:Double;
	roundedDistance:Single;
begin
	
				//velocity time accel
	WriteLn('Distance1');	
	WriteLn('You are travelling at 0m/s for 120 seconds with 0.07m/s^2 of acceleration');			
	WriteLn('You Travelled ', Round(Distance(0, 120, 0.07)), ' Meters');
	
	WriteLn('Distance2');
	WriteLn('You are travelling at 8.33m/s for 120 seconds with no acceleration');
	WriteLn('You then Travelled ', Round(Distance(8.33, 120, 0)), ' Meters');
	


	V := ReadDouble('Enter your speed in m/s: ');
	T := ReadInteger('Enter how long you spent travelling in seconds: ');
	A := ReadDouble('Enter your Acceleration in m/s^2: ');

	//WriteLn(Distance(V, T, A));
	WriteLn('Enter new values to find distance travelled');
	WriteLn('You travelled ', round(Distance(V, T, A)), ' meters');

end;

begin
	Main();
end.