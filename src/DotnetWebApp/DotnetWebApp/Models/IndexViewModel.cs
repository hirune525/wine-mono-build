namespace DotnetWebApp.Models
{
    public class IndexViewModel : IViewModel
    {
        public IndexViewModel()
        {
            Message = "Hello, World!";
        }

        public IndexViewModel(string message)
        {
            Message = message;
        }

        public string Title => "Welcome to ASP.NET Framework";

        public string Message { get; set; }
    }
}