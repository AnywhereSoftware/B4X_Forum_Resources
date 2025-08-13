<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form esegue l'override del metodo Dispose per pulire l'elenco dei componenti.
    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Richiesto da Progettazione Windows Form
    Private components As System.ComponentModel.IContainer

    'NOTA: la procedura che segue è richiesta da Progettazione Windows Form
    'Può essere modificata in Progettazione Windows Form.  
    'Non modificarla mediante l'editor del codice.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Form1))
        Me.CmbBoxComPort = New System.Windows.Forms.ComboBox()
        Me.BtnConnect = New System.Windows.Forms.Button()
        Me.BtnDisconnect = New System.Windows.Forms.Button()
        Me.TmrSendData = New System.Windows.Forms.Timer(Me.components)
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.RichTextBox1 = New System.Windows.Forms.RichTextBox()
        Me.TextBox5 = New System.Windows.Forms.TextBox()
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.Elimina = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.TextBox6 = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.Button4 = New System.Windows.Forms.Button()
        Me.Timer2 = New System.Windows.Forms.Timer(Me.components)
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Timer3 = New System.Windows.Forms.Timer(Me.components)
        Me.CheckBox1 = New System.Windows.Forms.CheckBox()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'CmbBoxComPort
        '
        Me.CmbBoxComPort.FormattingEnabled = True
        Me.CmbBoxComPort.Location = New System.Drawing.Point(489, 29)
        Me.CmbBoxComPort.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.CmbBoxComPort.Name = "CmbBoxComPort"
        Me.CmbBoxComPort.Size = New System.Drawing.Size(180, 28)
        Me.CmbBoxComPort.TabIndex = 0
        Me.CmbBoxComPort.Visible = False
        '
        'BtnConnect
        '
        Me.BtnConnect.Location = New System.Drawing.Point(680, 1)
        Me.BtnConnect.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.BtnConnect.Name = "BtnConnect"
        Me.BtnConnect.Size = New System.Drawing.Size(112, 35)
        Me.BtnConnect.TabIndex = 1
        Me.BtnConnect.Text = "Connetti"
        Me.BtnConnect.UseVisualStyleBackColor = True
        '
        'BtnDisconnect
        '
        Me.BtnDisconnect.Enabled = False
        Me.BtnDisconnect.Location = New System.Drawing.Point(680, 46)
        Me.BtnDisconnect.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.BtnDisconnect.Name = "BtnDisconnect"
        Me.BtnDisconnect.Size = New System.Drawing.Size(112, 35)
        Me.BtnDisconnect.TabIndex = 2
        Me.BtnDisconnect.Text = "Disconnetti"
        Me.BtnDisconnect.UseVisualStyleBackColor = True
        '
        'TmrSendData
        '
        Me.TmrSendData.Interval = 3000
        '
        'TextBox1
        '
        Me.TextBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TextBox1.Location = New System.Drawing.Point(489, 211)
        Me.TextBox1.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.TextBox1.Multiline = True
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.TextBox1.Size = New System.Drawing.Size(301, 77)
        Me.TextBox1.TabIndex = 9
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(489, 292)
        Me.Button1.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(112, 35)
        Me.Button1.TabIndex = 10
        Me.Button1.Text = "Invia SMS"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'RichTextBox1
        '
        Me.RichTextBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.RichTextBox1.Location = New System.Drawing.Point(0, 30)
        Me.RichTextBox1.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.RichTextBox1.Name = "RichTextBox1"
        Me.RichTextBox1.Size = New System.Drawing.Size(481, 293)
        Me.RichTextBox1.TabIndex = 11
        Me.RichTextBox1.Text = ""
        '
        'TextBox5
        '
        Me.TextBox5.Location = New System.Drawing.Point(529, 184)
        Me.TextBox5.Name = "TextBox5"
        Me.TextBox5.Size = New System.Drawing.Size(263, 26)
        Me.TextBox5.TabIndex = 15
        '
        'DataGridView1
        '
        Me.DataGridView1.AllowUserToAddRows = False
        Me.DataGridView1.AllowUserToOrderColumns = True
        Me.DataGridView1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.Elimina})
        Me.DataGridView1.Location = New System.Drawing.Point(0, 352)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.ReadOnly = True
        Me.DataGridView1.Size = New System.Drawing.Size(802, 273)
        Me.DataGridView1.TabIndex = 16
        '
        'Elimina
        '
        Me.Elimina.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells
        Me.Elimina.HeaderText = ""
        Me.Elimina.Name = "Elimina"
        Me.Elimina.ReadOnly = True
        Me.Elimina.Width = 19
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(689, 292)
        Me.Button2.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(112, 35)
        Me.Button2.TabIndex = 17
        Me.Button2.Text = "Elimina SMS"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(486, 6)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(119, 20)
        Me.Label1.TabIndex = 22
        Me.Label1.Text = "Inserisci IP App"
        '
        'TextBox6
        '
        Me.TextBox6.Location = New System.Drawing.Point(489, 30)
        Me.TextBox6.Name = "TextBox6"
        Me.TextBox6.Size = New System.Drawing.Size(180, 26)
        Me.TextBox6.TabIndex = 23
        Me.TextBox6.Text = "192.168.1.3"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(488, 187)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(39, 20)
        Me.Label2.TabIndex = 24
        Me.Label2.Text = "Cell."
        '
        'Timer1
        '
        Me.Timer1.Interval = 4000
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(680, 136)
        Me.Button4.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(112, 35)
        Me.Button4.TabIndex = 26
        Me.Button4.Text = "Pulisci"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'Timer2
        '
        Me.Timer2.Interval = 6000
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(-4, 329)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(57, 20)
        Me.Label3.TabIndex = 28
        Me.Label3.Text = "Label3"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Font = New System.Drawing.Font("Arial Narrow", 15.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.Location = New System.Drawing.Point(-4, 3)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(51, 25)
        Me.Label4.TabIndex = 29
        Me.Label4.Text = "GSM"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Font = New System.Drawing.Font("Arial Narrow", 15.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.Location = New System.Drawing.Point(111, 2)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(41, 25)
        Me.Label5.TabIndex = 30
        Me.Label5.Text = "Wifi"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Font = New System.Drawing.Font("Arial Narrow", 15.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.Location = New System.Drawing.Point(213, 2)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(48, 25)
        Me.Label6.TabIndex = 31
        Me.Label6.Text = "Batt."
        '
        'Timer3
        '
        Me.Timer3.Enabled = True
        Me.Timer3.Interval = 14400000
        '
        'CheckBox1
        '
        Me.CheckBox1.AutoSize = True
        Me.CheckBox1.Checked = True
        Me.CheckBox1.CheckState = System.Windows.Forms.CheckState.Checked
        Me.CheckBox1.Location = New System.Drawing.Point(493, 65)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(126, 24)
        Me.CheckBox1.TabIndex = 32
        Me.CheckBox1.Text = "Auto Connetti"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(9.0!, 20.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(801, 626)
        Me.Controls.Add(Me.CheckBox1)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Button4)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.TextBox6)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.DataGridView1)
        Me.Controls.Add(Me.TextBox5)
        Me.Controls.Add(Me.RichTextBox1)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.TextBox1)
        Me.Controls.Add(Me.BtnDisconnect)
        Me.Controls.Add(Me.BtnConnect)
        Me.Controls.Add(Me.CmbBoxComPort)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Margin = New System.Windows.Forms.Padding(4, 5, 4, 5)
        Me.Name = "Form1"
        Me.Text = "BluetoothWifiSMS"
        Me.WindowState = System.Windows.Forms.FormWindowState.Minimized
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents CmbBoxComPort As ComboBox
    Friend WithEvents BtnConnect As Button
    Friend WithEvents BtnDisconnect As Button
    Friend WithEvents TmrSendData As Timer
    Friend WithEvents TextBox1 As TextBox
    Friend WithEvents Button1 As Button
    Friend WithEvents RichTextBox1 As RichTextBox
    Friend WithEvents TextBox5 As TextBox
    Friend WithEvents DataGridView1 As DataGridView
    Friend WithEvents Button2 As Button
    Friend WithEvents Elimina As DataGridViewTextBoxColumn
    Friend WithEvents Label1 As Label
    Friend WithEvents TextBox6 As TextBox
    Friend WithEvents Label2 As Label
    Friend WithEvents Timer1 As Timer
    Friend WithEvents Button4 As Button
    Friend WithEvents Timer2 As Timer
    Friend WithEvents Label3 As Label
    Friend WithEvents Label4 As Label
    Friend WithEvents Label5 As Label
    Friend WithEvents Label6 As Label
    Friend WithEvents Timer3 As Timer
    Friend WithEvents CheckBox1 As CheckBox
End Class
