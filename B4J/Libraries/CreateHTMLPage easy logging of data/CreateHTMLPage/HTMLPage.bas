B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals

	Private fx As JFX
	Private Elements As List
	Private mHeader As String
	Private mFilePath As String = File.DirTemp
	Private mFileName As String = "CreateHTMLPage.html"
	Private mShowHTML As Boolean
	Private mAddlCss As String
	Private mIgnoreCss As Boolean
	Private mDontShowClose	As Boolean
	Private mSyncWith() As Object
	Private mSyncClass As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize As HTMLPage
	Elements.Initialize
	Return Me
End Sub

'HTMLPage_Table
'Each table is added in a div which has a class of tablediv. You an add more classes with the DivClass method
'Each table has a class of pagetable-{index} where index is the order that the tables were added starting from 0.
'You can add more classes with the Class method.
'You can add an ID with the ID method.
'Each cell in the column has a class data-cn where n refers to the data column index (data only the index column is excluded and
'has it's own class 'row-num')
Public Sub AddTable As HTMLPage_Table
	Dim Count As Int = 0
	For Each E As Object In Elements
		If E Is HTMLPage_Table Then Count = Count + 1
	Next
	Dim Table As HTMLPage_Table
	Table.Initialize(Count)
	Elements.add(Table)
	Return Table
End Sub

'Add a div to the page
Public Sub AddDiv As HTMLPage_Div
	Dim Div As HTMLPage_Div
	Div.Initialize
	Elements.Add(Div)
	Return Div
End Sub

'Additional CSS for the page.
Public Sub CSS(AddlCss As String) As HTMLPage
	mAddlCss = AddlCss
	Return Me
End Sub

'Adds a line break to the page.
Public Sub AddBr As HTMLPage_BR
	Dim BR As HTMLPage_BR
	BR.Initialize
	Elements.Add(BR)
	Return BR
End Sub

'Clear all the page settings
Public Sub Clear
	Elements.Clear
	mHeader = ""
	ResetUsedCSSFlags
	mAddlCss = ""
	mShowHTML = False
	mFilePath = File.DirTemp
	mFileName = "CreateHTMLPage.html"
	mIgnoreCss = False
	Dim mSyncWith() As Object
End Sub

Private Sub ResetUsedCSSFlags
	HTMLPage_Static.DivDefaultCSSUsed = False
	HTMLPage_Static.TableDefaultCSSUsed = False
End Sub

'Doesn't apply the default CSS to Objects
Public Sub DontGenerateCSS As HTMLPage
	mIgnoreCss = True
	Return Me
End Sub

'Add a header block to the HTML Page
Public Sub Header(tHeader As String) As HTMLPage
	mHeader = tHeader
	Return Me
End Sub

'Show the generated HTML on the page
Public Sub ShowHTML(Show As Boolean) As HTMLPage
	mShowHTML = Show
	Return Me
End Sub

'Set a filepath and file name for the created file.
Public Sub FileName(tFilePath As String,tFileName As String) As HTMLPage
	mFilePath = tFilePath
	mFileName = tFileName
	Return Me
End Sub

Public Sub DontShowClose As HTMLPage
	mDontShowClose = True
	Return Me
End Sub

'Requires an array of the table objects you want to scroll and the class assigned as 
'DivClass on the tables which must be the same on all tables to be scrolled.
Public Sub SyncScroll(With() As Object,AssignedClass As String) As HTMLPage
	mSyncWith = With
	mSyncClass = AssignedClass
	For Each Tbl As Object In mSyncWith
		CallSub(Tbl,"SyncRequired")
	Next
	Return Me
End Sub

'Get the generated HTML
Public Sub GetHTML As String
	Dim SB As StringBuilder
	SB.Initialize
	Dim FilterHits As Boolean
	
	SB.Append($"<!DOCTYPE html>
"$)
	
	If mHeader <> "" Then
		SB.Append($"<head>
	${mHeader}
</head>
"$)
	End If
	
	If mShowHTML Then
		SB.Append("<body onload= setTa();>")
	Else
		SB.Append("<body>")
	End If
	
	SB.Append(CRLF)
	SB.Append($"<div id="container" class="container">"$)
	SB.Append(CRLF)
	
	Dim CSSSB As StringBuilder
	CSSSB.Initialize
	For Each Element As Object In Elements
		If Element Is HTMLPage_Table And CallSub(Element,"GetFilterHits") Then
			FilterHits = True
		End If
		
		SB.Append(CallSub(Element,"getHTML"))
		
		If mIgnoreCss = False And CallSub(Element,"IgnoreCSS") = False Then
			CSSSB.Append(CallSub(Element,"DefaultCss"))
			If Element Is HTMLPage_Table And Elements.Size = 1 And CallSub(Element,"HasTitle") And mAddlCss.Contains(".tablediv{width:fit-content") = False Then
				CSSSB.Append($"${TAB}.tablediv{width:fit-content;}"$)
			End If
		End If
	Next
	
	If mDontShowClose = False Then
		SB.Append($"<button id="btnClose" Type="button"
	onclick="window.open('', '_self', ''); window.close();">Close</button>
"$)
	End If
	
	SB.Append(CRLF)
	SB.Append("</div>")
	
	SB.Append(CRLF)
	
	If mAddlCss <> "" Then
		CSSSB.Append(CRLF)
		CSSSB.Append($"/* Additional CSS */"$)
		CSSSB.Append(CRLF)
		CSSSB.Append(mAddlCss)
	End If
	
	If FilterHits Then
		CSSSB.Append(".nohit{display:none;}")
	End If
	
	If CSSSB.Length > 0 Then
		SB.Append($"<style>
	${CSSSB.ToString}
</style>
"$)
	End If
	
	Dim ScriptAdded As Boolean
	
	If mShowHTML Then
		Dim Code As String = $"${SB.ToString}
</body>
</html>"$
		SB.Append($"<textarea id="ta1" readonly>"$)
		SB.Append(Code)
		SB.Append("</textarea>")
		SB.Append($"<script>
		function setTa(){
		const elem = document.getElementById("ta1")
		elem.style.width = '50%';	
		elem.style.height = elem.scrollHeight + "px"; 
		}"$)
		ScriptAdded = True
	End If
	
	If FilterHits Then
		If ScriptAdded = False Then
			SB.Append("<script>")
			SB.Append(CRLF)
			ScriptAdded = True
		End If
		
		SB.Append($"function filterHits(tableclass){
			const tableArr = document.getElementsByClassName(tableclass);
			if (!tableArr.length){return};
			const table = tableArr[0];
			const hitElements = table.getElementsByClassName("xnohit");
			// Hide elements marked in the code as no hit
			if(hitElements.length){
			 	while (hitElements.length) {
   					 hitElements[0].className = "nohit";
  				}
			} else {
				const nohitElements = table.getElementsByClassName("nohit");
				// Show all elements
				while (nohitElements.length) {
   				 	nohitElements[0].className = "xnohit";
  				}
			}
		}"$)
	End If
	
	If mSyncWith.Length > 1 Then
		If ScriptAdded = False Then
			SB.Append("<script>")
			SB.Append(CRLF)
			ScriptAdded = True
		End If
Log(mSyncClass)
		SB.Append($"
		function syncScroll(sourceElement) {
			console.log(sourceElement.className);
		  	const elements = document.getElementsByClassName('${mSyncClass}');
			console.log(elements.length);
			for(let i = 0;i < elements.length; i++){
				if(elements[i] == sourceElement) {continue;}
				elements[i].scrollTop = sourceElement.scrollTop;
			}
//  If (phoneFaceId=="phoneface1") {
//    face2.scrollTop = face1.scrollTop;
//  }
//  Else {
//    face1.scrollTop = face2.scrollTop;
//  }
}
"$)
		
		
		
	End If


	If ScriptAdded Then
		SB.Append($"
</script>
"$)
	End If
	
	SB.Append($"</body>
"$)
	SB.Append($"</html>
"$)

	ResetUsedCSSFlags
	
	Return SB.ToString
End Sub

'Show the page in the default exteral browser
Public Sub ShowPage
	File.WriteString(mFilePath,mFileName,GetHTML)
	fx.ShowExternalDocument(File.GetUri(mFilePath,mFileName))
End Sub

