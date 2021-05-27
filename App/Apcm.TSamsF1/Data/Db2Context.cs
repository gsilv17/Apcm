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
    class Db2Context : IDisposable
    {
        private readonly DbProviderFactory providerFactory;
        private readonly DbConnection connection;
        private readonly int commandTimeout;

        public Db2Context()
        {
            providerFactory = DbProviderFactories.GetFactory("System.Data.Odbc");
            connection = providerFactory.CreateConnection();
            connection.ConnectionString = Settings.Default.Db2Context;
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

        public DataTable Load(string selectCommand, params object[] paramValues)
        {
            DbCommand cmd;
            DataTable tbl = new DataTable("DataTable");

            bool retry;
            int retryCount = 0;

            do
            {
                try
                {
                    retry = true;
                    cmd = CreateCommand(selectCommand, paramValues);
                    tbl = new DataTable("DataTable");
                    OpenConnection();
                    tbl.Load(cmd.ExecuteReader(CommandBehavior.CloseConnection));
                    retry = false;
                }
                catch (Exception ex)
                {
                    CloseConnection();
                    retryCount++;
                    if (retryCount >= 5)
                    {
                        throw ex;
                    }

                    retry = true;
                }

            } while (retry);

            return tbl;
        }

        private DbCommand CreateCommand(string commandText, params object[] paramValues)
        {
            DbCommand cmd = providerFactory.CreateCommand();
            cmd.Connection = connection;
            cmd.CommandTimeout = commandTimeout;
            cmd.CommandText = commandText;
            cmd.CommandType = CommandType.Text;
            FillParameters(cmd, paramValues);
            return cmd;
        }

        private void FillParameters(DbCommand cmd, params object[] paramValues)
        {
            for (int i = 0; i < paramValues.Length; i++)
            {
                DbParameter parameter = providerFactory.CreateParameter();
                parameter.Value = paramValues[i];
                //parameter.ParameterName = $":p{i.ToString()}";
                //parameter.DbType = DbType.String;
                cmd.Parameters.Add(parameter);
            }
        }

    }
}
