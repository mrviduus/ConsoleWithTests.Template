using Xunit;

namespace App.Tests;

public class ProgramTests
{
    [Fact]
    public void Test_Add_Returns_Correct_Sum()
    {
        // Arrange
        int a = 5;
        int b = 3;
        int expected = 8;

        // Act
        int result = Program.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Test_Add_With_Negative_Numbers()
    {
        // Arrange
        int a = -5;
        int b = 3;
        int expected = -2;

        // Act
        int result = Program.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }

    [Theory]
    [InlineData(0, 0, 0)]
    [InlineData(1, 1, 2)]
    [InlineData(10, 20, 30)]
    [InlineData(-10, -20, -30)]
    public void Test_Add_Multiple_Cases(int a, int b, int expected)
    {
        // Act
        int result = Program.Add(a, b);

        // Assert
        Assert.Equal(expected, result);
    }
}