B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Code Module
'==============================================
' Project:       rCommUART
' Brief:         Generalized binary framed command transport over UART.
' Date:          2026-09-30
' Description:   Data is transmitted as raw data byte frames with a defined frame size
'                set during initialization.
'                AsyncStreams is used to handle received data using the events
'                OnReceived and OnError.
'                These events call the mandatory methods defined in the Main module:
'                Main.CommUART_OnReceived(framebuffer)
'                Main.CommUART_OnError
'                Acknowledgement methods can be used to inform the client of the status.
' Dependencies:  rRandomAccessFile
' Notes:         B4R code modules are static and cannot be instantiated.
'                Using AsyncStreams prefix mode between B4J and B4A causes a
'                RuntimeException related to message size.
'                This occurs due to an endianness mismatch: B4R uses little-endian
'                byte order, while B4J uses big-endian byte order by default.
' Conditionals:  Set to enable additional hardware UART ports beyond the default UART0:
'                MEGA  - Set to enable additional hardware serial ports 1 to 3
'                        for Arduino Mega. Runs at 5 V!
'                ESP32 - Set to enable additional hardware serial port 2
'                        for ESP32. Runs at 3.3 V!'==============================================
#End Region

Private Sub Process_Globals
	' Public configuration (can be tweaked by Main prior to Initialize)
	Public Debug As Boolean = False

	' Mandatory frame header & footer	
	Private FRAME_HEADER As Byte = 0x19	' Example: STX
	Private FRAME_FOOTER As Byte = 0x58	' Example: ETX

	' Status Flags (Industry standard naming convention)
	Private Const STATUS_OK   As Byte = 0x06 ' ASCII ACK (Acknowledge) - Operation succeeded
	Private Const STATUS_ERR  As Byte = 0x15 ' ASCII NAK (Negative Acknowledge) - Operation failed
	Private Const STATUS_BUSY As Byte = 0x16 ' ASCII SYN - Controller processing a long operation

	' Preallocated transmission frame to prevent heap fragmentation
	Private StatusTXFrame(3) As Byte	' Frame used to reply the status as 3-bytes Header+Status+Footer to the client

	' Frame
	Public FrameSize As Int = 5					' Default size 5 bytes
	Public FrameHeader As Int = FRAME_HEADER	' Default 0x19
	Public FrameFooter As Int = FRAME_FOOTER	' Default 0x20
	
	' Communication mechanics using conditional flags for addition ports.
	#If MEGA
	Public SerialNative1 As Stream			
	Public SerialNative2 As Stream			
	Public SerialNative3 As Stream				
	#End If

	#If ESP32
	Public SerialNative1 As Stream		' NOT recommended
	Public SerialNative2 As Stream
	#End If
	Private AStreamLine As AsyncStreams
	
	' RX ring-less sliding buffer
	Private RXBuffer(64) As Byte
	Private RXLen As Int = 0

	' Frame buffering (Preallocated to prevent heap fragmentation)
	Private ActiveFrame(16) As Byte
	Private TotalBytes As UInt = 0
	Private OverflowCount As UInt = 0

	' Helper
	Private ByteConv As ByteConverter
End Sub

' Initialize
' Initializes the serial line and internal framing parameters.
' Parameter:
'   stream     - B4R Stream object (e.g. Serial1)
'   frameSize - Sizes the internal parsing frame to prevent out-of-bounds array copies
' Return:
'	None
Public Sub Initialize(stream As Stream, size As Int)
	FrameSize = size
	AStreamLine.Initialize(stream, "OnReceived", "OnError")
	If Debug Then
		Log("[CommUART.Initialize][I] Module ready. Frame size: ", FrameSize)
	End If
End Sub

' ================================================================
' ASYNCSTREAMS
' ================================================================

#Region ASyncStreams

' OnReceived
' Internal handler for raw data stream
' Parameter:
'	Buffer
' Return:
'	None
Public Sub OnReceived(buffer() As Byte)
	TotalBytes = TotalBytes + buffer.Length
    
	If Debug Then
		Log("[CommUART.OnReceived][I] len=", buffer.Length, " bytes=", ByteConv.HexFromBytes(buffer))
	End If

	' -------------------------------------------------
	' Append bytes safely with overflow prevention
	' -------------------------------------------------
	For i = 0 To buffer.Length - 1
		If RXLen >= RXBuffer.Length Then
			OverflowCount = OverflowCount + 1
			Log("[CommUART.OnReceived][E] RX buffer overflow -> flushing. Count=", OverflowCount)
			RXLen = 0
			Exit
		End If
        
		RXBuffer(RXLen) = buffer(i)
		RXLen = RXLen + 1
	Next

	' -------------------------------------------------
	' Frame Extraction Engine
	' -------------------------------------------------
	Do While RXLen >= FrameSize
        
		' ---------- FAST RESYNC (Header) ----------
		If RXBuffer(0) <> FrameHeader Then
			ShiftLeft(1)
			Continue
		End If
        
		' ---------- FAST RESYNC (Footer) ----------
		If RXBuffer(FrameSize - 1) <> FrameFooter Then
			ShiftLeft(1)
			Continue
		End If
        
		' ---------- Copy WITHOUT heap allocation ----------
		For i = 0 To FrameSize - 1
			ActiveFrame(i) = RXBuffer(i)
		Next
        
		ShiftLeft(FrameSize)

		' ---------- Dispatch Valid Frame to Main ----------
		' Slice a sized temporary view to pass to Main
		' without initializing new heap arrays.
		Dim framebuffer(FrameSize) As Byte
		For i = 0 To FrameSize - 1
			framebuffer(i) = ActiveFrame(i)
		Next
		
		Main.CommUART_OnReceived(framebuffer)
		' Log("[CommUART.OnReceived][I] len=", framebuffer.Length, " bytes=", ByteConv.HexFromBytes(framebuffer))
	Loop
End Sub

' Signal Stream errors out to the user's application logic
Public Sub OnError
	If Debug Then Log("[CommUART.OnError][E] Stream disconnected or I/O failure.")
	Main.CommUART_OnError
End Sub

' Write
' Exposed method for sending frames or messages out the interface
' Parameter:
'   data	- Byte array
' Return:
'	None
Public Sub Write(data() As Byte)
	If data.Length > 0 Then
		AStreamLine.Write(data)
		If Debug Then
			Log("[CommUART.Write][I] data=", ByteConv.HexFromBytes(data)," length=", data.Length)
		End If
	End If
End Sub

' WriteStatusOk
' Dispatches a standardized success verification frame (ACK).
Public Sub WriteStatusOk
	StatusTXFrame(0) = FrameHeader
	StatusTXFrame(1) = STATUS_OK
	StatusTXFrame(2) = FrameFooter
	AStreamLine.Write(StatusTXFrame)
	
	If Debug Then Log("[CommUART.WriteStatusOk][I] ACK frame sent.")
End Sub

' WriteStatusErr
' Dispatches a standardized error fault frame (NAK).
Public Sub WriteStatusErr
	StatusTXFrame(0) = FrameHeader
	StatusTXFrame(1) = STATUS_ERR
	StatusTXFrame(2) = FrameFooter
	AStreamLine.Write(StatusTXFrame)
	
	If Debug Then Log("[CommUART.WriteStatusErr][E] ERR frame sent.")
End Sub

' WriteStatusBusy
' Dispatches a standardized processing delay frame.
Public Sub WriteStatusBusy
	StatusTXFrame(0) = FrameHeader
	StatusTXFrame(1) = STATUS_BUSY
	StatusTXFrame(2) = FrameFooter
	AStreamLine.Write(StatusTXFrame)
	
	If Debug Then Log("[CommUART.WriteStatusBusy][W] BUSY frame sent.")
End Sub

' ================================================================
' ADDITIONAL SERIAL UART PORTS
' ================================================================

' ================================================================
' ARDUINO UNO HARDWARE & SOFTWARE SERIAL PORTS
'| Serial Port      | RX Pin  | TX Pin  | Primary Usage / Notes                                                                    |
'|                  | Receive | Transmit|                                                                                          |
'|------------------|---------|---------|------------------------------------------------------------------------------------------|
'| Serial (Port 0)  | Pin 0   | Pin 1   | Connected to the onboard USB-to-Serial converter for programming and the Serial Monitor. |
'|                  |         |         | Sharing this with external hardware can cause conflicts during code upload.              |
'| SoftwareSerial   | Any*    | Any*    | Emulated via library. Commonly assigned to Pin 10 (RX) and Pin 11 (TX) to avoid conflicts.|
' IMPORTANT
' Arduino UNO operates at 5V logic. Sending 5V signals to 3.3V devices can permanently damage them.
' *SoftwareSerial pins can be almost any digital pins, but cannot exceed high baud rates reliably (keep ≤ 57600).
' The default Baudrate is set to 115200 for Hardware Serial. Change accordingly.
'
' Call: RunNative("SerialNative1", Null)
' ================================================================

' ================================================================
' ARDUINO MEGA 2560 ADDITIONAL HARDWARE SERIAL PORTS
'| Serial Port      | RX Pin     | TX Pin     | Primary Usage / Notes                                                                    |
'|                  | Receive    | Transmit   |                                                                                          |
'|------------------|------------|------------|------------------------------------------------------------------------------------------|
'| Serial (Port 0)  | Pin 0      | Pin 1      | Connected to the onboard USB-to-Serial converter for programming and the Serial Monitor. |
'| Serial1 (Port 1) | Pin 19 RX1 | Pin 18 TX1 | Available for external hardware (e.g., GPS, Bluetooth).                                  |
'| Serial2 (Port 2) | Pin 17 RX2 | Pin 16 TX2 | Available for external hardware.                                                         |
'| Serial3 (Port 3) | Pin 15 RX3 | Pin 14 TX3 | Available for external hardware.                                                         |
' IMPORTANT
' Arduino MEGA operates at 5V logic. Sending 5V signals to 3.3V devices can permanently damage them.
' Arduino Due operates strictly at 3.3V logic. Connecting 5V lines directly will damage the chip.
' The default Baudrate is set to 115200. Change accordingly.
'
' Call: RunNative("SerialNative1", Null)
' ================================================================
#If MEGA
' InitializeMegaUART1
' Initialize uart on port 1 TX1, RX1
' Parameter:
'	size - Size of the frame (number of bytes)
Public Sub InitializeMegaUART1(size As Int)
	InitializeMegaPort(1, size)
End Sub

' InitializeMegaUART2
' Initialize uart on port 2 TX2, RX2
' Parameter:
'	size - Size of the frame (number of bytes)
Public Sub InitializeMegaUART2(size As Int)
	InitializeMegaPort(2, size)
End Sub

' InitializeMEGAPort3
' Initialize uart port 3 TX3, RX3
' Parameter:
'	size - Size of the frame (number of bytes)
Public Sub InitializeMegaUART3(size As Int)
	InitializeMegaPort(3, size)
End Sub

' InitializeMEGAPort
' Initialize port with frame size
' Parameter:
'	port - Port number 1 to 3 for an Arduino MEGA
'	size - Size of the frame (number of bytes)
Private Sub InitializeMegaPort(port As Int, size As Int)
	FrameSize = size
	' Select the UART port and init the asyncstream
	Select port
		Case 1
			RunNative("SerialNative1", Null)
			AStreamLine.Initialize(SerialNative1, "OnReceived", "OnError")
		Case 2
			RunNative("SerialNative2", Null)
			AStreamLine.Initialize(SerialNative2, "OnReceived", "OnError")
		Case 3
			RunNative("SerialNative3", Null)
			AStreamLine.Initialize(SerialNative3, "OnReceived", "OnError")			
	End Select
	If Debug Then
		Log("[CommUART.InitializeMegaPort][I] Module ready. port=", port, ", framesize=", FrameSize)
	End If
End Sub

#if C

void SerialNative1(B4R::Object* unused) {
	::Serial1.begin(115200); 
	b4r_commuart::_serialnative1->wrappedStream = &::Serial1;
}

void SerialNative2(B4R::Object* unused) {
	::Serial2.begin(115200); 
	b4r_commuart::_serialnative2->wrappedStream = &::Serial2;
}

void SerialNative3(B4R::Object* unused) {
	::Serial3.begin(115200); 
	b4r_commuart::_serialnative3->wrappedStream = &::Serial3;
}
#end if

#End If

' ================================================================
' ESP32 ADDITIONAL HARDWARE SERIAL PORTS
'| Serial Port     | Default RX Pin | Default TX Pin | Usage & Important Notes                                                                               |
'|-----------------|----------------|----------------|-------------------------------------------------------------------------------------------------------|
'| Serial (UART0)  | GPIO 3 (RX0)   | GPIO 1 (TX0)   | Connected to the onboard USB-to-UART chip for programming and the Serial Monitor.                     |
'|                 |                |                | Avoid using these for other devices.                                                                  |
'| Serial1 (UART1) | GPIO 9 (RX1)   | GPIO 10 (TX1)  | Warning: On standard WROOM modules, these pins are internally connected to the SPI flash memory chip. |
'|                 |                |                | Using them will crash the board. You must remap Serial1 to other pins.                                |
'| Serial2 (UART2) | GPIO 16 (RX2)  | GPIO 17 (TX2)  | Free and fully available for external modules (commonly used for GPS, Nextion displays, etc.).        |
' IMPORTANT
' ESP32 operates strictly at 3.3V logic. Connecting 5V lines directly to any ESP32 GPIO pin will damage the chip.
' The default Baudrate is set to 115200. Change accordingly.
'
' Call: RunNative("SerialNative1", Null)
' ================================================================

#If ESP32
' InitializeEsp32UART1
' Initialize uart port 1 TX1, RX1 - NOT RECOMMNDED
' Parameter:
'	size - Size of the frame (number of bytes)
Public Sub InitializeEsp32UART1(size As Int)
	InitializeEsp32Port(1, size)
End Sub

' InitializeEsp32UART2
' Initialize uart port 2 TX2, RX2
' Parameter:
'	size - Size of the frame (number of bytes)
Public Sub InitializeEsp32UART2(size As Int)
	InitializeEsp32Port(2, size)
End Sub

' InitializeESP32Port
' Parameter:
'	port - Port number 1 to 2 for an ESP32. Port 1 is not recommended.
'	size - Size of the frame (number of bytes)
Private Sub InitializeEsp32Port(port As Int, size As Int)
	FrameSize = size
	' Select the UART port and init the asyncstream
	Select port
		Case 1
			RunNative("SerialNative1", Null)
			AStreamLine.Initialize(SerialNative1, "OnReceived", "OnError")
		Case 2
			RunNative("SerialNative2", Null)
			AStreamLine.Initialize(SerialNative2, "OnReceived", "OnError")
	End Select
	If Debug Then
		Log("[CommUART.InitializeEsp32Port][I] Module ready. port=", port, ", framesize=", FrameSize)
	End If
End Sub

#if C
// Second Hardware Port - NOT RECOMMENDED
// Add this if not defined in the framework
// HardwareSerial Serial1(1); 
void SerialNative1(B4R::Object* unused)
{
	::Serial1.begin(115200);
	b4r_main::_serialnative1->wrappedStream = &::Serial1;
}

// Third Hardware Port
// Add this if not defined in the framework
// HardwareSerial Serial2(2); 
void SerialNative2(B4R::Object* unused)
{
	::Serial2.begin(115200);
	b4r_main::_serialnative2->wrappedStream = &::Serial2;
}
#End If

#End If

' ================================================================
' Internal Helper
' ================================================================
Private Sub ShiftLeft(count As UInt)
	For i = count To RXLen - 1
		RXBuffer(i - count) = RXBuffer(i)
	Next
	RXLen = RXLen - count
End Sub

#End Region
