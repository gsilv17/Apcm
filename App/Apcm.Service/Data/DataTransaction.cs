using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Data
{
    internal class DataTransaction : IDisposable
    {
        public SqlTransaction Transaction { get; private set; }
        private SqlConnection Connection { get; set; }
        public bool TransacaoAberta { get; private set; }

        public DataTransaction()
        {
            TransacaoAberta = false;
        }

        public void Begin(SqlConnection connection)
        {
            if (!TransacaoAberta)
            {
                Transaction = connection.BeginTransaction();
                Connection = connection;
                TransacaoAberta = true;
            }
        }

        public void Commit()
        {
            if (TransacaoAberta)
            {
                Transaction.Commit();
                TransacaoAberta = false;
                Dispose();
            }
        }

        public void Rollback()
        {
            if (TransacaoAberta)
            {
                Transaction.Rollback();
                TransacaoAberta = false;
                Dispose();
            }
        }
        
        private void CloseConnection()
        {
            if (Connection.State != System.Data.ConnectionState.Closed)
            {
                Connection.Close();
            }
        }

        public void Dispose()
        {
            Rollback();
            Transaction.Dispose();
            CloseConnection();
        }
    }
}
