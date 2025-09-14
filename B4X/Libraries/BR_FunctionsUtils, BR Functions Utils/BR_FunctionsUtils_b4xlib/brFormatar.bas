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

'somenteNumeros("R$ 2.500,00") --> "250000"
Public Sub somenteNumeros(texto As String) As String 'ignore
	Dim retorno As String = ""
	For i = 0 To texto.Length - 1
		If IsNumber(texto.CharAt(i)) Then
			retorno = retorno & texto.CharAt(i)
		End If
	Next
	Return retorno
End Sub

'telefone("99999999999") --> (99) 99999-9999
Public Sub telefone(texto As String) As String 'ignore
	texto = somenteNumeros(texto)
	If texto.Length=10 Then
		texto = "(" & texto.SubString2(0,2)& _
				   ")" & texto.SubString2(2,6)& _ 
				   "-" & texto.SubString2(6,10) 
	End If
	If texto.Length=11 Then
		texto = "(" & texto.SubString2(0,2)& _
				   ")" & texto.SubString2(2,7)& _ 
				   "-" & texto.SubString2(7,11) 
	End If
	If texto.Length=18 Then
		texto = "(" & texto.SubString2(0,2)& _
				   ")" & texto.SubString2(2,6)& _ 
				   "-" & texto.SubString2(6,10)& _ 
				   " / " & texto.SubString2(10,14)& _ 
				   "-" & texto.SubString2(14,18) 
	End If
	If texto.Length=19 Then
		texto = "(" & texto.SubString2(0,2)& _
				   ")" & texto.SubString2(2,7)& _ 
				   "-" & texto.SubString2(7,11)& _ 
				   " / " & texto.SubString2(11,15)& _ 
				   "-" & texto.SubString2(15,19)
	End If
	If texto.Length=20 Then
		texto = "(" & texto.SubString2(0,2)& _
				   ")" & texto.SubString2(2,7)& _ 
				   "-" & texto.SubString2(7,11)& _ 
				   " / " & texto.SubString2(11,16)& _ 
				   "-" & texto.SubString2(16,20)
	End If
	Return texto
End Sub

'cpfCnpj("99999999999") --> "999.999.999-99" ou cpfCnpj("99999999999999") --> "99.999.999/9999-99"
Public Sub cpfCnpj(texto As String) As String 'ignore
	texto = somenteNumeros(texto.Trim)
	If texto.Length=11 Then
		texto = cpf(texto)
	Else If texto.Length=14 Then
		texto = cnpj(texto)
	End If
	Return texto
End Sub

'cpf("99999999999") --> "999.999.999-99"
Sub cpf(texto As String) As String 'ignore
	texto = somenteNumeros(texto.Trim)
	If texto.Length=11 Then
		texto = ""  & texto.SubString2(0,3)& _
		      "." & texto.SubString2(3,6)& _
			  "." & texto.SubString2(6,9)& _
			  "-" & texto.SubString2(9,11)
	End If
	Return texto
End Sub

'cnpj("99999999999999") --> "99.999.999/9999-99"
Sub cnpj(texto As String) As String 'ignore
	texto = somenteNumeros(texto.Trim)
	If texto.Length=14 Then
		texto =	""  & texto.SubString2(0,2) & _
				"." & texto.SubString2(2,5) & _ 
				"." & texto.SubString2(5,8) & _ 
				"/" & texto.SubString2(8,12) & _ 
				"-" & texto.SubString2(12,14)
			  
	End If
	Return texto
End Sub

'cpfSeguro("99999999999") --> "***.999.999-**"
Sub cpfSeguro(texto As String) As String 'ignore
	If texto.Length=11 Then
		texto = ""  & "***"& _
		      "." & texto.SubString2(3,6)& _
			  "." & texto.SubString2(6,9)& _
			  "-" & "**"
	End If
	Return texto
End Sub

'valorBR(2500.75) --> "2.500,75"
Public Sub valorBR(valor As Double) As String 'ignore
	Log(NumberFormat2(valor,1,3,2,True).Replace(",","/").Replace(".",",").Replace("/","."))
	Return NumberFormat2(valor,1,3,2,True).Replace(",","/").Replace(".",",").Replace("/",".")
End Sub

'valorDB("2.500,75") --> 2500.75
Public Sub valorDB(valor As String) As Double 'ignore
	valor = valor.Trim.Replace(".","").Replace(",",".")
	Return IIf ( IsNumber(valor) , valor.As(Double) , 0 )
End Sub

'maiusculaInicioFrase("MARIA DA SILVA") --> "Maria da silva"
Public Sub maiusculaInicioFrase(texto As String) As String
	texto = texto.ToLowerCase
	Return texto.SubString2(0,1).ToUpperCase & texto.SubString(1)
End Sub

'maiusculaInicioFrase("MARIA DA SILVA") --> "Maria Da Silva"
Public Sub maiusculaCadaPalavra(texto As String) As String
	texto = texto.Trim.ToLowerCase
	
	If texto.Length>0 Then
		Dim palavras() As String = Regex.Split(" ", texto)
		
		texto = ""
		For i = 0 To palavras.Length-1
			Dim palavra As String = palavras(i)
		
			If palavra.Trim.Length > 0 Then
				
				If texto.Length>0 Then texto = texto & " "
			
				texto = texto & palavra.SubString2(0,1).ToUpperCase
			
				If palavra.Length>1 Then
					texto = texto & palavra.SubString(1)
				End If
			
			End If
		
		Next
		
	End If
	
	Return texto
End Sub

'removerCaracteresEspeciais("MARIA #@ SILVA") --> "MARIA  SILVA"
Sub removerCaracteresEspeciais(texto As String) As String 'ignore
	texto = texto.Replace("'","")
	texto = texto.Replace("!","")
	texto = texto.Replace("@","")
	texto = texto.Replace("#","")
	texto = texto.Replace("$","")
	texto = texto.Replace("%","")
	texto = texto.Replace("¨","")
	texto = texto.Replace("&","")
	texto = texto.Replace("*","")
	texto = texto.Replace("(","")
	texto = texto.Replace(")","")
	texto = texto.Replace("-","")
	texto = texto.Replace("_","")
	texto = texto.Replace("+","")
	texto = texto.Replace("=","")
	texto = texto.Replace("<","")
	texto = texto.Replace(">","")
	texto = texto.Replace(",","")
	texto = texto.Replace(".","")
	texto = texto.Replace(";","")
	texto = texto.Replace(":","")
	texto = texto.Replace("?","")
	texto = texto.Replace("/","")
	texto = texto.Replace("\","")
	Return texto
End Sub

'removerAcentos("JOÃO GONÇALVES") --> "JOAO GONCALVES"
Sub removerAcentos(texto As String) As String 'ignore
	texto = texto.Replace("Á","A")
	texto = texto.Replace("Ã","A")
	texto = texto.Replace("À","A")
	texto = texto.Replace("Â","A")
	texto = texto.Replace("É","E")
	texto = texto.Replace("È","E")
	texto = texto.Replace("Ê","E")
	texto = texto.Replace("Í","I")
	texto = texto.Replace("Ì","I")
	texto = texto.Replace("Î","I")
	texto = texto.Replace("Ó","O")
	texto = texto.Replace("Ò","O")
	texto = texto.Replace("Ô","O")
	texto = texto.Replace("Õ","O")
	texto = texto.Replace("Ú","U")
	texto = texto.Replace("Ù","U")
	texto = texto.Replace("Û","U")
	texto = texto.Replace("Ü","U")
	texto = texto.Replace("Ç","C")
	texto = texto.replace("á","a")
	texto = texto.replace("ã","a")
	texto = texto.replace("à","a")
	texto = texto.replace("â","a")
	texto = texto.replace("é","e")
	texto = texto.replace("è","e")
	texto = texto.replace("ê","e")
	texto = texto.replace("í","i")
	texto = texto.replace("ì","i")
	texto = texto.replace("î","i")
	texto = texto.replace("ó","o")
	texto = texto.replace("ò","o")
	texto = texto.replace("ô","o")
	texto = texto.replace("õ","o")
	texto = texto.replace("ú","u")
	texto = texto.replace("ù","u")
	texto = texto.replace("û","u")
	texto = texto.replace("ü","u")
	texto = texto.replace("ç","c")
	Return texto
End Sub