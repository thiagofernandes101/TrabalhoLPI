using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using YouPlay2019.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace YouPlay2019.DAO
{
    public class ProfessorDAO : PadraoDAO<ProfessorViewModel>
    {
        protected override SqlParameter[] CriaParametros(ProfessorViewModel model)
        {
            object imgByte = model.ImageByte();

            if (imgByte == null)
            {
                imgByte = DBNull.Value;
            }

            SqlParameter[] parametro = new SqlParameter[16];

            parametro[0] = new SqlParameter("codigo", model.Codigo);
            parametro[1] = new SqlParameter("nome", model.Nome);
            parametro[2] = new SqlParameter("genero", model.Genero);
            parametro[3] = new SqlParameter("data_nascimento", model.DataNascimento);
            parametro[4] = new SqlParameter("rg", model.Rg);
            parametro[5] = new SqlParameter("cpf", model.Cpf);
            parametro[6] = new SqlParameter("email", model.Email);
            parametro[7] = new SqlParameter("codigo_status", model.CodigoStatus);

            parametro[8] = new SqlParameter("rua", model.Rua);
            parametro[9] = new SqlParameter("numero", model.Numero);
            parametro[10] = new SqlParameter("bairro", model.Bairro);
            parametro[11] = new SqlParameter("cidade", model.Cidade);
            parametro[12] = new SqlParameter("estado", model.Estado);
            parametro[13] = new SqlParameter("cep", model.Cep);
            parametro[14] = new SqlParameter("telefone", model.Telefone);
            parametro[15] = new SqlParameter("imagem", imgByte);

            return parametro;
        }

        protected override ProfessorViewModel MontaModel(DataRow registro)
        {
            ProfessorViewModel professor = new ProfessorViewModel
            {
                Codigo = Convert.ToInt32(registro["codigo"]),
                Nome = registro["Nome"].ToString(),
                Genero = Convert.ToInt32(registro["codigo_genero"]),
                DataNascimento = Convert.ToDateTime(registro["data_nascimento"]),
                Rg = registro["rg"].ToString(),
                Cpf = registro["cpf"].ToString(),
                Email = registro["email"].ToString(),
                CodigoStatus = Convert.ToInt32(registro["codigo_status"]),

                Rua = registro["rua"].ToString(),
                Numero = Convert.ToInt32(registro["numero"]),
                Bairro = registro["bairro"].ToString(),
                Cidade = registro["cidade"].ToString(),
                Estado = registro["estado"].ToString(),
                Cep = registro["cep"].ToString(),
                Telefone = registro["telefone"] != DBNull.Value ? registro["telefone"].ToString() : string.Empty,
                ImageBase64 = registro["imagem"] != DBNull.Value ? Convert.ToBase64String(registro["imagem"] as byte[]) : null
            };

            return professor;
        }

        protected override void SetTabela()
        {
            Tabela = "professor";
        }
    }
}
