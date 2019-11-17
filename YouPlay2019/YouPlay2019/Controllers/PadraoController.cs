using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Data.SqlClient;
using YouPlay2019.DAO;
using YouPlay2019.Models;

namespace YouPlay2019.Controllers
{
    public class PadraoController<T> : Controller where T : PadraoViewModel
    {
        protected PadraoDAO<T> DAO { get; set; }

        /// <summary>
        /// Abrir a tela de cadastro de dados
        /// </summary>
        /// <returns></returns>
        public virtual IActionResult Index()
        {
            ViewBag.Operacao = "I";
            ViewBag.Erro = null;

            ListagemViewBag();

            return View();
        }

        /// <summary>
        /// Abrir a tela de consulta de dados
        /// </summary>
        /// <returns></returns>
        public virtual IActionResult Consulta()
        {
            ViewBag.Erro = null;

            List<T> listaConsulta = new List<T>();
            listaConsulta = DAO.Listagem();

            return View(listaConsulta);
        }

        /// <summary>
        /// Salvar as informações de cadastro
        /// </summary>
        /// <param name="model"></param>
        /// <param name="Operacao"></param>
        /// <returns></returns>
        public virtual IActionResult Salvar(T model, string Operacao)
        {
            try
            {
                ViewBag.Erro = null;

                ValidaDados(model, Operacao);

                if (ModelState.IsValid == false)
                {
                    ViewBag.Operacao = Operacao;
                    ListagemViewBag();
                    return View("Index", model);
                }
                else
                {
                    if (Operacao == "I")
                    {
                        DAO.Insert(model);
                    }
                    else
                    {
                        DAO.Update(model);
                    }

                    return RedirectToAction("Consulta");
                }
            }
            catch (Exception erro)
            {
                ViewBag.Erro = "Ocorreu um erro: " + erro.Message;
                ViewBag.Operacao = Operacao;

                ListagemViewBag();

                return View("Index", model);
            }
        }

        /// <summary>
        /// Editar as informações do id informado
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IActionResult Edit(int id)
        {
            try
            {
                ViewBag.Erro = null;
                ViewBag.Operacao = "A";

                var model = DAO.Consulta(id);

                if (model == null)
                {
                    return RedirectToAction("Consulta");
                }
                else
                {
                    ListagemViewBag();
                    return View("Index", model);
                }
            }
            catch (Exception erro)
            {
                ViewBag.Erro = erro.Message;
                return RedirectToAction("Consulta");
            }
        }

        /// <summary>
        /// Deletar da tabela o id informado
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IActionResult Delete(int id)
        {
            try
            {
                ViewBag.Erro = null;

                DAO.Delete(id);

                return RedirectToAction("Consulta");
            }
            catch (Exception erro)
            {
                ViewBag.Erro = erro.Message;
                return RedirectToAction("Consulta");
            }
        }

        /// <summary>
        /// O padrão será a listagem de genero e status
        /// </summary>
        protected virtual void ListagemViewBag()
        {
            try
            {
                List<BagSelectViewModel> listagemGenero = DAO.ListagemSelect("genero");
                ViewBag.Genero = listagemGenero;
            }
            catch (Exception erro)
            {
                ViewBag.Erro = erro.Message;
            }
        }

        /// <summary>
        /// Validação de dados de entrada
        /// </summary>
        /// <param name="model"></param>
        /// <param name="operacao"></param>
        protected virtual void ValidaDados(T model, string operacao)
        {
            if (operacao.Equals("A") && model.Codigo <= 0)
            {
                ModelState.AddModelError("Codigo", "Código inválido.");
            }
        }

        /// <summary>
        /// Validação de login
        /// </summary>
        /// <param name="context"></param>
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (!HelperController.VerificaUserLogado(HttpContext.Session))
            {
                context.Result = RedirectToAction("Index", "Login");
            }
            else
            {
                ViewBag.Logado = true;
                base.OnActionExecuting(context);
            }
        }
    }
}