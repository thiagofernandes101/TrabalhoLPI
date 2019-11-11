using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YouPlay.Models;

namespace YouPlay.DAO
{
    public class AlunoDAO : PadraoDAO<AlunoViewModel>
    {
        protected override SqlParameter[] CriaParametros(AlunoViewModel model)
        {
            //object imgByte = model.ImageByte();

            //if (imgByte == null)
            //{
            //    imgByte = DBNull.Value;
            //}

            SqlParameter[] parametros = new SqlParameter[23];
            parametros[0] = new SqlParameter("codigo", model.Codigo);
            parametros[1] = new SqlParameter("nome", model.Nome);
            parametros[2] = new SqlParameter("genero", model.Genero);
            parametros[3] = new SqlParameter("data_nascimento", model.DataNascimento);
            parametros[4] = new SqlParameter("data_matricula", model.DataMatricula);
            parametros[5] = new SqlParameter("idade", model.Idade);
            parametros[6] = new SqlParameter("rg", model.Rg);
            parametros[7] = new SqlParameter("cpf", model.Cpf);
            parametros[8] = new SqlParameter("email", model.Email);
            parametros[9] = new SqlParameter("codigo_status", model.CodigoStatus);
            parametros[10] = new SqlParameter("rua", model.Rua);
            parametros[11] = new SqlParameter("numero", model.Numero);
            parametros[12] = new SqlParameter("bairro", model.Bairro);
            parametros[13] = new SqlParameter("cidade", model.Cidade);
            parametros[14] = new SqlParameter("estado", model.Estado);
            parametros[15] = new SqlParameter("cep", model.Cep);
            parametros[16] = new SqlParameter("telefone", model.Telefone);
            parametros[17] = new SqlParameter("codigo_escolaridade", model.CodigoEscolaridade);
            parametros[18] = new SqlParameter("nome_responsavel", model.NomeResponsavel);
            parametros[19] = new SqlParameter("rg_responsavel", model.RgResponsavel);
            parametros[20] = new SqlParameter("cpf_responsavel", model.CpfResponsavel);
            parametros[21] = new SqlParameter("telefone_responsavel", model.TelefoneResponsavel);
            parametros[22] = new SqlParameter("codigo_vinculo_responsavel", model.CodigoVinculoResponsavel);
            //parametros[24] = new SqlParameter("imagem", model.Imagem);

            return parametros;
        }

        protected override AlunoViewModel MontaModel(DataRow registro)
        {
            AlunoViewModel aluno = new AlunoViewModel();
            
            aluno.Codigo = registro["codigo"] != DBNull.Value ? Convert.ToInt32(registro["codigo"]) : 0;
            aluno.Nome = registro["nome"] != DBNull.Value ? registro["nome"].ToString() : string.Empty;
            aluno.Genero = registro["genero"] != DBNull.Value ? registro["genero"].ToString() : string.Empty;
            aluno.DataNascimento = registro["data_nascimento"] != DBNull.Value ? Convert.ToDateTime(registro["data_nascimento"]) : DateTime.Now;
            aluno.DataMatricula = registro["data_matricula"] != DBNull.Value ? Convert.ToDateTime(registro["data_matricula"]) : DateTime.Now;
            aluno.Idade = registro["idade"] != DBNull.Value ? Convert.ToInt32(registro["idade"]) : 0;
            aluno.Rg = registro["rg"] != DBNull.Value ? registro["rg"].ToString() : string.Empty;
            aluno.Cpf = registro["cpf"] != DBNull.Value ? registro["cpf"].ToString() : string.Empty;
            aluno.Email = registro["email"] != DBNull.Value ? registro["email"].ToString() : string.Empty;
            aluno.CodigoStatus = registro["codigo_status"] != DBNull.Value ? Convert.ToInt32(registro["codigo_status"]) : 0;
            aluno.DescricaoStatus = registro["descricao_status"] != DBNull.Value ? registro["descricao_status"].ToString() : string.Empty;
            //ImagemEmByte = registro["imagem"] != DBNull.Value ? registro["imagem"] as byte[] : null,
            //ImageBase64 = registro["imagem"] != DBNull.Value ? Convert.ToBase64String(registro["imagem"] as byte[]) : null,

            aluno.Rua = registro["rua"] != DBNull.Value ? registro["rua"].ToString() : string.Empty;
            aluno.Numero = registro["numero"] != DBNull.Value ? Convert.ToInt32(registro["numero"]) : 0;
            aluno.Bairro = registro["bairro"] != DBNull.Value ? registro["bairro"].ToString() : string.Empty;
            aluno.Cidade = registro["cidade"] != DBNull.Value ? registro["cidade"].ToString() : string.Empty;
            aluno.Estado = registro["estado"] != DBNull.Value ? registro["estado"].ToString() : string.Empty;
            aluno.Cep = registro["cep"] != DBNull.Value ? Convert.ToInt32(registro["cep"]) : 0;
            aluno.Telefone = registro["telefone"] != DBNull.Value ? registro["telefone"].ToString() : string.Empty;
            aluno.CodigoEscolaridade = registro["codigo_escolaridade"] != DBNull.Value ? Convert.ToInt32(registro["codigo_escolaridade"]) : 0;
            aluno.DescricaoEscolaridade = registro["descricao_escolaridade"] != DBNull.Value ? registro["descricao_escolaridade"].ToString() : string.Empty;

            aluno.NomeResponsavel = registro["nome_responsavel"] != DBNull.Value ? registro["nome_responsavel"].ToString() : string.Empty;
            aluno.RgResponsavel = registro["rg_responsavel"] != DBNull.Value ? registro["rg_responsavel"].ToString() : string.Empty;
            aluno.CpfResponsavel = registro["cpf_responsavel"] != DBNull.Value ? registro["cpf_responsavel"].ToString() : string.Empty;
            aluno.TelefoneResponsavel = registro["telefone_responsavel"] != DBNull.Value ? registro["telefone_responsavel"].ToString() : string.Empty;
            aluno.CodigoVinculoResponsavel = registro["codigo_vinculo_responsavel"] != DBNull.Value ? Convert.ToInt32(registro["codigo_vinculo_responsavel"]) : 0;
            aluno.DescricaoDisciplina = registro["descricao_disciplina"] != DBNull.Value ? registro["descricao_disciplina"].ToString() : null;

            return aluno;
        }

        protected override void SetTabela()
        {
            Tabela = "aluno";
        }

        public List<PadraoViewBagSelect> ObtemEscolaridade()
        {
            try
            {
                var tabela = HelperDAO.ExecutaProcSelect("sp_obtem_escolaridade", null);
                List<PadraoViewBagSelect> lista = new List<PadraoViewBagSelect>();

                foreach (DataRow registro in tabela.Rows)
                {
                    PadraoViewBagSelect escolaridade = new PadraoViewBagSelect
                    {
                        Codigo = Convert.ToInt32(registro["Codigo"]),
                        Descricao = registro["Descricao"].ToString()
                    };
                    lista.Add(escolaridade);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PadraoViewBagSelect> ObtemVinculoAluno()
        {
            try
            {
                var tabela = HelperDAO.ExecutaProcSelect("sp_obtem_vinculo_aluno", null);
                List<PadraoViewBagSelect> lista = new List<PadraoViewBagSelect>();

                foreach (DataRow registro in tabela.Rows)
                {
                    PadraoViewBagSelect vinculo = new PadraoViewBagSelect
                    {
                        Codigo = Convert.ToInt32(registro["codigo"]),
                        Descricao = registro["descricao"].ToString()
                    };

                    lista.Add(vinculo);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //public virtual List<PadraoViewBagSelect> ListagemStatus()
        //{
        //    try
        //    {
        //        var p = new SqlParameter[]
        //        {
        //            new SqlParameter("tabela", "aluno_status")
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