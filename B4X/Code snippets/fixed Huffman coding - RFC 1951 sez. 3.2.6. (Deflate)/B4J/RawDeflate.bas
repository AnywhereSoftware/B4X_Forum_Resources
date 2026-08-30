B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'RawDeflate.bas
'Classe B4X (B4A/B4J/B4i) che implementa la compressione DEFLATE "raw" (RFC 1951),
'cioe' senza header/trailer zlib (RFC 1950) ne' gzip, adatta al permessage-deflate
'di WebSocket (RFC 7692).
'
'Implementazione: LZ77 (ricerca match con hash a 3 byte) + Huffman FISSO
'(RFC 1951 par. 3.2.6), un unico blocco con BFINAL=1, BTYPE=01.
'Nessuna libreria esterna: usa solo Bit, List, Map (core B4X).
'
'Uso:
'   Dim rd As RawDeflate
'   rd.Initialize
'   Dim compressed() As Byte = rd.Compress(sourceBytes)

Sub Class_Globals
	Private mBits As Int
	Private mBitCount As Int
	Private mBytes As List

	'Tabelle RFC 1951 par. 3.2.5 (length code 257..285 -> base length, extra bits)
	Private mLengthBase() As Int = Array As Int(3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43,51,59,67,83,99,115,131,163,195,227,258)
	Private mLengthExtra() As Int = Array As Int(0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0)

	'Tabelle RFC 1951 par. 3.2.5 (distance code 0..29 -> base distance, extra bits)
	Private mDistBase() As Int = Array As Int(1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385,513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577)
	Private mDistExtra() As Int = Array As Int(0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13)

	Type FixedCode (code As Int, len As Int)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub


'Comprime Data() in un flusso DEFLATE raw (RFC 1951), blocco singolo, Huffman fisso.
Public Sub Compress(Data() As Byte) As Byte()
	mBits = 0
	mBitCount = 0
	mBytes.Initialize

	Dim n As Int = Data.Length

	WriteBitsLSB(1, 1)   'BFINAL = 1 (ultimo ed unico blocco)
	WriteBitsLSB(1, 2)   'BTYPE  = 01 (Huffman fisso)

	If n = 0 Then
		Dim eob As FixedCode = GetFixedCode(256)
		WriteHuffman(eob.code, eob.len)
	Else
		Dim hashTable As Map
		hashTable.Initialize
		Dim i As Int = 0
		Do While i < n
			Dim bestLen As Int = 0
			Dim bestDist As Int = 0

			If i + 3 <= n Then
				Dim h As Int = Hash3(Data, i)
				If hashTable.ContainsKey(h) Then
					Dim positions As List = hashTable.Get(h)
					Dim tries As Int = 0
					Dim j As Int = positions.Size - 1
					Do While j >= 0 And tries < 64
						Dim pos As Int = positions.Get(j)
						Dim dist As Int = i - pos
						If dist > 32768 Then
							Exit 
						End If
						Dim mlen As Int = MatchLength(Data, pos, i, n)
						If mlen > bestLen Then
							bestLen = mlen
							bestDist = dist
							If bestLen >= 258 Then
								Exit 
							End If
						End If
						j = j - 1
						tries = tries + 1
					Loop
				End If
				AddToHash(hashTable, h, i)
			End If

			If bestLen >= 3 Then
				EncodeLength(bestLen)
				EncodeDistance(bestDist)
				Dim k As Int
				For k = i + 1 To i + bestLen - 1
					If k + 3 <= n Then
						Dim hh As Int = Hash3(Data, k)
						AddToHash(hashTable, hh, k)
					End If
				Next
				i = i + bestLen
			Else
				Dim lit As Int = Bit.And(Data(i), 0xFF)
				Dim fc As FixedCode = GetFixedCode(lit)
				WriteHuffman(fc.code, fc.len)
				i = i + 1
			End If
		Loop

		Dim eob2 As FixedCode = GetFixedCode(256)
		WriteHuffman(eob2.code, eob2.len)
	End If

	FlushToByte
	Return GetBytes
End Sub

'--- LZ77: hashing e ricerca dei match --------------------------------------

Private Sub Hash3(Data() As Byte, pos As Int) As Int
	Dim b0 As Int = Bit.And(Data(pos), 0xFF)
	Dim b1 As Int = Bit.And(Data(pos + 1), 0xFF)
	Dim b2 As Int = Bit.And(Data(pos + 2), 0xFF)
	Return Bit.Or(Bit.Or(Bit.ShiftLeft(b0, 16), Bit.ShiftLeft(b1, 8)), b2)
End Sub

Private Sub AddToHash(hashTable As Map, h As Int, pos As Int)
	Dim positions As List
	If hashTable.ContainsKey(h) Then
		positions = hashTable.Get(h)
	Else
		positions.Initialize
		hashTable.Put(h, positions)
	End If
	positions.Add(pos)
	'limita la catena per tenere la ricerca O(1) anche su dati molto ripetitivi
	If positions.Size > 128 Then
		positions.RemoveAt(0)
	End If
End Sub

Private Sub MatchLength(Data() As Byte, pos As Int, cur As Int, n As Int) As Int
	Dim maxLen As Int = 258
	If n - cur < maxLen Then
		maxLen = n - cur
	End If
	Dim len As Int = 0
	Do While len < maxLen
		If Data(pos + len) <> Data(cur + len) Then
			Exit 
		End If
		len = len + 1
	Loop
	Return len
End Sub

'--- Codifica length/distance -------------------------------------------------

Private Sub EncodeLength(length As Int)
	Dim idx As Int = -1
	Dim k As Int
	For k = 28 To 0 Step -1
		If length >= mLengthBase(k) Then
			idx = k
			Exit 
		End If
	Next
	Dim extra As Int = length - mLengthBase(idx)
	Dim symbol As Int = 257 + idx
	Dim fc As FixedCode = GetFixedCode(symbol)
	WriteHuffman(fc.code, fc.len)
	If mLengthExtra(idx) > 0 Then
		WriteBitsLSB(extra, mLengthExtra(idx))
	End If
End Sub

Private Sub EncodeDistance(dist As Int)
	Dim idx As Int = -1
	Dim k As Int
	For k = 29 To 0 Step -1
		If dist >= mDistBase(k) Then
			idx = k
			Exit 
		End If
	Next
	Dim extra As Int = dist - mDistBase(idx)
	'codici di distanza Huffman fissi: 5 bit, valore = indice del codice
	WriteHuffman(idx, 5)
	If mDistExtra(idx) > 0 Then
		WriteBitsLSB(extra, mDistExtra(idx))
	End If
End Sub

'Huffman fisso per literal/length, RFC 1951 par. 3.2.6
Private Sub GetFixedCode(symbol As Int) As FixedCode
	Dim fc As FixedCode
	If symbol <= 143 Then
		fc.len = 8
		fc.code = 0x30 + symbol
	Else If symbol <= 255 Then
		fc.len = 9
		fc.code = 0x190 + (symbol - 144)
	Else If symbol <= 279 Then
		fc.len = 7
		fc.code = symbol - 256
	Else
		fc.len = 8
		fc.code = 0xC0 + (symbol - 280)
	End If
	Return fc
End Sub

'--- Bit writer di basso livello ---------------------------------------------
'NB: i byte prodotti possono superare 127; l'assegnazione a Byte esegue
'il normale wrap-around (equivalente al cast (byte) di Java), che e'
'esattamente il pattern di bit desiderato.

Private Sub WriteBit(myBit As Int)
	mBits = Bit.Or(mBits, Bit.ShiftLeft(myBit, mBitCount))
	mBitCount = mBitCount + 1
	If mBitCount = 8 Then
		mBytes.Add(Bit.And(mBits, 0xFF))
		mBits = 0
		mBitCount = 0
	End If
End Sub

'Scrive n bit di un valore "normale", LSB per primo (BFINAL, BTYPE, extra bits)
Private Sub WriteBitsLSB(value As Int, n As Int)
	Dim i As Int
	For i = 0 To n - 1
		WriteBit(Bit.And(Bit.ShiftRight(value, i), 1))
	Next
End Sub

'Scrive un codice Huffman: MSB per primo, come richiesto da RFC 1951 par. 3.1.1
Private Sub WriteHuffman(code As Int, length As Int)
	Dim i As Int
	For i = length - 1 To 0 Step -1
		WriteBit(Bit.And(Bit.ShiftRight(code, i), 1))
	Next
End Sub

Private Sub FlushToByte
	If mBitCount > 0 Then
		mBytes.Add(Bit.And(mBits, 0xFF))
		mBits = 0
		mBitCount = 0
	End If
End Sub

Private Sub GetBytes As Byte()
	Dim result(mBytes.Size) As Byte
	Dim i As Int
	For i = 0 To mBytes.Size - 1
		result(i) = mBytes.Get(i)
	Next
	Return result
End Sub
