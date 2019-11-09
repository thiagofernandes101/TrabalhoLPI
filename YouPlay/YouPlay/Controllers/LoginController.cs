using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouPlay.DAO;
using YouPlay.Models;

namespace YouPlay.Controllers
{
    public class LoginController : Controller
    { 

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login(string usuario, string senha)
        {
            try
            {
                LoginDAO dao = new LoginDAO();
                UsuarioViewModel usuarioLogado = dao.ObtemUsuario(usuario, senha);
                Session["usuarioLogado"] = usuarioLogado;
                return RedirectToAction("Consulta", "Aula");
            }
            catch (Exception ex)
            {
                ViewBag.ErroLogin = "Usuario não encontrado ou não cadastrado";
                return View("Index");
            }
        }

        public ActionResult LogOut()
        {
            Session.Clear();
            return RedirectToAction("Index", "Home");
        }
    }
}