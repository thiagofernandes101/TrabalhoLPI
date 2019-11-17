using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace YouPlay2019.Models
{
    public class DisciplinaViewModel : PadraoViewModel
    {
        [Required(ErrorMessage = "Preencha o nome da disciplina")]
        public string Descricao { get; set; }

        public int TotalVagas { get; set; }

        [Required(ErrorMessage = "Informe a data")]
        public DateTime Data { get; set; }

        public int VagasDisponiveis { get; set; }
    }
}
