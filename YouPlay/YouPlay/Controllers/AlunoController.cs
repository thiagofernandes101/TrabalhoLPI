using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouPlay.Filtros;
using YouPlay.DAO;
using YouPlay.Models;
using System.IO;
using Microsoft.AspNetCore.Http;

namespace YouPlay.Controllers
{
    [AutorizacaoFilter]
    public class AlunoController : PadraoController<AlunoViewModel>
    {
        public AlunoController()
        {
            DAO = new AlunoDAO();
            GeraProximoId = false;
        }
        // GET: Aluno
        public override ActionResult Index()
        {
            try
            {
                ViewBag.Operacao = "I";

                // Preencher o dropbox escolaridade
                PreencheViewBag();

                AlunoViewModel aluno = new AlunoViewModel();
                return View(aluno);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #region métodos
        //public byte[] ConvertImageToByte(IFormFile file)
        //{
        //    if (file != null)
        //    {
        //        using (var ms = new MemoryStream())
        //        {
        //            file.CopyTo(ms);
        //            return ms.ToArray();
        //        }
        //    }
        //    else
        //    {
        //        return null;
        //    }
        //}

        protected override void ValidaDados(AlunoViewModel model, string operacao)
        {
            base.ValidaDados(model, operacao);

            if (string.IsNullOrEmpty(model.Nome))
            {
                ModelState.AddModelError("Nome", "Preencha o nome.");
            }

            if (model.Genero.Equals(0))
            {
                ModelState.AddModelError("Genero", "Selecione uma opção");
            }

            if (model.CodigoStatus.Equals(0))
            {
                ModelState.AddModelError("Status", "Selecione uma opção");
            }

            if (model.CodigoVinculoResponsavel.Equals(0))
            {
                ModelState.AddModelError("Vinculo", "Selecione uma opção");
            }

            if (model.CodigoEscolaridade.Equals(0))
            {
                ModelState.AddModelError("Escolaridade", "Selecione uma opção");
            }

            //Imagem será obrigatio apenas na inclusão. 
            //Na alteração iremos considerar a que já estava salva.
            //if (model.Imagem == null && operacao == "I")
            //{
            //    ModelState.AddModelError("Imagem", "Escolha uma imagem.");
            //}

            //if (model.Imagem != null && model.Imagem.Length / 1024 / 1024 >= 2)
            //{
            //    ModelState.AddModelError("Imagem", "Imagem limitada a 2 mb.");
            //}

            //if (ModelState.IsValid)
            //{
            //    //na alteração, se não foi informada a imagem, iremos manter a que
            //    //já estava salva.
            //    if (operacao == "A" && model.Imagem == null)
            //    {
            //        AlunoViewModel cid = DAO.Consulta(model.Codigo);
            //        model.ImagemEmByte = cid.ImagemEmByte;
            //    }
            //    else
            //    {
            //        model.ImagemEmByte = ConvertImageToByte(model.Imagem);
            //    }
            //}
        }

        //public void PreencheViewBag()
        //{
        //    AlunoDAO dao = new AlunoDAO();

        //    List<PadraoViewBagSelect> listaEscolaridade = dao.ObtemEscolaridade();
        //    List<PadraoViewBagSelect> listaVinculoAluno = dao.ObtemVinculoAluno();
        //    List<PadraoViewBagSelect> listaStatus = dao.ListagemStatus();

        //    ViewBag.Escolaridade = listaEscolaridade;
        //    ViewBag.VinculoAluno = listaVinculoAluno;
        //    ViewBag.Status = listaStatus;

        //}
        #endregion
    }
}
