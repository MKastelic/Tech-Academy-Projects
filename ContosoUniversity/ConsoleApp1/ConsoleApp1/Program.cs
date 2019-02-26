using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            word string = Console.ReadLine("Type in a word: ");
            
            for (int i = 0; i < word.Length; i++)
            {
                string result;
                result.Append(word[i]);
            }

            Console.WriteLine(result);
            // Go to http://aka.ms/dotnet-get-started-console to continue learning how to build a console app! 
        }
    }
}
