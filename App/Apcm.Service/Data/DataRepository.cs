namespace Apcm.Service.Data
{
    internal abstract class DataRepository
    {
        protected DataContext DataContext { get; }
        public DataRepository(DataContext DataContext) => this.DataContext = DataContext;
    }
}
