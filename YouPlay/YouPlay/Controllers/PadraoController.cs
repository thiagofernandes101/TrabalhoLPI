using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouPlay.Models;
using YouPlay.DAO;

namespace YouPlay.Controllers
{
    public abstract class PadraoController<T> : Controller where T : PadraoViewModel
    {
        protected PadraoDAO<T> DAO { get; set; }
        protected bool GeraProximoId { get; set; }

        public abstract ActionResult Index();

        public abstract ActionResult Consulta();

        protected virtual void PreencheDadosParaView(string Operacao, T model)
        {
            if (GeraProximoId && Operacao == "I")
                model.Codigo = DAO.ProximoId();
        }

        [HttpPost]
        public virtual ActionResult Salvar(T model, string Operacao)
        {
            try
            {
                ValidaDados(model, Operacao);
                if (ModelState.IsValid == false)
                {
                    ViewBag.Operacao = Operacao;
                    //PreencheDadosParaView(Operacao, model);
                    PreencheViewBag();
                    return View("Index", model);
                }
                else
                {
                    if (Operacao == "I")
                        DAO.Insert(model);
                    else
                        DAO.Update(model);
                    return RedirectToAction("Consulta");
                }
            }
            catch (Exception erro)
            {
                ViewBag.Erro = "Ocorreu um erro: " + erro.Message;
                ViewBag.Operacao = Operacao;
                PreencheDadosParaView(Operacao, model);
                return View("Index", model);
            }
        }

        protected virtual void ValidaDados(T model, string operacao)
        {
            if (operacao == "I" && DAO.Consulta(model.Codigo) != null)
            {
                ModelState.AddModelError("Id", "Código já está em uso!");
            }

            if (operacao == "A" && DAO.Consulta(model.Codigo) == null)
            {
                ModelState.AddModelError("Id", "Este registro não existe!");
            }

            if (model.Codigo <= 0)
            {
                ModelState.AddModelError("Id", "Id inválido!");
            }
        }

        public ActionResult Edit(int id)
        {
            try
            {
                ViewBag.Operacao = "A";
                var model = DAO.Consulta(id);
                if (model == null)
                    return RedirectToAction("Consulta");
                else
                {
                    PreencheDadosParaView("A", model);
                    return View("Index", model);
                }
            }
            catch
            {
                return RedirectToAction("Consulta");
            }
        }

        public ActionResult Delete(int id)
        {
            try
            {
                DAO.Delete(id);
                return RedirectToAction("Consulta");
            }
            catch
            {
                return RedirectToAction("Consulta");
            }
        }

        public void PreencheViewBag()
        {
            AlunoDAO dao = new AlunoDAO();

            List<PadraoViewBagSelect> listaEscolaridade = dao.ObtemEscolaridade();
            List<PadraoViewBagSelect> listaVinculoAluno = dao.ObtemVinculoAluno();
            List<PadraoViewBagSelect> listaStatus = dao.ListagemStatus();

            ViewBag.Escolaridade = listaEscolaridade;
            ViewBag.VinculoAluno = listaVinculoAluno;
            ViewBag.Status = listaStatus;

        }
    }
}