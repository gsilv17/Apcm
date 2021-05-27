using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Data
{
    internal class DataContext : IDisposable
    {
        private SqlConnection Connection { get; set; }
        private SqlTransaction Transaction { get; set; }
        private int CommandTimeOut { get; }

        public DataContext()
        {
            CommandTimeOut = 30 * 60;
            ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings
                .Cast<ConnectionStringSettings>()
                .Where(cs => cs.Name.EndsWith(this.GetType().Name))
                .FirstOrDefault();

            if (connectionStringSettings == null)
            {
                throw new Exception($"Connection string { this.GetType().Name } não localizada.");
            }

            Connection = new SqlConnection(connectionStringSettings.ConnectionString);
        }

        public void Dispose()
        {
            if (Connection != null)
            {
                RollbackTransaction();
                CloseConnection();
                Connection.Dispose();
            }

            Connection = null;
        }

        private void OpenConnection()
        {
            if (Connection.State == System.Data.ConnectionState.Closed)
            {
                Connection.Open();
            }
        }

        private void CloseConnection()
        {
            if (Connection.State != System.Data.ConnectionState.Closed && Transaction == null)
            {
                Connection.Close();
            }
        }


        public void BeginTransaction()
        {
            if (Transaction == null)
            {
                OpenConnection();
                Transaction = Connection.BeginTransaction();
            }
        }

        public void CommitTransaction()
        {
            if (Transaction != null)
            {
                Transaction.Commit();
                Transaction.Dispose();
                Transaction = null;
                CloseConnection();
            }
        }

        public void RollbackTransaction()
        {
            if (Transaction != null)
            {
                Transaction.Rollback();
                Transaction.Dispose();
                Transaction = null;
                CloseConnection();
            }
        }

        public T ExecuteScalar<T>(string commandText, params DataParam[] parameters)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand(commandText, Connection, Transaction))
                {
                    cmd.CommandType = commandText.Contains(" ") ? CommandType.Text : CommandType.StoredProcedure;
                    FillParameters(cmd, parameters);
                    cmd.CommandTimeout = CommandTimeOut;
                    OpenConnection();
                    return (T)Convert.ChangeType(cmd.ExecuteScalar(), typeof(T));
                }
            }
            finally
            {
                CloseConnection();
            }
        }

        public int ExecuteNonQuery(string commandText, params DataParam[] parameters)
        {
            using (SqlCommand cmd = new SqlCommand(commandText, Connection, Transaction))
            {
                try
                {
                    cmd.CommandType = commandText.Contains(" ") ? CommandType.Text : CommandType.StoredProcedure;
                    cmd.CommandTimeout = CommandTimeOut;
                    FillParameters(cmd, parameters);
                    OpenConnection();
                    return cmd.ExecuteNonQuery();
                }
                finally
                {
                    CloseConnection();
                }
            }
        }

        public int ExecuteNonQuery(string commandText, DataParam[][] parameters)
        {
            using (SqlCommand cmd = new SqlCommand(commandText, Connection, Transaction))
            {
                try
                {
                    int rCount = 0;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandTimeout = CommandTimeOut;
                    OpenConnection();
                    foreach (DataParam[] ps in parameters)
                    {
                        cmd.Parameters.Clear();
                        FillParameters(cmd, ps);
                        rCount += cmd.ExecuteNonQuery();
                    }

                    return rCount;
                }
                finally
                {
                    CloseConnection();
                }
            }
        }

        public DataTable Load(string commandText, params DataParam[] parameters)
        {
            using (SqlCommand cmd = new SqlCommand(commandText, Connection))
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandTimeout = CommandTimeOut;
                FillParameters(cmd, parameters);
                DataTable tbl = new DataTable("DataTable");
                try
                {
                    OpenConnection();
                    tbl.Load(cmd.ExecuteReader());
                    return tbl;
                }
                finally
                {
                    CloseConnection();
                }
            }
        }

        public DataSet Fill(string commandText, params DataParam[] parameters)
        {
            DataSet ds = new DataSet("DataSet");
            using (SqlDataAdapter adp = new SqlDataAdapter(commandText, Connection))
            {
                adp.SelectCommand.CommandType = CommandType.Text;
                adp.SelectCommand.CommandTimeout = CommandTimeOut;
                FillParameters(adp.SelectCommand, parameters);

                try
                {
                    OpenConnection();
                    adp.Fill(ds);
                    return ds;
                }
                finally
                {
                    CloseConnection();
                }
            }
        }

        public void ExecuteBulk(DataTable dataTable)
        {
            try
            {
                OpenConnection();
                using (SqlBulkCopy bc = new SqlBulkCopy(Connection))
                {
                    bc.BatchSize = dataTable.Rows.Count;
                    bc.DestinationTableName = dataTable.TableName;
                    bc.WriteToServer(dataTable);
                }
            }
            finally
            {
                CloseConnection();
            }
        }

        public void FillParameters(SqlCommand cmd, DataParam[] parameters)
        {
            parameters.ToList().ForEach(p => cmd.Parameters.AddWithValue(p.Name, p.Value ?? DBNull.Value));
        }
    }
}
