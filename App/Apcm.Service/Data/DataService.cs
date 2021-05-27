using Apcm.Service.Log;
using System;

namespace Apcm.Service.Data
{
    internal abstract class DataService<TRepository> : IDisposable where TRepository : class
    {
        protected readonly DataContext DataContext;
        protected readonly bool DataContextOwner;
        protected readonly TRepository Repository;
        protected readonly InternalServices Services;
        private readonly InternalRepositories Repositories;

        public DataService()
        {
            DataContext = new DataContext();
            DataContextOwner = true;
            Repositories = new InternalRepositories(DataContext);
            Services = new InternalServices(DataContext);
            Repository = Repositories.Get<TRepository>();
        }

        public DataService(DataContext DataContext)
        {
            this.DataContext = DataContext;
            DataContextOwner = false;
            Repositories = new InternalRepositories(this.DataContext);
            Services = new InternalServices(this.DataContext);
            Repository = Repositories.Get<TRepository>();
        }

        public void Dispose()
        {
            Repositories.Dispose();
            Services.Dispose();

            if (DataContext != null && DataContextOwner)
            {
                DataContext.Dispose();
            }
        }
    }
}
