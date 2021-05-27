using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Web.Script.Serialization;

namespace Apcm.Service.Data
{
    internal static class DataRowCollectionExtension
    {
        public static void ForEach(this DataRowCollection rows, Action<DataRow> action)
        {
            foreach (DataRow row in rows)
            {
                action.Invoke(row);
            }
        }
    }

    internal static class DataRowExtension
    {
        public static T Read<T>(this DataRow row, int columnIndex)
        {
            object value = row[columnIndex];
            if (value.Equals(DBNull.Value))
            {
                return Activator.CreateInstance<T>();
            }
            else
            {
                return (T)Convert.ChangeType(value, typeof(T));
            }
        }

        public static T Read<T>(this DataRow row, string columnName)
        {
            object value = row[columnName];
            if (value.Equals(DBNull.Value))
            {
                return default(T);
            }
            else
            {
                return (T)Convert.ChangeType(value, typeof(T));
            }
        }

        public static void Write<T>(this DataRow row, int columnIndex, T value)
        {
            row[columnIndex] = value;
        }

        public static void Write<T>(this DataRow row, string columnName, T value)
        {
            row[columnName] = value;
        }

        public static T ToObject<T>(this DataRow row)
        {
            T item = Activator.CreateInstance<T>();
            foreach (PropertyInfo property in typeof(T).GetProperties().Where(p => p.CanWrite))
            {
                if (row.Table.Columns.Contains(property.Name))
                {
                    if (!row[property.Name].Equals(DBNull.Value))
                    {
                        object value = Convert.ChangeType(row[property.Name], property.GetPropertyType());
                        property.SetValue(item, value, null);
                    }
                }
            }

            return item;
        }

        public static void ReadObject<T>(this DataRow row, T obj)
        {
            foreach (PropertyInfo property in typeof(T).GetProperties().Where(p => p.CanRead))
            {
                if (row.Table.Columns.Contains(property.Name))
                {
                    object value = property.GetValue(obj, null);
                    if (value != null)
                    {
                        row[property.Name] = value;
                    }
                }
            }
        }

        public static void CopyTo(this DataRow row, DataRow destRow)
        {
            foreach (DataColumn column in destRow.Table.Columns)
            {
                if (row.Table.Columns.Contains(column.ColumnName))
                {
                    destRow[column] = row[column.ColumnName];
                }
            }
        }
    }

    internal static class DataSetExtension
    {
        public static void ConfigPks(this DataSet dataSet)
        {
            foreach (DataTable table in dataSet.Tables)
            {
                foreach (DataColumn dataColumn in table.PrimaryKey)
                {
                    if (dataColumn.AutoIncrement)
                    {
                        dataColumn.AutoIncrementSeed = -1;
                        dataColumn.AutoIncrementStep = -1;
                    }
                }
            }
        }

    }

    internal static class DataTableExtension
    {
        public static IEnumerable<DataRow> GetRows(this DataTable dataTable, DataRowState rowState)
        {
            foreach (DataRow row in dataTable.Rows)
            {
                if (row.RowState.Equals(rowState))
                {
                    yield return row;
                }
            }
        }

        public static IEnumerable<DataRow> GetRows(this DataTable dataTable)
        {
            foreach (DataRow row in dataTable.Rows)
            {
                yield return row;
            }
        }

        public static T Read<T>(this DataTable dataTable, int columnIndex)
        {
            if (dataTable.Rows.Count.Equals(0))
            {
                return default(T);
            }
            else
            {
                return dataTable.Rows[0].Read<T>(columnIndex);
            }
        }

        public static T Read<T>(this DataTable dataTable, string columnName)
        {
            if (dataTable.Rows.Count.Equals(0))
            {
                return default(T);
            }
            else
            {
                return dataTable.Rows[0].Read<T>(columnName);
            }
        }

        public static void Write<T>(this DataTable dataTable, int columnIndex, T value)
        {
            if (!dataTable.Rows.Count.Equals(0))
            {
                dataTable.Rows[0].Write(columnIndex, value);
            }
        }

        public static void Write<T>(this DataTable dataTable, string columnName, T value)
        {
            if (!dataTable.Rows.Count.Equals(0))
            {
                dataTable.Rows[0].Write(columnName, value);
            }
        }

        public static bool HasRows(this DataTable dataTable)
        {
            return !dataTable.Rows.Count.Equals(0);
        }

        public static List<T> ToObject<T>(this DataTable dataTable)
        {
            List<T> itens = new List<T>();
            dataTable.Rows.ForEach(r => itens.Add(r.ToObject<T>()));
            return itens;
        }

        public static List<T> ToList<T>(this DataTable dataTable, int columnIndex)
        {
            List<T> lst = new List<T>();
            dataTable.Rows.ForEach(r => lst.Add(r.Read<T>(columnIndex)));
            return lst;
        }

        public static List<T> ToList<T>(this DataTable dataTable, string columnName)
        {
            List<T> lst = new List<T>();
            dataTable.Rows.ForEach(r => lst.Add(r.Read<T>(columnName)));
            return lst;
        }

        public static void ReadObject<T>(this DataTable dataTable, IList<T> lstObj)
        {
            foreach (T obj in lstObj)
            {
                DataRow row = dataTable.NewRow();
                row.ReadObject<T>(obj);
                dataTable.Rows.Add(row);
            }
        }

        public static List<string> GetColumnNames(this DataTable dataTable)
        {
            List<string> result = new List<string>();
            foreach (DataColumn column in dataTable.Columns)
            {
                result.Add(column.ColumnName);
            }

            return result;
        }

        public static Dictionary<TKey, TValue> ToDictionary<TKey, TValue>(this DataTable dataTable)
        {
            Dictionary<TKey, TValue> dic = new Dictionary<TKey, TValue>();
            dataTable.Rows.ForEach(r => dic.Add(r.Read<TKey>(0), r.Read<TValue>(1)));
            return dic;
        }
    }

    internal static class ListExtension
    {
        /// <summary>
        /// Obtem um bloco específico de itens de uma lista.
        /// </summary>
        /// <typeparam name="T">Tipo de Lista.</typeparam>
        /// <param name="lst">List Extension.</param>
        /// <param name="lenght">Tamanho do bloco.</param>
        /// <param name="block">(zero-based) Número do bloco desejado.</param>
        /// <returns>Parte de uma Coleção Genérica.</returns>
        public static List<T> GetBlock<T>(this List<T> lst, int length, int block)
        {
            int index = Convert.ToInt32(block * length);
            int count = index + length > lst.Count ? lst.Count - index : length;
            return lst.GetRange(index, count);
        }

        /// <summary>
        /// Obtem a quantidade máxima de blocos possíveis em uma lista.
        /// </summary>
        /// <typeparam name="T">Tipo de Lista.</typeparam>
        /// <param name="lst">List Extension.</param>
        /// <param name="lenght">Tamanho do bloco.</param>
        /// <returns>Quatidade de blocos possíveis.</returns>
        public static int CountBlocks<T>(this List<T> lst, int length)
        {
            return Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(lst.Count) / length));
        }

        /// <summary>
        /// Executa uma ação para cada bloco de tamanho específico em uma lista.
        /// </summary>
        /// <typeparam name="T">Tipo de Lista.</typeparam>
        /// <param name="lst">List Extension.</param>
        /// <param name="length">Tamanho do bloco.</param>
        /// <param name="action">Ação para execução sobre os blocos.</param>
        public static void ForEachBlock<T>(this List<T> lst, int length, Action<List<T>> action)
        {
            int blocks = lst.CountBlocks(length);
            for (int block = 0; block < blocks; block++)
            {
                action.Invoke(lst.GetBlock(length, block));
            }
        }

        public static DataTable ConvertToDataTable<T>(this IList<T> lst, List<string> columns = null)
        {
            PropertyDescriptorCollection properties = TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            if (columns == null)
            {
                foreach (PropertyDescriptor prop in properties)
                    table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);


                foreach (T item in lst)
                {
                    DataRow row = table.NewRow();
                    foreach (PropertyDescriptor prop in properties)
                        row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                    table.Rows.Add(row);
                }
            }
            else
            {
                foreach (string col in columns)
                    table.Columns.Add(col, Nullable.GetUnderlyingType(typeof(T).GetProperty(col).PropertyType) ?? typeof(T).GetProperty(col).PropertyType);


                foreach (T item in lst)
                {
                    DataRow row = table.NewRow();

                    foreach (string col in columns)
                        row[col] = typeof(T).GetProperty(col).GetValue(item, null);

                    table.Rows.Add(row);
                }
            }
            return table;

        }
    }

    internal static class PropertyInfoExtension
    {
        public static Type GetPropertyType(this PropertyInfo property)
        {
            if (property.PropertyType.IsGenericType && property.PropertyType.Name.Equals(typeof(Nullable<>).Name))
            {
                return property.PropertyType.GetGenericArguments()[0];
            }
            else
            {
                return property.PropertyType;
            }
        }

        public static bool IsNullable(this PropertyInfo property)
        {
            return property.PropertyType.IsGenericType && property.PropertyType.Name.Equals(typeof(Nullable<>).Name);
        }

        public static bool NameEquals<T>(this PropertyInfo property, Expression<Func<T>> propertyExpression)
        {
            MemberExpression memberExpression = propertyExpression.Body as MemberExpression;
            return property.Name == memberExpression.Member.Name;
        }

        public static bool IsTypeof<T>(this PropertyInfo property)
        {
            return property.GetPropertyType() == typeof(T);
        }

        public static T GetCustomAttribute<T>(this PropertyInfo property)
        {
            object[] attrObjects = property.GetCustomAttributes(typeof(T), false);
            if (attrObjects.Count().Equals(0))
            {
                return default(T);
            }
            else
            {
                return (T)attrObjects[0];
            }
        }

        public static bool HasCustomAttribute<T>(this PropertyInfo property)
        {
            object[] attrObjects = property.GetCustomAttributes(typeof(T), false);
            return attrObjects.Count() > 0;
        }
    }

    internal static class ObjectExtension
    {
        public static string ToJSon(this object obj)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(obj);
        }
    }
}
