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
                //PreencheViewBagEscolaridade();
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
        public byte[] ConvertImageToByte(IFormFile file)
        {
            if (file != null)
            {
                using (var ms = new MemoryStream())
                {
                    file.CopyTo(ms);
                    return ms.ToArray();
                }
            }
            else
            {
                return null;
            }
        }
        protected override void ValidaDados(AlunoViewModel model, string operacao)
        {
            base.ValidaDados(model, operacao);
            if (string.IsNullOrEmpty(model.Nome))
            {
                ModelState.AddModelError("Nome", "Preencha o nome.");
            }

            //Imagem será obrigatio apenas na inclusão. 
            //Na alteração iremos considerar a que já estava salva.
            if (model.Imagem == null && operacao == "I")
            {
                ModelState.AddModelError("Imagem", "Escolha uma imagem.");
            }

            if (model.Imagem != null && model.Imagem.Length / 1024 / 1024 >= 2)
            {
                ModelState.AddModelError("Imagem", "Imagem limitada a 2 mb.");
            }

            if (ModelState.IsValid)
            {
                //na alteração, se não foi informada a imagem, iremos manter a que
                //já estava salva.
                if (operacao == "A" && model.Imagem == null)
                {
                    AlunoViewModel cid = DAO.Consulta(model.Codigo);
                    model.ImagemEmByte = cid.ImagemEmByte;
                }
                else
                {
                    model.ImagemEmByte = ConvertImageToByte(model.Imagem);
                }
            }
        }
        #endregion
    }
}
