B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
#Event: Drag(el as BANanoObject, source as BANanoObject)
#Event: DragEnd(el as BANanoObject)
#Event: Drop(el as BANanoObject, target as BANanoObject, source as BANanoObject, sibling as BANanoObject)
#Event: Cancel(el as BANanoObject, container as BANanoObject, source as BANanoObject)
#Event: Remove(el as BANanoObject, container as BANanoObject, source as BANanoObject)
#Event: Shadow(el as BANanoObject, container as BANanoObject, source as BANanoObject)
#Event: Over(el as BANanoObject, container as BANanoObject, source as BANanoObject)
#Event: Out(el as BANanoObject, container as BANanoObject, source as BANanoObject)
#Event: Cloned(clone as BANanoObject, original as BANanoObject, typ as BANanoObject)
' overrule default methods
#Event: IsContainer(el As BANanoObject) As Boolean
#Event: Moves(el As BANanoObject, source As BANanoObject, handle As BANanoObject, sibling As BANanoObject) As Boolean
#Event: Accepts(el As BANanoObject, target As BANanoObject, source As BANanoObject, sibling As BANanoObject) As Boolean
#Event: Invalid(el As BANanoObject, handle As BANanoObject)
#Event: Copy(el As BANanoObject, source As BANanoObject) As Boolean

Sub Class_Globals
	Private BANano As BANano 'ignore
	Private Drake As BANanoObject
	Public Options As DragulaOptions
	Private mCaller As Object 'ignore
	Private mEventName As String 'ignore	
End Sub

'Initializes the object. 
' 
' Has the following events:
' Drag, DragEnd, Drop, Cancel, Remove, Shadow, Over, Out, Cloned

' Has the following methods (used as events) to overrule the default methods:
' IsContainer, Moves, Accepts, Invalid, Copy
Public Sub Initialize(caller As Object, eventName As String)
	mCaller = caller
	mEventName = eventName.ToLowerCase
	Options.Initialize	
End Sub

' starts Dragula using the options you have set with Dragula.Options
public Sub Start()
	Dim el As BANanoObject
	Dim source As BANanoObject
	Dim target As BANanoObject
	Dim handle As BANanoObject
	Dim sibling As BANanoObject
	' set the defaults if you didn't specify them
	If SubExists(mCaller, mEventName & "_IsContainer") Then
		Options.IsContainerFunction = BANano.CallBack(mCaller, mEventName & "_IsContainer", Array(el))
	Else	
		Options.IsContainerFunction = BANano.CallBack(Me, "IsContainer", Array(el))
	End If
	If SubExists(mCaller, mEventName & "_Moves") Then
		Options.MovesFunction = BANano.CallBack(mCaller, mEventName & "_Moves", Array(el, source, handle, sibling))
	Else	
		Options.MovesFunction = BANano.CallBack(Me, "Moves", Array(el, source, handle, sibling))
	End If
	If SubExists(mCaller, mEventName & "_Accepts") Then
		Options.AcceptsFunction = BANano.CallBack(mCaller, mEventName & "_Accepts", Array(el, target, source, sibling))
	Else
		Options.AcceptsFunction = BANano.CallBack(Me, "Accepts", Array(el, target, source, sibling))
	End If
	If SubExists(mCaller, mEventName & "_Invalid") Then
		Options.InvalidFunction = BANano.CallBack(mCaller, mEventName & "_Invalid", Array(el, handle))
	Else	
		Options.InvalidFunction = BANano.CallBack(Me, "Invalid", Array(el, handle))
	End If
	If SubExists(mCaller, mEventName & "_Copy") Then
		Options.CopyFunction = BANano.CallBack(mCaller, mEventName & "_Copy", Array(el, handle))
	Else
		Options.CopyFunction = BANano.CallBack(Me, "Copy", Array(el, handle))
	End If
	
	Drake.Initialize2("dragula",Options.Build)
	
	Drake.RunMethod("on", Array("drag", BANano.CallBack(Me, "DrakeDrag", Null)))
	Drake.RunMethod("on", Array("dragend", BANano.CallBack(Me, "DrakeDragEnd", Null)))
	Drake.RunMethod("on", Array("drop", BANano.CallBack(Me, "DrakeDrop", Null)))
	Drake.RunMethod("on", Array("cancel", BANano.CallBack(Me, "DrakeCancel", Null)))
	Drake.RunMethod("on", Array("remove", BANano.CallBack(Me, "DrakeRemove", Null)))
	Drake.RunMethod("on", Array("shadow", BANano.CallBack(Me, "DrakeShadow", Null)))
	Drake.RunMethod("on", Array("over", BANano.CallBack(Me, "DrakeOver", Null)))
	Drake.RunMethod("on", Array("out", BANano.CallBack(Me, "DrakeOut", Null)))
	Drake.RunMethod("on", Array("cloned", BANano.CallBack(Me, "DrakeCloned", Null)))
End Sub

private Sub IsContainer(el As BANanoObject) As Boolean 'ignore
	Return el.GetField("classList").RunMethod("contains", Options.DraggableClass).Result
End Sub

private Sub Moves(el As BANanoObject, source As BANanoObject, handle As BANanoObject, sibling As BANanoObject) As Boolean 'ignore
	Return True
End Sub

private Sub Accepts(el As BANanoObject, target As BANanoObject, source As BANanoObject, sibling As BANanoObject) As Boolean 'ignore
	Return True
End Sub

private Sub Invalid(el As BANanoObject, handle As BANanoObject) As Boolean 'ignore
	Return False
End Sub

private Sub Copy(el As BANanoObject, source As BANanoObject) As Boolean 'ignore
	Return False
End Sub

private Sub DrakeDrag(el As BANanoObject, source As BANanoObject) 'ignore
	BANano.CallSub(mCaller, mEventName & "_drag", Array(el, source))
End Sub

private Sub DrakeEnd(el As BANanoObject) 'ignore
	BANano.CallSub(mCaller, mEventName & "_dragend", Array(el))
End Sub

private Sub DrakeDrop(el As BANanoObject, target As BANanoObject, source As BANanoObject, sibling As BANanoObject) 'ignore
	BANano.CallSub(mCaller, mEventName & "_drop", Array(el, target, source, sibling))
End Sub

private Sub DrakeCancel(el As BANanoObject, container As BANanoObject, source As BANanoObject) 'ignore
	BANano.CallSub(mCaller, mEventName & "_cancel", Array(el, container, source))
End Sub

private Sub DrakeRemove(el As BANanoObject, container As BANanoObject, source As BANanoObject) 'ignore
	BANano.CallSub(mCaller, mEventName & "_remove", Array(el, container, source))
End Sub

private Sub DrakeShadow(el As BANanoObject, container As BANanoObject, source As BANanoObject) 'ignore
	BANano.CallSub(mCaller, mEventName & "_shadow", Array(el, container, source))
End Sub

private Sub DrakeOver(el As BANanoObject, container As BANanoObject, source As BANanoObject) 'ignore
	BANano.CallSub(mCaller, mEventName & "_over", Array(el, container, source))
End Sub

private Sub DrakeOut(el As BANanoObject, container As BANanoObject, source As BANanoObject) 'ignore
	BANano.CallSub(mCaller, mEventName & "_out", Array(el, container, source))
End Sub

private Sub DrakeCloned(clone As BANanoObject, original As BANanoObject, typ As String) 'ignore
	BANano.CallSub(mCaller, mEventName & "_cloned", Array(clone, original, typ))
End Sub

' This property will be true whenever an element is being dragged.
public Sub IsDragging() As Boolean
	Return Drake.GetField("dragging").Result
End Sub

' Enter drag mode without a shadow. This method is most useful when providing complementary keyboard shortcuts to an existing drag and drop solution. 
' Even though a shadow won't be created at first, the user will get one as soon as they click on item and start dragging it around. 
' Note that if they click and drag something else, .end will be called before picking up the new item.
public Sub StartItem(Item As BANanoObject)
	Drake.RunMethod("start", Item)
End Sub

' Check if an element can be dragged
'
' Example:
' <code>
' Dim item As BANanoObject
' Item = BANano.GetElement("#SKLabel1".ToLowerCase).ToObject
' Log(Drake.CanMove(Item))
' </code>
public Sub CanMove(item As BANanoObject) As Boolean
	Return Drake.RunMethod("canMove", item).Result
End Sub

' Removes all drag and drop events used by dragula to manage drag and drop between the containers. 
' If .destroy is called while an element is being dragged, the drag will be effectively cancelled.
public Sub Destroy()
	Drake.RunMethod("destroy", Null)
End Sub

' Gracefully end the drag event as if using the last position marked by the preview shadow as the drop target. 
' The proper cancel or drop event will be fired, depending on whether the item was dropped back where it was originally 
' lifted from (which is essentially a no-op that's treated as a cancel event).
public Sub EndItem()
	Drake.RunMethod("end", Null)
End Sub

' If an element managed by drake is currently being dragged, this method will gracefully cancel the drag action. 
' You can also pass in revert at the method invocation level, effectively producing the same result as if revertOnSpill was true.
'
' Note that a "cancellation" will result in a cancel event only in the following scenarios.
'
' * revertOnSpill is true
' * Drop target (as previewed by the feedback shadow) is the source container and the item is dropped in the same position where it was originally dragged from
public Sub CancelItem(Revert As Boolean)
	Drake.RunMethod("cancel", Revert)
End Sub

' If an element managed by drake is currently being dragged, this method will gracefully remove it from the DOM.
public Sub Remove()
	Drake.RunMethod("remove", Null)
End Sub
