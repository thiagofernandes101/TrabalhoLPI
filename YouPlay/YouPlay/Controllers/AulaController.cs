using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouPlay.Filtros;
using YouPlay.Models;

namespace YouPlay.Controllers
{
    [AutorizacaoFilter]
    public class AulaController : PadraoController<DisciplinaViewModel>
    {
        // GET: Aula
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