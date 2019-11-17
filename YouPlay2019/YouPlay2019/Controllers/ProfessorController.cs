using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using YouPlay2019.Models;
using YouPlay2019.DAO;

namespace YouPlay2019.Controllers
{
    public class ProfessorController : PadraoController<ProfessorViewModel>
    {
        public ProfessorController()
        {
            DAO = new ProfessorDAO();
        }

        public override IActionResult Index()
        {
            ViewBag.Operacao = "I";
            ViewBag.Erro = null;

            ProfessorViewModel professor = new ProfessorViewModel();

            try
            {
                ListagemViewBag();
                return View(professor);
            }
            catch (Exception erro)
            {
                ViewBag.Erro = erro.Message;

                ListagemViewBag();
                return View(professor);
            }
        }

        protected override void ListagemViewBag()
        {
            base.ListagemViewBag();

            List<BagSelectViewModel> listagemStatusAluno = DAO.ListagemSelect("professor_status");

            ViewBag.StatusAluno = listagemStatusAluno;
        }

        protected override void ValidaDados(ProfessorViewModel model, string operacao)
        {
            base.ValidaDados(model, operacao);

            if (model.Imagem == null)
            {
                ModelState.AddModelError("Imagem", "Escolha uma imagem.");
            }
            else if (model.Imagem.Length / 1024 / 1024 >= 2)
            {
                ModelState.AddModelError("Imagem", "Imagem limitada a 2 mb.");
            }

            if (model.Nome == null)
            {
                ModelState.AddModelError("Nome", "Nome não informado");
            }

            if (string.IsNullOrEmpty(model.DataNascimento.ToString().Trim()))
            {
                ModelState.AddModelError("DataNascimento", "Data de nascimento não informado");
            }

            if (model.Rg.Trim() == null)
            {
                ModelState.AddModelError("Rg", "Número de RG inválido");
            }
            else if (model.Rg.Length != 9)
            {
                ModelState.AddModelError("Rg", "Número de RG inválido");
            }

            if (model.Cpf.Trim() == null)
            {
                ModelState.AddModelError("Cpf", "Número de CPF inválido");
            }
            else if (model.Cpf.Length != 11)
            {
                ModelState.AddModelError("Cpf", "Número de CPF inválido");
            }

            if (model.Telefone.Trim() == null)
            {
                ModelState.AddModelError("Telefone", "Número de telefone inválido");
            }
            else if (model.Telefone.Length > 13)
            {
                ModelState.AddModelError("Telefone", "Número de telefone inválido");
            }

            if (model.Email.Trim() == null)
            {
                ModelState.AddModelError("Email", "Email inválido");
            }

            if (model.Cep == null)
            {
                ModelState.AddModelError("Cep", "Cep informado inválido");
            }
            else if (Convert.ToInt32(model.Cep) <= 0 || model.Cep.ToString().Length != 8)
            {
                ModelState.AddModelError("Cep", "Cep informado inválido");
            }

            if (model.Numero.ToString().Trim() == null)
            {
                ModelState.AddModelError("Numero", "Número inváido");
            }
            else if (model.Numero < 0)
            {
                ModelState.AddModelError("Numero", "Número inváido");
            }
        }
    }
}