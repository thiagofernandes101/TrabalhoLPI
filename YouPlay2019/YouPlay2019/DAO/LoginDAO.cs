using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using YouPlay2019.Models;

namespace YouPlay2019.DAO
{
    public class LoginDAO
    {
        protected SqlParameter[] CriaParametros(UsuarioViewModel model)
        {
            SqlParameter[] parametro = new SqlParameter[2];
            parametro[0] = new SqlParameter("usuario", model.Usuario);
            parametro[1] = new SqlParameter("senha", model.Senha);

            return parametro;
        }

        protected UsuarioViewModel MontaModel(DataRow registro)
        {
            UsuarioViewModel usuario = new UsuarioViewModel
            {
                Codigo = Convert.ToInt32(registro["codigo"]),
                Usuario = registro["usuario"].ToString()
            };

            return usuario;
        }

        public UsuarioViewModel ObtemUsuario(UsuarioViewModel model)
        {
            var parametro = new SqlParameter[]
            {
                new SqlParameter("usuario", model.Usuario),
                new SqlParameter("senha", model.Senha)
            };

            DataTable tabela = HelperDAO.ExecutaProcSelect("sp_obtem_usuario", parametro);

            if (tabela.Rows.Count == 0)
            {
                return null;
            }
            else
            {
                return MontaModel(tabela.Rows[0]);
            }
        }
    }
}
