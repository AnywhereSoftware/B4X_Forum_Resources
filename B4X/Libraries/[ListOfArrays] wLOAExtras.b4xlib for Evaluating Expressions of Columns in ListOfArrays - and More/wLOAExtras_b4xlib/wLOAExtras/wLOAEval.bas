B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.83
@EndOfDesignText@
#Event: Function(Name As String, Values As List) As String
Sub Class_Globals
	Private Const String_TYPE = 1, OPERATOR_TYPE = 2 As Int
	Type ParsedNode (Operator As String, Left As ParsedNode, Right As ParsedNode, _
		NodeType As Int, Value As String)
	Type OrderData (Index As Int, Level As Int, Added As Int)
	Private root As ParsedNode
	Private ParseIndex As Int
	Private Nodes As List
	Private OperatorLevel As Map
	Public Error As Boolean
	Private mCallback As Object
	Private mEventName As String
	
	Private LOA As ListOfArrays	'WiL
	Private temps As Map	'WiL
	Private nrows As Int	'WiL
	Private lastExpression As String
End Sub

'Initializes the wEval instance
Public Sub Initialize (Callback As Object, EventName As String)
	temps.initialize
	mCallback = Callback
	mEventName = EventName
	OperatorLevel = CreateMap("+": 1, "-": 1, "*":2, "/": 2)
End Sub

'Use Internally by wLOA
Public Sub eval_X(LOA_ As ListOfArrays, colName As String, Expression As String) As List
	lastExpression = Expression
	LOA = LOA_
	nrows = LOA.GetColumn(0).size
	temps.clear
	Error = False
	Expression = tokenizeQuotes(Expression)		'WiL
	Expression = Expression.replace("?", colName)
	Expression = Expression.Replace(" mod ", "|").Replace(" ", "").Replace("-(", "-1*(").ToLowerCase			'WiL
	Expression = Expression.Replace(">=", "^").Replace("<=", "#").Replace("<>", "~")		'WiL
	Dim res As String = EvalHelper(Expression)
	If Not(LOA.mIndicesMap.containsKey(res)) Then 
		Return temps.Get(res)
	Else
		Return Null
	End If
End Sub

'Use Internally by wLOA
Public Sub Eval3(LOA_ As ListOfArrays, colName As String, Expression As String)
	LOA = LOA_
	nrows = LOA.GetColumn(0).size
	temps.clear
	Error = False
	Expression = tokenizeQuotes(Expression)		'WiL
	Expression = Expression.Replace(" mod ", "|").Replace(" ", "").Replace("-(", "-1*(").ToLowerCase			'WiL
	Expression = Expression.Replace(">=", "^").Replace("<=", "#").Replace("<>", "~")		'WiL
	Dim res As String = EvalHelper(Expression)
	If Not(LOA.mIndicesMap.containsKey(res)) Then 
		Dim  resLst As List = temps.Get(res)
		Dim colindex As Int = LOA.ColumnIndexToOrdinal(colName)
		LOA.SetColumn(colindex, resLst)
	End If
End Sub

Private Sub PrepareExpression(expr As String) As String
	Dim m As Matcher = Regex.Matcher("(\w*)\(", expr)			'WiL to change from digits to alpha & digits & "_"
	Dim sb As StringBuilder
	sb.Initialize
	Dim lastMatchEnd As Int = 0
	Do While m.Find
		Dim currentStart As Int = m.GetStart(0)
		If currentStart < lastMatchEnd Then Continue
		sb.Append(expr.SubString2(lastMatchEnd, currentStart))
		Dim functionCall As Boolean
		Dim args As List
		If m.Match.Length > 1 Then
			args.Initialize
			args.Add(LOA)	'WiL, this needs to be passed to function call args
			args.Add(temps)	'WiL, this needs to be passed to function call args
			args.Add(nrows)	'WiL, this needs to be passed to function call args
			functionCall = True
		End If
		Dim level As Int
		Dim start As Int = m.GetEnd(0)
		For i = start To expr.Length - 1
			If expr.CharAt(i) = "(" Then
				level = level + 1
			Else if expr.CharAt(i) = "," And level = 0 Then
				args.Add(CalcSubExpression(expr.SubString2(start, i)))
				start = i + 1
			Else if expr.CharAt(i) = ")" Then
				level = level - 1
				If level = -1 And (start < i) Then
					Dim d As String = CalcSubExpression(expr.SubString2(start, i))
					If functionCall Then
						args.Add(d)
						d = CallSub3(mCallback, mEventName & "_Function", m.Match.SubString2(0, m.Match.Length - 1), args)
					End If
					sb.Append(d)
					lastMatchEnd = i + 1
					Exit
				End If
			End If
		Next
	Loop
	If lastMatchEnd < expr.Length Then sb.Append(expr.SubString(lastMatchEnd))
	Return sb.ToString 
End Sub

Private Sub CalcSubExpression (expr As String) As String
	Dim be As wLOAEval
	be.Initialize (mCallback, mEventName)
	be.LOA = LOA			'WiL, this needs to be passed recursively 
	be.temps = temps		'WiL, this needs to be passed recursively 
	be.nrows = nrows		'WiL, this needs to be passed recursively 

	Dim d As String = be.EvalHelper(expr)
	If be.Error Then
		Error = True
		Return 0
	End If
	Return d
End Sub

'only evaluates Strings and operators. No functions or parenthesis here.
Private Sub EvalHelper (expr As String) As String
	ParseIndex = 0
	Dim root As ParsedNode
	root.Initialize
	expr = PrepareExpression(expr)
	If Error Then Return 0
	Dim m As Matcher = Regex.Matcher("[\.\w]+", expr)
	Nodes.Initialize
	Dim lastIndex As Int = 0
	Dim currentOrderData As OrderData
	currentOrderData.Initialize
	Nodes.Add(CreateOperatorNode("("))
	Dim cnt As Int = -1
	Do While m.Find
		cnt = cnt + 1
		Dim Operator As String = expr.SubString2(lastIndex, m.GetStart(0))
		Dim rawString As String = m.Match
		If Operator.EndsWith("-") Then
			Dim lastNode As ParsedNode = Nodes.Get(Nodes.Size - 1)
			If lastNode.Operator = "(" Or Operator.Length > 1 Then 
			'handle negative Strings: (-2 + 1, 1/-2
				Operator = Operator.SubString2(0, Operator.Length - 1)
				Dim lst As List
				If LOA.mIndicesMap.ContainsKey(rawString) Then 
					lst = LOA.GetColumn(rawString)
					For i = 0 To nrows - 1
						Dim val As Double = lst.Get(i)
						lst.Set(i, -val)
					Next
					Dim newTemp As String = "_temp_" & temps.Size
					temps.Put(newTemp, lst)
					rawString = newTemp
				Else if temps.ContainsKey(rawString) Then
					lst = temps.Get(rawString)
					For i = 0 To nrows - 1
						Dim val As Double = lst.Get(i)
						lst.Set(i, -val)
					Next
				Else if IsNumber(rawString) Then 
					lst.initialize
					For i = 0 To nrows - 1
						Dim val As Double = rawString
						lst.Add(-val)
					Next
				Else
					lst.initialize
					Log($"ERR: Unknown item '${"-" & rawString}' in expression:  ${lastExpression}"$)
					ExitApplication
				End If
			End If
		End If
		lastIndex = m.GetEnd(0)
		If Operator.Length > 0 Then
			Dim level As Int = OperatorLevel.GetDefault(Operator, 1)
			If currentOrderData.Level > 0 Then
				If currentOrderData.Level < level Then
					Nodes.InsertAt(currentOrderData.Index, CreateOperatorNode("("))
					currentOrderData.Added = currentOrderData.Added + 1
				Else if currentOrderData.Level > level Then
					If currentOrderData.Added > 0 Then
						Nodes.Add(CreateOperatorNode(")"))
						currentOrderData.Added = currentOrderData.Added - 1 
					End If
				End If
			End If
			currentOrderData.Level = level
			currentOrderData.Index = Nodes.Size + 1
			Nodes.Add(CreateOperatorNode(Operator))
		End If
		Dim d As String = rawString
		Nodes.Add(CreateStringNode(d))
	Loop
	For i = 1 To currentOrderData.Added
		Nodes.Add(CreateOperatorNode(")"))
	Next
	Nodes.Add(CreateOperatorNode(")"))
	root = BuildTree
	Return EvalNode(root)
End Sub

private Sub BuildTree As ParsedNode
	Dim rt As ParsedNode
	Do While ParseIndex < Nodes.Size
		Dim pn As ParsedNode = TakeNextNode
		Dim built As Boolean
		If pn.Operator = ")" Then 
			Exit
		Else If pn.Operator = "(" Then 
			pn = BuildTree
			built = True
		End If
		If pn.NodeType = String_TYPE Or built Then
			If rt.IsInitialized Then
				rt.Right = pn
			Else
				rt = pn
			End If
		Else if pn.NodeType = OPERATOR_TYPE Then
			pn.Left = rt
			rt = pn
		End If
	Loop
	If rt.IsInitialized = False Then rt = pn
	Return rt
End Sub

Private Sub makeList(ref As String) As List	'WiL, this sub is used to convert string column names to column data
	Dim lst As List
	If LOA.mIndicesMap.ContainsKey(ref) Then 
		lst = LOA.GetColumn(ref)
	Else if temps.ContainsKey(ref) Then
		Dim obj As Object = temps.Get(ref)
		If obj Is List Then 
			lst = obj
		Else
			lst.initialize
			For i = 0 To nrows - 1
				lst.Add(obj)
			Next
		End If
	Else if IsNumber(ref) Then 
		lst.initialize
		For i = 0 To nrows - 1
			lst.Add(ref)
		Next
	Else If ref = "false" Or ref = "true" Then 
		lst.initialize
		For i = 0 To nrows - 1
			lst.Add(ref.As(Boolean))
		Next
	Else
		lst.initialize
		Log($"ERR: Unknown item '${ref}' in expression:  ${lastExpression}"$)
		ExitApplication
	End If
	Return lst
End Sub

Private Sub EvalNode (pn As ParsedNode) As String
	If pn.NodeType = String_TYPE Then Return pn.Value
	Dim left As String = EvalNode(pn.Left)
	Dim right As String = EvalNode(pn.Right)
'WiL, the rest of this Sub is modified to compute results as an list operation on lists, result is stored under a temporary name
	Dim leftLst As List = makeList(left)
	Dim rightLst As List = makeList(right)
	Dim resultLst As List
	resultLst.Initialize
	For i = 0 To nrows - 1
		Dim obj0 As Object = leftLst.Get(i)
		Dim obj1 As Object = rightLst.Get(i)
		Dim handled As Boolean = False
		If IsNumber(obj0) And IsNumber(obj1) Then 
			Dim d0 As Double = obj0
			Dim d1 As Double = obj1
			handled = True
			Select pn.Operator
				Case "+": resultLst.Add(d0 + d1)
				Case "-": resultLst.Add(d0 - d1)
				Case "*": resultLst.Add(d0 * d1)
				Case "/"
					If d1 <> 0 Then 
						resultLst.Add(d0 / d1)
					Else
						resultLst.Add(Null)
					End If
				Case "|": resultLst.Add(d0 Mod d1)
				Case ">": resultLst.Add(d0 > d1)
				Case "<": resultLst.Add(d0 < d1)
				Case "^": resultLst.Add(d0 >= d1)
				Case "#": resultLst.Add(d0 <= d1)
				Case Else
					handled = False
			End Select	
		End If
		If Not(handled) And (obj0 Is String) And (obj1 Is String) Then 
			Dim s0 As String = obj0
			Dim s1 As String = obj1
			Select pn.Operator
				Case "&": resultLst.Add(s0 & s1)
				Case "=": resultLst.Add(s0 = s1)
				Case "~": resultLst.Add(s0 <> s1)
				Case Else
					Log("Syntax error: " & pn.Operator)
					Return "error"
			End Select
			handled = True
		End If
		If Not(handled) And (obj0 Is Boolean) And ((obj1 Is Boolean) Or ("false" = obj1) Or ("true" = obj1)) Then 
			Dim b0 As Boolean = obj0
			Dim b1 As Boolean = obj1
			Select pn.Operator
				Case "=": resultLst.Add(b0 = b1)
				Case "~": resultLst.Add(b0 <> b1)
				Case Else
					Log("Syntax error: " & pn.Operator)
					Return "error"
			End Select
			handled = True
		End If

		If Not(handled) Then 
			resultLst.Add(Null)
		End If
	Next
	Dim newTemp As String = "_temp_" & temps.Size
	temps.Put(newTemp, resultLst)
	Return newTemp
End Sub

private Sub TakeNextNode As ParsedNode
	Dim pn As ParsedNode = Nodes.Get(ParseIndex)
	ParseIndex = ParseIndex + 1
	Return pn
End Sub

Private Sub CreateOperatorNode(operator As String) As ParsedNode
	Dim pn As ParsedNode
	pn.Initialize
	pn.NodeType = OPERATOR_TYPE
	pn.Operator = operator
	Return pn
End Sub

Private Sub CreateStringNode (d As String) As ParsedNode
	Dim pn As ParsedNode
	pn.Initialize
	pn.NodeType = String_TYPE
	pn.Value = d
	Return pn
End Sub

'To handle quoted string scalars - number scalars work without quotes
Private Sub tokenizeQuotes(Input As String) As String		
	Dim Q As String = "'"
	Dim InsideQuotes As Boolean
	Dim mainsb As StringBuilder: mainsb.Initialize
	Dim sb As StringBuilder: sb.Initialize
	Dim CurrentIndex As Int = 0
	Do While CurrentIndex < Input.Length
		Dim c As String
		c = Input.CharAt(CurrentIndex)
		If InsideQuotes Then
			If c = Q Then
				Dim temp As String = "_temp_" & temps.size
				temps.Put(temp, sb.ToString)
				sb.Initialize
				mainsb.Append(temp)
				InsideQuotes = False
			Else
				sb.Append(c)
			End If
		Else
			If c = Q Then
				InsideQuotes = True
			Else
				mainsb.Append(c)
			End If
		End If
		CurrentIndex = CurrentIndex + 1
	Loop
	Return mainsb.toString
End Sub
