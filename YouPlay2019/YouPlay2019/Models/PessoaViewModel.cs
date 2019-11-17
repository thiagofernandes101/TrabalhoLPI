using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace YouPlay2019.Models
{
    public class PessoaViewModel : PadraoViewModel
    {
        [Required(ErrorMessage = "Insira o nome")]
        public string Nome { get; set; }

        [Required(ErrorMessage = "Selecione o genero")]
        public int Genero { get; set; }

        [Required(ErrorMessage = "Insira a data de nascimento")]
        public DateTime DataNascimento { get; set; }

        public int Idade { get; set; }

        [Required(ErrorMessage = "Informe o RG"), MaxLength(9), MinLength(9, ErrorMessage = "Insira todos os números do RG")]
        public string Rg { get; set; }

        [Required(ErrorMessage = "Informe o CPF"), MaxLength(11), MinLength(11, ErrorMessage = "Insira todos os números do CPF")]
        public string Cpf { get; set; }

        [Required(ErrorMessage = "Insira o email")]
        public string Email { get; set; }

        public string Rua { get; set; }

        public int Numero { get; set; }

        public string Bairro { get; set; }

        public string Cidade { get; set; }

        public string Estado { get; set; }

        [Required(ErrorMessage = "Insira o CEP")]
        public string Cep { get; set; }

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
