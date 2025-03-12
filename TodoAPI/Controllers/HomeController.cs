using Microsoft.AspNetCore.Mvc;

namespace TodoAPI.Controllers
{
    [Route("/")]  // This will map the root URL (http://localhost:5080)
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return Ok("Welcome to the Todo API!");
            // return View("Welcome to the Todo API!");
        }
    }
}
