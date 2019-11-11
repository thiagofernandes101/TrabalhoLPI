using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YouPlay.Models;

namespace YouPlay.DAO
{
    public class ProfessorDAO : PadraoDAO<ProfessorViewModel>
    {
        protected override SqlParameter[] CriaParametros(ProfessorViewModel model)
        {
            //object imgByte = model.ImageByte();

            //if (imgByte == null)
            //{
            //    imgByte = DBNull.Value;
            //}

            SqlParameter[] parametros = new SqlParameter[16];
            parametros[0] = new SqlParameter("codigo", model.Codigo);
            parametros[1] = new SqlParameter("nome", model.Nome);
            parametros[2] = new SqlParameter("genero", model.Genero);
            parametros[3] = new SqlParameter("data_nascimento", model.DataNascimento);
            parametros[4] = new SqlParameter("idade", model.Idade);
            parametros[5] = new SqlParameter("rg", model.Rg);
            parametros[6] = new SqlParameter("cpf", model.Cpf);
            parametros[7] = new SqlParameter("email", model.Email);
            parametros[8] = new SqlParameter("codigo_status", model.CodigoStatus);
            parametros[9] = new SqlParameter("rua", model.Rua);
            parametros[10] = new SqlParameter("numero", model.Numero);
            parametros[11] = new SqlParameter("bairro", model.Bairro);
            parametros[12] = new SqlParameter("cidade", model.Cidade);
            parametros[13] = new SqlParameter("estado", model.Estado);
            parametros[14] = new SqlParameter("cep", model.Cep);
            parametros[15] = new SqlParameter("telefone", model.Telefone);
            //parametros[17] = new SqlParameter("imagem", model.Imagem);

            return parametros;
        }

        protected override ProfessorViewModel MontaModel(DataRow registro)
        {
            ProfessorViewModel professor = new ProfessorViewModel
            {
                Codigo = registro["codigo"] != DBNull.Value ? Convert.ToInt32(registro["codigo"]) : 0,
                Nome = registro["nome"] != DBNull.Value ? registro["nome"].ToString() : string.Empty,
                Genero = registro["genero"] != DBNull.Value ? registro["genero"].ToString() : string.Empty,
                DataNascimento = registro["data_nascimento"] != DBNull.Value ? Convert.ToDateTime(registro["data_nascimento"]) : DateTime.Now,
                Idade = registro["idade"] != DBNull.Value ? Convert.ToInt32(registro["idade"]) : 0,
                Rg = registro["rg"] != DBNull.Value ? registro["rg"].ToString() : string.Empty,
                Cpf = registro["cpf"] != DBNull.Value ? registro["cpf"].ToString() : string.Empty,
                Email = registro["email"] != DBNull.Value ? registro["email"].ToString() : string.Empty,
                CodigoStatus = registro["codigo_status"] != DBNull.Value ? Convert.ToInt32(registro["codigo_status"]) : 0,
                DescricaoStatus = registro["descricao_status"] != DBNull.Value ? registro["descricao_status"].ToString() : string.Empty,
                //ImagemEmByte = registro["imagem"] != DBNull.Value ? registro["imagem"] as byte[] : null,
                //ImageBase64 = registro["imagem"] != DBNull.Value ? Convert.ToBase64String(registro["imagem"] as byte[]) : null,

                Rua = registro["rua"] != DBNull.Value ? registro["rua"].ToString() : string.Empty,
                Numero = registro["numero"] != DBNull.Value ? Convert.ToInt32(registro["numero"]) : 0,
                Bairro = registro["bairro"] != DBNull.Value ? registro["bairro"].ToString() : string.Empty,
                Cidade = registro["cidade"] != DBNull.Value ? registro["cidade"].ToString() : string.Empty,
                Estado = registro["estado"] != DBNull.Value ? registro["estado"].ToString() : string.Empty,
                Cep = registro["cep"] != DBNull.Value ? Convert.ToInt32(registro["cep"]) : 0,
                Telefone = registro["telefone"] != DBNull.Value ? registro["telefone"].ToString() : string.Empty,
                DescricaoDisciplina = registro["descricao_disciplina"] != DBNull.Value ? registro["descricao_disciplina"].ToString() : string.Empty
            };

            return professor;
        }

        protected override void SetTabela()
        {
            Tabela = "Professor";
        }

        //public virtual List<PadraoViewBagSelect> ListagemStatus()
        //{
        //    try
        //    {
        //        var p = new SqlParameter[]
        //        {
        //            new SqlParameter("tabela", "professor_status")
        //        };

        //        var tabela = HelperDAO.ExecutaProcSelect("sp_obtem_status", p);
        //        List<PadraoViewBagSelect> lista = new List<PadraoViewBagSelect>();

        //        foreach (DataRow registro in tabela.Rows)
        //        {
        //            PadraoViewBagSelect padraoBag = new PadraoViewBagSelect
        //            {
        //                Codigo = Convert.ToInt32(registro["codigo"]),
        //                Descricao = registro["descricao"].ToString()
        //            };
        //            lista.Add(padraoBag);
        //        }

        //        return lista;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
    }
}