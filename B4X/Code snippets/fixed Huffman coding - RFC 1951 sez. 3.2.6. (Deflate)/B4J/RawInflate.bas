B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Classe B4X (B4A/B4J/B4i) che implementa la decompressione DEFLATE "raw" (RFC 1951),
'cioe' senza header/trailer zlib (RFC 1950) ne' gzip, complementare a RawDeflate.bas
'(adatta anche al permessage-deflate di WebSocket, RFC 7692).
'
'A differenza del Deflate (che produce solo blocchi Huffman fisso), questo Inflate
'e' completo: gestisce blocchi STORED (BTYPE=00), Huffman FISSO (BTYPE=01) e
'Huffman DINAMICO (BTYPE=10), oltre a piu' blocchi concatenati (BFINAL=0/1).
'Nessuna libreria esterna: usa solo Bit, List, Map (core B4X).
'
'Uso:
'   Dim ri As RawInflate
'   ri.Initialize
'   Dim original() As Byte = ri.Decompress(compressedBytes)

Sub Class_Globals
	Private mData() As Byte
	Private mPos As Int
	Private mBitBuf As Int
	Private mBitCount As Int
	Private mOut As List   'List di Int (0..255), poi convertita in Byte()

	'Tabelle RFC 1951 par. 3.2.5 (length code 257..285 -> base length, extra bits)
	Private mLengthBase() As Int = Array As Int(3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258)
	Private mLengthExtra() As Int = Array As Int(0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0)

	'Tabelle RFC 1951 par. 3.2.5 (distance code 0..29 -> base distance, extra bits)
	Private mDistBase() As Int = Array As Int(1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577)
	Private mDistExtra() As Int = Array As Int(0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13)

	'Ordine di lettura delle lunghezze dei codici per l'alfabeto "code length" (RFC 1951 par. 3.2.7)
	Private mClOrder() As Int = Array As Int(16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15)

	Type HuffPair (Lit As Map, Dist As Map)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'Decomprime un flusso DEFLATE raw (RFC 1951) e restituisce i byte originali.
Public Sub Decompress(Data() As Byte) As Byte()
	mData = Data
	mPos = 0
	mBitBuf = 0
	mBitCount = 0
	mOut.Initialize

	Dim bfinal As Int
	Do Until bfinal = 1
		'guardia di sicurezza: se il buffer e' esaurito senza aver incontrato BFINAL=1,
		'il flusso e' troncato/corrotto e usciamo comunque, invece di girare all'infinito
		If mPos >= mData.Length And mBitCount = 0 Then
			Exit
		End If

		bfinal = ReadBit
		Dim btype As Int = ReadBitsLSB(2)

		If btype = 0 Then
			InflateStored
		Else If btype = 1 Then
			Dim litTable As Map = BuildHuffman(GetFixedLitLenLengths)
			Dim distTable As Map = BuildHuffman(GetFixedDistLengths)
			InflateBlock(litTable, distTable)
		Else If btype = 2 Then
			Dim hp As HuffPair = BuildDynamicTables
			InflateBlock(hp.Lit, hp.Dist)
		Else
			'BTYPE=11 riservato/non valido: flusso corrotto, interrompiamo
			Exit
		End If
	Loop 

	Return GetOutBytes
End Sub

'--- Decodifica di un blocco compresso (fisso o dinamico) -------------------

Private Sub InflateBlock(litTable As Map, distTable As Map)
	Do While mPos <= mData.Length 'guardia di sicurezza: mai oltre la fine del buffer
		Dim sym As Int = DecodeSymbol(litTable)

		If sym = -1 Then
			'flusso corrotto: nessun codice Huffman valido trovato
			Exit
		Else If sym < 256 Then
			mOut.Add(sym)
		Else If sym = 256 Then
			Exit 'fine blocco (terminazione normale)
		Else
			Dim idx As Int = sym - 257
			If idx < 0 Or idx >= mLengthBase.Length Then
				Exit 'simbolo length fuori range: flusso corrotto
			End If
			Dim length As Int = mLengthBase(idx)
			If mLengthExtra(idx) > 0 Then
				length = length + ReadBitsLSB(mLengthExtra(idx))
			End If

			Dim distSym As Int = DecodeSymbol(distTable)
			If distSym = -1 Or distSym < 0 Or distSym >= mDistBase.Length Then
				Exit 'codice distanza non valido: flusso corrotto
			End If
			Dim dist As Int = mDistBase(distSym)
			If mDistExtra(distSym) > 0 Then
				dist = dist + ReadBitsLSB(mDistExtra(distSym))
			End If

			Dim start As Int = mOut.Size - dist
			If start < 0 Then
				Exit 'distanza superiore ai byte finora prodotti: flusso corrotto
			End If
			Dim k As Int
			For k = 0 To length - 1
				mOut.Add(mOut.Get(start + k))
			Next
		End If
	Loop
End Sub

'--- Blocco STORED (non compresso, RFC 1951 par. 3.2.4) ---------------------

Private Sub InflateStored
	AlignToByte
	Dim lenLo As Int = ReadByteAligned
	Dim lenHi As Int = ReadByteAligned
	Dim len As Int = lenLo + lenHi * 256
	'NLEN e' il complemento a uno di LEN: lo leggiamo e scartiamo (nessuna verifica)
	ReadByteAligned
	ReadByteAligned

	Dim i As Int
	For i = 1 To len
		mOut.Add(ReadByteAligned)
	Next
End Sub

'--- Huffman dinamico (RFC 1951 par. 3.2.7) ----------------------------------

Private Sub BuildDynamicTables As HuffPair
	Dim hlit As Int = ReadBitsLSB(5) + 257
	Dim hdist As Int = ReadBitsLSB(5) + 1
	Dim hclen As Int = ReadBitsLSB(4) + 4

	Dim clLengths(19) As Int
	Dim i As Int
	For i = 0 To hclen - 1
		clLengths(mClOrder(i)) = ReadBitsLSB(3)
	Next
	Dim clTable As Map = BuildHuffman(clLengths)

	Dim total As Int = hlit + hdist
	Dim allLengths(total) As Int
	Dim n As Int = 0
	Do While n < total
		Dim sym As Int = DecodeSymbol(clTable)
		If sym < 16 Then
			allLengths(n) = sym
			n = n + 1
		Else If sym = 16 Then
			Dim rep As Int = ReadBitsLSB(2) + 3
			Dim prev As Int = allLengths(n - 1)
			Dim r As Int
			For r = 1 To rep
				allLengths(n) = prev
				n = n + 1
			Next
		Else If sym = 17 Then
			Dim rep2 As Int = ReadBitsLSB(3) + 3
			Dim r2 As Int
			For r2 = 1 To rep2
				allLengths(n) = 0
				n = n + 1
			Next
		Else If sym = 18 Then
			Dim rep3 As Int = ReadBitsLSB(7) + 11
			Dim r3 As Int
			For r3 = 1 To rep3
				allLengths(n) = 0
				n = n + 1
			Next
		End If
	Loop

	Dim litLengths(hlit) As Int
	For i = 0 To hlit - 1
		litLengths(i) = allLengths(i)
	Next
	Dim distLengths(hdist) As Int
	For i = 0 To hdist - 1
		distLengths(i) = allLengths(hlit + i)
	Next

	Dim result As HuffPair
	result.Lit = BuildHuffman(litLengths)
	result.Dist = BuildHuffman(distLengths)
	Return result
End Sub

'--- Huffman fisso (RFC 1951 par. 3.2.6) -------------------------------------

Private Sub GetFixedLitLenLengths As Int()
	Dim lengths(288) As Int
	Dim i As Int
	For i = 0 To 143
		lengths(i) = 8
	Next
	For i = 144 To 255
		lengths(i) = 9
	Next
	For i = 256 To 279
		lengths(i) = 7
	Next
	For i = 280 To 287
		lengths(i) = 8
	Next
	Return lengths
End Sub

Private Sub GetFixedDistLengths As Int()
	Dim lengths(30) As Int
	Dim i As Int
	For i = 0 To 29
		lengths(i) = 5
	Next
	Return lengths
End Sub

'--- Costruzione tabella Huffman canonica (RFC 1951 par. 3.2.2) -------------
'Mappa chiave = (lunghezza_codice << 16) | codice  ->  simbolo

Private Sub BuildHuffman(lengths() As Int) As Map
	Dim maxLen As Int = 0
	Dim i As Int
	For i = 0 To lengths.Length - 1
		If lengths(i) > maxLen Then
			maxLen = lengths(i)
		End If
	Next

	Dim blCount(maxLen + 1) As Int
	For i = 0 To lengths.Length - 1
		If lengths(i) > 0 Then
			blCount(lengths(i)) = blCount(lengths(i)) + 1
		End If
	Next

	Dim nextCode(maxLen + 1) As Int
	Dim code As Int = 0
	Dim bits As Int
	For bits = 1 To maxLen
		code = Bit.ShiftLeft(code + blCount(bits - 1), 1)
		nextCode(bits) = code
	Next

	Dim table As Map
	table.Initialize
	For i = 0 To lengths.Length - 1
		Dim len As Int = lengths(i)
		If len > 0 Then
			Dim c As Int = nextCode(len)
			nextCode(len) = nextCode(len) + 1
			Dim key As Int = Bit.Or(Bit.ShiftLeft(len, 16), c)
			table.Put(key, i)
		End If
	Next
	Return table
End Sub

'Decodifica un simbolo leggendo un bit alla volta (i codici Huffman sono
'trasmessi MSB-per-primo, RFC 1951 par. 3.1.1), fino a trovare una corrispondenza.
Private Sub DecodeSymbol(huff As Map) As Int
	Dim code As Int = 0
	Dim len As Int = 0
	Do While len <= 15
		Dim myBit As Int = ReadBit
		code = Bit.Or(Bit.ShiftLeft(code, 1), myBit)
		len = len + 1
		Dim key As Int = Bit.Or(Bit.ShiftLeft(len, 16), code)
		If huff.ContainsKey(key) Then
			Return huff.Get(key)
		End If
	Loop
	'flusso corrotto: nessun codice valido trovato entro 15 bit
	Return -1
End Sub

'--- Bit reader di basso livello ---------------------------------------------

Private Sub ReadBit As Int
	If mBitCount = 0 Then
		If mPos >= mData.Length Then
			'buffer esaurito (flusso troncato/corrotto): restituiamo 0 invece di sollevare un'eccezione
			Return 0
		End If
		mBitBuf = Bit.And(mData(mPos), 0xFF)
		mPos = mPos + 1
		mBitCount = 8
	End If
	Dim b As Int = Bit.And(mBitBuf, 1)
	mBitBuf = Bit.ShiftRight(mBitBuf, 1)
	mBitCount = mBitCount - 1
	Return b
End Sub

'Legge n bit di un valore "normale", LSB per primo (BTYPE, extra bits, HLIT, ecc.)
Private Sub ReadBitsLSB(n As Int) As Int
	Dim value As Int = 0
	Dim i As Int
	For i = 0 To n - 1
		value = Bit.Or(value, Bit.ShiftLeft(ReadBit, i))
	Next
	Return value
End Sub

'Scarta eventuali bit residui nel byte corrente (usato prima di un blocco STORED)
Private Sub AlignToByte
	mBitCount = 0
End Sub

Private Sub ReadByteAligned As Int
	If mPos >= mData.Length Then
		Return 0
	End If
	Dim v As Int = Bit.And(mData(mPos), 0xFF)
	mPos = mPos + 1
	Return v
End Sub

Private Sub GetOutBytes As Byte()
	Dim result(mOut.Size) As Byte
	Dim i As Int
	For i = 0 To mOut.Size - 1
		result(i) = mOut.Get(i)
	Next
	Return result
End Sub
