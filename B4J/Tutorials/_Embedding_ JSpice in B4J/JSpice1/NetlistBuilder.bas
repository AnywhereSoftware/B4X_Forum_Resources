B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Private builder As JavaObject
End Sub

Public Sub Initialize
	builder.InitializeNewInstance("org.knowm.jspice.netlist.NetlistBuilder", Null)
End Sub

Public Sub AddNetlistResistor (Id As String, Resistance As Double, Nodes() As String) As NetlistBuilder
	builder.RunMethod("addNetlistResistor", Array(Id, Resistance, Nodes))
	Return Me
End Sub

Public Sub AddNetlistDCCurrent (Id As String, Current As Double, Nodes() As String) As NetlistBuilder
	builder.RunMethod("addNetlistDCCurrent", Array(Id, Current, Nodes))
	Return Me
End Sub

'Returns Netlist
Public Sub Build As JavaObject
	Return builder.RunMethod("build", Null)
End Sub