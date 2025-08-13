B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.2
@EndOfDesignText@
'version 1.02
Sub Class_Globals
	Private xui As XUI
	Public cvs As B4XCanvas
	Private xview As B4XView
End Sub

Public Sub Initialize
	Dim xview As B4XView = xui.CreatePanel(Null)
	xview.SetLayoutAnimated(0, 0, 0, 1050dip, 300dip)
	xview.Color = xui.Color_White
End Sub


#Region EAN13

Public Sub EAN13(codigo As String) As B4XBitmap
	cvs.Initialize(xview)
	cvs.ClearRect(cvs.TargetRect)
	
	If codigo.Length=12 Then codigo = "0" & codigo
	
	If codigo.Length=13 Then
		
		Dim novoCodigo As String = preparaEAN13(codigo)
	
		If novoCodigo<>"" Then
		
			'Dim canvas As B4XCanvas
			Dim alturaPainel As Int = xview.Height
			Dim larguraPainel As Int = xview.Width
			Dim larguraCodigo As Int = xview.Width - 100dip
    
			'Calcula as dimensões dos elementos do código de barras'
			Dim alturaNumero As Int = 40dip 'altura dos números abaixo do código'
			Dim larguraBarra As Int = larguraCodigo / 95 'largura de cada barra'
			Dim alturaBarra As Int = alturaPainel - alturaNumero'altura das barras'
    
			'Desenha as barras e os números do código de barras'
			Dim rect As B4XRect
			rect.Initialize(0, 0, larguraPainel, alturaPainel)
	
			cvs.DrawRect(rect, xui.Color_White, True, 0) 'fundo branco'
	
			Dim larguraAtual As Int = 50dip
	
			For i=0 To novoCodigo.Length-1
				Dim cor As Int = xui.Color_Black
				If novoCodigo.CharAt(i) = "0" Then cor = xui.Color_White
				If novoCodigo.CharAt(i) = "2" Then
					cvs.DrawLine(larguraAtual, 0, larguraAtual, alturaBarra, cor, larguraBarra)
				Else
					cvs.DrawLine(larguraAtual, 0, larguraAtual, alturaBarra - alturaNumero, cor, larguraBarra)
				End If
		
				larguraAtual = larguraAtual + larguraBarra
			Next
			
			'Desenha o número abaixo do código de barras'
			Dim fonte As B4XFont = xui.CreateFontAwesome(63)
	
			Dim sb As StringBuilder
			sb.Initialize
	
			For i=1 To codigo.Length
				Dim codigoCaracter As String = codigo.CharAt(i-1)
				sb.Append(codigoCaracter)
		
				If i=1 Then
					sb.Append("    ")
				Else If i=7 Then
					sb.Append("      ")
				Else If i=13 Then
					'nao adiciona nada
				Else
					sb.Append("  ")
				End If
			Next
	
			cvs.DrawText(sb.ToString, 1dip, alturaBarra+10dip, fonte, xui.Color_Black, "LEFT")
    
		End If
		
	End If
	cvs.Invalidate
	Dim res As B4XBitmap = cvs.CreateBitmap
	cvs.Release
	Return res
End Sub

Private Sub preparaEAN13(codigo As String) As String
	
	Dim primeiroDigito As String = codigo.SubString2(0,1)
	Dim primeiroGrupo As String = codigo.SubString2(1,7)
	Dim segundoGrupo As String = codigo.SubString2(7,13)
	
	Dim sequenciaNovo As String = ""
	Dim codigoNovo As String = "-" & primeiroGrupo & "=" & segundoGrupo & "-"
	
	If primeiroDigito="0" Then sequenciaNovo="-LLLLLL=RRRRRR-"
	If primeiroDigito="1" Then sequenciaNovo="-LLGLGG=RRRRRR-"
	If primeiroDigito="2" Then sequenciaNovo="-LLGGLG=RRRRRR-"
	If primeiroDigito="3" Then sequenciaNovo="-LLGGGL=RRRRRR-"
	If primeiroDigito="4" Then sequenciaNovo="-LGLLGG=RRRRRR-"
	If primeiroDigito="5" Then sequenciaNovo="-LGGLLG=RRRRRR-"
	If primeiroDigito="6" Then sequenciaNovo="-LGGGLL=RRRRRR-"
	If primeiroDigito="7" Then sequenciaNovo="-LGLGLG=RRRRRR-"
	If primeiroDigito="8" Then sequenciaNovo="-LGLGGL=RRRRRR-"
	If primeiroDigito="9" Then sequenciaNovo="-LGGLGL=RRRRRR-"
	
	Dim sb As StringBuilder
	sb.Initialize
	
	For i=0 To codigoNovo.Length-1
		Dim digitoGrupo As String = codigoNovo.CharAt(i)
		Dim sequenciaGrupo As String = sequenciaNovo.CharAt(i)
		
		If sequenciaGrupo="L" Then
			If digitoGrupo="0" Then sb.Append("0001101")
			If digitoGrupo="1" Then sb.Append("0011001")
			If digitoGrupo="2" Then sb.Append("0010011")
			If digitoGrupo="3" Then sb.Append("0111101")
			If digitoGrupo="4" Then sb.Append("0100011")
			If digitoGrupo="5" Then sb.Append("0110001")
			If digitoGrupo="6" Then sb.Append("0101111")
			If digitoGrupo="7" Then sb.Append("0111011")
			If digitoGrupo="8" Then sb.Append("0110111")
			If digitoGrupo="9" Then sb.Append("0001011")
		else If sequenciaGrupo="G" Then
			If digitoGrupo="0" Then sb.Append("0100111")
			If digitoGrupo="1" Then sb.Append("0110011")
			If digitoGrupo="2" Then sb.Append("0011011")
			If digitoGrupo="3" Then sb.Append("0100001")
			If digitoGrupo="4" Then sb.Append("0011101")
			If digitoGrupo="5" Then sb.Append("0111001")
			If digitoGrupo="6" Then sb.Append("0000101")
			If digitoGrupo="7" Then sb.Append("0010001")
			If digitoGrupo="8" Then sb.Append("0001001")
			If digitoGrupo="9" Then sb.Append("0010111")
		Else If sequenciaGrupo="R" Then
			If digitoGrupo="0" Then sb.Append("1110010")
			If digitoGrupo="1" Then sb.Append("1100110")
			If digitoGrupo="2" Then sb.Append("1101100")
			If digitoGrupo="3" Then sb.Append("1000010")
			If digitoGrupo="4" Then sb.Append("1011100")
			If digitoGrupo="5" Then sb.Append("1001110")
			If digitoGrupo="6" Then sb.Append("1010000")
			If digitoGrupo="7" Then sb.Append("1000100")
			If digitoGrupo="8" Then sb.Append("1001000")
			If digitoGrupo="9" Then sb.Append("1110100")
		Else If sequenciaGrupo="-" Then
			sb.Append("202")
		Else If sequenciaGrupo="=" Then
			sb.Append("02020")
		End If
	Next
	
	Return sb.ToString
End Sub

#End Region


#Region UPCA

Public Sub UPCA(codigo As String) As B4XBitmap
	cvs.Initialize(xview)
	cvs.ClearRect(cvs.TargetRect)
	
	If codigo.Length=11 Then codigo = "0" & codigo
	
	If codigo.Length=12 Then
		
		Dim novoCodigo As String = preparaUPCA(codigo)
	
		If novoCodigo<>"" Then
		
			'Dim canvas As B4XCanvas
			Dim alturaPainel As Int = xview.Height
			Dim larguraPainel As Int = xview.Width
			Dim larguraCodigo As Int = xview.Width - 100dip
    
			'Calcula as dimensões dos elementos do código de barras'
			Dim alturaNumero As Int = 40dip 'altura dos números abaixo do código'
			Dim larguraBarra As Int = larguraCodigo / 95 'largura de cada barra'
			Dim alturaBarra As Int = alturaPainel - alturaNumero'altura das barras'
    
			'Desenha as barras e os números do código de barras'
			Dim rect As B4XRect
			rect.Initialize(0, 0, larguraPainel, alturaPainel)
	
			cvs.DrawRect(rect, xui.Color_White, True, 0) 'fundo branco'
	
			Dim larguraAtual As Int = 50dip
	
			For i=0 To novoCodigo.Length-1
				Dim cor As Int = xui.Color_Black
				If novoCodigo.CharAt(i) = "0" Then cor = xui.Color_White
				If novoCodigo.CharAt(i) = "2" Then
					cvs.DrawLine(larguraAtual, 0, larguraAtual, alturaBarra, cor, larguraBarra)
				Else
					cvs.DrawLine(larguraAtual, 0, larguraAtual, alturaBarra - alturaNumero, cor, larguraBarra)
				End If
		
				larguraAtual = larguraAtual + larguraBarra
			Next
			
			'Desenha o número abaixo do código de barras'
			Dim fonte As B4XFont = xui.CreateFontAwesome(63)
	
			Dim sb As StringBuilder
			sb.Initialize
	
			For i=1 To codigo.Length
				Dim codigoCaracter As String = codigo.CharAt(i-1)
				sb.Append(codigoCaracter)
		
				If i=1 Then
					sb.Append("        ")
				Else If i=6 Then
					sb.Append("      ")
				Else If i=11 Then
					sb.Append("         ")
				Else If i=12 Then
					'nao adiciona nada
				Else
					sb.Append("  ")
				End If
			Next
	
			cvs.DrawText(sb.ToString, 1dip, alturaBarra+10dip, fonte, xui.Color_Black, "LEFT")
    
		End If
		
	End If
	cvs.Invalidate
	Dim res As B4XBitmap = cvs.CreateBitmap
	cvs.Release
	Return res
End Sub

Private Sub preparaUPCA(codigo As String) As String
	
	Dim primeiroGrupo As String = codigo.SubString2(0,6)
	Dim segundoGrupo As String = codigo.SubString2(6,12)
	
	Dim sequenciaNovo As String = "-JLLLLL=RRRRRS-"
	Dim codigoNovo As String = "-" & primeiroGrupo & "=" & segundoGrupo & "-"
	
	Dim sb As StringBuilder
	sb.Initialize
	
	For i=0 To codigoNovo.Length-1
		Dim digitoGrupo As String = codigoNovo.CharAt(i)
		Dim sequenciaGrupo As String = sequenciaNovo.CharAt(i)
		
		If sequenciaGrupo="L" Then
			If digitoGrupo="0" Then sb.Append("0001101")
			If digitoGrupo="1" Then sb.Append("0011001")
			If digitoGrupo="2" Then sb.Append("0010011")
			If digitoGrupo="3" Then sb.Append("0111101")
			If digitoGrupo="4" Then sb.Append("0100011")
			If digitoGrupo="5" Then sb.Append("0110001")
			If digitoGrupo="6" Then sb.Append("0101111")
			If digitoGrupo="7" Then sb.Append("0111011")
			If digitoGrupo="8" Then sb.Append("0110111")
			If digitoGrupo="9" Then sb.Append("0001011")
		Else If sequenciaGrupo="J" Then
			If digitoGrupo="0" Then sb.Append("0001101".Replace("1","2"))
			If digitoGrupo="1" Then sb.Append("0011001".Replace("1","2"))
			If digitoGrupo="2" Then sb.Append("0010011".Replace("1","2"))
			If digitoGrupo="3" Then sb.Append("0111101".Replace("1","2"))
			If digitoGrupo="4" Then sb.Append("0100011".Replace("1","2"))
			If digitoGrupo="5" Then sb.Append("0110001".Replace("1","2"))
			If digitoGrupo="6" Then sb.Append("0101111".Replace("1","2"))
			If digitoGrupo="7" Then sb.Append("0111011".Replace("1","2"))
			If digitoGrupo="8" Then sb.Append("0110111".Replace("1","2"))
			If digitoGrupo="9" Then sb.Append("0001011".Replace("1","2"))
		Else If sequenciaGrupo="R" Then
			If digitoGrupo="0" Then sb.Append("1110010")
			If digitoGrupo="1" Then sb.Append("1100110")
			If digitoGrupo="2" Then sb.Append("1101100")
			If digitoGrupo="3" Then sb.Append("1000010")
			If digitoGrupo="4" Then sb.Append("1011100")
			If digitoGrupo="5" Then sb.Append("1001110")
			If digitoGrupo="6" Then sb.Append("1010000")
			If digitoGrupo="7" Then sb.Append("1000100")
			If digitoGrupo="8" Then sb.Append("1001000")
			If digitoGrupo="9" Then sb.Append("1110100")		
		Else If sequenciaGrupo="S" Then
			If digitoGrupo="0" Then sb.Append("1110010".Replace("1","2"))
			If digitoGrupo="1" Then sb.Append("1100110".Replace("1","2"))
			If digitoGrupo="2" Then sb.Append("1101100".Replace("1","2"))
			If digitoGrupo="3" Then sb.Append("1000010".Replace("1","2"))
			If digitoGrupo="4" Then sb.Append("1011100".Replace("1","2"))
			If digitoGrupo="5" Then sb.Append("1001110".Replace("1","2"))
			If digitoGrupo="6" Then sb.Append("1010000".Replace("1","2"))
			If digitoGrupo="7" Then sb.Append("1000100".Replace("1","2"))
			If digitoGrupo="8" Then sb.Append("1001000".Replace("1","2"))
			If digitoGrupo="9" Then sb.Append("1110100".Replace("1","2"))
		Else If sequenciaGrupo="-" Then
			sb.Append("202")
		Else If sequenciaGrupo="=" Then
			sb.Append("02020")
		End If
	Next
	
	Return sb.ToString
End Sub

#End Region


#Region CODE128

Public Sub CODE128(codigo As String) As B4XBitmap
	cvs.Initialize(xview)
	cvs.ClearRect(cvs.TargetRect)
	
	Dim novoCodigo As String = preparaCODE128(codigo)

	If novoCodigo<>"" Then
	
		'Dim canvas As B4XCanvas
		Dim alturaPainel As Int = xview.Height
		Dim larguraPainel As Int = xview.Width
		Dim larguraCodigo As Int = xview.Width - 100dip

		'Calcula as dimensões dos elementos do código de barras'
		Dim alturaNumero As Int = 40dip 'altura dos números abaixo do código'
		Dim larguraBarra As Int = larguraCodigo / ((codigo.Length*11)+11+11+13) 'largura de cada barra'
		Dim alturaBarra As Int = alturaPainel - alturaNumero'altura das barras'


		'Desenha as barras e os números do código de barras'
		Dim rect As B4XRect
		rect.Initialize(0, 0, larguraPainel, alturaPainel)

		cvs.DrawRect(rect, xui.Color_White, True, 0) 'fundo branco'
		
		Dim larguraAtual As Int = 50dip

		For i=0 To novoCodigo.Length-1
			Dim cor As Int = xui.Color_Black
			If novoCodigo.CharAt(i) = "0" Then cor = xui.Color_White
			If novoCodigo.CharAt(i) = "2" Then
				cvs.DrawLine(larguraAtual, 0, larguraAtual, alturaBarra, cor, larguraBarra)
			Else If novoCodigo.CharAt(i) = "3" Then
				cvs.DrawLine(larguraAtual, 0, larguraAtual, alturaBarra, xui.Color_Blue, larguraBarra)
			Else
				cvs.DrawLine(larguraAtual, 0, larguraAtual, alturaBarra - alturaNumero, cor, larguraBarra)
			End If
	
			larguraAtual = larguraAtual + larguraBarra
		Next
		
		'Desenha o número abaixo do código de barras'
		Dim fonte As B4XFont = xui.CreateFontAwesome(63)

		cvs.DrawText(codigo, cvs.TargetRect.CenterX, alturaBarra+10dip, fonte, xui.Color_Black, "CENTER")

	End If
	
	cvs.Invalidate
	Dim res As B4XBitmap = cvs.CreateBitmap
	cvs.Release
	Return res
End Sub

Private Sub preparaCODE128(codigo As String) As String
	
	Dim codigoNovo As String = codigo
	
	Dim sb As StringBuilder
	sb.Initialize
	
	sb.Append("11010010000") ' iniciar codigo b
	
	Dim somatoria As Int = 104 ' valor do inicio
	
	For i=0 To codigoNovo.Length-1
		Dim digitoGrupo As String = codigoNovo.CharAt(i)
		
		Dim multiplicador As Int = (i+1)
		Dim valorDigito As Int = valorDigitoCODE128(digitoGrupo)
		Dim valorDigitoMultiplicado As Int = (multiplicador*valorDigito)
		somatoria = (somatoria + valorDigitoMultiplicado)
		
		sb.Append(sequenciaDigitoCODE128(digitoGrupo))
	Next
	
	Dim checksum As Int = (somatoria Mod 103)
	Dim checksumDigito As String = codigoDigitoCODE128(checksum)
	
	sb.Append(sequenciaDigitoCODE128(checksumDigito))
	
	sb.Append("1100011101011") 'fim do codigo
	
	Return sb.ToString
End Sub

Private Sub sequenciaDigitoCODE128(digitoGrupo As String) As String
	If digitoGrupo=" " Then Return "11011001100"
	If digitoGrupo="!" Then Return "11001101100"
	If digitoGrupo=$"""$ Then Return "11001100110"
	If digitoGrupo="#" Then Return "10010011000"
	If digitoGrupo="$" Then Return "10010001100"
	If digitoGrupo="%" Then Return "10001001100"
	If digitoGrupo="&" Then Return "10011001000"
	If digitoGrupo="'" Then Return "10011000100"
	If digitoGrupo="(" Then Return "10001100100"
	If digitoGrupo=")" Then Return "11001001000"
	If digitoGrupo="*" Then Return "11001000100"
	If digitoGrupo="+" Then Return "11000100100"
	If digitoGrupo="," Then Return "10110011100"
	If digitoGrupo="-" Then Return "10011011100"
	If digitoGrupo="." Then Return "10011001110"
	If digitoGrupo="/" Then Return "10111001100"
	If digitoGrupo="0" Then Return "10011101100"
	If digitoGrupo="1" Then Return "10011100110"
	If digitoGrupo="2" Then Return "11001110010"
	If digitoGrupo="3" Then Return "11001011100"
	If digitoGrupo="4" Then Return "11001001110"
	If digitoGrupo="5" Then Return "11011100100"
	If digitoGrupo="6" Then Return "11001110100"
	If digitoGrupo="7" Then Return "11101101110"
	If digitoGrupo="8" Then Return "11101001100"
	If digitoGrupo="9" Then Return "11100101100"
	If digitoGrupo=":" Then Return "11100100110"
	If digitoGrupo=";" Then Return "11101100100"
	If digitoGrupo="<" Then Return "11100110100"
	If digitoGrupo="=" Then Return "11100110010"
	If digitoGrupo=">" Then Return "11011011000"
	If digitoGrupo="?" Then Return "11011000110"
	If digitoGrupo="@" Then Return "11000110110"
	If digitoGrupo="A" Then Return "10100011000"
	If digitoGrupo="B" Then Return "10001011000"
	If digitoGrupo="C" Then Return "10001000110"
	If digitoGrupo="D" Then Return "10110001000"
	If digitoGrupo="E" Then Return "10001101000"
	If digitoGrupo="F" Then Return "10001100010"
	If digitoGrupo="G" Then Return "11010001000"
	If digitoGrupo="H" Then Return "11000101000"
	If digitoGrupo="I" Then Return "11000100010"
	If digitoGrupo="J" Then Return "10110111000"
	If digitoGrupo="K" Then Return "10110001110"
	If digitoGrupo="L" Then Return "10001101110"
	If digitoGrupo="M" Then Return "10111011000"
	If digitoGrupo="N" Then Return "10111000110"
	If digitoGrupo="O" Then Return "10001110110"
	If digitoGrupo="P" Then Return "11101110110"
	If digitoGrupo="Q" Then Return "11010001110"
	If digitoGrupo="R" Then Return "11000101110"
	If digitoGrupo="S" Then Return "11011101000"
	If digitoGrupo="T" Then Return "11011100010"
	If digitoGrupo="U" Then Return "11011101110"
	If digitoGrupo="V" Then Return "11101011000"
	If digitoGrupo="W" Then Return "11101000110"
	If digitoGrupo="X" Then Return "11100010110"
	If digitoGrupo="Y" Then Return "11101101000"
	If digitoGrupo="Z" Then Return "11101100010"
	If digitoGrupo="[" Then Return "11100011010"
	If digitoGrupo="\" Then Return "11101111010"
	If digitoGrupo="]" Then Return "11001000010"
	If digitoGrupo="^" Then Return "11110001010"
	If digitoGrupo="_" Then Return "10100110000"
	If digitoGrupo="`" Then Return "10100001100"
	If digitoGrupo="a" Then Return "10010110000"
	If digitoGrupo="b" Then Return "10010000110"
	If digitoGrupo="c" Then Return "10000101100"
	If digitoGrupo="d" Then Return "10000100110"
	If digitoGrupo="e" Then Return "10110010000"
	If digitoGrupo="f" Then Return "10110000100"
	If digitoGrupo="g" Then Return "10011010000"
	If digitoGrupo="h" Then Return "10011000010"
	If digitoGrupo="i" Then Return "10000110100"
	If digitoGrupo="j" Then Return "10000110010"
	If digitoGrupo="k" Then Return "11000010010"
	If digitoGrupo="l" Then Return "11001010000"
	If digitoGrupo="m" Then Return "11110111010"
	If digitoGrupo="n" Then Return "11000010100"
	If digitoGrupo="o" Then Return "10001111010"
	If digitoGrupo="p" Then Return "10100111100"
	If digitoGrupo="q" Then Return "10010111100"
	If digitoGrupo="r" Then Return "10010011110"
	If digitoGrupo="s" Then Return "10111100100"
	If digitoGrupo="t" Then Return "10011110100"
	If digitoGrupo="u" Then Return "10011110010"
	If digitoGrupo="v" Then Return "11110100100"
	If digitoGrupo="w" Then Return "11110010100"
	If digitoGrupo="x" Then Return "11110010010"
	If digitoGrupo="y" Then Return "11011011110"
	If digitoGrupo="z" Then Return "11011110110"
	If digitoGrupo="{" Then Return "11110110110"
	If digitoGrupo="|" Then Return "10101111000"
	If digitoGrupo="}" Then Return "10100011110"
	If digitoGrupo="~" Then Return "10001011110"
	
	Return ""
End Sub

Private Sub valorDigitoCODE128(digitoGrupo As String) As Int
	
	If digitoGrupo=" " Then Return 0
	If digitoGrupo="!" Then Return 1
	If digitoGrupo=$"""$ Then Return 2
	If digitoGrupo="#" Then Return 3
	If digitoGrupo="$" Then Return 4
	If digitoGrupo="%" Then Return 5
	If digitoGrupo="&" Then Return 6
	If digitoGrupo="'" Then Return 7
	If digitoGrupo="(" Then Return 8
	If digitoGrupo=")" Then Return 9
	If digitoGrupo="*" Then Return 10
	If digitoGrupo="+" Then Return 11
	If digitoGrupo="," Then Return 12
	If digitoGrupo="-" Then Return 13
	If digitoGrupo="." Then Return 14
	If digitoGrupo="/" Then Return 15
	If digitoGrupo="0" Then Return 16
	If digitoGrupo="1" Then Return 17
	If digitoGrupo="2" Then Return 18
	If digitoGrupo="3" Then Return 19
	If digitoGrupo="4" Then Return 20
	If digitoGrupo="5" Then Return 21
	If digitoGrupo="6" Then Return 22
	If digitoGrupo="7" Then Return 23
	If digitoGrupo="8" Then Return 24
	If digitoGrupo="9" Then Return 25
	If digitoGrupo=":" Then Return 26
	If digitoGrupo=";" Then Return 27
	If digitoGrupo="<" Then Return 28
	If digitoGrupo="=" Then Return 29
	If digitoGrupo=">" Then Return 30
	If digitoGrupo="?" Then Return 31
	If digitoGrupo="@" Then Return 32
	If digitoGrupo="A" Then Return 33
	If digitoGrupo="B" Then Return 34
	If digitoGrupo="C" Then Return 35
	If digitoGrupo="D" Then Return 36
	If digitoGrupo="E" Then Return 37
	If digitoGrupo="F" Then Return 38
	If digitoGrupo="G" Then Return 39
	If digitoGrupo="H" Then Return 40
	If digitoGrupo="I" Then Return 41
	If digitoGrupo="J" Then Return 42
	If digitoGrupo="K" Then Return 43
	If digitoGrupo="L" Then Return 44
	If digitoGrupo="M" Then Return 45
	If digitoGrupo="N" Then Return 46
	If digitoGrupo="O" Then Return 47
	If digitoGrupo="P" Then Return 48
	If digitoGrupo="Q" Then Return 49
	If digitoGrupo="R" Then Return 50
	If digitoGrupo="S" Then Return 51
	If digitoGrupo="T" Then Return 52
	If digitoGrupo="U" Then Return 53
	If digitoGrupo="V" Then Return 54
	If digitoGrupo="W" Then Return 55
	If digitoGrupo="X" Then Return 56
	If digitoGrupo="Y" Then Return 57
	If digitoGrupo="Z" Then Return 58
	If digitoGrupo="[" Then Return 59
	If digitoGrupo="\" Then Return 60
	If digitoGrupo="]" Then Return 61
	If digitoGrupo="^" Then Return 62
	If digitoGrupo="_" Then Return 63
	If digitoGrupo="`" Then Return 64
	If digitoGrupo="a" Then Return 65
	If digitoGrupo="b" Then Return 66
	If digitoGrupo="c" Then Return 67
	If digitoGrupo="d" Then Return 68
	If digitoGrupo="e" Then Return 69
	If digitoGrupo="f" Then Return 70
	If digitoGrupo="g" Then Return 71
	If digitoGrupo="h" Then Return 72
	If digitoGrupo="i" Then Return 73
	If digitoGrupo="j" Then Return 74
	If digitoGrupo="k" Then Return 75
	If digitoGrupo="l" Then Return 76
	If digitoGrupo="m" Then Return 77
	If digitoGrupo="n" Then Return 78
	If digitoGrupo="o" Then Return 79
	If digitoGrupo="p" Then Return 80
	If digitoGrupo="q" Then Return 81
	If digitoGrupo="r" Then Return 82
	If digitoGrupo="s" Then Return 83
	If digitoGrupo="t" Then Return 84
	If digitoGrupo="u" Then Return 85
	If digitoGrupo="v" Then Return 86
	If digitoGrupo="w" Then Return 87
	If digitoGrupo="x" Then Return 88
	If digitoGrupo="y" Then Return 89
	If digitoGrupo="z" Then Return 90
	If digitoGrupo="{" Then Return 91
	If digitoGrupo="|" Then Return 92
	If digitoGrupo="}" Then Return 93
	If digitoGrupo="~" Then Return 94
	
	Return 0
End Sub

Private Sub codigoDigitoCODE128(digitoGrupo As Int) As String
	
	If digitoGrupo=0 Then Return " "
	If digitoGrupo=1 Then Return "!"
	If digitoGrupo=2 Then Return $"""$
	If digitoGrupo=3 Then Return "#"
	If digitoGrupo=4 Then Return "$"
	If digitoGrupo=5 Then Return "%"
	If digitoGrupo=6 Then Return "&"
	If digitoGrupo=7 Then Return "'"
	If digitoGrupo=8 Then Return "("
	If digitoGrupo=9 Then Return ")"
	If digitoGrupo=10 Then Return "*"
	If digitoGrupo=11 Then Return "+"
	If digitoGrupo=12 Then Return ","
	If digitoGrupo=13 Then Return "-"
	If digitoGrupo=14 Then Return "."
	If digitoGrupo=15 Then Return "/"
	If digitoGrupo=16 Then Return "0"
	If digitoGrupo=17 Then Return "1"
	If digitoGrupo=18 Then Return "2"
	If digitoGrupo=19 Then Return "3"
	If digitoGrupo=20 Then Return "4"
	If digitoGrupo=21 Then Return "5"
	If digitoGrupo=22 Then Return "6"
	If digitoGrupo=23 Then Return "7"
	If digitoGrupo=24 Then Return "8"
	If digitoGrupo=25 Then Return "9"
	If digitoGrupo=26 Then Return ":"
	If digitoGrupo=27 Then Return ";"
	If digitoGrupo=28 Then Return "<"
	If digitoGrupo=29 Then Return "="
	If digitoGrupo=30 Then Return ">"
	If digitoGrupo=31 Then Return "?"
	If digitoGrupo=32 Then Return "@"
	If digitoGrupo=33 Then Return "A"
	If digitoGrupo=34 Then Return "B"
	If digitoGrupo=35 Then Return "C"
	If digitoGrupo=36 Then Return "D"
	If digitoGrupo=37 Then Return "E"
	If digitoGrupo=38 Then Return "F"
	If digitoGrupo=39 Then Return "G"
	If digitoGrupo=40 Then Return "H"
	If digitoGrupo=41 Then Return "I"
	If digitoGrupo=42 Then Return "J"
	If digitoGrupo=43 Then Return "K"
	If digitoGrupo=44 Then Return "L"
	If digitoGrupo=45 Then Return "M"
	If digitoGrupo=46 Then Return "N"
	If digitoGrupo=47 Then Return "O"
	If digitoGrupo=48 Then Return "P"
	If digitoGrupo=49 Then Return "Q"
	If digitoGrupo=50 Then Return "R"
	If digitoGrupo=51 Then Return "S"
	If digitoGrupo=52 Then Return "T"
	If digitoGrupo=53 Then Return "U"
	If digitoGrupo=54 Then Return "V"
	If digitoGrupo=55 Then Return "W"
	If digitoGrupo=56 Then Return "X"
	If digitoGrupo=57 Then Return "Y"
	If digitoGrupo=58 Then Return "Z"
	If digitoGrupo=59 Then Return "["
	If digitoGrupo=60 Then Return "\"
	If digitoGrupo=61 Then Return "]"
	If digitoGrupo=62 Then Return "^"
	If digitoGrupo=63 Then Return "_"
	If digitoGrupo=64 Then Return "`"
	If digitoGrupo=65 Then Return "a"
	If digitoGrupo=66 Then Return "b"
	If digitoGrupo=67 Then Return "c"
	If digitoGrupo=68 Then Return "d"
	If digitoGrupo=69 Then Return "e"
	If digitoGrupo=70 Then Return "f"
	If digitoGrupo=71 Then Return "g"
	If digitoGrupo=72 Then Return "h"
	If digitoGrupo=73 Then Return "i"
	If digitoGrupo=74 Then Return "j"
	If digitoGrupo=75 Then Return "k"
	If digitoGrupo=76 Then Return "l"
	If digitoGrupo=77 Then Return "m"
	If digitoGrupo=78 Then Return "n"
	If digitoGrupo=79 Then Return "o"
	If digitoGrupo=80 Then Return "p"
	If digitoGrupo=81 Then Return "q"
	If digitoGrupo=82 Then Return "r"
	If digitoGrupo=83 Then Return "s"
	If digitoGrupo=84 Then Return "t"
	If digitoGrupo=85 Then Return "u"
	If digitoGrupo=86 Then Return "v"
	If digitoGrupo=87 Then Return "w"
	If digitoGrupo=88 Then Return "x"
	If digitoGrupo=89 Then Return "y"
	If digitoGrupo=90 Then Return "z"
	If digitoGrupo=91 Then Return "{"
	If digitoGrupo=92 Then Return "|"
	If digitoGrupo=93 Then Return "}"
	If digitoGrupo=94 Then Return "~"
	
	Return " "
End Sub

#End Region