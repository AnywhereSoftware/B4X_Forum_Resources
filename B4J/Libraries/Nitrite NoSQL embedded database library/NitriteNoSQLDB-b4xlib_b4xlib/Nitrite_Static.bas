B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module

'Requires Additional Jars
'<code>#AdditionalJar: nitrite\nitrite-3.4.3
'#AdditionalJar: nitrite\slf4j-api-1.7.30
'#AdditionalJar: nitrite\h2-mvstore-1.4.200
'#AdditionalJar: nitrite\jackson-core-2.12.1
'#AdditionalJar: nitrite\jackson-databind-2.12.1
'#AdditionalJar: nitrite\jackson-annotations-2.12.1
'#AdditionalJar: nitrite\objenesis-3.1
'#AdditionalJar: nitrite\podam-7.2.6.RELEASE</code>
Sub Process_Globals
'	Private fx As JFX
End Sub

'Provides a builder utility to create a Nitrite database instance.
Public Sub Builder As NitriteBuilder
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("org.dizitart.no2.Nitrite")
	Dim Wrapper As NitriteBuilder
	Wrapper.Initialize
	Wrapper.SetObject(Tjo1.RunMethod("builder",Null))
	Return Wrapper
End Sub