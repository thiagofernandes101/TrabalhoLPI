using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YouPlay.Models
{
    public class DisciplinaViewModel : PadraoViewModel
    {
        public DateTime Data { get; set; }
        public string Descricao { get; set; }
        public int TotalVagas { get; set; }
        public int VagasDisponiveis { get; set; }
        public string Aluno { get; set; }
        public string Professor { get; set; }
    }
}