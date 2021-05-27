using System;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace Apcm.Service.Extensions
{
    public static class PropertyInfoExtension
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
}
