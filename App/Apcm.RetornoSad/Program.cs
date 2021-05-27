using System;
using System.ServiceProcess;

namespace Apcm.RetornoSad
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main()
        {
            if (Environment.UserInteractive)
            {
                ConsultaRetornoSvc t = new ConsultaRetornoSvc();
                System.Threading.Thread.Sleep(System.Threading.Timeout.Infinite);
            }
            else
            {
                ServiceBase[] ServicesToRun;
                ServicesToRun = new ServiceBase[]
                {
                    new ConsultaRetornoSvc()
                };
                ServiceBase.Run(ServicesToRun);
            }
        }
    }
}
