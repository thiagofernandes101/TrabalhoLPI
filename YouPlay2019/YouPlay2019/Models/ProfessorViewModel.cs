using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace YouPlay2019.Models
{
    public class ProfessorViewModel : PessoaViewModel
    {
        public int CodigoStatus { get; set; }

        public string DescricaoStatus { get; set; }

        public string Telefone { get; set; }

        public string DescricaoDisciplina { get; set; }
    }
}
