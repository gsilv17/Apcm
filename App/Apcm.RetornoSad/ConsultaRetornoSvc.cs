using Apcm.RetornoSad.Businness;
using System.Configuration;
using System.ServiceProcess;
using System.Timers;

namespace Apcm.RetornoSad
{
    public partial class ConsultaRetornoSvc : ServiceBase
    { 
        private System.Timers.Timer trmRunSync;
        public ConsultaRetornoSvc()
        {
            InitializeComponent();

            System.Threading.Thread.CurrentThread.CurrentCulture = System.Globalization.CultureInfo.CreateSpecificCulture("en-US");
            double timeExecute = double.Parse(ConfigurationManager.AppSettings["timeExecute"].ToString());
            //double timeExecute = 30;
            trmRunSync = new System.Timers.Timer(timeExecute * 1000.0d);
            trmRunSync.Elapsed += new ElapsedEventHandler(trmRunSync_Tick);
            trmRunSync.Enabled = true;
            if (trmRunSync.Enabled)
            {
                trmRunSync.Elapsed += new ElapsedEventHandler(trmRunSync_Tick);
                trmRunSync.Start();
            }
        }

        public void trmRunSync_Tick(object sender, ElapsedEventArgs e)
        {
            trmRunSync.Enabled = false;
            ProcessamentoRetorno procRet = new ProcessamentoRetorno();
            procRet.ProcessarRetorno();
            trmRunSync.Enabled = true;
        }
    }
}
