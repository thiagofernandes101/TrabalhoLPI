using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using YouPlay2019.Models;

namespace YouPlay2019.DAO
{
    public class DisciplinaDAO : PadraoDAO<DisciplinaViewModel>
    {
        protected override SqlParameter[] CriaParametros(DisciplinaViewModel model)
        {
            SqlParameter[] parametro = new SqlParameter[4];
            parametro[0] = new SqlParameter("codigo", model.Codigo);
            parametro[1] = new SqlParameter("data", model.Data);
            parametro[2] = new SqlParameter("descricao", model.Descricao);
            parametro[3] = new SqlParameter("total_vagas", model.TotalVagas);

            return parametro;
        }

        protected override DisciplinaViewModel MontaModel(DataRow registro)
        {
            DisciplinaViewModel disciplina = new DisciplinaViewModel
            {
                Codigo = registro["codigo"] != DBNull.Value ? Convert.ToInt32(registro["Codigo"]) : 0,
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
