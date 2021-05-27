using System;
using System.Collections.Generic;
using Apcm.Service.Data;

namespace Apcm.Service
{
    internal sealed class InternalServices : IDisposable
    {
        private readonly IDictionary<string, Object> services;
        private readonly DataContext DataContext;

        public InternalServices(DataContext dataContext)
        {
            services = new Dictionary<string, Object>();
            DataContext = dataContext;
        }

        public void Dispose()
        {
            services.Clear();
        }

        public T Get<T>() where T : class
        {
            Type serviceType = typeof(T);
            string serviceName = serviceType.Name;
            if (!services.ContainsKey(serviceName))
            {
                services[serviceName] = Activator.CreateInstance(serviceType, DataContext);
            }

            return (T)services[serviceName];
        }        
    }
}
