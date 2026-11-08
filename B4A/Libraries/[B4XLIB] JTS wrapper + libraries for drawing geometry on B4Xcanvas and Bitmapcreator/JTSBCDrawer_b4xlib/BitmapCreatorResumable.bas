B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Class module
'
'Thin wrapper around BitmapCreator.DrawBitmapCreatorsAsync that isolates the
'BitmapReady event in its own class instance. This avoids the Wait For
'"last-write-wins" overwrite problem: each instance owns its own Me target,
'so events delivered to one instance never interfere with another.
'
'Each instance owns one BitmapCreator and represents one asynchronous draw.
'To draw concurrently, create several BCAsyncDrawer instances and await them
'with Wait For (rs) Complete on the caller side.
'

Sub Class_Globals
	Private mBC As BitmapCreator
End Sub

'Initializes the wrapper and creates a dedicated BitmapCreator of the given
'size. Each BCAsyncDrawer instance owns its own BitmapCreator, which is the
'guarantee that lets multiple instances draw concurrently without interfering.
'Typical usage:
'	Dim BCR As BitmapCreatorResumable
'	BCR.Initialize(width, height)
'	Dim lTasks As List
'	lTasks.Initialize
'	lTasks.Add(BCR.BC.AsyncDrawPath(Path, Brush, True, 0))
'	lTasks.Add(BCR.BC.AsyncDrawPath(Path, StrokeBrush, False, 2))
'	Wait For (BCR.DrawBitmapCreatorsAsync(lTasks)) Complete (result As bitmapcreator)
Public Sub Initialize(Width As Int, Height As Int)
	mBC.Initialize(Width, Height)
End Sub

'Asynchronously draws all the xDrawTasks on the underlying BitmapCreator and
'returns it once the BitmapReady event has fired. Returns a ResumableSub so
'the caller can await this single draw, or fan out several BCAsyncDrawer
'instances and await them all with Wait For (rs) Complete.
Public Sub DrawBitmapCreatorsAsync(xDrawTasks As List) As ResumableSub
	mBC.DrawBitmapCreatorsAsync(Me, "mBC", xDrawTasks)
'	Log("Wait for mBC_BitmapReady")
	Wait For mBC_BitmapReady (bmp As B4XBitmap)
	Return mBC
End Sub

'Returns the underlying BitmapCreator. The caller needs this to build the
'xDrawTasks (via AsyncDrawPath, AsyncDrawRect, etc.) that are later passed to
'DrawBitmapCreatorsAsync. Also useful after the async draw completes — for committing
'the bitmap, reading pixels, or doing further synchronous drawing
Public Sub getBC As BitmapCreator
	Return mBC
End Sub