B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Code Module
Sub Process_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
End Sub

Public Sub cga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("cga"))
	Return Wrapper
End Sub

Public Sub cif As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("cif"))
	Return Wrapper
End Sub

Public Sub ega As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("ega"))
	Return Wrapper
End Sub

Public Sub film As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("film"))
	Return Wrapper
End Sub

Public Sub FOUR_cif As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("FOUR_cif"))
	Return Wrapper
End Sub

Public Sub FOURk As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("FOURk"))
	Return Wrapper
End Sub

Public Sub FOURkdci As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("FOURkdci"))
	Return Wrapper
End Sub

Public Sub FOURkflat As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("FOURkflat"))
	Return Wrapper
End Sub

Public Sub FOURkscope As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("FOURkscope"))
	Return Wrapper
End Sub

Public Sub fwqvga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("fwqvga"))
	Return Wrapper
End Sub

Public Sub hd1080 As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("hd1080"))
	Return Wrapper
End Sub

Public Sub hd480 As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("hd480"))
	Return Wrapper
End Sub

Public Sub hd720 As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("hd720"))
	Return Wrapper
End Sub

Public Sub hqvga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("hqvga"))
	Return Wrapper
End Sub

Public Sub hsxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("hsxga"))
	Return Wrapper
End Sub

Public Sub hvga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("hvga"))
	Return Wrapper
End Sub

Public Sub nhd As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("nhd"))
	Return Wrapper
End Sub

Public Sub ntsc As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("ntsc"))
	Return Wrapper
End Sub

Public Sub ntsc_film As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("ntsc_film"))
	Return Wrapper
End Sub

Public Sub pal As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("pal"))
	Return Wrapper
End Sub

Public Sub qcif As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("qcif"))
	Return Wrapper
End Sub

Public Sub qhd As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("qhd"))
	Return Wrapper
End Sub

Public Sub qntsc As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("qntsc"))
	Return Wrapper
End Sub

Public Sub qpal As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("qpal"))
	Return Wrapper
End Sub

Public Sub qqvga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("qqvga"))
	Return Wrapper
End Sub

Public Sub qsxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("qsxga"))
	Return Wrapper
End Sub

Public Sub qvga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("qvga"))
	Return Wrapper
End Sub

Public Sub qxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("qxga"))
	Return Wrapper
End Sub

Public Sub SIXTEEN_cif As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("SIXTEEN_cif"))
	Return Wrapper
End Sub

Public Sub sntsc As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("sntsc"))
	Return Wrapper
End Sub

Public Sub spal As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("spal"))
	Return Wrapper
End Sub

Public Sub sqcif As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("sqcif"))
	Return Wrapper
End Sub

Public Sub svga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("svga"))
	Return Wrapper
End Sub

Public Sub sxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("sxga"))
	Return Wrapper
End Sub

Public Sub TWOk As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("TWOk"))
	Return Wrapper
End Sub

Public Sub TWOkdci As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("TWOkdci"))
	Return Wrapper
End Sub

Public Sub TWOkflat As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("TWOkflat"))
	Return Wrapper
End Sub

Public Sub TWOkscope As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("TWOkscope"))
	Return Wrapper
End Sub

Public Sub uhd2160 As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("uhd2160"))
	Return Wrapper
End Sub

Public Sub uhd4320 As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("uhd4320"))
	Return Wrapper
End Sub

Public Sub uxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("uxga"))
	Return Wrapper
End Sub

Public Sub vga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("vga"))
	Return Wrapper
End Sub

Public Sub whsxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("whsxga"))
	Return Wrapper
End Sub

Public Sub whuxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("whuxga"))
	Return Wrapper
End Sub

Public Sub woxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("woxga"))
	Return Wrapper
End Sub

Public Sub wqsxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("wqsxga"))
	Return Wrapper
End Sub

Public Sub wquxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("wquxga"))
	Return Wrapper
End Sub

Public Sub wqvga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("wqvga"))
	Return Wrapper
End Sub

Public Sub wsxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("wsxga"))
	Return Wrapper
End Sub

Public Sub wuxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("wuxga"))
	Return Wrapper
End Sub

Public Sub wvga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("wvga"))
	Return Wrapper
End Sub

Public Sub wxga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("wxga"))
	Return Wrapper
End Sub

Public Sub xga As VideoSize
	Dim Wrapper As VideoSize
	Wrapper.Initialize
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("ws.schild.jave.info.VideoSize")
	Wrapper.SetObject(Tjo.GetField("xga"))
	Return Wrapper
End Sub

Public Sub New_VideoSize(Width As Int, Height As Int) As VideoSize
	Dim VS As VideoSize
	VS.Initialize
	VS.Create(Width,Height)
	Return VS
End Sub