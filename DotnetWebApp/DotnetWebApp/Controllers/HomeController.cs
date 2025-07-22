using DotnetWebApp.Models;
using System.Web.Mvc;

namespace DotnetWebApp.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View(new IndexViewModel());
        }
    }
}