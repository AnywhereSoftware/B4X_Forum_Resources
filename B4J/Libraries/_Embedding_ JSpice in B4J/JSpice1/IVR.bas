B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private netlist, netlistDCCurrent, netlistDCVoltage, NetlistResistor As JavaObject
	
End Sub

'initialize the Netlist object
Public Sub Initialize
	netlist.InitializeNewInstance("org.knowm.jspice.netlist.Netlist", Null)
End Sub

'id = id of the current source
'val = value of the DC current source eg 0.02A
'nodes() = array of string with the nodes between which the DC current source is connected
'a node  = "0" is a ground node
public Sub addNetlistDCCurrent (id As String, val As Double, nodes() As String) As IVR
	
'	netlistDCCurrent.InitializeNewInstance("org.knowm.jspice.netlist.NetlistDCCurrent", Array("a", val, Array As String("0", "4")))
	netlistDCCurrent.InitializeNewInstance("org.knowm.jspice.netlist.NetlistDCCurrent", Array(id, val, nodes))
	netlist.RunMethod("addNetListComponent", Array(netlistDCCurrent))
	Return Me
	
End Sub

'id = id of the DC voltage source
'val = value of the voltage source eg 10V
'nodes() = array of string with the nodes between which the DC voltage source is connected
'a node  = "0" is a ground node
public Sub addNetlistDCVoltage(id As String, val As Double, nodes() As String) As IVR
	
'	netlistDCVoltage.InitializeNewInstance("org.knowm.jspice.netlist.NetlistDCVoltage", Array("x", val, Array As String("2", "5")))
	netlistDCVoltage.InitializeNewInstance("org.knowm.jspice.netlist.NetlistDCVoltage", Array(id, val, nodes))
	netlist.RunMethod("addNetListComponent", Array(netlistDCVoltage))
	Return Me
	
End Sub

'id = id of the Resistor
'val = value of the resistor eg 100 Ohms
'nodes() = array of string with the nodes between which the resistor is connected
'a node  = "0" is a ground node
public Sub addNetlistResistor(id As String, val As Double, nodes() As String) As IVR
	
'	NetlistResistor.InitializeNewInstance("org.knowm.jspice.netlist.NetlistResistor", Array("R1", val, Array As String("5", "0")))
	NetlistResistor.InitializeNewInstance("org.knowm.jspice.netlist.NetlistResistor", Array(id, val, nodes))
	netlist.RunMethod("addNetListComponent", Array(NetlistResistor))
	Return Me
	
End Sub

'return the netlist so thst is can be passed on to jspice for simulatiln of the circuit
public Sub build() As JavaObject	

	Return netlist

End Sub

