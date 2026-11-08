B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals

End Sub

Public Sub Save(Buffer() As Byte, AudioFormat As JavaObject,FilePath As String,FileName As String)
	
	'Delete the file if it exists to avoid problems with Random access files
	If File.Exists(FilePath,FileName) Then
		File.Delete(FilePath,FileName)
	End If
	
	Dim OutFile As RandomAccessFile
	
	'Initialize the output file
	OutFile.Initialize2(FilePath,FileName,False,True)
	
	'Get required parameters from the AudioFormat object
	Dim ChannelConfig As Int  = AudioFormat.RunMethod("getChannels",Null)
	Dim SampleRateInHz As Float = AudioFormat.RunMethod("getSampleRate",Null)
	Dim SampleSizeInBits As Int = AudioFormat.RunMethod("getSampleSizeInBits",Null)

	'Write the file header
	Dim Pos,IntLen,ShLen As Int
	Pos=0
	IntLen=4
	ShLen=2
	Dim Msg As String = "RIFF"
	OutFile.WriteBytes(Msg.GetBytes("UTF8"),0,Msg.Length,Pos)					'Pos = 0
	Pos=Pos+IntLen
	OutFile.WriteInt(36 + Buffer.Length,Pos)														'Pos = 4 - Final size not yet known
	Pos=Pos+IntLen
	Msg = "WAVE"
	OutFile.WriteBytes(Msg.GetBytes("UTF8"),0,Msg.Length,Pos)    				'Pos = 8
	Pos=Pos+IntLen
	Msg = "fmt "
	OutFile.WriteBytes(Msg.GetBytes("UTF8"),0,Msg.Length,Pos)					'Pos = 12
	Pos=Pos+IntLen
	OutFile.WriteInt(16,Pos)													'Pos = 16 Sub chunk size 16 for PCM
	Pos=Pos+IntLen
	OutFile.WriteShort(1,Pos)													'Pos = 20 Audio Format, 1 for PCM
	Pos=Pos+ShLen
	OutFile.WriteShort(ChannelConfig,Pos)										'Pos = 22 No of Channels
	Pos=Pos+ShLen
	OutFile.WriteInt(SampleRateInHz,Pos)										'Pos = 24
	Pos=Pos+IntLen
	OutFile.WriteInt(SampleRateInHz * SampleSizeInBits * ChannelConfig / 8,Pos)	'pos = 28 Byte Rate
	Pos=Pos+IntLen
	OutFile.WriteShort(ChannelConfig * SampleSizeInBits / 8,Pos)				'Pos = 32 Block align, NumberOfChannels*BitsPerSample/8
	Pos=Pos+ShLen
	OutFile.WriteShort(SampleSizeInBits,Pos)									'Pos = 34 BitsPerSample
	Pos=Pos+ShLen
	Msg = "data"
	OutFile.WriteBytes(Msg.GetBytes("UTF8"),0,Msg.Length,Pos) 					'Pos = 36
	Pos=Pos+IntLen
	OutFile.WriteInt(Buffer.Length,Pos)											'Pos = 40 Data chunk size (Not yet known)
	Pos=Pos+IntLen
	
	'Write the recorded data
	OutFile.WriteBytes(Buffer,0,Buffer.Length,Pos)								'Pos = 44 - Data
	
	'Flush and close the RandomAccessFile
	OutFile.Flush
	OutFile.Close
End Sub

Public Sub PrependWavHeader(Buffer() As Byte, AudioFormat As JavaObject) As Byte()
	
	Dim Out As B4XBytesBuilder
	Out.Initialize
	
	Dim BC As ByteConverter
	
	
	'Get required parameters from the AudioFormat object
	Dim ChannelConfig As Int  = AudioFormat.RunMethod("getChannels",Null)
	Dim SampleRateInHz As Float = AudioFormat.RunMethod("getSampleRate",Null)
	Dim SampleSizeInBits As Int = AudioFormat.RunMethod("getSampleSizeInBits",Null)

	'Write the file header
	
	
	Dim Msg As String = "RIFF"
	Out.Append(Msg.GetBytes("UTF8"))											'Pos = 0
	
	Out.Append(BC.IntsToBytes(Array As Int(36 + Buffer.Length)))														'Pos = 4 - Final size not yet known
	
	Msg = "WAVE"
	Out.Append(Msg.GetBytes("UTF8"))						    				'Pos = 8
	
	Msg = "fmt "
	Out.Append(Msg.GetBytes("UTF8"))											'Pos = 12
	
	Out.Append(BC.IntsToBytes(Array As Int(16)))													'Pos = 16 Sub chunk size 16 for PCM
	
	Out.Append(BC.ShortsToBytes(Array As Short(1)))													'Pos = 20 Audio Format, 1 for PCM
	
	Out.Append(BC.ShortsToBytes(Array As Short(ChannelConfig)))										'Pos = 22 No of Channels
	
	Out.Append(BC.IntsToBytes(Array As Int(SampleRateInHz)))										'Pos = 24
	
	Out.Append(BC.IntsToBytes(Array As Int(SampleRateInHz * SampleSizeInBits * ChannelConfig / 8)))	'pos = 28 Byte Rate
	
	Out.Append(BC.ShortsToBytes(Array As Short(ChannelConfig * SampleSizeInBits / 8)))				'Pos = 32 Block align, NumberOfChannels*BitsPerSample/8
	
	Out.Append(BC.ShortsToBytes(Array As Short(SampleSizeInBits)))									'Pos = 34 BitsPerSample
	
	Msg = "data"
	Out.Append(Msg.GetBytes("UTF8")) 					'Pos = 36
	
	Out.Append(BC.IntsToBytes(Array As Int(Buffer.Length)))											'Pos = 40 Data chunk size 
	
	
	Log("OL " & Out.Length)
	
	'Write the recorded data
	Out.Append(Buffer)								'Pos = 44 - Data
	
	Return Out.ToArray
End Sub

