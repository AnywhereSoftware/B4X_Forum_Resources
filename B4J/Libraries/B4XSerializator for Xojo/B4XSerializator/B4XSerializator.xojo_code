#tag Class
Protected Class B4XSerializator
	#tag Method, Flags = &h0
		Function ConvertBytesToObject(Bytes() As Byte) As Variant
		  ' Convert byte array to MemoryBlock
		  Dim mb As New MemoryBlock(Bytes.Count)
		  For i As Integer = 0 To Bytes.LastIndex
		    mb.Byte(i) = Bytes(i)
		  Next
		  
		  ' Decompress (zlib/deflate)
		  Dim decompressed As MemoryBlock =  zlib.Inflate(mb)
		  If decompressed = Nil Then
		    Raise New RuntimeException("Failed to decompress data")
		  End If
		  
		  ' Create BinaryStream for reading
		  mStream = New BinaryStream(decompressed)
		  mStream.LittleEndian = True
		  
		  Dim ret As Variant = ReadObject()
		  mStream.Close
		  mStream = Nil
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConvertObjectToBytes(obj As Variant) As Byte()
		  ' Write to a MemoryBlock via BinaryStream
		  Dim mb As New MemoryBlock(0)
		  mStream = New BinaryStream(mb)
		  mStream.LittleEndian = True
		  
		  WriteObject(obj)
		  
		  mStream.Close
		  
		  ' Compress (zlib/deflate)
		  Dim compressed As MemoryBlock =  zlib.Deflate(mb)
		  If compressed = Nil Then
		    Raise New RuntimeException("Failed to compress data")
		  End If
		  
		  ' Convert MemoryBlock to byte array
		  Dim result() As Byte
		  For i As Integer = 0 To compressed.Size - 1
		    result.Add(compressed.Byte(i))
		  Next
		  
		  mStream = Nil
		  Return result()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadInt() As Int32
		  Return mStream.ReadInt32()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadList() As Variant()
		  Dim len As Integer = ReadInt()
		  Dim arr() As Variant
		  For i As Integer = 0 To len - 1
		    arr.Add(ReadObject())
		  Next
		  Return arr()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadMap() As Dictionary
		  Dim len As Integer = ReadInt()
		  Dim d As New Dictionary
		  For i As Integer = 0 To len - 1
		    Dim key As Variant = ReadObject()
		    Dim value As Variant = ReadObject()
		    d.Value(key) = value
		  Next
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadObject() As Variant
		  Dim t As Byte = mStream.ReadUInt8
		  Dim len As Integer
		  
		  Select Case t
		  Case T_NULL
		    Return Nil
		    
		  Case T_INT
		    Return ReadInt()
		    
		  Case T_SHORT
		    Return ReadShort()
		    
		  Case T_LONG
		    Return mStream.ReadInt64()
		    
		  Case T_FLOAT
		    Return mStream.ReadSingle()
		    
		  Case T_DOUBLE
		    Return mStream.ReadDouble()
		    
		  Case T_BOOLEAN
		    Return (mStream.ReadUInt8 = 1)
		    
		  Case T_BYTE
		    Return CType(mStream.ReadUInt8, Int32)
		    
		  Case T_STRING
		    len = ReadInt()
		    Dim mb As MemoryBlock = mStream.Read(len)
		    Return mb.StringValue(0, mb.Size, Encodings.UTF8)
		    
		  Case T_CHAR
		    Dim charVal As Int16 = ReadShort()
		    Return Encodings.UTF8.Chr(charVal)
		    
		  Case T_LIST
		    Return ReadList()
		    
		  Case T_MAP
		    Return ReadMap()
		    
		  Case T_NSDATA
		    len = ReadInt()
		    Return mStream.Read(len)
		    
		  Case T_NSARRAY
		    Return ReadList()
		    
		  Case T_TYPE
		    Return ReadType()
		    
		  Else
		    Raise New RuntimeException("Unsupported type: " + Str(t))
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadShort() As Int16
		  Return mStream.ReadInt16()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadType() As B4XType
		  Dim cls As String = ReadObject().StringValue
		  Dim data As Dictionary = ReadMap()
		  Return New B4XType(cls, data)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteByte(b As Byte)
		  mStream.WriteUInt8(b)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteInt(i As Int32)
		  mStream.WriteInt32(i)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteMap(m As Dictionary)
		  WriteInt(m.Count)
		  For Each key As Variant In m.Keys
		    WriteObject(key)
		    WriteObject(m.Value(key))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteObject(obj As Variant)
		  If obj Is Nil Or obj.IsNull Then
		    WriteByte(T_NULL)
		    
		    ' --- Wrapper classes first (before Int32 check) ---
		  ElseIf obj IsA B4XByte Then
		    WriteByte(T_BYTE)
		    mStream.WriteUInt8(B4XByte(obj).GetValue())
		    
		  ElseIf obj IsA B4XShort Then
		    WriteByte(T_SHORT)
		    mStream.WriteInt16(B4XShort(obj).GetValue())
		    
		    ' --- Standard Variant types ---
		  ElseIf obj.Type = Variant.TypeBoolean Then
		    WriteByte(T_BOOLEAN)
		    If obj.BooleanValue Then
		      WriteByte(1)
		    Else
		      WriteByte(0)
		    End If
		    
		  ElseIf obj.Type = Variant.TypeInt32 Then
		    WriteByte(T_INT)
		    WriteInt(obj.Int32Value)
		    
		  ElseIf obj.Type = Variant.TypeInt64 Then
		    WriteByte(T_LONG)
		    mStream.WriteInt64(obj.Int64Value)
		    
		  ElseIf obj.Type = Variant.TypeDouble Then
		    WriteByte(T_DOUBLE)
		    mStream.WriteDouble(obj.DoubleValue)
		    
		  ElseIf obj.Type = Variant.TypeSingle Then
		    WriteByte(T_FLOAT)
		    mStream.WriteSingle(obj.SingleValue)
		    
		  ElseIf obj.Type = Variant.TypeString Then
		    Dim temp As String = obj.StringValue.ConvertEncoding(Encodings.UTF8)
		    Dim tempBytes As MemoryBlock = temp
		    WriteByte(T_STRING)
		    WriteInt(tempBytes.Size)
		    mStream.Write(tempBytes)
		    
		  ElseIf obj IsA Dictionary Then
		    WriteByte(T_MAP)
		    WriteMap(Dictionary(obj))
		    
		  ElseIf obj IsA B4XType Then
		    WriteByte(T_TYPE)
		    WriteType(B4XType(obj))
		    
		  ElseIf obj IsA MemoryBlock Then
		    ' MemoryBlock -> T_NSDATA (byte array equivalent)
		    WriteByte(T_NSDATA)
		    Dim data As MemoryBlock = obj
		    WriteInt(data.Size)
		    mStream.Write(data)
		  ElseIf obj IsA B4XList Then
		    ' B4XList -> T_LIST (distinct from T_NSARRAY)
		    WriteByte(T_LIST)
		    Dim lst As B4XList = B4XList(obj)
		    WriteInt(lst.Items.Count)
		    For Each item As Variant In lst.Items
		      WriteObject(item)
		    Next
		  ElseIf obj.IsArray Then
		    ' Variant array -> T_NSARRAY
		    WriteByte(T_NSARRAY)
		    Dim arr() As Variant = obj
		    WriteInt(arr.Count)
		    For Each item As Variant In arr
		      WriteObject(item)
		    Next
		    
		  Else
		    Raise New RuntimeException("Type not supported: " + Introspection.GetType(obj).Name)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteType(t As B4XType)
		  WriteObject("_" + t.ClassName)
		  WriteMap(t.Fields)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mStream As BinaryStream
	#tag EndProperty


	#tag Constant, Name = T_BOOLEAN, Type = Double, Dynamic = False, Default = \" 7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_BYTE, Type = Double, Dynamic = False, Default = \" 10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_CHAR, Type = Double, Dynamic = False, Default = \" 14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_DOUBLE, Type = Double, Dynamic = False, Default = \" 6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_FLOAT, Type = Double, Dynamic = False, Default = \" 5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_INT, Type = Double, Dynamic = False, Default = \" 3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_LIST, Type = Double, Dynamic = False, Default = \" 21", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_LONG, Type = Double, Dynamic = False, Default = \" 4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_MAP, Type = Double, Dynamic = False, Default = \" 20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_NSARRAY, Type = Double, Dynamic = False, Default = \" 22", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_NSDATA, Type = Double, Dynamic = False, Default = \" 23", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_NULL, Type = Double, Dynamic = False, Default = \" 0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_SHORT, Type = Double, Dynamic = False, Default = \" 2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_STRING, Type = Double, Dynamic = False, Default = \" 1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = T_TYPE, Type = Double, Dynamic = False, Default = \" 24", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
