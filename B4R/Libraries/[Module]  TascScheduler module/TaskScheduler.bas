B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.5
@EndOfDesignText@
'including GlobalStore version 2.00
public  Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Private TaskMax As Byte = 14
	Type TTask(Period As ULong, Watchdog As Long, Tag As Byte, Enabled As bool)	
	Type TTask2(Shouldrun As bool, Running As bool, msPostRun As ULong, msTaskSv As ULong)
	Type Ttaskstat(Mini As ULong, med As ULong, Maxi As ULong, Nb As ULong)	

	Public Task(15) As TTask
	Private Task2(15) As TTask2
	Private TaskStatD(15) As Ttaskstat		'check of each task duration
	Private TaskStatL(15) As Ttaskstat		'check of delay between launchs of each task	
	Private SchStatD As Ttaskstat			' check of Scheduler duration
	Private SchStatL As Ttaskstat			' check of delay between Scheduler cycles
	Private	statenable As bool = False		
	Private msstatstart As ULong 
	Private msSchSv As ULong
	'*************************************************************************************
	'from GlobalStore module v2.00
	'The data will be stored in this buffer.
	'Change its size if you encounter out of bounds errors.
	Private GlobalBuffer(200) As Byte
	Private bc As ByteConverter
	Private mmSrcOffset, mmDestOffset, mmCount As UInt 'ignore
	'You can change the number of slots. You must update the next three lines.
	Public Slot0(), Slot1(), Slot2(), Slot3(), Slot4(), Slot5(), Slot6(), Slot7(), Slot8(), Slot9(), Slot10(), Slot11(), Slot12(), Slot13(), Slot14()As Byte
	Private slots() As Object = Array(Slot0, Slot1, Slot2, Slot3, Slot4,Slot5, Slot6, Slot7, Slot8, Slot9,Slot10, Slot11, Slot12, Slot13, Slot14)
	Private lengths(15) As Byte
End Sub
public  Sub initialize(nb As Byte)
	'tasks basic init: no period, no watchdog, ready to run after a change Enabled=True
	If nb < TaskMax Then TaskMax = nb
	For i = 0 To TaskMax
		Task(i).Period=0 : Task(i).Watchdog=0 : Task(i).tag=0 : Task(i).Enabled = False 
		Task2(i).Shouldrun=False: Task2(i).Running = False : Task2(i).msPostRun=Millis
	Next
	statReset
	CallSubPlus("Scheduler",1,0)
End Sub
private Sub Scheduler(tag As Byte)
'	Log("scheduler => Run")
	If statenable = True  Then statSunderRun(Millis) Else msSchSv = Millis
	For i = 0 To TaskMax
		'only if activce task
		If Task(i).Enabled = True Then
			'case Task Delay
			If Task(i).Period+Task2(i).msPostRun <= msSchSv  Then Task2(i).Shouldrun = True
			'case Task Watchdog
			If Task(i).Watchdog >0 Then
				If Task(i).Watchdog +Task2(i).msPostRun <= msSchSv Then
					Task(i).Tag = 255
					Task2(i).shouldrun = True
				End If
			End If
			' case Shouldrun = true => we run Tack
			If (Task2(i).shouldrun = True) And (Task2(i).running = False) Then
				TaskRun(i)
			End If
		End If
	Next
	If statenable = True  Then statSDuration(Millis) Else msSchSv = Millis
	' end of "task_check_and_run". we will restast after 1ms (to give time to external tasks)
	CallSubPlus("Scheduler",1,0)
	
End Sub

private Sub statTDuration(i As Byte, ms As ULong)
	'case stat on task duration
	Dim duration As ULong = ms - Task2(i).msTaskSv 'task duration
	If duration < TaskStatD(i).Mini Then TaskStatD(i).Mini = duration
	If duration > TaskStatD(i).Maxi Then TaskStatD(i).Maxi = duration
	TaskStatD(i).med= ((TaskStatD(i).med * TaskStatD(i).Nb)+duration)/(TaskStatD(i).nb+1)
	TaskStatD(i).nb = TaskStatD(i).nb + 1
	Task2(i).msTaskSv = ms		'time of end of task
End Sub
private Sub statTunderRun(i As Byte, ms As ULong)
	'case stat on task duration
	Dim duration As ULong = ms - Task2(i).msTaskSv 'task duration
	If duration < TaskStatL(i).Mini Then TaskStatL(i).Mini = duration
	If duration > TaskStatL(i).Maxi Then TaskStatL(i).Maxi = duration
	TaskStatL(i).med= ((TaskStatL(i).med * TaskStatL(i).Nb)+duration)/(TaskStatL(i).nb+1)
	TaskStatL(i).nb = TaskStatL(i).nb + 1
	Task2(i).msTaskSv = ms 'time at start of task
End Sub
private Sub statSDuration(ms As ULong)
	'case stat on task duration
	Dim duration As ULong = ms - msSchSv 'task duration
	If duration < SchStatD.Mini Then SchStatD.Mini = duration
	If duration > SchStatD.Maxi Then SchStatD.Maxi = duration
	SchStatD.med= ((SchStatD.med * SchStatD.Nb)+duration)/(SchStatD.nb+1)
	SchStatD.nb = SchStatD.nb + 1
	msSchSv = ms		'time of end of task
End Sub
private Sub statSunderRun(ms As ULong)
	'case stat on task duration
	Dim duration As ULong = ms - msSchSv 'task duration
	If duration < SchStatL.Mini Then SchStatL.Mini = duration
	If duration > SchStatL.Maxi Then SchStatL.Maxi = duration
	SchStatL.med= ((SchStatL.med * SchStatL.Nb)+duration)/(SchStatL.nb+1)
	SchStatL.nb = SchStatL.nb + 1
	msSchSv = ms 'time at start of task
	If  ms-msstatstart > 15000 Then CallSubPlus("statlog",0,0)
End Sub
private  Sub StatLog(Tag As Byte)
'	Log("task is divided in 3 steps to avoid blocking thread")
	statenable = False
	Select Tag
	Case 0	
	  Log(" ")
	  For i = 0 To 7
		If Task(i).enabled Then
			Log("task",i," duration  : mini=",TaskStatD(I).Mini," med =",TaskStatD(I).med," Maxi=",TaskStatD(I).Maxi," Nb run =",TaskStatD(I).nb)
			Log("task",i," WaitForRun: mini=",TaskStatL(I).Mini," med =",TaskStatL(I).med," Maxi=",TaskStatL(I).Maxi," Nb run =",TaskStatL(I).nb)
		End If
	  Next
	  CallSubPlus("statlog",0,1)
	Case 1
	  For i = 8 To TaskMax
		If Task(i).enabled Then
			Log("task",i," duration  : mini=",TaskStatD(I).Mini," med =",TaskStatD(I).med," Maxi=",TaskStatD(I).Maxi," Nb run =",TaskStatD(I).nb)
			Log("task",i," WaitForRun: mini=",TaskStatL(I).Mini," med =",TaskStatL(I).med," Maxi=",TaskStatL(I).Maxi," Nb run =",TaskStatL(I).nb)
		End If
	  Next
	  CallSubPlus("statlog",0,2)
	Case 2		
	  Log("Scheduler duration: mini=",SchStatD.Mini," med =",SchStatD.med," Maxi=",SchStatD.Maxi," Nb run =",SchStatD.nb)
	  Log("Scheduler underRun: mini=",SchStatL.Mini," med =",SchStatL.med," Maxi=",SchStatL.Maxi," Nb run =",SchStatL.nb)
	  statReset
	  statenable = True
	End Select
End Sub
private Sub statReset
	For i = 0 To TaskMax
		TaskStatD(i).mini=0xFFFFFFFF: TaskStatD(i).med=0: TaskStatD(i).Maxi=0: TaskStatD(i).Nb=0
		TaskStatL(i).mini=0xFFFFFFFF: TaskStatL(i).med=0: TaskStatL(i).Maxi=0: TaskStatL(i).Nb=0
	Next
	msstatstart = Millis
	SchStatD.mini=0xFFFFFFFF: SchStatD.med=0: SchStatD.Maxi=0: SchStatD.Nb=0
	SchStatL.mini=0xFFFFFFFF: SchStatL.med=0: SchStatL.Maxi=0: SchStatL.Nb=0
End Sub
public  Sub statStart
	statReset
	For i = 0 To TaskMax
		Task2(i).msTaskSv = Millis
	Next
	statenable = True
End Sub
public  Sub statStop
	statenable = False
End Sub

private Sub TaskRun(tasc As Byte)
	' Log("runtasc: ",Tasc)
	Select tasc
		Case 0: 	CallSubPlus("Task00",0,tasc)
		Case 1: 	CallSubPlus("Task01",0,tasc)
		Case 2:		CallSubPlus("Task02",0,tasc)
		Case 3:		CallSubPlus("Task03",0,tasc)
		Case 4:		CallSubPlus("Task04",0,tasc)
		Case 5:		CallSubPlus("Task05",0,tasc)
		Case 6:		CallSubPlus("Task06",0,tasc)
		Case 7:		CallSubPlus("Task07",0,tasc)
		Case 8:		CallSubPlus("Task08",0,tasc)
		Case 9:		CallSubPlus("Task09",0,tasc)
		Case 10:	CallSubPlus("Task10",0,tasc)
		Case 11:	CallSubPlus("Task11",0,tasc)
		Case 12:	CallSubPlus("Task12",0,tasc)
		Case 13:	CallSubPlus("Task13",0,tasc)
		Case 14:	CallSubPlus("Task14",0,tasc)
	End Select
End Sub

private Sub task00(i As Byte)
	TaskRunAV(i)
	Main.Task00(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task01(i As Byte)
	TaskRunAV(i)
	Main.Task01(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task02(i As Byte)
	TaskRunAV(i)
	Main.Task02(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task03(i As Byte)
	TaskRunAV(i)
	Main.Task03(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task04(i As Byte)
	TaskRunAV(i)
	Main.Task04(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task05(i As Byte)
	TaskRunAV(i)
	Main.Task05(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task06(i As Byte)
	TaskRunAV(i)
	Main.Task06(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task07(i As Byte)
	TaskRunAV(i)
	Main.Task07(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task08(i As Byte)
	TaskRunAV(i)
	Main.Task08(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task09(i As Byte)
	TaskRunAV(i)
	Main.Task09(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task10(i As Byte)
	TaskRunAV(i)
	Main.Task10(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task11(i As Byte)
	TaskRunAV(i)
	Main.Task11(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task12(i As Byte)
	TaskRunAV(i)
	Main.Task12(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task13(i As Byte)
	TaskRunAV(i)
	Main.Task13(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub task14(i As Byte)
	TaskRunAV(i)
	Main.Task14(Task(i).tag)
	TaskRunAP(i)
End Sub
private Sub TaskRunAV(i As Byte)
	Task2(i).running = True
	Task2(i).Shouldrun = False
	If statenable = True Then statTunderRun(i,Millis)
	Task2(i).msPostRun = Millis
End Sub
private Sub TaskRunAP(i As Byte)
	If statenable = True Then statTDuration(i,Millis)
	Task2(i).running = False
End Sub

' from GlobalStore module, to store array of byte for tasks if needed

Public Sub Put(slot As Int, Value() As Byte)
	Dim index As Int = 0
	For i = 0 To slot - 1
		index = index + lengths(i)
	Next
	Dim ToCopy As Int = 0
	For i = slot + 1 To lengths.Length - 1
		ToCopy = ToCopy + lengths(i)
	Next
	If lengths(slot) <> Value.Length Then
		mmSrcOffset = index + lengths(slot)
		mmDestOffset = index + Value.Length
		mmCount = ToCopy
		RunNative("MemMove", Null)
	End If
	Dim b As Byte = GlobalBuffer(index + Value.Length + ToCopy - 1) 'ignore (check for out of bounds)
	bc.ArrayCopy2(Value, 0, GlobalBuffer, index, Value.Length)
	lengths(slot) = Value.Length
	mmSrcOffset = 0
	For index = 0 To slots.Length - 1
		If index > 0 Then mmSrcOffset = mmSrcOffset + lengths(index - 1)
		mmCount = lengths(index)
		RunNative("SetSlot", slots(index))
	Next
End Sub
#if C
void SetSlot(B4R::Object* o) {
	B4R::ArrayByte* ab = b4r_taskscheduler::_globalbuffer;
	B4R::ArrayByte* arr = (B4R::ArrayByte*)B4R::Object::toPointer(o);
	arr->data = (Byte*)ab->data + b4r_taskscheduler::_mmsrcoffset;
	arr->length = b4r_taskscheduler::_mmcount;
}
void MemMove(B4R::Object* o) {
	B4R::ArrayByte* ab = b4r_taskscheduler::_globalbuffer;
	memmove((Byte*)ab->data + b4r_taskscheduler::_mmdestoffset, 
		(Byte*)ab->data + b4r_taskscheduler::_mmsrcoffset, b4r_taskscheduler::_mmcount);
}
#End If
