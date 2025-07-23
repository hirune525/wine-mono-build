using System;

namespace DotnetConsoleApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var service = new Service(".net framework console.");
            Console.WriteLine(service.GetName());
        }
    }
}
