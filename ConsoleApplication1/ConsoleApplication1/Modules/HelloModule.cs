using Nancy;

namespace test.Modules
{
    public class HelloModule : NancyModule
    {
        public HelloModule()
        {
            Get["/"] = _ => "Hello, world!";
        }
    }
}
