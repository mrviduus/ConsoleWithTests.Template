namespace App;

public class Program
{
    public static void Main(string[] args)
    {
        Console.WriteLine("Hello from ProjectName!");
        Console.WriteLine("This console app was created with the console-with-tests template.");
        int sum = Add(3, 5);
        Console.WriteLine($"3 + 5 = {sum}");


    }

    public static int Add(int a, int b)
    {
        return a + b;
    }
}