Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Drawing
Imports System.Text

Public Class Quadrante
    Private AngoloOra As Double = 360 / 12
    Private AngoloMinuto As Double = 360 / 60
    Private AngoloSecondo As Double = 360 / 60
    Private AMinuti As Double
    Private ASecondi As Double
    Private AOre As Double
    Private GA As Double, GB As Double
    Private RaggioX As Integer, RaggioY As Integer
    Private Ore As Integer, Minuti As Integer, Secondi As Integer
    Private Sfondo As Graphics
    Private CentroX As Integer, CentroY As Integer
    ' variabili per muovere 
    Private Px As Integer, Py As Integer, Muove As Integer

    Private Sub Quadrante_Load(sender As Object, e As EventArgs) Handles Me.Load
        Sfondo = Me.CreateGraphics()
        Px = Me.Left
        Py = Me.Top
        Muove = 0
    End Sub

    Private Sub Timer1_Tick(sender As Object, e As EventArgs) Handles Timer1.Tick
        Dim Linea As Point() = {New Point(10, 10), New Point(10, 100), New Point(10, 10)}
        Dim orario As DateTime
        Dim penna As Pen
        Dim brash As Brush
        brash = New SolidBrush(Color.Black)
        penna = New Pen(Color.Black)
        orario = DateTime.Now
        Ore = orario.Hour
        Minuti = orario.Minute
        Secondi = orario.Second
        ASecondi = Secondi * AngoloSecondo
        AMinuti = Minuti * AngoloMinuto
        AOre = Ore * AngoloOra
        AMinuti = AMinuti + ((AngoloMinuto / 60) * Secondi)
        AOre = AOre + ((AngoloOra / 60) * Minuti)
        Me.Refresh()
        ' trasformo gradi in radianti

        CentroX = Me.Width / 2
        CentroY = Me.Height / 2
        ' lancetta secondi
        GA = DaGraRad(ASecondi + 90)
        GB = DaGraRad(ASecondi - 90)
        ASecondi = DaGraRad(ASecondi)
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(ASecondi) * (CentroX - (CentroX / 10)))
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(ASecondi) * (CentroY - (CentroY / 10)))
        Linea(1).X = RaggioX
        Linea(1).Y = RaggioY
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(GA) * 2)
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(GA) * 2)
        Linea(0).X = RaggioX
        Linea(0).Y = RaggioY
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(GB) * 2)
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(GB) * 2)
        Linea(2).X = RaggioX
        Linea(2).Y = RaggioY
        penna.Color = System.Drawing.Color.Black
        penna.Width = 1
        Sfondo.FillPolygon(brash, Linea)

        ' lancetta minuti            
        GA = DaGraRad(AMinuti + 90)
        GB = DaGraRad(AMinuti - 90)
        AMinuti = DaGraRad(AMinuti)
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(AMinuti) * (CentroX - (CentroX / 6)))
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(AMinuti) * (CentroY - (CentroY / 6)))
        Linea(1).X = RaggioX
        Linea(1).Y = RaggioY
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(GA) * 3)
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(GA) * 3)
        Linea(0).X = RaggioX
        Linea(0).Y = RaggioY
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(GB) * 3)
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(GB) * 3)
        Linea(2).X = RaggioX
        Linea(2).Y = RaggioY
        penna.Width = 1
        penna.Color = System.Drawing.Color.Red
        Sfondo.FillPolygon(brash, Linea)

        ' lancetta ore
        GA = DaGraRad(AOre + 90)
        GB = DaGraRad(AOre - 90)
        AOre = DaGraRad(AOre)
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(AOre) * (CentroX - (CentroX / 4)))
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(AOre) * (CentroY - (CentroY / 4)))
        Linea(1).X = RaggioX
        Linea(1).Y = RaggioY
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(GA) * 4)
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(GA) * 4)
        Linea(0).X = RaggioX
        Linea(0).Y = RaggioY
        RaggioX = CentroX + Convert.ToInt16(Math.Cos(GB) * 4)
        RaggioY = CentroY + Convert.ToInt16(Math.Sin(GB) * 4)
        Linea(2).X = RaggioX
        Linea(2).Y = RaggioY
        penna.Width = 1
        penna.Color = System.Drawing.Color.Red
        Sfondo.FillPolygon(brash, Linea)
        brash = New SolidBrush(Color.Aquamarine)
        Sfondo.FillEllipse(brash, CentroX - 4, CentroY - 4, 8, 8)
    End Sub

    Private Function DaGraRad(gradi As Double) As Double
        Return (3.14159265358 / 180) * (gradi - 90)
    End Function

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Me.Close()
    End Sub
End Class
