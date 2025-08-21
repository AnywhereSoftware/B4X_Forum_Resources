B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@
Sub Class_Globals	
	Private BANAno As BANano 'ignore
	Private mDraggableClass As String = "dragula-container"
	Private mIsContainerFunction As BANanoObject
	Private mMovesFunction As BANanoObject
	Private mAcceptsFunction As BANanoObject
	Private mInvalidFunction As BANanoObject
	Private mCopyFunction As BANanoObject
	Private mCopySortSource As Boolean = False
	Private mDirection As String = "vertical"
	Private mRevertOnSpill As Boolean = True
	Private mRemoveOnSpill As Boolean = False
	Private mMirrorContainer As BANanoObject
	Private mIgnoreInputTextSelection As Boolean = True
End Sub

' Initialize the Object.  Use the Dragula.Options instead.
Public Sub Initialize()
	mMirrorContainer.Initialize("document.body")
End Sub

' Set/Gets the class a container must have to be considered a Dragula container
' default = 'dragula-container'
public Sub getDraggableClass() As String
	Return mDraggableClass
End Sub

public Sub setDraggableClass(class As String)
	mDraggableClass = class
End Sub

' Set/Gets a function to check if it is a container of draggable objects.  
'
' By default, it checks if the DraggableClass is found as a class of the element.
'
' if you use the eventName_IsContainer() event, then this is automatically set
public Sub getIsContainerFunction() As BANanoObject
	Return mIsContainerFunction
End Sub

public Sub setIsContainerFunction(function As BANanoObject)
	mIsContainerFunction = function
End Sub

' Set/Gets a function which will be invoked whenever an element is clicked. If this method returns false, 
' a drag event won't begin, and the event won't be prevented either. 
' The handle element will be the original click target, which comes in handy to test if that element is an expected "drag handle".
'
' By default, returns true.
'
' if you use the eventName_IsContainer() event, then this is automatically set
public Sub getMovesFunction() As BANanoObject
	Return mMovesFunction
End Sub

public Sub setMovesFunction(function As BANanoObject)
	mMovesFunction = function
End Sub

' Set/Gets a function to check if an element can be dropped.
' It'll be called to make sure that an element el, that came from container source, can be dropped on container target before a sibling element. 
' The sibling can be null, which would mean that the element would be placed as the last element in the container. 
' Note that if options.copy is set to true, el will be set to the copy, instead of the originally dragged element.
'
' Also note that the position where a drag starts is always going to be a valid place where to drop the element, even if accepts returned false for all cases.
'
' By default, returns true.
'
' if you use the eventName_Accepts() event, then this is automatically set
public Sub getAcceptsFunction() As BANanoObject
	Return mAcceptsFunction
End Sub

public Sub setAcceptsFunction(function As BANanoObject)
	mAcceptsFunction = function
End Sub

' Sets/Gets a function which if invoked and returns true or false. 
' This method should return true for elements that shouldn't trigger a drag. The handle argument is the element that was clicked, 
' while el is the item that would be dragged. Here's the default implementation, which doesn't prevent any drags.
'
' By default, returns false (moving instead of copying)
'
' if you use the eventName_Invalid() event, then this is automatically set
public Sub getInvalidFunction() As BANanoObject
	Return mInvalidFunction
End Sub

public Sub setInvalidFunction(function As BANanoObject)
	mInvalidFunction = function
End Sub

' Sets/Gets a function which if invoked and returns true, the items will be copied rather than moved. 
'
' By default, returns false (moving instead of copying)
'
' if you use the eventName_Copy() event, then this is automatically set
public Sub getCopyFunction() As BANanoObject
	Return mCopyFunction
End Sub

public Sub setCopyFunction(function As BANanoObject)
	mCopyFunction = function
End Sub

' If copy returns true and copySortSource is true as well, users will be able to sort elements in copy-source containers.
'
' By default, returns false
public Sub getCopySortSource() As Boolean
	Return mCopySortSource
End Sub

public Sub setCopySortSource(b As Boolean)
	mCopySortSource = b
End Sub

' By default, spilling an element outside of any containers will move the element back to the drop position previewed by the feedback shadow. 
' Setting revertOnSpill to true will ensure elements dropped outside of any approved containers are moved back to the source element where the drag event began, 
' rather than stay at the drop position previewed by the feedback shadow.
public Sub getRevertOnSpill() As Boolean
	Return mRevertOnSpill
End Sub

public Sub setRevertOnSpill(b As Boolean)
	mRevertOnSpill = b
End Sub

' By default, spilling an element outside of any containers will move the element back to the drop position previewed by the feedback shadow. 
' Setting removeOnSpill to true will ensure elements dropped outside of any approved containers are removed from the DOM. 
' Note that remove events won't fire if copy is set to true.
public Sub getRemoveOnSpill() As Boolean
	Return mRemoveOnSpill
End Sub

public Sub setRemoveOnSpill(b As Boolean)
	mRemoveOnSpill = b
End Sub

' When an element is dropped onto a container, it'll be placed near the point where the mouse was released. 
' If the direction is 'vertical', the default value, the Y axis will be considered. Otherwise, if the direction is 'horizontal', the X axis will be considered.
public Sub getDirection() As String
	Return mDirection
End Sub

public Sub setDirection(direct As String)
	mDirection = direct
End Sub

' When this option is enabled, if the user clicks on an input element the drag won't start until their mouse pointer exits the input. 
' This translates into the user being able to select text in inputs contained inside draggable elements, and still drag the element 
' by moving their mouse outside of the input -- so you get the best of both worlds.
'
' This option is enabled by default. Turn it off by setting it to false. 
' If its disabled your users won't be able to select text in inputs within dragula containers with their mouse.
public Sub getIgnoreInputTextSelection() As Boolean
	Return mIgnoreInputTextSelection
End Sub

public Sub setIgnoreInputTextSelection(b As Boolean)
	mIgnoreInputTextSelection = b
End Sub

' Internal method
public Sub Build() As BANanoObject
	Dim m As Map
	m.Initialize
	m.Put("isContainer", mIsContainerFunction)
	m.Put("moves", mMovesFunction)
	m.Put("accepts", mAcceptsFunction)
	m.Put("invalid", mInvalidFunction)
	m.Put("copy", mCopyFunction)
	m.Put("copySortSource", mCopySortSource)
	m.Put("direction", mDirection)
	m.Put("revertOnSpill", mRevertOnSpill)
	m.Put("removeOnSpill", mRemoveOnSpill)
	m.Put("mirrorContainer", mMirrorContainer)
	m.Put("ignoreInputTextSelection", mIgnoreInputTextSelection)
	Return m
End Sub


