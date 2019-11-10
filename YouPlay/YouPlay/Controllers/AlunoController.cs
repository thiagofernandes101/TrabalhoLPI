using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouPlay.Filtros;
using YouPlay.DAO;
using YouPlay.Models;

namespace YouPlay.Controllers
{
    public class AlunoController : PadraoController<AlunoViewModel>
    {
        // GET: Aluno
        public override ActionResult Consulta()
        {
            return View();
        }

        public override ActionResult Index()
        {
            try
            {
                ViewBag.Operacao = "I";

                // Preencher o dropbox escolaridade
                PreencheViewBagEscolaridade();

                AlunoViewModel aluno = new AlunoViewModel();
                return View(aluno);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #region métodos
        /// <summary>
        /// Obtem a escolaridade cadastrada
        /// </summary>
        private void PreencheViewBagEscolaridade()
        {
            AlunoDAO dao = new AlunoDAO();

            List<PadraoViewBagSelect> listaEscolaridade = dao.ObtemEscolaridade();
            List<PadraoViewBagSelect> listaVinculoAluno = dao.ObtemVinculoAluno();

            ViewBag.Escolaridade = listaEscolaridade;
            ViewBag.VinculoAluno = listaVinculoAluno;

        }
        #endregion
    }
}