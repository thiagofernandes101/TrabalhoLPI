using Microsoft.AspNetCore.Http;
using System.IO;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace YouPlay2019.Models
{
    public class AlunoViewModel : PessoaViewModel
    {
        [Required(ErrorMessage = "Insira o telefone do aluno")]
        public string Telefone { get; set; }

        public DateTime DataMatricula { get; set; } = DateTime.Now;

        [Required(ErrorMessage = "Selecione a escolaridade")]
        public int CodigoEscolaridade { get; set; }

        public string DescricaoEscolaridade { get; set; }

        [Required(ErrorMessage = "Insira o nome do responsável")]
        public string NomeResponsavel { get; set; }

        [Required(ErrorMessage = "Informe o RG"), MaxLength(9), MinLength(9, ErrorMessage = "Insira todos os números do RG")]
        public string RgResponsavel { get; set; }

        [Required(ErrorMessage = "Informe o CPF"), MaxLength(11), MinLength(11, ErrorMessage = "Insira todos os números do CPF")]
        public string CpfResponsavel { get; set; }

        [Required(ErrorMessage = "Insira o telefone do responsável")]
        public string TelefoneResponsavel { get; set; }

        [Required(ErrorMessage = "Selecione o vinculo do aluno com o responsável")]
        public int CodigoVinculoResponsavel { get; set; }

        public string DescricaoVinculoResponsavel { get; set; }

        public int CodigoStatus { get; set; }

        public string DescricaoStatus { get; set; }

        public string DescricaoDisciplina { get; set; }
    }
}
