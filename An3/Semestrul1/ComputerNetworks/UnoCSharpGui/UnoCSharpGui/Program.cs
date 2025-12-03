using System;
using System.Windows.Forms;

namespace UnoCSharpGui
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            string user = "CSharpGui";
            Application.Run(new MainForm(user));
        }
    }
}