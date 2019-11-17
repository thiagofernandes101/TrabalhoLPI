using System;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.IO;

namespace YouPlay.Models
{
    public abstract class Pessoa : PadraoViewModel
    {
        [Required(ErrorMessage = "Insira o nome")]
        public string Nome { get; set; }

        [Required(ErrorMessage = "Selecione o genero")]
        public string Genero { get; set; }

        [Required(ErrorMessage = "Insira a data de nascimento")]
        public DateTime DataNascimento { get; set; }

        public int Idade { get; set; }

        public string Rg { get; set; }

        public string Cpf { get; set; }

        [Required(ErrorMessage = "Insira o email")]
        public string Email { get; set; }

        public string Rua { get; set; }

        public int Numero { get; set; }

        public string Bairro { get; set; }

        public string Cidade { get; set; }

        public string Estado { get; set; }

        [Required(ErrorMessage = "Insira o CEP")]
        public int Cep { get; set; }

        /// <summary>
        /// Imagem recebida do form pelo controller
        /// </summary>
        [Required(ErrorMessage = "Inserir uma imagem")]
        public IFormFile Imagem { get; set; }

        public string ImageBase64 { get; set; }

        public byte[] ImageByte()
        {
            if (Imagem != null)
            {
                using (var ms = new MemoryStream())
                {
                    Imagem.CopyTo(ms);
                    return ms.ToArray();
                }
            }
            else
            {
                return null;
            }
        }
    }
}