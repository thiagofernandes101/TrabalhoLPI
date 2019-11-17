using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using YouPlay2019.Models;
using YouPlay2019.DAO;

namespace YouPlay2019.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Login(UsuarioViewModel model)
        {
            try
            {
                LoginDAO dao = new LoginDAO();
                UsuarioViewModel usuarioLogado = dao.ObtemUsuario(model);

                if (usuarioLogado != null)
                {
                    HttpContext.Session.SetString("Logado", "true");
                    ViewBag.Logado = HelperController.VerificaUserLogado(HttpContext.Session);
                    return RedirectToAction("Index", "Professor");
                }
                else
                {
                    ViewBag.Erro = "Usuário ou senha inválidos!";
                    return View("Index");
                }
            }
            catch (Exception ex)
            {
                ViewBag.Erro = ex.Message;
                return View("Index");
            }
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }
    }
}