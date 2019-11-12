using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouPlay.Filtros;
using YouPlay.Models;
using YouPlay.DAO;

namespace YouPlay.Controllers
{
    [AutorizacaoFilter]
    public class DisciplinaController : PadraoController<DisciplinaViewModel>
    {
        public DisciplinaController()
        {
            DAO = new AulaDAO();
        }

        public override ActionResult Index()
        {
            ViewBag.Operacao = "I";
            DisciplinaViewModel disciplina = new DisciplinaViewModel();
            return View(disciplina);
        }
    }
}