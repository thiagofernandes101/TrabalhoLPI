using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouPlay.Filtros;
using YouPlay.Models;

namespace YouPlay.Controllers
{

    public class ProfessorController : PadraoController<ProfessorViewModel>
    {
        // GET: Professor
        public override ActionResult Consulta()
        {
            return View();
        }

        public override ActionResult Index()
        {
            return View();
        }
    }
}