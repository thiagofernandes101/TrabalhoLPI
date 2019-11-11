using System;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace YouPlay.Models
{
    public abstract class Pessoa : PadraoViewModel
    {
        [Required(ErrorMessage = "Insira o nome")]
        public string Nome { get; set; }
        [Required(ErrorMessage = "Selecione o genero")]
        public string Genero { get; set; }
        [Required(ErrorMessage ="Insira a data de nascimento")]
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
        public IFormFile Imagem { get; set; }

        /// <summary>
        /// Imagem em bytes pronta para ser salva
        /// </summary>
        public byte[] ImagemEmByte { get; set; }

        /// <summary>
        /// Imagem usada para ser enviada ao form no formato para ser exibida
        /// </summary>
        public string ImagemEmBase64
        {
            get
            {
                if (ImagemEmByte != null)
                    return Convert.ToBase64String(ImagemEmByte);
                else
                    return string.Empty;
            }
        }
    }
}