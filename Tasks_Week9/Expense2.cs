using System;
using System.Collections.Generic;
using Input;

enum ExpenseKind{groceries, bills, entertainment, other, none};

class Expenses
{
	public int expense;
	public ExpenseKind kind;
	

	public void Print()
	{
		Console.WriteLine("Expense: $" + expense);
		Console.WriteLine("Type: " + kind);
	}

	public static ExpenseKind ReadKind(string prompt)
	{
		
		ExpenseKind result = ExpenseKind.none;
		do
		{
			string value = ReadString(prompt);
			
			
			if(value == "groceries")
			{
				result = ExpenseKind.groceries;
			}
			if(value == "bills")
			{
				result = ExpenseKind.bills;
			}
			if(value == "entertainment")
			{
				result = ExpenseKind.entertainment;
			}
			if(value == "other")
			{
				result = ExpenseKind.other;
			}
				
			
			if (result == ExpenseKind.none)
			{
			Console.WriteLine("please enter groceries, bills, entertainment or other");
			}
		} while (result == ExpenseKind.none);

		return result;
	}

}

class ExpensesCalc
{
	public static Expenses ReadExpense(string prompt)
	{
		Expenses result = new Expenses();
		Console.WriteLine(prompt);

		result.expense = ReadInteger("Enter Cost: ");
		result.kind = Expenses.ReadKind("Enter type of expense: ");
		

		return result;
	}

	public static void AddExpense(List<Expenses> expenses)
	{
		expenses.Add(ReadExpense("-Enter new Expense-"));
	}

	public static void Main()
	{
		List<Expenses> expenses = new List<Expenses>();
		int count;
		int total = 0;

		count = ReadInteger("Enter how many expenses you wish to enter: ");

		for (int i = 0; i < count; i++)
		{
		AddExpense(expenses);
		}

		Console.WriteLine("-Printing Entered Values-");
		foreach(Expenses e in expenses)
		{
					//MyClass.MyItem.Property1
			total += e.expense;
			e.Print();
		}
			Console.WriteLine("Total Expenditure: $" + total);
	}


}