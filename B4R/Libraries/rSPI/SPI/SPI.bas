B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.5
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Private iMode As Int
	Private iBitOrder As Int
	Private lngClockFreq As ULong
	Private bRet As UInt
	Private bSend As UInt
	Private iArdBitOrder As Int
	Private bc As ByteConverter
	Private bSendA(64) As Byte
	Private lenbSendA As UInt
	Private bc As ByteConverter
End Sub



Public Sub Begin_Transaction(ClockFrequencyInHz As Long, BitOrder As Int, SPI_MODEX As Int)
	lngClockFreq = ClockFrequencyInHz
	iBitOrder = BitOrder
	iMode = SPI_MODEX
	RunNative("ardbegintransaction", Null)
End Sub

Public Sub End_Transaction
	RunNative("ardendtransaction", Null)
End Sub

Public Sub Transfer_Byte(ByteToSend As Byte) As Byte
	bSend = ByteToSend
	RunNative("ardtransfer", Null)
	Return bRet
End Sub

Public Sub DisableInterrupts
	RunNative("ardnointerrupts", Null)
End Sub

Public Sub EnableInterrupts
	RunNative("ardinterrupts", Null)
End Sub

Public Sub Transfer_Byte_Array(ByteArrayToSend() As Byte, ByteArrayToPutTheResultsIn() As Byte)
	Dim bRetA(ByteArrayToSend.Length) As Byte
	For ii = 0 To ByteArrayToSend.Length - 1
		bRetA(ii) = Transfer_Byte(ByteArrayToSend(ii))
	Next
	bc.ArrayCopy(bRetA, ByteArrayToPutTheResultsIn)
End Sub

Public Sub CheckIfThisBoardIsSupported
	RunNative("ardchecksupport", Null)
End Sub

Public Sub CSPinActivate(CS As Pin)
	CS.DigitalWrite(False)
End Sub

Public Sub CSPinDeActivate(CS As Pin)
	CS.DigitalWrite(True)
End Sub

Public Sub ShiftLeftByte(B As Byte, NumberOfBits As UInt) As UInt
	Return Bit.ShiftLeft(NumberOfBits, B)
End Sub

Public Sub ShiftRightByte(B As Byte, NumberOfBits As UInt) As UInt
	Return Bit.ShiftRight(NumberOfBits, B)
End Sub

Public Sub GetByteFromString(ByteString As String) As UInt
	Dim val As UInt = 0
	val = Bit.ParseInt(ByteString, 2)
	Return val
End Sub

Public Sub ApplyMask(b As Byte, mask As Byte) As Byte
	Return (Bit.And(b,mask))
End Sub

Public Sub GetBitAt(b As Byte, PositionFromRight As UInt) As UInt
	'PositionFromRight=1 in byte binary 00000001 returns 1
	Dim s As String = Bit.ToBinaryString(b)
	Dim val As UInt = bc.StringFromBytes(bc.SubString2(s, s.Length - PositionFromRight, s.Length - PositionFromRight + 1))
	Return val
End Sub

#if C
#include <SPI.h>

void ardbegintransaction (B4R::Object* o) {

	SPI.begin();
	switch (b4r_spi::_ibitorder){
		case 0:
			b4r_spi::_iardbitorder = LSBFIRST;
			break;
		case 1:
			b4r_spi::_iardbitorder = MSBFIRST;
			break;
	}

	switch (b4r_spi::_imode) {
		case 0: {
			SPI.beginTransaction(SPISettings(b4r_spi::_lngclockfreq, b4r_spi::_iardbitorder, SPI_MODE0));
			break;
			}
		case 1: {
			SPI.beginTransaction(SPISettings(b4r_spi::_lngclockfreq, b4r_spi::_iardbitorder, SPI_MODE1));
			break;
			}
		case 2: {
			SPI.beginTransaction(SPISettings(b4r_spi::_lngclockfreq, b4r_spi::_iardbitorder, SPI_MODE2));
			break;
			}
		case 3: {
			SPI.beginTransaction(SPISettings(b4r_spi::_lngclockfreq, b4r_spi::_iardbitorder, SPI_MODE3));
			break;
			}
	}
	
}

void ardendtransaction (B4R::Object* o) {
	SPI.endTransaction();
	SPI.end();
}

void ardnointerrupts (B4R::Object* o) {
	noInterrupts();
}

void ardinterrupts (B4R::Object* o) {
	interrupts();
}

void ardtransfer (B4R::Object* o) {
	b4r_spi::_bret = SPI.transfer(b4r_spi::_bsend);
}


void ardchecksupport(B4R::Object* o) {
Serial.print("-");
#ifdef SPI_HAS_TRANSACTION
  Serial.print("You can use this library with your board");
#endif
Serial.println("-");
}

#End If


Public Sub MSBFIRST As Int
	Return 1
End Sub

Public Sub LSBFIRST As Int
	Return 0
End Sub

Public Sub SPI_MODE0 As Int
	Return 0
End Sub

Public Sub SPI_MODE1 As Int
	Return 1
End Sub

Public Sub SPI_MODE2 As Int
	Return 2
End Sub

Public Sub SPI_MODE3 As Int
	Return 3
End Sub
