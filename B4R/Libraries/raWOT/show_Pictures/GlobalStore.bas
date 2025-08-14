B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=1.5
@EndOfDesignText@

'version 2.00
Sub Process_Globals
	'The data will be stored in this buffer.
	'Change its size if you encounter out of bounds errors.
	Private GlobalBuffer(256) As Byte 
	Private bc As ByteConverter
	Private mmSrcOffset, mmDestOffset, mmCount As UInt 'ignore
	'You can change the number of slots. You must update the next three lines.
	Public Slot0(), Slot1(), Slot2() As Byte
	Private slots() As Object = Array(Slot0, Slot1, Slot2)
	Private lengths(3) As Byte
End Sub

' Slot0 < slot2  => filebrowser

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
	B4R::ArrayByte* ab = b4r_globalstore::_globalbuffer;
	B4R::ArrayByte* arr = (B4R::ArrayByte*)B4R::Object::toPointer(o);
	arr->data = (Byte*)ab->data + b4r_globalstore::_mmsrcoffset;
	arr->length = b4r_globalstore::_mmcount;
}
void MemMove(B4R::Object* o) {
	B4R::ArrayByte* ab = b4r_globalstore::_globalbuffer;
	memmove((Byte*)ab->data + b4r_globalstore::_mmdestoffset, 
		(Byte*)ab->data + b4r_globalstore::_mmsrcoffset, b4r_globalstore::_mmcount);
}
#End If





