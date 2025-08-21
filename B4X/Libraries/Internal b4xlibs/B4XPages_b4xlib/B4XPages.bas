B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.85
@EndOfDesignText@
Sub Process_Globals
	Private mPM As Object
	Public Delegate As B4XPagesDelegator
	Public GlobalContext As Object
End Sub

'Tests whether B4XPagesManager was initialized.
'The common case where it will not be initialized is in B4A before the Main activity was created.
Public Sub IsInitialized As Boolean
	Return mPM Is B4XPagesManager
End Sub

'Returns the pages manager. Shouldn't be used in most cases.
Public Sub GetManager As B4XPagesManager
	Return mPM
End Sub

'Internal method. Don't call.
Public Sub InternalSetPagesManager(PM As Object)
	Delegate.Initialize
	mPM = PM
End Sub

'Returns the page instance. You should cast it to the correct type.
'Example:<code>
'Dim page2 As B4XPage2 = B4XPages.GetPage("Page2")</code>
Public Sub GetPage (Id As String) As Object
	Return GetManager.GetPage(Id)
End Sub

'Returns the page id from the page object.
Public Sub GetPageId (B4XPage As Object) As String
	Return GetManager.FindPIFromB4XPage(B4XPage).Id
End Sub

'Adds a new page. The first page will be displayed.
Public Sub AddPage (Id As String, B4XPage As Object)
	GetManager.AddPage(Id, B4XPage)
End Sub

'Adds a new page and immediately creates it. Usually the page is only created right before it is displayed.
Public Sub AddPageAndCreate (Id As String, B4XPage As Object)
	GetManager.AddPageAndCreate(Id, B4XPage)
End Sub

'Shows a page. In cases where the page is already in the stack:
'B4A - The page will be moved to the top of the stack.
'B4i - Pages above this page will be removed.
'B4J - Not relevant as multiple pages can be displayed.
Public Sub ShowPage (Id As String)
	GetManager.ShowPage(Id)
End Sub

'Clears the pages stack and shows the page.
'Useful for example after a log-in page where there is no reason to keep the log-in page on the stack.
Public Sub ShowPageAndRemovePreviousPages (Id As String)
	GetManager.ShowPageAndRemovePreviousPages (Id)
End Sub

'Closes the page. The page is not destroyed.
'In B4i, only the top page can be closed.
Public Sub ClosePage (B4XPage As Object)
	GetManager.ClosePage (B4XPage)
End Sub

'Sets the page title. Can be CSBuilder in B4A.
'Example: <code>B4XPages.SetTitle(Me, "New Title")</code>
Public Sub SetTitle (B4XPage As Object, Title As Object)
	GetManager.SetTitle(B4XPage, Title)
End Sub

'Returns the main page.
Public Sub MainPage As B4XMainPage
	Return GetManager.MainPage
End Sub

#If B4A
'Returns the platform specific container.
Public Sub GetNativeParent (B4XPage As Object) As Activity
#Else if B4J
'Returns the platform specific container.
Public Sub GetNativeParent (B4XPage As Object) As Form
#else if B4i
'Returns the platform specific container.
Public Sub GetNativeParent (B4XPage As Object) As Page
#end if
	Return GetManager.FindPIFromB4XPage(B4XPage).Parent.NativeType
End Sub

#if B4A
Public Sub AddMenuItem(B4XPage As Object, Title As Object) As B4AMenuItem
	Return GetManager.AddMenuItem(B4XPage, Title)
End Sub
#End If

