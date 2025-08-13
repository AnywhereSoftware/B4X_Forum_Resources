Imports System.IO
Imports System.Text
Imports System.ComponentModel
Imports System.Net.Sockets
Imports System.Net
Imports System.Data.OleDb

Public Class Form1
    Dim readData As String
    Dim infiniteCounter As Integer
    Dim Inviato As Boolean
    Dim Rx As String = ""
    Dim Connesso As Boolean
    Public Delegate Sub mydel(ByVal i As Integer)
    Dim oledbConnectionx As OleDb.OleDbConnection
    Private tcpClient As TcpClient
    Private stream As NetworkStream
    Dim receiveThread As Threading.Thread


    Private Sub FrmMain_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Process.GetProcessesByName(Process.GetCurrentProcess.ProcessName).Length > 1 Then
            MsgBox(My.Application.Info.AssemblyName & " è già aperto", MsgBoxStyle.Information)
            Application.Exit()
            Exit Sub
        End If


        Dim AnnoDB As Integer = Year(Now)
        'AnnoDB = 2020
        If File.Exists(App_Path() & "dbAcconciatori" & AnnoDB & ".accdb") Then
            My.Settings("dbAcconciatori2020ConnectionString") = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\dbAcconciatori" & AnnoDB & ".accdb"
            oledbConnectionx = New OleDb.OleDbConnection(My.Settings.dbAcconciatori2020ConnectionString)
            oledbConnectionx.Open()
            AggiornaSMS()
        Else
            End
        End If

        System.Runtime.GCSettings.LargeObjectHeapCompactionMode = System.Runtime.GCLargeObjectHeapCompactionMode.CompactOnce
        Me.Visible = False
        If File.Exists(App_Path() & "App.txt") Then
            Dim fileReader As String()
            Dim objReader As New StreamReader(App_Path() & "App.txt")
            fileReader = objReader.ReadLine.Split("|")
            objReader.Close()

            TextBox6.Text = fileReader(0)
            Me.Refresh()
        End If

        TmrSendData.Interval = 3000
        Timer1.Enabled = False
        Timer2.Enabled = True
        TmrSendData.Enabled = False
        Me.Visible = True
    End Sub

    Public Function App_Path() As String
        Return System.AppDomain.CurrentDomain.BaseDirectory()
    End Function


    Private Sub BtnConnect_Click(sender As Object, e As EventArgs) Handles BtnConnect.Click

        Dim f As System.IO.StreamWriter
        f = My.Computer.FileSystem.OpenTextFileWriter(App_Path() & "App.txt", False)
        f.WriteLine(TextBox6.Text & "|true")
        f.Close()


        Try

            If CheckTCPPort(TextBox6.Text, 5500, 1000) = False Then
                Timer2.Enabled = True
                Timer2.Start()
                Exit Sub
            End If
            tcpClient = New TcpClient()
            tcpClient.Connect(TextBox6.Text, 5500) 'IP del server B4A e porta su cui ascolta
            stream = tcpClient.GetStream()


            receiveThread = New Threading.Thread(AddressOf ReceiveData)
            receiveThread.Start()

            RichTextBox1.Focus()
            RichTextBox1.Text = "App Connessa" & vbCrLf
            RichTextBox1.Select(RichTextBox1.Text.Length - 1, 0)
            Connesso = True
            BtnDisconnect.Enabled = True
            BtnConnect.Enabled = False
            TmrSendData.Enabled = True
            TmrSendData.Start()
        Catch ex As Exception
            RichTextBox1.Text = "App Disconnessa" & vbCrLf & ex.Message
        End Try

    End Sub

    Private Function CheckTCPPort(ByVal sIPAdress As String, ByVal iPort As Integer, Optional ByVal iTimeout As Integer = 5000)

        Dim ip As IPAddress = Nothing

        Dim is_valid As Boolean = IPAddress.TryParse(sIPAdress, ip)
        If is_valid = False Then
            Return False
        End If

        Dim socket As New Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp)
        ' Connect using a timeout (default 5 seconds)
        Dim result As IAsyncResult = socket.BeginConnect(sIPAdress, iPort, Nothing, Nothing)
        Dim success As Boolean = result.AsyncWaitHandle.WaitOne(iTimeout, True)

        If Not success Then
            ' NOTE, MUST CLOSE THE SOCKET
            socket.Close()
            Label1.Text = "IP Sbagliato"
            Return False
        End If
        Label1.Text = "IP Corretto"
        Return True
    End Function

    Private Sub ReceiveData()
        Dim bytes(tcpClient.ReceiveBufferSize) As Byte
        Dim data As String

        While True
            Try
                Dim bytesRead As Integer = stream.ReadAsync(bytes, 0, tcpClient.ReceiveBufferSize).Result
                data = Encoding.UTF8.GetString(bytes, 0, bytesRead)
                AddMessage(data)
            Catch ex As Exception
            End Try

        End While
    End Sub

    Private Sub AddMessage(ByVal message As String)
        If Me.InvokeRequired Then
            Me.Invoke(Sub() AddMessage(message))
        Else
            Dim Dati As String() = message.ToString.Split("|")
            If Dati.Length = 1 Then
                If Leftx(message, 5) = "Clip%" Then
                    Dim file As System.IO.StreamWriter
                    file = My.Computer.FileSystem.OpenTextFileWriter(App_Path() & "Lotteria.txt", False)
                    file.WriteLine(message.Split(",")(1))
                    file.Close()
                    RichTextBox1.AppendText("Codice Lotteria " & message.Split(",")(1) & vbCrLf)
                    Exit Sub
                End If
                Dati = message.ToString.Split(",")
                If Dati.Length = 5 Then
                        ColoraDati(Dati)
                    End If
                ElseIf Dati.Length = 2 Then
                    If Dati(1) = "Chiamata" Then
                        If File.Exists(App_Path() & "Chiamata.txt") Then File.Delete(App_Path() & "Chiamata.txt")
                        Dim filex As System.IO.StreamWriter
                        filex = My.Computer.FileSystem.OpenTextFileWriter(App_Path() & "Chiamata.txt", False)
                        filex.WriteLine(Dati(0))
                        filex.Close()
                        RichTextBox1.AppendText(message & vbCrLf)
                    Else
                        RichTextBox1.AppendText("SMS Ricevuto " & message & vbCrLf)

                        Dim M() As String = ConvSmsCaster2(message).Split("|")
                        If File.Exists(App_Path() & "RecvSms.csv") Then
                            My.Computer.FileSystem.WriteAllText(
                                App_Path() & "RecvSms.csv", "-1,COM1," & M(0) & "," & M(1).Replace(",", "") & "," & Now.ToString & vbCrLf, True)
                        Else
                            My.Computer.FileSystem.WriteAllText(App_Path() & "RecvSms.csv", "ID,COM,From,Message,Date" & vbCrLf, True)
                            My.Computer.FileSystem.WriteAllText(
                                App_Path() & "RecvSms.csv", "-1,COM1," & M(0) & "," & M(1).Replace(",", "") & "," & Now.ToString & vbCrLf, True)
                        End If
                    End If
                ElseIf Dati.Length = 3 Then
                    Inviato = True
                    RichTextBox1.AppendText(message & vbCrLf)
                Else
                    RichTextBox1.AppendText(message & vbCrLf)
            End If
        End If
    End Sub

    Sub ColoraDati(Dati() As String)
        If IsNumeric(Dati(1)) And IsNumeric(Dati(2)) And IsNumeric(Dati(3)) Then
            Label4.Text = "GSM " & Dati(1) & "%"
            Label5.Text = "Wifi " & Dati(2) & "%"
            Label6.Text = "Batt. " & Dati(3) & "% " & Dati(4)

            If CInt(Dati(1)) > 50 Then
                Label4.BackColor = Color.LightGreen
            ElseIf CInt(Dati(1)) <= 50 And CInt(Dati(1)) > 10 Then
                Label4.BackColor = Color.Yellow
            Else
                Label4.BackColor = Color.Red
            End If

            If CInt(Dati(2)) > 50 Then
                Label5.BackColor = Color.LightGreen
            ElseIf CInt(Dati(2)) <= 50 And CInt(Dati(2)) > 10 Then
                Label5.BackColor = Color.Yellow
            Else
                Label5.BackColor = Color.Red
            End If

            If CInt(Dati(3)) > 50 Then
                Label6.BackColor = Color.LightGreen
            ElseIf CInt(Dati(3)) <= 50 And CInt(Dati(3)) > 10 Then
                Label6.BackColor = Color.Yellow
            Else
                Label6.BackColor = Color.Red
            End If
        End If

    End Sub

    Private Sub BtnDisconnect_Click(sender As Object, e As EventArgs) Handles BtnDisconnect.Click

        Label1.Text = ""
        RichTextBox1.Text = "App Disconnessa"
        TmrSendData.Stop()

        Try
            receiveThread.Abort()
        Catch ex As Exception
        End Try

        Label4.Text = "GSM"
        Label4.BackColor = SystemColors.Control
        Label5.Text = "Wifi"
        Label5.BackColor = SystemColors.Control
        Label6.Text = "Batt."
        Label6.BackColor = SystemColors.Control

        BtnDisconnect.Enabled = False
        BtnConnect.Enabled = True
        Timer1.Start()
    End Sub

    Private Sub TmrSendData_Tick(sender As Object, e As EventArgs) Handles TmrSendData.Tick
        Try
            RichTextBox1.Select(RichTextBox1.Text.Length, 0)
            Dim LineNum As Integer = (RichTextBox1.GetLineFromCharIndex(RichTextBox1.SelectionStart)) + 1
            If LineNum > 5000 Then RichTextBox1.Text = ""

            Dim bytes As Byte() = Encoding.UTF8.GetBytes("Test Connessione OK")
            stream.WriteAsync(bytes, 0, bytes.Length)


            If tcpClient.Connected Then
                Connesso = True
                Label1.Text = "IP Corretto"
            Else
                Connesso = False
                Label1.Text = "Inserisci IP App"
                Label1.ForeColor = Color.Black
                BtnDisconnect.PerformClick()
                Exit Sub
                If Label1.ForeColor <> Color.Green Then
                    BtnDisconnect.PerformClick()
                    Exit Sub
                End If
            End If
        Catch ex As Exception
            BtnDisconnect.PerformClick()
            Exit Sub
        End Try

        Dim cmd As New OleDb.OleDbCommand With {.Connection = oledbConnectionx}
        Dim Adapter As OleDb.OleDbDataAdapter = New OleDb.OleDbDataAdapter

        Dim foundRows As New Data.DataTable
        Adapter.SelectCommand = New OleDb.OleDbCommand("SELECT * From SMS Where NOME='Da Inviare'", oledbConnectionx)
        foundRows.Clear()
        Adapter.Fill(foundRows)
        For Each Rowsx In foundRows.Rows

            Dim Txt As String
            Txt = Rowsx("DA").ToString & "|" & Rowsx("MESSAGGIO").ToString & "|" & Rowsx("ID").ToString
            Txt = ConvASCII(Txt)

            If Connesso = True Then
                Try
                    TmrSendData.Enabled = False
                    Dim bytes As Byte() = Encoding.UTF8.GetBytes(Txt)
                    stream.WriteAsync(bytes, 0, bytes.Length)
                    RichTextBox1.AppendText(Txt & vbCrLf)
                    Do Until Inviato = True
                        Application.DoEvents()
                    Loop
                    Inviato = False
                    cmd.CommandText = "Update SMS Set NOME='Inviato' Where ID=" & Rowsx("ID").ToString
                    cmd.ExecuteNonQuery()
                Catch ex As Exception
                    BtnDisconnect.PerformClick()
                    Exit Sub
                End Try

            End If
            cmd.CommandText = "Delete From SMS Where NOME='Inviato';"
            cmd.ExecuteNonQuery()

            AggiornaSMS()
        Next




        If File.Exists(App_Path() & "GrupposmsText.txt") And File.Exists(App_Path() & "Grupposms.txt") And Connesso = True Then
            TmrSendData.Enabled = False
            Timer1.Enabled = False
            Timer2.Enabled = True
            Dim fileReader As String
            fileReader = My.Computer.FileSystem.ReadAllText(App_Path() & "GrupposmsText.txt")

            Dim sLine As String = ""
            Dim arrText As New ArrayList()
            Dim objReader As New StreamReader(App_Path() & "Grupposms.txt")
            Do
                sLine = objReader.ReadLine()
                If Not sLine Is Nothing Then
                    arrText.Add(sLine)
                End If
                Application.DoEvents()
            Loop Until sLine Is Nothing
            objReader.Close()


            RichTextBox1.AppendText(fileReader & vbCrLf)
            Dim conta As Integer
            For Each sLine In arrText
                conta += 1
                Dim Txt As String

                Txt = sLine & "|" & fileReader & "|-1"
                Txt = ConvASCII(Txt)
                Try
                    Dim bytes As Byte() = Encoding.UTF8.GetBytes(Txt)
                    stream.WriteAsync(bytes, 0, bytes.Length)
                    RichTextBox1.AppendText(Txt & vbCrLf)
                    Inviato = False
                    Do Until Inviato = True
                        Application.DoEvents()
                    Loop
                Catch ex As Exception
                    BtnDisconnect.PerformClick()
                    Exit Sub
                End Try

                Dim linesx As List(Of String) = System.IO.File.ReadAllLines(App_Path() & "Grupposms.txt").ToList
                If sLine = linesx(0) Then
                    linesx.RemoveAt(0)  ' index starts at 0 
                    System.IO.File.WriteAllLines("Grupposms.txt", linesx)
                End If

                RichTextBox1.AppendText(sLine & "  " & conta & " di " & arrText.Count & "  " & Now & vbCrLf)

                Application.DoEvents()
            Next


            If File.Exists(App_Path() & "Grupposms.txt") And Connesso = True Then File.Delete(App_Path() & "Grupposms.txt")
            If File.Exists(App_Path() & "GrupposmsText.txt") Then File.Delete(App_Path() & "GrupposmsText.txt")
            TmrSendData.Enabled = True
            Timer1.Enabled = True

        End If
        Timer2.Enabled = False
        TmrSendData.Enabled = True

    End Sub

    Function Accento(S As String) As String
        Return Replace(S, "'", "''")
    End Function


    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim Txt As String = TextBox5.Text & "|" & ConvSmsCaster(TextBox1.Text) & "|-12345"
        Txt = ConvASCII(Txt)

        Try
            Dim bytes As Byte() = Encoding.UTF8.GetBytes(Txt)
            stream.WriteAsync(bytes, 0, bytes.Length)

            RichTextBox1.AppendText(Txt & vbCrLf)
            Do Until Inviato = True
                Application.DoEvents()
            Loop
            Inviato = False

        Catch ex As Exception

            BtnDisconnect.PerformClick()
            Exit Sub
        End Try
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click

        If MsgBox("Elimino tutti gli SMS ?", MsgBoxStyle.YesNo + MsgBoxStyle.Question + 262144) = MsgBoxResult.No Then
            Exit Sub
        End If

        Try
            Dim cmd As New OleDb.OleDbCommand
            Dim J
            cmd.Connection = oledbConnectionx
            cmd.CommandText = "Delete From SMS Where NOME='Da Inviare'"
            J = cmd.ExecuteNonQuery()
        Catch ex As Exception
        End Try
        AggiornaSMS()
    End Sub

    Sub AggiornaSMS()
        Try

            Dim cmd As New OleDb.OleDbCommand With {.Connection = oledbConnectionx}

            Dim Adapter As OleDb.OleDbDataAdapter = New OleDb.OleDbDataAdapter
            Dim tabDest As New Data.DataTable

            Adapter.SelectCommand = New OleDb.OleDbCommand("SELECT * From SMS Where NOME='Da Inviare'", oledbConnectionx)
            Adapter.Fill(tabDest)
            DataGridView1.DataSource = tabDest

        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Private Sub DataGridView1_DataBindingComplete(sender As Object, e As DataGridViewBindingCompleteEventArgs) Handles DataGridView1.DataBindingComplete

        For index As Integer = 0 To DataGridView1.RowCount - 1
            DataGridView1.Rows(index).Cells("Elimina").Value = "Cancella"
            DataGridView1.Item("Elimina", index).Style.BackColor = Color.IndianRed
            DataGridView1.Item("Elimina", index).Style.ForeColor = Color.White
        Next
        DataGridView1.Columns("Elimina").ReadOnly = True
        Label3.Text = "Tot SMS " & DataGridView1.Rows.Count
    End Sub

    Private Sub DataGridView1_CellMouseClick(sender As Object, e As DataGridViewCellMouseEventArgs) Handles DataGridView1.CellMouseClick
        If e.ColumnIndex = 0 Then
            If DataGridView1.RowCount = e.RowIndex Then Exit Sub
            If MsgBox("Elimino la riga ?", MsgBoxStyle.YesNo + MsgBoxStyle.Question + 262144) = MsgBoxResult.No Then Exit Sub
            Dim cmd As New OleDb.OleDbCommand With {.Connection = oledbConnectionx}
            cmd.CommandText = "Delete From SMS Where ID=" & Me.DataGridView1.CurrentRow.Cells("ID").FormattedValue
            cmd.ExecuteNonQuery()
            AggiornaSMS()

            DataGridView1.Refresh()
        End If
    End Sub


    Private Sub Timer1_Tick(sender As Object, e As EventArgs) Handles Timer1.Tick
        If BtnConnect.Enabled = True Then
            BtnConnect.PerformClick()
        End If


        Dim cmdxx = New OleDbCommand("SELECT * From OpzioniApp", oledbConnectionx)
        Dim drx As OleDbDataReader = cmdxx.ExecuteReader()

        Dim Sms As Boolean
        While drx.Read
            Sms = drx("SMS")
        End While

        Dim cmd As New OleDb.OleDbCommand With {.Connection = oledbConnectionx}
        If tcpClient.Connected Then
            If Sms = False Then
                cmd.CommandText = "Update OpzioniApp Set SMS=true "
                cmd.ExecuteNonQuery()
            End If
        Else
            If Sms = True Then
                cmd.CommandText = "Update OpzioniApp Set SMS=0 "
                cmd.ExecuteNonQuery()
            End If
        End If

    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        RichTextBox1.Text = ""
    End Sub

    Private Sub Timer2_Tick(sender As Object, e As EventArgs) Handles Timer2.Tick
        Timer2.Enabled = False
        BtnConnect.PerformClick()
    End Sub

    Private Sub Form1_Closing(sender As Object, e As CancelEventArgs) Handles Me.Closing
        If tcpClient IsNot Nothing Then
            tcpClient.Close()
        End If

        Dim cmd As New OleDb.OleDbCommand With {.Connection = oledbConnectionx}
        cmd.CommandText = "Update OpzioniApp Set SMS=0 "
        cmd.ExecuteNonQuery()

        oledbConnectionx.Close()
        BtnDisconnect.PerformClick()

    End Sub

    Private Sub Timer3_Tick(sender As Object, e As EventArgs) Handles Timer3.Tick
        BtnDisconnect.PerformClick()
    End Sub

    Private Sub CheckBox1_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox1.CheckedChanged
        If CheckBox1.Checked = True Then
            Timer1.Enabled = True
            Timer1.Start()
        Else
            BtnDisconnect.PerformClick()
            Timer1.Enabled = False
            Timer1.Stop()
        End If
    End Sub
End Class
