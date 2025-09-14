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

Private Sub somenteNumeros(texto As String) As String 'ignore
	Dim retorno As String = ""
	For i = 0 To texto.Length - 1
		If IsNumber(texto.CharAt(i)) Then
			retorno = retorno & texto.CharAt(i)
		End If
	Next
	Return retorno
End Sub

Public Sub cpfCnpj(texto As String) As Boolean 'ignore
	If cpf(texto) Or cnpj(texto) Then
		Return True
	End If
	Return False
End Sub

Public Sub cpf(texto As String) As Boolean 'ignore
	texto = somenteNumeros(texto)
	
	Dim Soma1 As Int
	Dim Divisao1 As Double
	Dim Multiplica1 As Double
	Dim Dig1 As String
	Dim Divisao2 As Double
	Dim Multiplica2 As Double
	Dim Soma2 As Int
	Dim Dig2 As String
	Dim Resto As Int
	Dim I As Int
	Dim Cont As Int
	Dim iNumero As Int
	
	If texto.Trim.Length <> 11 Then
		Return False
	End If
   
	Soma1 = 0
	Cont = 10
		
	For I = 0 To 8
		iNumero = texto.SubString2(I,I+1)
		Soma1 = Soma1 + (iNumero * Cont)
		Cont = Cont - 1
	Next
		
	Divisao1 = Floor(Soma1 / 11)
	Multiplica1 = Divisao1 * 11
	Resto = Soma1 - Multiplica1
		
	If Resto = 0 Or Resto = 1 Then
		Dig1 = "0"
	Else
		Dig1 = (11 - Resto)
	End If
		
	If Dig1 <> texto.SubString2(9,10) Then
		Return False
	End If
		
	'** Cálculo do 2° digito
	Soma2 = 0
	Cont = 11
		
	For I = 0 To 8
		iNumero = texto.SubString2(I,I+1)
		Soma2 = Soma2 + (iNumero * Cont)
		Cont = Cont - 1
	Next
		
	iNumero = Dig1
	Soma2 = Soma2 + (iNumero * 2)
	Divisao2 = Floor(Soma2 / 11)
	Multiplica2 = Divisao2 * 11
	Resto = Soma2 - Multiplica2
		
	If Resto = 0 Or Resto = 1 Then
		Dig2 = "0"
	Else
		Dig2 = (11 - Resto)
	End If
		
	If Dig2 = texto.SubString (10) Then
		Return True
	End If
	
	Return False
End Sub

Public Sub cnpj(texto As String) As Boolean 'ignore
	texto = somenteNumeros(texto)
	
	Dim Soma1 As Int
	Dim Divisao1 As Double
	Dim Multiplica1 As Double
	Dim Dig1 As String
	Dim Divisao2 As Double
	Dim Multiplica2 As Double
	Dim Soma2 As Int
	Dim Dig2 As String
	Dim Resto As Int
	Dim I As Int
	Dim Cont As Int
	Dim iNumero As Int
	
	If  texto.Trim.Length <> 14 Then
		Return False
	End If
   
	Soma1 = 0
	Cont = 5
		
	For I = 0 To 11 '12 primeiros numeros do CNPJ
		iNumero = texto.SubString2(I,I+1)
		Soma1 = Soma1 + (iNumero * Cont)
		Cont = Cont - 1
		If Cont = 1 Then Cont = 9
	Next
	   
	Divisao1 = Floor(Soma1 / 11)
	Multiplica1 = Divisao1 * 11
	Resto = Soma1 - Multiplica1
		
	If Resto = 0 Or Resto = 1 Then
		Dig1 = "0"
	Else
		Dig1 = (11 - Resto)
	End If
		
	If Dig1 <> texto.SubString2(12,13) Then
		Return False
	End If
	  
	Soma2 = 0
	Cont = 6
		
	For I = 0 To 11 '12 primeiros numeros do CNPJ
			
		iNumero = texto.SubString2(I,I+1)
		Soma2 = Soma2 + (iNumero * Cont)
		Cont = Cont - 1
			
		If Cont = 1 Then
			Cont = 9
		End If
			
	Next
		
	iNumero = Dig1 'converte para numero
	Soma2 = Soma2 + (iNumero * 2)
	Divisao2 = Floor(Soma2 / 11)
	Multiplica2 = Divisao2 * 11
	Resto = Soma2 - Multiplica2
		
	If Resto = 0 Or Resto = 1 Then
		Dig2 = "0"
	Else
		Dig2 = (11 - Resto)
	End If
		
	If Dig2 = texto.SubString(13) Then
		Return True
	End If
	
	Return False
End Sub

Sub email(texto As String) As Boolean 'ignore
	Dim valido As Boolean = True
	
	'teste@teste.com
	
	If texto.Contains("@@") Then
		valido = False
	End If
	
	If Not(texto.Contains("@")) Then
		valido = False
	End If
	
	If Not(texto.Contains(".")) Then
		valido = False
	End If
	
	If texto.Length<5 Then
		valido = False
	End If
	
	Return valido
End Sub


