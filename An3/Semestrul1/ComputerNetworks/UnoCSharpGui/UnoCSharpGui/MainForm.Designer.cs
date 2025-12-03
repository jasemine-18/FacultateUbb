namespace UnoCSharpGui
{
    partial class MainForm
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.Label lblTopCard;
        private System.Windows.Forms.ListBox lstHand;
        private System.Windows.Forms.Button btnDraw;
        private System.Windows.Forms.Button btnPlay;
        private System.Windows.Forms.TextBox txtLog;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
                components.Dispose();
            base.Dispose(disposing);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            lblTopCard = new System.Windows.Forms.Label();
            lstHand = new System.Windows.Forms.ListBox();
            btnDraw = new System.Windows.Forms.Button();
            btnPlay = new System.Windows.Forms.Button();
            txtLog = new System.Windows.Forms.TextBox();
            label1 = new System.Windows.Forms.Label();
            SuspendLayout();
            // 
            // lblTopCard
            // 
            lblTopCard.AutoSize = true;
            lblTopCard.Font = new System.Drawing.Font("Segoe UI", 14F);
            lblTopCard.Location = new System.Drawing.Point(290, 24);
            lblTopCard.Name = "lblTopCard";
            lblTopCard.Size = new System.Drawing.Size(360, 51);
            lblTopCard.TabIndex = 0;
            lblTopCard.Text = "Top card: (unknown)";
            lblTopCard.Click += lblTopCard_Click;
            // 
            // lstHand
            // 
            lstHand.Location = new System.Drawing.Point(38, 108);
            lstHand.Name = "lstHand";
            lstHand.Size = new System.Drawing.Size(372, 324);
            lstHand.TabIndex = 1;
            // 
            // btnDraw
            // 
            btnDraw.Location = new System.Drawing.Point(440, 101);
            btnDraw.Name = "btnDraw";
            btnDraw.Size = new System.Drawing.Size(138, 52);
            btnDraw.TabIndex = 2;
            btnDraw.Text = "Draw";
            btnDraw.Click += btnDraw_Click;
            // 
            // btnPlay
            // 
            btnPlay.Location = new System.Drawing.Point(593, 101);
            btnPlay.Name = "btnPlay";
            btnPlay.Size = new System.Drawing.Size(214, 52);
            btnPlay.TabIndex = 3;
            btnPlay.Text = "Play Selected";
            btnPlay.Click += btnPlay_Click;
            // 
            // txtLog
            // 
            txtLog.Location = new System.Drawing.Point(440, 159);
            txtLog.Multiline = true;
            txtLog.Name = "txtLog";
            txtLog.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            txtLog.Size = new System.Drawing.Size(367, 273);
            txtLog.TabIndex = 4;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new System.Drawing.Font("Segoe UI", 10F);
            label1.Location = new System.Drawing.Point(38, 68);
            label1.Name = "label1";
            label1.Size = new System.Drawing.Size(137, 37);
            label1.TabIndex = 5;
            label1.Text = "Your hand";
            label1.Click += label1_Click;
            // 
            // MainForm
            // 
            ClientSize = new System.Drawing.Size(827, 448);
            Controls.Add(label1);
            Controls.Add(lblTopCard);
            Controls.Add(lstHand);
            Controls.Add(btnDraw);
            Controls.Add(btnPlay);
            Controls.Add(txtLog);
            Text = "UNO C# Client";
            ResumeLayout(false);
            PerformLayout();
        }

        private System.Windows.Forms.Label label1;
    }
}
