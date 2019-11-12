using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YouPlay.Models;

namespace YouPlay.DAO
{
    public class LoginDAO
    {
        private UsuarioViewModel MontaUsuario(DataRow row)
        {
            UsuarioViewModel usuarioLogado = new UsuarioViewModel
            {
                Codigo = Convert.ToInt32(row["codigo"]),
                Usuario = row["usuario"].ToString()
            };

            return usuarioLogado;
        }

        public UsuarioViewModel ObtemUsuario(string usuario, string senha)
        {
            var parametro = new SqlParameter[]
            {
                new SqlParameter("usuario", usuario),
                new SqlParameter("senha", senha)
            };

            var tabela = HelperDAO.ExecutaProcSelect("sp_obtem_login", parametro);

            if (tabela.Rows.Count.Equals(0))
            {
                return null;
            }
            else
            {
                return MontaUsuario(tabela.Rows[0]);
            }
        }
    }
}