using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using YouPlay.Models;

namespace YouPlay.DAO
{
    public class AulaDAO : PadraoDAO<DisciplinaViewModel>
    {
        protected override SqlParameter[] CriaParametros(DisciplinaViewModel model)
        {
            SqlParameter[] parametros = new SqlParameter[4];
            parametros[0] = new SqlParameter("codigo", model.Codigo);
            parametros[1] = new SqlParameter("data", model.Data);
            parametros[2] = new SqlParameter("descricao", model.Descricao);
            parametros[3] = new SqlParameter("total_vagas", model.TotalVagas);

            return parametros;
        }

        protected override DisciplinaViewModel MontaModel(DataRow registro)
        {
            DisciplinaViewModel disciplina = new DisciplinaViewModel
            {
                Codigo = registro["codigo"] != DBNull.Value ? Convert.ToInt32(registro["codigo"]) : 0,
                Data = registro["data"] != DBNull.Value ? Convert.ToDateTime(registro["data"]) : DateTime.Now,
                Descricao = registro["descricao"] != DBNull.Value ? registro["descricao"].ToString() : null,
                TotalVagas = registro["total_vagas"] != DBNull.Value ? Convert.ToInt32(registro["total_vagas"]) : 0,
                VagasDisponiveis = registro["vagas_disponiveis"] != DBNull.Value ? Convert.ToInt32(registro["vagas_disponiveis"]) : 0
            };

            return disciplina;
        }

        protected override void SetTabela()
        {
            Tabela = "disciplina";
        }
    }
}