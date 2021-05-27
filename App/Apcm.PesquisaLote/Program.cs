﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.PesquisaLote
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
                PesquisaLoteService pesquisaLoteService = new PesquisaLoteService();
            }
            else
            {
                ServiceBase[] ServicesToRun;
                ServicesToRun = new ServiceBase[]
                {
                new PesquisaLoteService()
                };
                ServiceBase.Run(ServicesToRun);
            }
        }
    }
}
