using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace YouPlay2019.DAO
{
    public static class Conexao
    {
        public static SqlConnection GetConexao()
        {
            string stringConexao = "Data Source=localhost;Initial Catalog=NewYouPlay;user=sa;password=123456";
            SqlConnection conexao = new SqlConnection(stringConexao);

            conexao.Open();

            return conexao;
        }
    }
}
