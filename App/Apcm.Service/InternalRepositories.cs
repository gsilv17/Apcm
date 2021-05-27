using System;
using System.Collections.Generic;
using Apcm.Service.Data;

namespace Apcm.Service
{
    internal sealed class InternalRepositories : IDisposable
    {
        private readonly IDictionary<string, Object> repositories;
        private readonly DataContext DataContext;

        public InternalRepositories(DataContext dataContext)
        {
            repositories = new Dictionary<string, Object>();
            DataContext = dataContext;
        }

        public void Dispose()
        {
            repositories.Clear();
        }

        public T Get<T>() where T : class
        {
            Type repositoryType = typeof(T);
            string repositoryName = repositoryType.Name;
            if (!repositories.ContainsKey(repositoryName))
            {
                repositories[repositoryName] = Activator.CreateInstance(repositoryType, DataContext);
            }

            return (T)repositories[repositoryName];
        }
    }
}
