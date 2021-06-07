using Apcm.PesquisaLote.Properties;
using Apcm.Service.Lote;
using Apcm.Service.Sad;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Apcm.PesquisaLote
{
    public partial class PesquisaLoteService : ServiceBase
    {

        private System.Timers.Timer Timer;
        private Service.Services Services;
        private bool Executando;

        public PesquisaLoteService()
        {
            InitializeComponent();

            SadService.DefinirUrlsConsulta(
                Settings.Default.SadBaseUrlAtacado,
                Settings.Default.SadBaseUrlVarejo,
                Settings.Default.SadConsultaLote,
                Settings.Default.SadConsultaDetalhe);

            SadService.DefinirUrlsInclusao(
                Settings.Default.SadBaseUrlAtacado,
                Settings.Default.SadBaseUrlVarejo,
                string.Empty,
                string.Empty,
                string.Empty,
                Settings.Default.SadDessincSadReport);

            if (Environment.UserInteractive)
            {
                using (Services = new Service.Services())
                {
                    Services.LoteService.ProcessarLotes();
                }
            }
            else
            {
                Timer = new System.Timers.Timer(Settings.Default.EsperaEntreExecucoes.TotalMilliseconds);
                Timer.Enabled = false;
                Timer.Elapsed += Timer_Elapsed;
                Executando = false;
            }
        }

        protected override void OnStart(string[] args)
        {
            Services = new Service.Services();
            Timer.Enabled = true;
            Timer.Start();
        }

        protected override void OnStop()
        {
            while (Executando)
            {
                Thread.Sleep(new TimeSpan(0, 0, 1));
            }

            Timer.Enabled = false;
            Timer.Stop();
            Services.Dispose();
            Services = null;
        }

        protected override void OnPause()
        {
            Timer.Stop();
            Executando = false;
        }

        protected override void OnContinue()
        {
            Timer.Enabled = true;
        }
        
        private void Timer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            Timer.Enabled = false;
            Executando = true;

            try
            {
                Task removerItem = Task.Run(() => Services.Carrinho.RemoverCarrinhoItemAutomatico(Settings.Default.DiasLimiteCarrinho));
                Task processamento = Task.Run(() => Services.LoteService.ProcessarLotes());
                Task.WaitAll(removerItem, processamento);
                Services.LogService.Fixo("Apcm.PesquisaLote", "Executado");
            }
            catch (Exception ex)
            {
                EventLog.WriteEntry(ex.Message, EventLogEntryType.Error);
                Services.LogService.Fixo("Apcm.PesquisaLote", "Executado com Erro");
                Services.LogService.Erro("Apcm.PesquisaLote.Timer_Elapsed", ex);
            }

            Executando = false;
            Timer.Enabled = true;
        }
    }
}
