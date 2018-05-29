using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.ComponentModel;

class Expenses
{
	public string Name {get; set;}
	public string Type {get; set;}
	public int Expense {get; set;}

	//other functions here for Expenses

	public string Details
	{
		get
		{
		return Name + " (" + Type + ") $" + Expense;
		}

	}

}

class ExpenseCalc
{
	private BindingList<Expenses> _Expensess = new BindingList<Expenses>();

	private Form ExpenseForm;
	private TextBox _nameText;
	private TextBox _TypeText;
	private TextBox _ExpenseText;
	private ListBox _ExpensesList;

	public ExpenseCalc()
	{
		ExpenseForm = new Form();

		Label nameLabel = new Label();
		nameLabel.Text = "Name: ";
		nameLabel.Left = 10;
		nameLabel.Top = 10;
		ExpenseForm.Controls.Add(nameLabel);

		Label TypeLabel = new Label();
		TypeLabel.Text = "Type: ";
		TypeLabel.Left = 10;
		TypeLabel.Top = 40;
		ExpenseForm.Controls.Add(TypeLabel);

		Label ExpenseLabel = new Label();
		ExpenseLabel.Text = "Expense: ";
		ExpenseLabel.Left = 10;
		ExpenseLabel.Top = 70;
		ExpenseForm.Controls.Add(ExpenseLabel);

		_nameText = new TextBox();
		_nameText.Left = 120;
		_nameText.Top = 10;
		ExpenseForm.Controls.Add(_nameText);

		_TypeText = new TextBox();
		_TypeText.Left = 120;
		_TypeText.Top = 40;
		ExpenseForm.Controls.Add(_TypeText);

		_ExpenseText = new TextBox();
		_ExpenseText.Left = 120;
		_ExpenseText.Top = 70;
		ExpenseForm.Controls.Add(_ExpenseText);

		Button addButton = new Button();
		addButton.Text = "Add";
		addButton.Left = 120;
		addButton.Top = 100;
		addButton.Click += AddButtonClick;
		ExpenseForm.Controls.Add(addButton);

		_ExpensesList = new ListBox();
		_ExpensesList.Left = 10;
		_ExpensesList.Top = 130;
		_ExpensesList.Width = ExpenseForm.Width - 20;
		_ExpensesList.Height = ExpenseForm.Height - 140;
		ExpenseForm.Controls.Add(_ExpensesList);

		_ExpensesList.DataSource = _Expensess;
		_ExpensesList.DisplayMember = "Details";
	}

	private void AddButtonClick(object sender, EventArgs args)
	{
		Expenses newExpenses = new Expenses();

		newExpenses.Name = _nameText.Text;
		newExpenses.Type = _TypeText.Text;
		int Expense = 0;
		int.TryParse(_ExpenseText.Text, out Expense);
		newExpenses.Expense = Expense;

		_Expensess.Add(newExpenses);

		_nameText.Text = "";
		_TypeText.Text = "";
		_ExpenseText.Text = "";
	}

	public void Run()
	{
		ExpenseForm.ShowDialog();
	}

}

class ExpensesCalculator
{
	public static void Main()
	{
		//creates a friend window
		ExpenseCalc mainForm = new ExpenseCalc();
		//runs ExpenseCalc
		mainForm.Run();
	}

}