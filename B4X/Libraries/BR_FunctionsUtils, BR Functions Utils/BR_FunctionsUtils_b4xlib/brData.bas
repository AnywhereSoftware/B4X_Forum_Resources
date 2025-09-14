B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

'MM->mes | dd->dia | yyyy->ano | hh->hora | mm->minuto | ss->segundo
Public Sub obterData(formatoSaida As String) As String 'ignore
	
	Try
	
		If formatoSaida = "" Or formatoSaida = "d" Then
			formatoSaida = "dd/MM/yyyy"
		Else If formatoSaida = "dh" Then
			formatoSaida = "dd/MM/yyyy hh:mm"
		Else If formatoSaida = "dhs" Then
			formatoSaida = "dd/MM/yyyy hh:mm:ss"
		Else If formatoSaida = "h" Then
			formatoSaida = "hh:mm"
		Else If formatoSaida = "hs" Then
			formatoSaida = "hh:mm:ss"
		Else If formatoSaida = "ymdhs" Then
			formatoSaida = "yyyy-MM-dd hh:mm:ss"
		Else If formatoSaida = "ymdh" Then
			formatoSaida = "yyyy-MM-dd hh:mm"
		Else If formatoSaida = "ymd" Then
			formatoSaida = "yyyy-MM-dd"
		Else If formatoSaida = "ym" Then
			formatoSaida = "yyyy-MM"
		Else If formatoSaida = "y" Then
			formatoSaida = "yyyy"
		End If
		
		Dim dia As String =  NumberFormat( DateTime.GetDayOfMonth(DateTime.Now) , 2 , 0 )
		Dim mes As String = NumberFormat( DateTime.GetMonth(DateTime.Now) , 2 , 0 )
		Dim ano As String = DateTime.GetYear(DateTime.Now)
		Dim ano2 As String = ano.SubString(2)
	
		Dim hora As String = NumberFormat( DateTime.GetHour(DateTime.Now) , 2 , 0 )
		Dim minuto As String = NumberFormat( DateTime.GetMinute(DateTime.Now) , 2 , 0 )
		Dim segundo As String = NumberFormat( DateTime.GetSecond(DateTime.Now) , 2 , 0 )
	
		formatoSaida = formatoSaida.Replace("dd",dia)
		formatoSaida = formatoSaida.Replace("MM",mes)
		formatoSaida = formatoSaida.Replace("yyyy",ano)
		formatoSaida = formatoSaida.Replace("yy",ano2)
		formatoSaida = formatoSaida.Replace("hh",hora)
		formatoSaida = formatoSaida.Replace("mm",minuto)
		formatoSaida = formatoSaida.Replace("ss",segundo)
	
	Catch
		Log(LastException)
	End Try
	
	Return formatoSaida
End Sub

'MM->mes | dd->dia | yyyy->ano | hh->hora | mm->minuto | ss->segundo
Public Sub data(dataHoraEntrada As String, formatoEntrada As String, formatoSaida As String) As String 'ignore
	
	Dim retorno As String = ""
		
	Try
		If formatoEntrada = "" Or formatoEntrada = "d" Then
			formatoEntrada = "dd/MM/yyyy"
		Else If formatoEntrada = "dh" Then
			formatoEntrada = "dd/MM/yyyy hh:mm"
		Else If formatoEntrada = "dhs" Then
			formatoEntrada = "dd/MM/yyyy hh:mm:ss"
		Else If formatoEntrada = "h" Then
			formatoEntrada = "hh:mm"
		Else If formatoEntrada = "hs" Then
			formatoEntrada = "hh:mm:ss"
		Else If formatoEntrada = "ymdhs" Then
			formatoEntrada = "yyyy-MM-dd hh:mm:ss"
		Else If formatoEntrada = "ymdh" Then
			formatoEntrada = "yyyy-MM-dd hh:mm"
		Else If formatoEntrada = "ymd" Then
			formatoEntrada = "yyyy-MM-dd"
		Else If formatoEntrada = "ym" Then
			formatoEntrada = "yyyy-MM"
		Else If formatoEntrada = "y" Then
			formatoEntrada = "yyyy"
		End If
		
		If formatoSaida = "" Or formatoSaida = "d" Then
			formatoSaida = "dd/MM/yyyy"
		Else If formatoSaida = "dh" Then
			formatoSaida = "dd/MM/yyyy hh:mm"
		Else If formatoSaida = "dhs" Then
			formatoSaida = "dd/MM/yyyy hh:mm:ss"
		Else If formatoSaida = "h" Then
			formatoSaida = "hh:mm"
		Else If formatoSaida = "hs" Then
			formatoSaida = "hh:mm:ss"
		Else If formatoSaida = "ymdhs" Then
			formatoSaida = "yyyy-MM-dd hh:mm:ss"
		Else If formatoSaida = "ymdh" Then
			formatoSaida = "yyyy-MM-dd hh:mm"
		Else If formatoSaida = "ymd" Then
			formatoSaida = "yyyy-MM-dd"
		Else If formatoSaida = "ym" Then
			formatoSaida = "yyyy-MM"
		Else If formatoSaida = "y" Then
			formatoSaida = "yyyy"
		End If
		
		
		
		dataHoraEntrada = dataHoraEntrada.Trim
	
		If dataHoraEntrada="" Or dataHoraEntrada=Null Or dataHoraEntrada.ToLowerCase="null" Then
			Return retorno
		End If
	
		If dataHoraEntrada.Length > formatoEntrada.Length Then
			dataHoraEntrada = dataHoraEntrada.SubString2(0, formatoEntrada.Length )
		End If
	
		If formatoEntrada.Length > dataHoraEntrada.Length Then
			formatoEntrada = formatoEntrada.SubString2(0, dataHoraEntrada.Length )
		End If
	
		Dim d1 As Int = formatoEntrada.IndexOf("d")
		Dim d2 As Int = formatoEntrada.LastIndexOf("d")+1
	
		Dim M1 As Int = formatoEntrada.IndexOf("M")
		Dim M2 As Int = formatoEntrada.LastIndexOf("M")+1
	
		Dim y1 As Int = formatoEntrada.IndexOf("y")
		Dim y2 As Int = formatoEntrada.LastIndexOf("y")+1
	
		Dim h1 As Int = formatoEntrada.IndexOf("h")
		Dim h2 As Int = formatoEntrada.LastIndexOf("h")+1
	
		Dim m3 As Int = formatoEntrada.IndexOf("m")
		Dim m4 As Int = formatoEntrada.LastIndexOf("m")+1
	
		Dim s1 As Int = formatoEntrada.IndexOf("s")
		Dim s2 As Int = formatoEntrada.LastIndexOf("s")+1
	
		Dim dia As String =  NumberFormat( IIf(d1>=0, dataHoraEntrada.SubString2(d1,d2), 0) , 2 , 0 )
		Dim mes As String = NumberFormat( IIf(M1>=0, dataHoraEntrada.SubString2(M1,M2), 0) , 2 , 0 )
		Dim ano As String = IIf(y1>=0, dataHoraEntrada.SubString2(y1,y2), 0)
		Dim ano2 As String = ano.SubString(2)
	
		Dim hora As String = NumberFormat( IIf(h1>=0, dataHoraEntrada.SubString2(h1,h2), 0) , 2 , 0 )
		Dim minuto As String = NumberFormat( IIf(m3>=0, dataHoraEntrada.SubString2(m3,m4), 0) , 2 , 0 )
		Dim segundo As String = NumberFormat( IIf(s1>=0, dataHoraEntrada.SubString2(s1,s2), 0) , 2 , 0 )
	
		formatoSaida = formatoSaida.Replace("dd",dia)
		formatoSaida = formatoSaida.Replace("MM",mes)
		formatoSaida = formatoSaida.Replace("yyyy",ano)
		formatoSaida = formatoSaida.Replace("yy",ano2)
		formatoSaida = formatoSaida.Replace("hh",hora)
		formatoSaida = formatoSaida.Replace("mm",minuto)
		formatoSaida = formatoSaida.Replace("ss",segundo)
	
		retorno = formatoSaida
	Catch
		Log("Erro ao converter data("&dataHoraEntrada&") : "&LastException)
	End Try
	
	Return retorno
End Sub


'MM->mes | dd->dia | yyyy->ano | hh->hora | mm->minuto | ss->segundo
Public Sub longData(dataHoraEntrada As Long, formatoSaida As String) As String 'ignore
	
	Dim retorno As String = ""
	
	Try
		If formatoSaida = "" Or formatoSaida = "d" Then
			formatoSaida = "dd/MM/yyyy"
		Else If formatoSaida = "dh" Then
			formatoSaida = "dd/MM/yyyy hh:mm"
		Else If formatoSaida = "dhs" Then
			formatoSaida = "dd/MM/yyyy hh:mm:ss"
		Else If formatoSaida = "h" Then
			formatoSaida = "hh:mm"
		Else If formatoSaida = "hs" Then
			formatoSaida = "hh:mm:ss"
		Else If formatoSaida = "ymdhs" Then
			formatoSaida = "yyyy-MM-dd hh:mm:ss"
		Else If formatoSaida = "ymdh" Then
			formatoSaida = "yyyy-MM-dd hh:mm"
		Else If formatoSaida = "ymd" Then
			formatoSaida = "yyyy-MM-dd"
		Else If formatoSaida = "ym" Then
			formatoSaida = "yyyy-MM"
		Else If formatoSaida = "y" Then
			formatoSaida = "yyyy"
		End If
		
		If dataHoraEntrada=0 Then
			DateTime.SetTimeZone(-3) 'HORA BR
			dataHoraEntrada = DateTime.Now
		End If
	
		Dim dia As String = NumberFormat( DateTime.GetDayOfMonth( dataHoraEntrada ) , 2 , 0 )
		Dim mes As String = NumberFormat( DateTime.GetMonth( dataHoraEntrada ) , 2 , 0 )
		Dim ano As String = DateTime.GetYear( dataHoraEntrada )
		Dim ano2 As String = ano.SubString(2)
	
		Dim hora As String = NumberFormat( DateTime.GetHour( dataHoraEntrada ) , 2 , 0 )
		Dim minuto As String = NumberFormat( DateTime.GetMinute( dataHoraEntrada ) , 2 , 0 )
		Dim segundo As String = NumberFormat( DateTime.GetSecond( dataHoraEntrada ) , 2 , 0 )
	
		formatoSaida = formatoSaida.Replace("dd",dia)
		formatoSaida = formatoSaida.Replace("MM",mes)
		formatoSaida = formatoSaida.Replace("yyyy",ano)
		formatoSaida = formatoSaida.Replace("yy",ano2)
		formatoSaida = formatoSaida.Replace("hh",hora)
		formatoSaida = formatoSaida.Replace("mm",minuto)
		formatoSaida = formatoSaida.Replace("ss",segundo)
		
		retorno = formatoSaida
	Catch
		Log(LastException)
	End Try
	
	Return retorno
End Sub

'MM->mes | dd->dia | yyyy->ano | hh->hora | mm->minuto | ss->segundo
Public Sub dataLong(dataHoraEntrada As String, formatoEntrada As String) As Long 'ignore
	
	Dim retorno As Long = 0
	
	If dataHoraEntrada.Length > 0 Then
		
		If formatoEntrada = "" Or formatoEntrada = "d" Then
			formatoEntrada = "dd/MM/yyyy"
		Else If formatoEntrada = "dh" Then
			formatoEntrada = "dd/MM/yyyy hh:mm"
		Else If formatoEntrada = "dhs" Then
			formatoEntrada = "dd/MM/yyyy hh:mm:ss"
		Else If formatoEntrada = "h" Then
			formatoEntrada = "hh:mm"
		Else If formatoEntrada = "hs" Then
			formatoEntrada = "hh:mm:ss"
		Else If formatoEntrada = "ymdhs" Then
			formatoEntrada = "yyyy-MM-dd hh:mm:ss"
		Else If formatoEntrada = "ymdh" Then
			formatoEntrada = "yyyy-MM-dd hh:mm"
		Else If formatoEntrada = "ymd" Then
			formatoEntrada = "yyyy-MM-dd"
		Else If formatoEntrada = "ym" Then
			formatoEntrada = "yyyy-MM"
		Else If formatoEntrada = "y" Then
			formatoEntrada = "yyyy"
		End If
		 
		Try
			If dataHoraEntrada.Length > formatoEntrada.Length Then
				dataHoraEntrada = dataHoraEntrada.SubString2(0, formatoEntrada.Length )
			End If
	
			If formatoEntrada.Length > dataHoraEntrada.Length Then
				formatoEntrada = formatoEntrada.SubString2(0, dataHoraEntrada.Length )
			End If
	
			Dim d1 As Int = formatoEntrada.IndexOf("d")
			Dim d2 As Int = formatoEntrada.LastIndexOf("d")+1
	
			Dim M1 As Int = formatoEntrada.IndexOf("M")
			Dim M2 As Int = formatoEntrada.LastIndexOf("M")+1
	
			Dim y1 As Int = formatoEntrada.IndexOf("y")
			Dim y2 As Int = formatoEntrada.LastIndexOf("y")+1
	
			Dim h1 As Int = formatoEntrada.IndexOf("h")
			Dim h2 As Int = formatoEntrada.LastIndexOf("h")+1
	
			Dim m3 As Int = formatoEntrada.IndexOf("m")
			Dim m4 As Int = formatoEntrada.LastIndexOf("m")+1
	
			Dim s1 As Int = formatoEntrada.IndexOf("s")
			Dim s2 As Int = formatoEntrada.LastIndexOf("s")+1
	
			Dim dia As String =  NumberFormat( IIf(d1>=0, dataHoraEntrada.SubString2(d1,d2), 0) , 2 , 0 )
			Dim mes As String = NumberFormat( IIf(M1>=0, dataHoraEntrada.SubString2(M1,M2), 0) , 2 , 0 )
			Dim ano As String = IIf(y1>=0, dataHoraEntrada.SubString2(y1,y2), 0)
	
			Dim hora As String = NumberFormat( IIf(h1>=0, dataHoraEntrada.SubString2(h1,h2), 0) , 2 , 0 )
			Dim minuto As String = NumberFormat( IIf(m3>=0, dataHoraEntrada.SubString2(m3,m4), 0) , 2 , 0 )
			Dim segundo As String = NumberFormat( IIf(s1>=0, dataHoraEntrada.SubString2(s1,s2), 0) , 2 , 0 )
	
			retorno = DateUtils.SetDateAndTime(ano,mes,dia,hora,minuto,segundo)
		Catch
			Log(LastException)
		End Try
	End If
	
	Return retorno
End Sub

'saída: "dd/MM/yyyy hh:mm:ss"
Public Sub dataHoraBR(dataHoraEntrada As String) As String 'ignore
	Return data(dataHoraEntrada, "yyyy-MM-dd hh:mm:ss", "dd/MM/yyyy hh:mm:ss")
End Sub

'saída: "yyyy-MM-dd hh:mm:ss"
Public Sub dataHoraDB(dataHoraEntrada As String) As String 'ignore
	Return data(dataHoraEntrada, "dd/MM/yyyy hh:mm:ss", "yyyy-MM-dd hh:mm:ss")
End Sub

'saída: "dd/MM/yyyy"
Public Sub dataBR(dataHoraEntrada As String) As String 'ignore
	Return data(dataHoraEntrada, "yyyy-MM-dd", "dd/MM/yyyy")
End Sub

'saída: "yyyy-MM-dd"
Public Sub dataDB(dataHoraEntrada As String) As String 'ignore
	Return data(dataHoraEntrada, "dd/MM/yyyy", "yyyy-MM-dd")
End Sub


'saída: "dezembro"
Public Sub nomeMes(dataHoraEntrega As Long) As String 'ignore
	Dim mesesDoAno As Map = CreateMap(1:"janeiro", 2:"fevereiro", 3:"março", 4:"abril", 5:"maio", 6:"junho", 7:"julho", 8:"agosto", 9:"setembro", 10:"outubro", 11:"novembro", 12:"dezembro")
	Return mesesDoAno.GetDefault(DateTime.GetMonth(dataHoraEntrega), "")
	
End Sub

'seída: "segunda-feira"
Public Sub nomeDiaSemana(dataHoraEntrega As Long) As String 'ignore
	Dim diasDaSemana As Map = CreateMap(1:"domingo", 2:"segunda-feira", 3:"terça-feira", 4:"quarta-feira", 5:"quinta-feira", 6:"sexta-feira", 7:"sábado")
	Return diasDaSemana.GetDefault(DateTime.GetDayOfWeek(dataHoraEntrega), "")
End Sub
