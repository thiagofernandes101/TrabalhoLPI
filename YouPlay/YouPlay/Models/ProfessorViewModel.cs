using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YouPlay.Models
{
    public class ProfessorViewModel : Pessoa
    {
        public int CodigoStatus { get; set; }

        public string DescricaoStatus { get; set; }

        public string Telefone { get; set; }

        public string DescricaoDisciplina { get; set; }
    }
}