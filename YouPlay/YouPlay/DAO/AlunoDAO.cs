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
            SqlParameter[] parametros = new SqlParameter[5];
            parametros[0] = new SqlParameter("codigo", model.Codigo);
            parametros[1] = new SqlParameter("nome", model.Nome);
            parametros[2] = new SqlParameter("genero", model.Genero);
            parametros[3] = new SqlParameter("dataNascimento", model.DataNascimento);
            parametros[4] = new SqlParameter("idade", model.Idade);
            parametros[5] = new SqlParameter("rg", model.Rg);
            parametros[5] = new SqlParameter("cpf", model.Cpf);
            parametros[6] = new SqlParameter("codigoEscolaridade", model.Escolaridade.Codigo);
            parametros[7] = new SqlParameter("dataMatricula", model.DataMatricula);
            parametros[8] = new SqlParameter("rua", model.Endereco.Rua);

            return parametros;
        }

        protected override AlunoViewModel MontaModel(DataRow registro)
        {
            AlunoViewModel aluno = new AlunoViewModel
            {
                Codigo = Convert.ToInt32(registro["id"]),
                Nome = registro["nome"].ToString(),
                Genero = registro["genero"].ToString(),
                DataNascimento = Convert.ToDateTime(registro["dataNascimento"]),
                Idade = Convert.ToInt32(registro["idade"]),
                Rg = registro["rg"].ToString(),
                Cpf = registro["cpf"].ToString(),
                CodigoEscolaridade = Convert.ToInt32(registro["codigoEscolaridade"]),
                DataMatricula = Convert.ToDateTime(registro["dataMatricula"]),
                CodigoStatus = Convert.ToInt32(registro["codigoStatus"])
            };

            return aluno;
        }

        protected override void SetTabela()
        {
            Tabela = "Alunos";
        }

        public List<EscolaridadeViewModel> ObtemEscolaridade()
        {
            try
            {
                var tabela = HelperDAO.ExecutaProcSelect("spObtemEscolaridade", null);
                List<EscolaridadeViewModel> lista = new List<EscolaridadeViewModel>();

                foreach (DataRow registro in tabela.Rows)
                {
                    EscolaridadeViewModel escolaridade = new EscolaridadeViewModel
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

        public List<VinculoViewModel> ObtemVinculoAluno()
        {
            try
            {
                var tabela = HelperDAO.ExecutaProcSelect("spObtemVinculoAluno", null);
                List<VinculoViewModel> lista = new List<VinculoViewModel>();

                foreach (DataRow registro in tabela.Rows)
                {
                    VinculoViewModel vinculo = new VinculoViewModel
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
    }
}