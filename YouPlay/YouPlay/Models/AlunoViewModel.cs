﻿using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Web;

namespace YouPlay.Models
{
    public class AlunoViewModel : Pessoa
    {
        [Required(ErrorMessage = "Insira o telefone do aluno")]
        public string Telefone { get; set; }

        public DateTime DataMatricula { get; set; } = DateTime.Now;

        [Required(ErrorMessage = "Selecione a escolaridade")]
        public int CodigoEscolaridade { get; set; }

        public string DescricaoEscolaridade { get; set; }

        [Required(ErrorMessage = "Insira o nome do responsável")]
        public string NomeResponsavel { get; set; }

        public string RgResponsavel { get; set; }

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