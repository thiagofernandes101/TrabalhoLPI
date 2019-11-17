using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using YouPlay2019.DAO;
using YouPlay2019.Models;

namespace YouPlay2019.Controllers
{
    public class DisciplinaController : PadraoController<DisciplinaViewModel>
    {
        public DisciplinaController()
        {
            DAO = new DisciplinaDAO();
        }

        public override IActionResult Index()
        {
            ViewBag.Operacao = "I";
            ViewBag.Erro = null;

            DisciplinaViewModel disciplina = new DisciplinaViewModel();

            return View("Index", disciplina);
        }
    }
}