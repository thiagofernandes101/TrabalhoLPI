using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using YouPlay2019.Models;

namespace YouPlay2019.DAO
{
    public class AlunoDAO : PadraoDAO<AlunoViewModel>
    {
        protected override SqlParameter[] CriaParametros(AlunoViewModel model)
        {
            object imgByte = model.ImageByte();

            if (imgByte == null)
            {
                imgByte = DBNull.Value;
            }

            SqlParameter[] parametro = new SqlParameter[21];
            
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
            
            parametro[15] = new SqlParameter("codigo_escolaridade", model.CodigoEscolaridade);
            parametro[16] = new SqlParameter("nome_responsavel", model.NomeResponsavel);
            parametro[17] = new SqlParameter("rg_responsavel", model.RgResponsavel);
            parametro[17] = new SqlParameter("cpf_responsavel", model.CpfResponsavel);
            parametro[18] = new SqlParameter("telefone_responsavel", model.TelefoneResponsavel);
            parametro[19] = new SqlParameter("codigo_vinculo_responsavel", model.CodigoVinculoResponsavel);
            parametro[20] = new SqlParameter("imagem", imgByte);

            return parametro;
        }

        protected override AlunoViewModel MontaModel(DataRow registro)
        {
            AlunoViewModel aluno = new AlunoViewModel
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

                CodigoEscolaridade = Convert.ToInt32(registro["codigo_escolaridade"]),
                NomeResponsavel = registro["nome_responsavel"] != DBNull.Value ? registro["nome_responsavel"].ToString() : string.Empty,
                RgResponsavel = registro["rg_responsavel"] != DBNull.Value ? registro["rg_responsavel"].ToString() : string.Empty,
                CpfResponsavel = registro["cpf_responsavel"] != DBNull.Value ? registro["cpf_responsavel"].ToString() : string.Empty,
                TelefoneResponsavel = registro["telefone_responsavel"] != DBNull.Value ? registro["telefone_responsavel"].ToString() : string.Empty,
                CodigoVinculoResponsavel = registro["codigo_vinculo_responsavel"] != DBNull.Value ? Convert.ToInt32(registro["codigo_vinculo_responsavel"]) : 1,
                ImageBase64 = registro["imagem"] != DBNull.Value ? Convert.ToBase64String(registro["imagem"] as byte[]) : null
            };

            return aluno;
        }

        protected override void SetTabela()
        {
            Tabela = "aluno";
        }
    }
}
