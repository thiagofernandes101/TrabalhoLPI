using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace YouPlay.DAO
{
    public class Conexao
    {
        public static SqlConnection GetConexao()
        {
            string strCon = "Data Source=localhost;Initial Catalog=YouplaY;user id = sa"; /*user id = sa; password = 123456*/
            SqlConnection conexao = new SqlConnection(strCon);
            conexao.Open();
            return conexao;
        }
    }
}