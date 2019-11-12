using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouPlay.DAO;
using YouPlay.Filtros;
using YouPlay.Models;

namespace YouPlay.Controllers
{
    [AutorizacaoFilter]
    public class ProfessorController : PadraoController<ProfessorViewModel>
    {
        public ProfessorController()
        {
            DAO = new ProfessorDAO();
            GeraProximoId = false;
        }

        public override ActionResult Index()
        {
            try
            {
                ViewBag.Operacao = "I";
                
                // Preencher o dropbox escolaridade
                PreencheViewBag();

                ProfessorViewModel professor = new ProfessorViewModel();
                return View(professor);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected override void ValidaDados(ProfessorViewModel model, string operacao)
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

        public void PreencheViewBag()
        {
            ProfessorDAO dao = new ProfessorDAO();
            List<PadraoViewBagSelect> listaStatus = dao.ListagemStatus();
            ViewBag.Status = listaStatus;

        }
    }
}