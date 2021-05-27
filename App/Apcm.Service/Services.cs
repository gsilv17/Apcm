using System;
using System.Collections.Generic;
using System.Linq;
using Apcm.Service.Carrinho;
using Apcm.Service.Cross;
using Apcm.Service.Data;
using Apcm.Service.EstruturaMercadologica;
using Apcm.Service.Item;
using Apcm.Service.Log;
using Apcm.Service.Lote;
using Apcm.Service.Mapa;
using Apcm.Service.RetornoSAD;
using Apcm.Service.Sad;
using Apcm.Service.AppUser;

namespace Apcm.Service
{
    public sealed class Services : IDisposable
    {
        private readonly IDictionary<string, object> services;
        private DataContext DataContext;

        public ICarrinhoService Carrinho => Get<CarrinhoService>();
        public IEstruturaMercadologicaService EstruturaMercadologica => Get<EstruturaMercadologicaService>();
        public IItemService Item => Get<ItemService>();
        public IAppUserService AppUser => Get<AppUserService>();
        public IResultSearch ResultSearch => Get<ResultSearchService>();
        public IMapaService MapaService => Get<MapaService>();
        public ILoteService LoteService => Get<LoteService>();
        public ILogService LogService => Get<LogService>();
        public ICrossService CrossService => Get<CrossService>();

        public Services()
        {
            services = new Dictionary<string, object>();
        }

        private T Get<T>() where T : class
        {
            if (DataContext == null)
            {
                DataContext = new DataContext();
            }

            Type serviceType = typeof(T);
            string serviceName = serviceType.Name;
            if (!services.ContainsKey(serviceName))
            {
                services[serviceName] = Activator.CreateInstance(serviceType, DataContext);
            }

            return (T)services[serviceName];
        }
        
        public void Dispose()
        {
            services.ToList().ForEach(service => ((IDisposable)service.Value).Dispose());
            services.Clear();
            
            if (DataContext != null)
            {
                DataContext.Dispose();
            }

            DataContext = null;
        }
    }
}
