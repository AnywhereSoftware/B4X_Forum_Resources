B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private cv As B4XCanvas
	Private cvRect As B4XRect
	Private names() As String
	Private levels() As Int
	Private prefixLength As Int
	Private levelNodes(15) As List
	
	Private xOffset, yOffset As Float
	Private fnt As B4XFont
	Private lastParent As String
	Private colorToggle As Boolean
	
	Private nameIndices As Map
	Private classNodes As B4XOrderedMap
	Private parentDir As String
	
	Private toast As BCToast
	Dim classesNames As List
End Sub

Public Sub Initialize(Root1 As B4XView)
	Root = Root1
	nameIndices.Initialize
	classNodes.Initialize
	classesNames.Initialize
	fnt = xui.CreateDefaultBoldFont(15)
	For i = 0 To 14
		levelNodes(i).Initialize
	Next

#if B4J	
	parentDir = File.DirApp
	parentDir = parentDir.SubString2(0, parentDir.LastIndexOf("\"))
	parentDir = parentDir.SubString2(0, parentDir.LastIndexOf("\"))
#End IF
	
	cv.Initialize(Root)
	cvRect.Initialize(0, 0, Root.Width, Root.Height)
	toast.Initialize(Root)
	toast.pnl.Visible = False
	toast.pnl.SetColorAndBorder(xui.Color_RGB(220,20,60), 0dip, xui.Color_White, 20dip)
End Sub

Public Sub parseTree(tree As String)
	names = Regex.Split(CRLF, tree)
	Dim levels(names.Length) As Int
	prefixLength = -1
	For i = 0 To names.Length - 1
		Dim s As String = names(i)
		If s.Trim.Length > 0 Then
			Dim prefixSet As Boolean
			For j = 0 To s.Length -1
				If s.CharAt(j) <> TAB Then
					If prefixSet = False Then
						levels(i) = j
						prefixSet = True
						If prefixLength = -1 Or j < prefixLength Then prefixLength = j
					End If
				End If
			Next
			nameIndices.Put(s.Replace(TAB, ""), i)
		End If
	Next
	For i = 0 To names.Length - 1
		If levels(i) = prefixLength Then
			createNode(i, 0)
			Exit
		End If
	Next
End Sub

Private Sub createNode(i As Int, parentIndex As Int)
	registerNode(i, parentIndex)
	Dim childNodes As List: childNodes.Initialize
	For j = i + 1 To names.length - 1
		If levels(j) = levels(i) Then Exit
		If levels(j) = levels(i) + 1 Then childNodes.Add(j)
	Next
	For Each index As Int In childNodes
		createNode(index, i)
	Next
End Sub

Private Sub registerNode(index As Int, parentIndex As Int)
	levelNodes(levels(index)).Add(names(index).Replace(TAB, "") & "~" & names(parentIndex).Replace(TAB, ""))
End Sub

Private Sub drawNode(s As String, i As Int)
	Dim v() As String = Regex.Split("~", s)
	Dim name As String = v(0)
	Dim parent As String = ""
	If v.Length > 1 Then parent = v(1)
	Dim w As Float = 150dip
	Dim h As Float = 25dip
	Dim adjust As Float = (i Mod 2) * (h / 1.5)
	Dim nodeRect As B4XRect
	If parent <> lastParent Then colorToggle = (colorToggle = False)
	Dim nodeColor As Int = xui.Color_Black
	If colorToggle Then nodeColor = xui.Color_Blue
	nodeRect.Initialize(xOffset - w / 2, adjust + yOffset - h / 2, xOffset - w / 2 + w, adjust + yOffset - h / 2 + h)
	Dim textWidth As Float = cv.MeasureText(name, fnt).Width
	Dim suffix As String
	If classNodes.ContainsKey(name) Then
		suffix = "*"
	Else
		Dim index As Int = nameIndices.Get(name)
		Dim CNode As classNode = NewClassNode(name & suffix, index, parent, levels(index), nodeRect)
		classNodes.Put(name, CNode)
	End If
	Dim displayName As String = name
	If displayName.Contains(".") Then displayName = displayName.SubString2(0, displayName.IndexOf("."))
	
	cv.drawText(displayName & suffix, nodeRect.centerX - textWidth / 2, nodeRect.Bottom - 10dip, fnt, nodeColor, "LEFT")
	If parent <> "" Then
		Dim CNode As classNode = classNodes.Get(parent)
		CNode.children.Add(name & suffix)
		Dim r As B4XRect = CNode.displayRect
		cv.DrawLine(r.CenterX, r.Bottom, nodeRect.CenterX, nodeRect.Top, nodeColor, 1dip)
	End If
	lastParent = parent
End Sub

Public Sub displayTree
	Dim widthUnit As Float  = 75
#If B4A
	widthUnit = 65dip
#End If
	For i = prefixLength To 14
		Dim theList As List = levelNodes(i)
		If theList.Size = 0 Then Continue
		yOffset = 50dip + (i - prefixLength) * cvRect.Height / 5
		Dim totalWidth As Float = theList.Size * widthUnit
		xOffset = cvRect.Width / 2 - totalWidth / 2 + widthUnit / 2
		lastParent = ""
		For j = 0 To theList.Size - 1
			drawNode(theList.Get(j), j)
			xOffset = xOffset + widthUnit
		Next
	Next
End Sub

Public Sub generateClasses
	Dim output As List: output.Initialize
	For level = prefixLength To 14
		Dim theList As List = levelNodes(level)
		If theList.Size = 0 Then Continue
		For Each s As String In theList
			Dim v() As String = Regex.Split("~", s)
			Dim name As String = v(0)
			Dim CNode As classNode = classNodes.Get(name)
			Dim cnt As Int
			For Each t As String In CNode.children
				If t.EndsWith("*") Then Continue
				Dim DNode As classNode = classNodes.Get(t)
				If DNode.level > CNode.level Then cnt = cnt + 1
			Next
			Dim sb As StringBuilder: sb.Initialize
			If cnt > 0 Then
				classesNames.Add(name)
				sb.Append("B4J=True").Append(CRLF)
				sb.Append("Group=Default Group").Append(CRLF)
				sb.Append("ModulesStructureVersion=1").Append(CRLF)
				sb.Append("Type=Class").Append(CRLF)
				sb.Append("Version=9.1").Append(CRLF)
				sb.Append("@EndOfDesignText@").Append(CRLF)
				
				sb.Append("Sub Class_Globals").Append(CRLF)
				For Each t As String In CNode.children
					If t.contains(".") Then
						sb.Append(TAB & $"Private m${t.substring2(0, t.IndexOf("."))} As ${t.substring(t.IndexOf(".") + 1)}"$).Append(CRLF)
					Else
						sb.Append(TAB & $"Private m${t} As cls${t}"$).Append(CRLF)
					End If
				Next
				sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
				sb.Append("Public Sub Initialize").Append(CRLF)
				sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
				sb.Append("Public Sub New(")
				For Each t As String In CNode.children
					If t.contains(".") Then
						Dim varType As String = t.substring(t.IndexOf(".") + 1)
						If varType <> "List" And varType.EndsWith("Map") = False And varType <> "B4XSet" Then
							sb.Append($"${t.substring2(0, t.IndexOf("."))}_ As ${varType}, "$)
						End If
					Else
						sb.Append($"${t}_ As cls${t}, "$)
					End If
				Next
				If sb.toString.endsWith("(") Then
					sb.Remove(sb.Length - 1, sb.Length)
					sb.Append(" As cls").Append(name).Append(CRLF)
				Else
					sb.Remove(sb.Length - 2, sb.Length)
					sb.Append(") As cls").Append(name).Append(CRLF)
				End If
				sb.Append(TAB).Append("Dim newItem As cls").Append(name).Append(CRLF)
				sb.Append(TAB).Append("newItem.Initialize").Append(CRLF)
				For Each t As String In CNode.children
					If t.Contains(".") Then
						Dim varType As String = t.substring(t.IndexOf(".") + 1)
						Dim shortName As String = t.substring2(0, t.IndexOf("."))
						If varType = "List" Or varType.EndsWith("Map") Or varType = "B4XSet" Then
							sb.Append(TAB).Append($"newItem.m${shortName}.Initialize"$).Append(CRLF)
						Else
							sb.Append(TAB).Append($"newItem.m${t.substring2(0, t.IndexOf("."))} = ${shortName}_"$).Append(CRLF)
						End If
					Else
						sb.Append(TAB).Append($"newItem.m${t} = ${t}_"$).Append(CRLF)
					End If
				Next
				sb.Append(TAB).Append("Return newItem").Append(CRLF)
				sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
				For Each t As String In CNode.children
					SettersGetters(t, sb)
				Next
				sb.Append("'Add Class-specific Subs and Calls to other Class Public Subs Here_________________________________________").Append(CRLF).Append(TAB).Append(CRLF)
				sb.Append("'__________________________________________________________________________________________________________").Append(CRLF).Append(TAB).Append(CRLF)
				sb.Append("#Region Delegate Subs").Append(CRLF).Append(TAB).Append(CRLF)
				For Each t As String In CNode.children
					generateDelegate(t, sb)
				Next
				sb.Append("#End Region").Append(CRLF).Append(TAB).Append(CRLF)
			End If
			If sb.Length > 0 Then
				File.WriteString(parentDir, "cls" & CNode.name & ".bas", sb.ToString)
				Sleep(10)
				toast.pnl.TextColor = xui.Color_White
				toast.pnl.Visible = True
				toast.DurationMs = 5000
				toast.Show("[Color=White][b]New Classes have been saved in parent dir: " & parentDir & "[/b][/Color]")
			End If
		Next
	Next
	Log(TAB)
	Log("'Place the following in B4XMainPage: Sub Class_Globals")
	For Each s As String In classesNames
		Log($"'${TAB}Private ${s} As cls${s}"$)
	Next
	
	Log(TAB)
	Log("'Place the following in B4XMainPage: Public Sub Initialize")
	For Each s As String In classesNames
		Log($"'${TAB}${s}.Initialize"$)
	Next
End Sub

Private Sub SettersGetters(name As String, sb As StringBuilder)
	Dim QNode As classNode = classNodes.Get(name)
	Dim shortName As String = QNode.name
	Dim varType As String
	If shortName.Contains(".") Then
		varType = shortName.SubString(shortName.IndexOf(".") + 1)
		shortName = shortName.SubString2(0, shortName.IndexOf("."))
	Else
		varType = "cls" & shortName
	End If
	sb.Append($"Public Sub get${shortName} As ${varType}"$).Append(CRLF)
	sb.Append(TAB).Append($"Return m${shortName}"$).Append(CRLF)
	sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
	
	If varType <> "List" And varType.EndsWith("Map") = False And varType <> "B4XSet" Then
		sb.Append($"Public Sub set${shortName}(newValue As ${varType})"$).Append(CRLF)
		sb.Append(TAB).Append($"m${shortName} = newValue"$).Append(CRLF)
		sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
	End If
End Sub

Private Sub generateDelegate(name As String, sb As StringBuilder)
	Dim XNode As classNode = classNodes.Get(name)
	Dim children As List = XNode.children
	For Each child As String In children
		Dim isClass As Boolean
		Dim QNode As classNode = classNodes.Get(child)
		Dim shortName As String = QNode.name
		Dim varType As String
		If shortName.Contains(".") Then
			varType = shortName.SubString(shortName.IndexOf(".") + 1)
			shortName = shortName.SubString2(0, shortName.IndexOf("."))
			sb.Append("Public Sub get").Append(shortName).Append($" As ${varType}"$).Append(CRLF)
		Else
			sb.Append("Public Sub get").Append(shortName).Append($" As cls${shortName}"$).Append(CRLF)
			isClass = True
		End If
		sb.Append(TAB).Append($"Return m${name}.${shortName}"$).Append(CRLF)
		sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
		
		If varType <> "" And varType <> "List" And varType.EndsWith("Map") = False And varType <> "B4XSet" Then
			sb.Append($"Public Sub set${shortName}(newValue As ${varType})"$).Append(CRLF)
			sb.Append(TAB).Append($"m${name}.${shortName} = newValue"$).Append(CRLF)
			sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
		End If
		
		If isClass Then
			For Each t As String In QNode.children
				Dim sName As String = t
				Dim varType As String
				If sName.Contains(".") Then
					varType = sName.SubString(sName.IndexOf(".") + 1)
					sName = sName.SubString2(0, sName.IndexOf("."))
					sb.Append("Public Sub get").Append(sName).Append($" As ${varType}"$).Append(CRLF)
				Else
					sb.Append("Public Sub get").Append(sName).Append($" As cls${sName}"$).Append(CRLF)
				End If
				If name.contains(".") Then name = name.SubString2(0, name.indexOf("."))
				sb.Append(TAB).Append($"Return m${name}.${shortName}.${sName}"$).Append(CRLF)
				sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
				If varType <> "" And varType <> "List" And varType.EndsWith("Map") = False And varType <> "B4XSet" Then
					sb.Append($"Public Sub set${sName}(newValue As ${varType})"$).Append(CRLF)
					sb.Append(TAB).Append($"m${name}.${shortName}.${sName} = newValue"$).Append(CRLF)
					sb.Append("End Sub").Append(CRLF).Append(TAB).Append(CRLF)
				End If
			Next
		End If
	Next
End Sub

Public Sub NewClassNode (name As String, index As Int, parent As String, level As Int, displayRect As B4XRect) As classNode
	Dim t1 As classNode
	t1.Initialize
	t1.name = name
	t1.index = index
	t1.parent = parent
	t1.children.Initialize
	t1.level = level
	t1.displayRect = displayRect
	Return t1
End Sub