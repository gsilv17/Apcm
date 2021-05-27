using Apcm.TSamsF1.Properties;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.TSamsF1.Data
{
    class SqlContext : IDisposable
    {
        private readonly SqlConnection connection;
        private readonly int commandTimeout;
        public SqlContext()
        {
            connection = new SqlConnection(Settings.Default.SqlContext);
            commandTimeout = 60 * 120;
        }
                
        public void Dispose()
        {
            CloseConnection();
            connection.Dispose();
        }

        private void OpenConnection()
        {
            if (!connection.State.Equals(ConnectionState.Open))
            {
                connection.Open();
            }
        }

        private void CloseConnection()
        {
            if (!connection.State.Equals(ConnectionState.Closed))
            {
                connection.Close();
            }
        }

        public T ExecuteScalar<T>(string commandText, params object[] paramValues)
        {
            try
            {
                using (SqlCommand cmd = GetCommand(commandText, paramValues))
                {
                    OpenConnection();
                    return (T)Convert.ChangeType(cmd.ExecuteScalar(), typeof(T));
                }
            }
            finally
            {
                CloseConnection();
            }
        }

        public int ExecuteNonQuery(string commandText, params object[] paramValues)
        {
            using (SqlCommand cmd = GetCommand(commandText, paramValues))
            {
                try
                {
                    OpenConnection();
                    return cmd.ExecuteNonQuery();
                }
                finally
                {
                    CloseConnection();
                }

            }
        }

        public int ExecuteNonQuery(string commandText, object[][] paramGroupValues)
        {
            using (SqlCommand cmd = new SqlCommand(commandText, connection))
            {
                try
                {
                    int result = 0;
                    cmd.CommandType = GetCommandType(commandText);
                    cmd.CommandTimeout = commandTimeout;
                    OpenConnection();
                    foreach (object[] paramValues in paramGroupValues)
                    {
                        cmd.Parameters.Clear();
                        FillParameters(cmd, paramValues);
                        result += cmd.ExecuteNonQuery();
                    }

                    return result;
                }
                finally
                {
                    CloseConnection();
                }
            }
        }
        
        public DataTable Load(string commandText, params object[] paramValues)
        {
            using (SqlCommand cmd = GetCommand(commandText, paramValues))
            {
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

        public DataSet Fill(string commandText, params object[] paramValues)
        {
            DataSet ds = new DataSet("DataSet");
            using (SqlDataAdapter adp = new SqlDataAdapter(commandText, connection))
            {
                adp.SelectCommand.CommandType = GetCommandType(commandText);
                adp.SelectCommand.CommandTimeout = commandTimeout;
                FillParameters(adp.SelectCommand, paramValues);

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
                using (SqlBulkCopy bc = new SqlBulkCopy(connection))
                {
                    bc.BatchSize = dataTable.Rows.Count;
                    bc.DestinationTableName = dataTable.TableName;
                    bc.BulkCopyTimeout = commandTimeout;
                    bc.WriteToServer(dataTable);
                }
            }
            finally
            {
                CloseConnection();
            }
        }
        
        private SqlCommand GetCommand(string commandText, object[] paramValues)
        {
            SqlCommand cmd = new SqlCommand(commandText, connection);
            cmd.CommandType = GetCommandType(commandText);
            FillParameters(cmd, paramValues);
            cmd.CommandTimeout = commandTimeout;
            return cmd;
        }

        private void FillParameters(SqlCommand cmd, object[] paramValues)
        {
            for (int i = 0; i < paramValues.Length; i++)
            {
                cmd.Parameters.AddWithValue($"@p{i.ToString()}", paramValues[i]);
            }
        }

        private CommandType GetCommandType(string commandText)
        {
            return commandText.Contains(" ") ? CommandType.Text : CommandType.StoredProcedure;
        }

    }
}
