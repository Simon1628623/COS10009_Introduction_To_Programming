using System;
using System.Collections.Generic;
using Input;

public enum ExpenseKind{groceries, bills, entertainment, other};

struct User 
{
	public static int[] expenses;
	public static ExpenseKind[] kind;
} 

class ExpenseProgram
{
	
	public static ExpenseKind ReadKind(string prompt)
	{
		do
		{
			Console.WriteLine("groceries = 1, bills = 2, entertainment = 3 and other = 4");
			//string value = ReadString("Enter Kind: ");
			string value = ReadString("Enter Value: ");
			ExpenseKind result;
			
			if(value == "groceries")
			{
				result = groceries;
			}
			if(value == "bills")
			{
				result = bills;
			}
			if(value == "entertainment")
			{
				result = entertainment;
			}
			if(value == "other")
			{
				result = other;
			}
				
			
			if (value != "groceries" || value != "bills" || value != "entertainment" || value != "other")
			{
			Console.WriteLine("please enter groceries, bills, entertainment or other");
			}
		} while (result = null);
		return result;
	}

	public static User ReadExpenses(string prompt)
	{
		int i, j;
		User result;
		Console.WriteLine(prompt);
		j = ReadInteger("How many expenses do you want to add?");

		for (i=0; i <=j; i++)
		{
			result.expenses[i] = ReadInteger("Enter expense amount:");
			result.kind[i] = ReadKind("Enter type of expense:");
		}
	}

	public static void PrintExpenses(User print)
	{
		int result = 0;
		int total = 0; 
		int expenses = 0;
		int i;
		User user;

		for (i = 0; i <= expenses.Count - 1; i++);
		{
			Console.WriteLine("Expense: $", expenses[i]);
			Console.WriteLine("Type: ", kind[i]);
			total += expenses;
		}

		Console.WriteLine("Total Expenses: ", total);

	}

	public static void Main()
	{
		List<User> users = new List<User>();
		
		int Sel = ReadInteger("Enter What you want");

			switch(Sel)
			{
				case 1:ReadExpenses("Please Enter Your Expenses"); 
				case 2:PrintExpenses(users);
				
				break;
			}
			if(Sel != 1 || Sel != 2)
			{
			Console.WriteLine("please enter 1 or 2");
			}

		

	}







}