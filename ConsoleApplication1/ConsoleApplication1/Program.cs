using Nancy;
using Nancy.Hosting.Self;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var host = new NancyHost(new Uri("https://localhost:7364/")))
            {
                host.Start();
                Console.ReadLine();
            }
        }
    }
}
