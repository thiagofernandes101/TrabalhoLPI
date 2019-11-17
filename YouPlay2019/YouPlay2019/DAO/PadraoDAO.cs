using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using YouPlay2019.Models;

namespace YouPlay2019.DAO
{
    public abstract class PadraoDAO<T> where T : PadraoViewModel
    {
        protected PadraoDAO()
        {
            SetTabela();
        }

        protected string Tabela { get; set; }
        protected string Chave { get; set; } = "codigo";  // valor default
        protected abstract SqlParameter[] CriaParametros(T model);
        protected abstract T MontaModel(DataRow registro);
        protected abstract void SetTabela();

        public virtual void Insert(T model)
        {
            try
            {
                HelperDAO.ExecutaProc("sp_insert_" + Tabela, CriaParametros(model));
            }
            catch (Exception erro)
            {
                throw erro;
            }
        }

        public virtual void Update(T model)
        {
            try
            {
                HelperDAO.ExecutaProc("sp_update_" + Tabela, CriaParametros(model));
            }
            catch (Exception erro)
            {
                throw erro;
            }
        }

        public virtual void Delete(int id)
        {
            try
            {
                var p = new SqlParameter[]
                {
                    new SqlParameter("codigo", id),
                    new SqlParameter("tabela", Tabela)
                };
                HelperDAO.ExecutaProc("sp_delete", p);
            }
            catch (Exception erro)
            {
                throw erro;
            }
        }

        public virtual T Consulta(int codigo)
        {
            try
            {
                var p = new SqlParameter[]
                {
                    new SqlParameter("codigo", codigo)
                };

                var tabela = HelperDAO.ExecutaProcSelect("sp_consulta_" + Tabela, p);

                if (tabela.Rows.Count == 0)
                {
                    return null;
                }
                else
                {
                    return MontaModel(tabela.Rows[0]);
                }
            }
            catch (Exception erro)
            {
                throw erro;
            }
        }

        public virtual List<T> Listagem()
        {
            try
            {
                var tabela = HelperDAO.ExecutaProcSelect("sp_listagem_" + Tabela, null);
                List<T> lista = new List<T>();

                foreach (DataRow registro in tabela.Rows)
                {
                    lista.Add(MontaModel(registro));
                }

                return lista;
            }
            catch (Exception erro)
            {
                throw erro;
            }
        }

        public virtual List<BagSelectViewModel> ListagemSelect(string tabelaSql)
        {
            try
            {
                List<BagSelectViewModel> lista = new List<BagSelectViewModel>();

                var parametros = new SqlParameter[]
                {
                    new SqlParameter("tabela", tabelaSql)
                };

                var tabela = HelperDAO.ExecutaProcSelect($"sp_bag_listagem", parametros);

                foreach (DataRow registro in tabela.Rows)
                {
                    BagSelectViewModel bagSelect = new BagSelectViewModel
                    {
                        Codigo = Convert.ToInt32(registro["codigo"]),
                        Descricao = registro["descricao"].ToString()
                    };

                    lista.Add(bagSelect);
                }

                return lista;
            }
            catch (Exception erro)
            {
                throw erro;
            }
        }
    }
}
