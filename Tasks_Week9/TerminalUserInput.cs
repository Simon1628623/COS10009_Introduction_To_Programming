// ============================
// = User Input Function in C =
// ============================


using System;

public static class Input
{
  /// <summary>
  /// Reads a string from the Terminal.
  /// </summary>
  public static string ReadString(string prompt)
  {
    Console.Write (prompt);
    return Console.ReadLine ();
  }

  /// <summary>
  /// Reads the user's response to a prompt, and ensures that the
  /// answer is an integer.
  /// </summary>
  public static int ReadInteger(string prompt)
  {
    string userInput = ReadString (prompt);
    int num;
    
    while (false == Int32.TryParse(userInput, out num))
    {
      Console.WriteLine(userInput + " is not a valid Integer value.\nPlease enter a whole number.");
      userInput = ReadString (prompt);
    }

    return num;
  }

  /// <summary>
  /// Reads the user's response to a prompt, and ensures that the
  /// answer is a double.
  /// </summary>
  public static double ReadDouble(string prompt)
  {
    string userInput = ReadString (prompt);
    double num;
    
    while (false == Double.TryParse(userInput, out num))
    {
      Console.WriteLine(userInput + " is not a valid Double value.\nPlease enter a real number.");
      userInput = ReadString (prompt);
    }

    return num;
  }
}
