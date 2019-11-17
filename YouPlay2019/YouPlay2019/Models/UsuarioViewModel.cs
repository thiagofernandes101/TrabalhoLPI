using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace YouPlay2019.Models
{
    public class UsuarioViewModel : PadraoViewModel
    {
        [Required(ErrorMessage = "Usuário não informado")]
        public string Usuario { get; set; }

        [Required(ErrorMessage = "Senha não informada")]
        public string Senha { get; set; }
    }
}
