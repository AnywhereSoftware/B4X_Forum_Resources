B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.51
@EndOfDesignText@
Sub Class_Globals
	Private bc As ByteConverter
	Private su As StringUtils
	Private sr As SecureRandom
	Private cCFB As Cipher
	Private cECB As Cipher
	Private cCBC As Cipher
	Private k As KeyGenerator
End Sub

Public Sub Initialize(keyBytes() As Byte)
	cCFB.Initialize("AES/CFB8/NoPadding")
	cECB.Initialize("AES/ECB/NoPadding")
	cCBC.Initialize("AES/CBC/NoPadding")
	k.Initialize("AES")
	k.KeyFromBytes(keyBytes)
End Sub

Public Sub EncryptString(plainText As String) As String
	Dim cipherText As String = ""
	
	If plainText <> Null Then
		If plainText.Length > 0 Then
	
			Dim dataBytes() As Byte = plainText.GetBytes("UTF8")
	
			'Autogenerate nonce and insert into IV
			Dim nonce(8) As Byte
			sr.GetRandomBytes(nonce)
			Dim IV(16) As Byte
			bc.ArrayCopy(nonce, 0, IV, 0, 8)
			
			Dim encryptedBytes() As Byte
			If dataBytes.Length > 15 Then
				Dim fullBlocks As Int = dataBytes.Length / 16
				Dim lastBlockSize As Int = dataBytes.Length Mod 16
				Dim numberOfBlocks As Int = fullBlocks
				If lastBlockSize > 0 Then numberOfBlocks = numberOfBlocks + 1
				cCBC.InitialisationVector = IV
				If fullBlocks = numberOfBlocks Then
					'Round Message
					encryptedBytes = cCBC.Encrypt(dataBytes, k.Key, True)
				Else
					'Sharp Message
					Dim bb As B4XBytesBuilder
					bb.Initialize
					
					'Everything but the last full block and it's trailing partial block can be encrypted via standard CBC
					If fullBlocks > 1 Then
						Dim frontCipherData(dataBytes.Length - 16 - lastBlockSize) As Byte
						bc.ArrayCopy(dataBytes, 0, frontCipherData, 0, dataBytes.Length - 16 - lastBlockSize)
						Dim frontCipherEncrypted() As Byte = cCBC.Encrypt(frontCipherData, k.Key, True)
						bb.Append(frontCipherEncrypted)
						'IV is based on last encrypted block generated here
						bc.ArrayCopy(frontCipherEncrypted, frontCipherEncrypted.Length - 16, IV, 0, 16)
					End If

					'Take 2nd to last block of plaintext data, XOR with IV and ECB Encrypt
					Dim plainTextDataSecondToLastBlock(16) As Byte
					bc.ArrayCopy(dataBytes, dataBytes.Length - 16 - lastBlockSize, plainTextDataSecondToLastBlock, 0 , 16)
					For x = 0 To plainTextDataSecondToLastBlock.Length - 1
						plainTextDataSecondToLastBlock(x) = Bit.Xor(plainTextDataSecondToLastBlock(x), IV(x))
					Next
					Dim cipherLastBlock(16) As Byte = cECB.Encrypt(plainTextDataSecondToLastBlock, k.key, False)

					'Take last block of plaintext data, fill remaining bytes with corresponding bytes (in position) from cipherLastBlock created above,
					' XOR with IV (note: IV does not change!) and ECB Encrypt
					Dim plainTextDataLastBlock(16) As Byte
					bc.ArrayCopy(dataBytes, dataBytes.Length - lastBlockSize, plainTextDataLastBlock, 0, lastBlockSize)
					For x = lastBlockSize To plainTextDataLastBlock.Length - 1
						plainTextDataLastBlock(x) = cipherLastBlock(x)
					Next
					For x = 0 To plainTextDataLastBlock.Length - 1
						plainTextDataLastBlock(x) = Bit.Xor(plainTextDataLastBlock(x), IV(x))
					Next
					Dim cipherSecondToLastBlock(16) As Byte = cECB.Encrypt(plainTextDataLastBlock, k.Key, False)

					'Add the last two blocks and generate cipher bytes
					bb.Append(cipherSecondToLastBlock)
					'Trim last block to appropriate size
					Dim cipherLastBlockSized(lastBlockSize) As Byte
					bc.ArrayCopy(cipherLastBlock, 0, cipherLastBlockSized, 0, lastBlockSize)
					bb.Append(cipherLastBlockSized)
					encryptedBytes = bb.ToArray
				End If
			Else
				'Short message
				cCFB.InitialisationVector = IV
				encryptedBytes = cCFB.Encrypt(dataBytes, k.Key, True)
			End If
	
			'Create result byte array, consisting of nonce and encrypted data. Base64 encode
			Dim cipherTextBytes(encryptedBytes.Length + 8) As Byte
			bc.ArrayCopy(nonce, 0, cipherTextBytes, 0, 8)
			bc.ArrayCopy(encryptedBytes, 0, cipherTextBytes, 8, encryptedBytes.Length)
			cipherText = su.EncodeBase64(cipherTextBytes)
		End If
	End If
	
	Return cipherText
End Sub

Sub DecryptString(cipherText As String) As String
	Dim plainText As String = ""
	
	'Ciphertext that contains no data results in an empty emission
	'See: https://github.com/SeanBDurkin/tplockbox/blob/1cc5cde00808701ae77eb2dd35dce8dbcf0082d7/LockBox3/run/TPLB3.StreamToBlock.pas#L114
	
	If cipherText <> Null Then
		If cipherText.Length > 0 Then
			'Retrieve nonce and data to decrypt from ciphertext byte array
			Dim cipherTextBytes() As Byte = su.DecodeBase64(cipherText)
			Dim nonce(8) As Byte
			bc.ArrayCopy(cipherTextBytes, 0, nonce, 0, 8)
			Dim dataBytes(cipherTextBytes.Length - 8) As Byte
			bc.ArrayCopy(cipherTextBytes, 8, dataBytes, 0, cipherTextBytes.Length - 8)
			'Create IV from nonce
			Dim IV(16) As Byte
			bc.ArrayCopy(nonce, 0, IV, 0, 8)
	
			Dim decryptedBytes() As Byte

			If dataBytes.Length > 15 Then
				Dim fullBlocks As Int = dataBytes.Length / 16
				Dim lastBlockSize As Int = dataBytes.Length Mod 16
				Dim numberOfBlocks As Int = fullBlocks
				If lastBlockSize > 0 Then numberOfBlocks = numberOfBlocks + 1
				cCBC.InitialisationVector = IV
				If fullBlocks = numberOfBlocks Then
					'We have a round message
					'See: https://github.com/SeanBDurkin/tplockbox/blob/1cc5cde00808701ae77eb2dd35dce8dbcf0082d7/LockBox3/run/TPLB3.StreamToBlock.pas#L223
					decryptedBytes = cCBC.Decrypt(dataBytes, k.Key, True)
				Else
					'We have a sharp message
					'See: https://github.com/SeanBDurkin/tplockbox/blob/1cc5cde00808701ae77eb2dd35dce8dbcf0082d7/LockBox3/run/TPLB3.StreamToBlock.pas#L224
					Dim bb As B4XBytesBuilder
					bb.Initialize

					'Everything but the last full block and it's trailing partial block can be decrypted via standard CBC
					If fullBlocks > 1 Then
						Dim frontCipherData(dataBytes.Length - 16 - lastBlockSize) As Byte
						bc.ArrayCopy(dataBytes, 0, frontCipherData, 0, dataBytes.Length - 16 - lastBlockSize)
						Dim frontCipherDecrypted() As Byte = cCBC.Decrypt(frontCipherData, k.Key, True)
						bb.Append(frontCipherDecrypted)
						'IV is the last block of "frontCipherData"
						bc.ArrayCopy(frontCipherData, frontCipherData.Length - 16, IV, 0, 16)
					End If

					'Take 2nd to last block of ciphertext data, ECB decrypt and XOR with IV
					Dim secondToLastBlock(16) As Byte
					bc.ArrayCopy(dataBytes, dataBytes.Length - 16 - lastBlockSize, secondToLastBlock, 0, 16)
					Dim lastBlockDecrypted() As Byte = cECB.Decrypt(secondToLastBlock, k.Key, False)
					For x = 0 To lastBlockDecrypted.Length - 1
						lastBlockDecrypted(x) = Bit.Xor(lastBlockDecrypted(x), IV(x))
					Next

					'Take last block of ciphertext data, fill remaining bytes with corresponding bytes (in position) from lastBlockDecrypted created above,
					' ECB decrypt and XOR with IV (note: IV does not change!)
					Dim lastBlock(16) As Byte
					bc.ArrayCopy(dataBytes, dataBytes.Length - lastBlockSize, lastBlock, 0, lastBlockSize)
					For x = lastBlockSize To lastBlock.Length - 1
						lastBlock(x) = lastBlockDecrypted(x)
					Next
					Dim secondToLastBlockDecrypted(16) As Byte = cECB.Decrypt(lastBlock, k.Key, False)
					For x = 0 To secondToLastBlockDecrypted.Length - 1
						secondToLastBlockDecrypted(x) = Bit.Xor(secondToLastBlockDecrypted(x), IV(x))
					Next

					'Add the last two blocks and generate plaintext bytes
					bb.Append(secondToLastBlockDecrypted)
					'Trim last block to appropriate
					Dim lastBlockDecryptedSized(lastBlockSize) As Byte
					bc.ArrayCopy(lastBlockDecrypted, 0, lastBlockDecryptedSized, 0, lastBlockSize)
					bb.Append(lastBlockDecryptedSized)
					decryptedBytes = bb.ToArray
				End If
			Else
				'We have a short message
				'See https://github.com/SeanBDurkin/tplockbox/blob/1cc5cde00808701ae77eb2dd35dce8dbcf0082d7/LockBox3/run/TPLB3.StreamToBlock.pas#L222
				cCFB.InitialisationVector = IV
				decryptedBytes = cCFB.Decrypt(dataBytes, k.Key, True)
			End If
			plainText = BytesToString(decryptedBytes, 0, decryptedBytes.Length, "UTF8")
		End If
	End If
	
	Return plainText
End Sub