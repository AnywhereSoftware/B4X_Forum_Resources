B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub


Public Sub ArrayToList(Arr As Object) As List
	Dim L1 As List
	L1.Initialize
	Dim AType As String = GetType(Arr)

	Select AType
		
		Case "[[Ljava.lang.Object;"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim OOArr(,) As Object = Arr
			Dim OOArrList As List = Arrays.RunMethod("asList",Array(OOArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To OOArrList.Size- 1
				Dim O As Object = OOArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)
			
		Case "[[I"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim IIArr(,) As Int = Arr
			Dim IIArrList As List = Arrays.RunMethod("asList",Array(IIArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To IIArrList.Size- 1
				Dim O As Object = IIArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)
			
		Case "[[D"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim DDArr(,) As Double = Arr
			Dim DDArrList As List = Arrays.RunMethod("asList",Array(DDArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To DDArrList.Size- 1
				Dim O As Object = DDArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)

		Case "[[F"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim FFArr(,) As Float = Arr
			Dim FFArrList As List = Arrays.RunMethod("asList",Array(FFArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To FFArrList.Size- 1
				Dim O As Object = FFArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)
			
		Case "[[B"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim BBArr(,) As Byte = Arr
			Dim BBArrList As List = Arrays.RunMethod("asList",Array(BBArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To BBArrList.Size- 1
				Dim O As Object = BBArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)
			
		Case "[[Ljava.lang.String;"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim SSArr(,) As String = Arr
			Dim SSArrList As List = Arrays.RunMethod("asList",Array(SSArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To SSArrList.Size- 1
				Dim O As Object = SSArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)
			
		Case "[[S"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim SSHArr(,) As Short = Arr
			Dim SSHArrList As List = Arrays.RunMethod("asList",Array(SSHArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To SSHArrList.Size- 1
				Dim O As Object = SSHArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)
			
		Case "[[Z"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim ZZArr(,) As Boolean = Arr
			Dim ZZArrList As List = Arrays.RunMethod("asList",Array(ZZArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To ZZArrList.Size- 1
				Dim O As Object = ZZArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)
			
		Case "[[C"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim CCArr(,) As Char = Arr
			Dim CCArrList As List = Arrays.RunMethod("asList",Array(CCArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To CCArrList.Size- 1
				Dim O As Object = CCArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)
			
		Case "[[J"

			Dim Arrays As JavaObject
			Arrays.InitializeStatic("java.util.Arrays")

			Dim JJArr(,) As Long = Arr
			Dim JJArrList As List = Arrays.RunMethod("asList",Array(JJArr))

			Dim IL As List
			IL.Initialize
			For i = 0 To JJArrList.Size- 1
				Dim O As Object = JJArrList.Get(i)
				IL.Add(ArrayToList(O))
			Next

			L1.AddAll(IL)

		Case "[Ljava.lang.Object;"
			Dim OArr() As Object = Arr
			For Each O As Object In OArr
				L1.Add(O)
			Next
			
		Case "[I"
			Dim IArr() As Int = Arr
			For Each O As Object In IArr
				L1.Add(O)
			Next
			
		Case "[D"
			Dim DArr() As Double = Arr
			For Each O As Object In DArr
				L1.Add(O)
			Next
			
		Case "[F"
			Dim FArr() As Float = Arr
			For Each O As Object In FArr
				L1.Add(O)
			Next
			
		Case "[B"
			Dim BArr() As Byte = Arr
			For Each O As Object In BArr
				L1.Add(O)
			Next
			
		Case "[Ljava.lang.String;"
			Dim SArr() As String = Arr
			For Each O As Object In SArr
				L1.Add(O)
			Next
			
		Case "[S"
			Dim SHArr() As Short = Arr
			For Each O As Object In SHArr
				L1.Add(O)
			Next
			
		Case "[C"
			Dim CArr() As Char = Arr
			For Each O As Object In CArr
				L1.Add(O)
			Next
			
		Case "[Z"
			Dim ZArr() As Boolean = Arr
			For Each O As Object In ZArr
				L1.Add(O)
			Next
			
		Case "[J"
			Dim JArr() As Long = Arr
			For Each O As Object In JArr
				L1.Add(O)
			Next
	End Select
	Return L1
End Sub

Public Sub GetTypeFieldNames(TType As Object) As List
  
	Dim ThisClass As Reflector
  
	ThisClass.Target  = TType.As(JavaObject).RunMethod("getClass",Null)
  
	Dim Fields() As Object = ThisClass.RunMethod("getFields")
  
	Dim FieldList As List
	FieldList.Initialize
  
	For Each Field As JavaObject In Fields
		Dim FieldStr As String = Field.RunMethod("toGenericString",Null)
		FieldStr = FieldStr.SubString(FieldStr.LastIndexOf(".") + 1)
		If FieldStr = "IsInitialized" Then Continue
      
		FieldList.Add(FieldStr)
	Next
  
	Return FieldList
End Sub

Public Sub GetTypeFieldValues(TType As Object) As List
  
	Dim ThisClass As Reflector
  
	ThisClass.Target  = TType.As(JavaObject).RunMethod("getClass",Null)
  
	Dim Fields() As Object = ThisClass.RunMethod("getFields")
  
	Dim FieldList As List
	FieldList.Initialize
  
	For Each Field As JavaObject In Fields
		Dim FieldStr As String = Field.RunMethod("toGenericString",Null)
		FieldStr = FieldStr.SubString(FieldStr.LastIndexOf(".") + 1)
		If FieldStr = "IsInitialized" Then Continue
      
		FieldList.Add(Field.RunMethod("get",Array(TType)))
	Next
  
	Return FieldList
End Sub