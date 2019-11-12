using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using YouPlay.Models;

namespace YouPlay.DAO
{
    public abstract class PadraoDAO<T> where T : PadraoViewModel
    {
        protected PadraoDAO()
        {
            SetTabela();
        }

        protected string Tabela { get; set; }
        protected string Chave { get; set; } = "Codigo";
        protected abstract SqlParameter[] CriaParametros(T model);
        protected abstract T MontaModel(DataRow registro);
        protected abstract void SetTabela();

        public virtual void Insert(T model)
        {
            HelperDAO.ExecutaProc("sp_inserir_" + Tabela, CriaParametros(model));
        }

        public virtual void Update(T model)
        {
            HelperDAO.ExecutaProc("sp_update_" + Tabela, CriaParametros(model));
        }

        public virtual void Delete(int codigo)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter("codigo", codigo)
            };

            HelperDAO.ExecutaProc("sp_delete_" + Tabela, p);
        }

        public virtual T Consulta(int codigo)
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

        public virtual int ProximoId()
        {
            var p = new SqlParameter[]
            {
                new SqlParameter("tabela", Tabela)
            };

            var tabela = HelperDAO.ExecutaProcSelect("sp_proximo_id", p);


            return Convert.ToInt32(tabela.Rows[0][0]);
        }

        public virtual List<T> Listagem()
        {
            var tabela = HelperDAO.ExecutaProcSelect("sp_listagem_" + Tabela, null);
            List<T> lista = new List<T>();

            foreach (DataRow registro in tabela.Rows)
            {
                lista.Add(MontaModel(registro));
            }

            return lista;
        }

        public virtual List<PadraoViewBagSelect> ListagemStatus()
        {
            try
            {
                var p = new SqlParameter[]
                {
                    new SqlParameter("tabela", Tabela + "_status")
                };

                var tabela = HelperDAO.ExecutaProcSelect("sp_obtem_status", p);
                List<PadraoViewBagSelect> lista = new List<PadraoViewBagSelect>();

                foreach (DataRow registro in tabela.Rows)
                {
                    PadraoViewBagSelect padraoBag = new PadraoViewBagSelect
                    {
                        Codigo = Convert.ToInt32(registro["codigo"]),
                        Descricao = registro["descricao"].ToString()
                    };
                    lista.Add(padraoBag);
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