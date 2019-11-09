using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YouPlay.Models
{
    public class UsuarioViewModel : PadraoViewModel
    {
        public string Usuario { get; set; }
        public string Senha { get; set; }
    }
}