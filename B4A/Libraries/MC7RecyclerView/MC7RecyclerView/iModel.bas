B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
Sub Class_Globals
	Private mlist As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	mlist.Initialize
	mlist.Clear
	mlist.Add(CreateMap("Hello 1":"android.png"))
	mlist.Add(CreateMap("Hello 2":"bing.png"))
	mlist.Add(CreateMap("Hello 3":"dropbox.png"))
	mlist.Add(CreateMap("Hello 4":"facebook.png"))
	mlist.Add(CreateMap("Hello 5":"html-5.png"))
	mlist.Add(CreateMap("Hello 6":"instagram.png"))
	mlist.Add(CreateMap("Hello 7":"linkedin.png"))
	mlist.Add(CreateMap("Hello 8":"pinterest.png"))
	mlist.Add(CreateMap("Hello 9":"skype.png"))
	mlist.Add(CreateMap("Hello 10":"whatsapp.png"))
	mlist.Add(CreateMap("Hello 11":"wordpress.png"))
	mlist.Add(CreateMap("Hello 12":"youtube.png"))
	mlist.Add(CreateMap("Hello 13":"pinterest.png"))
	mlist.Add(CreateMap("Hello 14":"html-5.png"))
	mlist.Add(CreateMap("Hello 15":"facebook.png"))
	mlist.Add(CreateMap("Hello 16":"instagram.png"))
	mlist.Add(CreateMap("Hello 17":"skype.png"))
	mlist.Add(CreateMap("Hello 18":"bing.png"))
	mlist.Add(CreateMap("Hello 19":"dropbox.png"))
	mlist.Add(CreateMap("Hello 20":"android.png"))
End Sub

Public Sub getList As List
	Return mlist
End Sub

Public Sub getListSize As Int
	Return mlist.Size
End Sub

Public Sub getListObject(pos As Int) As Map
	Return mlist.Get(pos)
End Sub