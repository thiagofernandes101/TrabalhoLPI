using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using YouPlay2019.DAO;
using YouPlay2019.Models;

namespace YouPlay2019.Controllers
{
    public class AlunoController : PadraoController<AlunoViewModel>
    {
        public AlunoController()
        {
            DAO = new AlunoDAO();
        }

        public override IActionResult Index()
        {
            ViewBag.Operacao = "I";
            ViewBag.Erro = null;

            AlunoViewModel aluno = new AlunoViewModel();

            try
            {
                ListagemViewBag();
                return View(aluno);
            }
            catch (Exception erro)
            {
                ViewBag.Erro = erro.Message;

                ListagemViewBag();
                return View(aluno);
            }
        }

        protected override void ListagemViewBag()
        {
            base.ListagemViewBag();

            List<BagSelectViewModel> listagemStatusAluno = DAO.ListagemSelect("aluno_status");
            List<BagSelectViewModel> listaEscolaridade = DAO.ListagemSelect("escolaridade");
            List<BagSelectViewModel> listaAlunoResponsavel = DAO.ListagemSelect("vinculo");

            ViewBag.StatusAluno = listagemStatusAluno;
            ViewBag.EscolaridadeAluno = listaEscolaridade;
            ViewBag.VinculoAlunoResponsavel = listaAlunoResponsavel;
        }

        protected override void ValidaDados(AlunoViewModel model, string operacao)
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

            if (model.NomeResponsavel == null)
            {
                ModelState.Remove("NomeResponsavel");
            }

            if (model.RgResponsavel == null)
            {
                ModelState.Remove("RgResponsavel");
            }
            else if (model.RgResponsavel.Length != 9)
            {
                ModelState.AddModelError("RgResponsavel", "Rg inválido");
            }

            if (model.CpfResponsavel == null)
            {
                ModelState.Remove("CpfResponsavel");
            }
            else if (model.CpfResponsavel.Length != 11)
            {
                ModelState.AddModelError("CpfResponsavel", "CPF inválido");
            }

            if (model.TelefoneResponsavel == null)
            {
                ModelState.Remove("TelefoneResponsavel");
            }
            else if (model.TelefoneResponsavel.Length > 13)
            {
                ModelState.AddModelError("TelefoneResponsavel", "Telefone inválido");
            }
        }
    }
}