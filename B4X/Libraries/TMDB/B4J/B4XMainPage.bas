B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private ListView1 As ListView
	Private TMDB As tmdb
	Private ComboBox1 As ComboBox
	Private number As Int
	Private key As String = ""
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	ComboBox1.Items.AddAll(Array As String("Popular film","Details of the film","Search title: Rambo", "Discover film:TMDB.REVENUE_DESC","Discover film:TMDB.VOTE_ASC","Discover film:TMDB.POPULARITY_ASC", "Now watched"))
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	If key = "" Then
		xui.MsgboxAsync("TMDB key missing. Please complete the code with the key.", "Error")
		Return
	End If
	TMDB.Initialize(key, Me, "en-EN")
	Select number
		Case 0
			TMDB.PopularMovie(1)
		Case 1
			TMDB.GetMovie(649087)
		Case 2
			TMDB.SearchMovie(1,"rambo")
		Case 3
			TMDB.DiscoverMovie(1,2021, TMDB.REVENUE_DESC)
		Case 4
			TMDB.DiscoverMovie(1,2022, TMDB.VOTE_ASC)
		Case 5
			TMDB.DiscoverMovie(1,2022, TMDB.POPULARITY_ASC)
		Case 6
			TMDB.NowMovie(1)
				
			
	End Select
	
	ListView1.Items.Clear
End Sub

Private Sub ListView1_SelectedIndexChanged(Index As Int)
	
End Sub

Sub PopularMovie(value As Map)
		ListView1.Items.Clear
		Dim lista As List = value.Get("results")
		For Each r As Map In lista
			Dim opis As String = _
			$"Title: ${r.Get("title")}
			id film: ${r.Get("id")}
			For aduls: ${r.Get("adult")}
			Votes: ${r.Get("vote_count")}
			Rating: ${r.Get("vote_average")}
			Data: ${r.Get("release_date")}
			Description: ${r.Get("overview")}
			Image link: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("poster_path")}
			Link background: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("backdrop_path")}"$
		ListView1.Items.Add(opis)
	Next
End Sub

Sub NowMovie(value As Map)
	ListView1.Items.Clear
	Dim lista As List = value.Get("results")
	For Each r As Map In lista
		Dim opis As String = _
			$"Title: ${r.Get("title")}
			id film: ${r.Get("id")}
			For aduls: ${r.Get("adult")}
			Votes: ${r.Get("vote_count")}
			Rating: ${r.Get("vote_average")}
			Data: ${r.Get("release_date")}
			Description: ${r.Get("overview")}
			Image link: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("poster_path")}
			Link background: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("backdrop_path")}"$
		ListView1.Items.Add(opis)
	Next
End Sub


Sub DiscoverMovie(value As Map)
		ListView1.Items.Clear
		Dim lista As List = value.Get("results")
		For Each r As Map In lista
		Dim opis As String = _
			$"Title: ${r.Get("title")}
			id film: ${r.Get("id")}
			For aduls: ${r.Get("adult")}
			Votes: ${r.Get("vote_count")}
			Rating: ${r.Get("vote_average")}
			Data: ${r.Get("release_date")}
			Description: ${r.Get("overview")}
			Image link: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("poster_path")}
			Link background: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("backdrop_path")}"$
			ListView1.Items.Add(opis)
	Next
End Sub

Sub SearchMovie(value As Map)
		ListView1.Items.Clear
		Dim lista As List = value.Get("results")
		For Each r As Map In lista
		Dim opis As String = _
			$"Title: ${r.Get("title")}
			id film: ${r.Get("id")}
			For aduls: ${r.Get("adult")}
			Votes: ${r.Get("vote_count")}
			Rating: ${r.Get("vote_average")}
			Data: ${r.Get("release_date")}
			Description: ${r.Get("overview")}
			Image link: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("poster_path")}
			Link background: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("backdrop_path")}"$
			ListView1.Items.Add(opis)
		Next
End Sub


Sub GetMovie(value As Map)
	Dim r As Map = value
	Dim opis As String = _
			$"Title: ${r.Get("title")}
			Original title:${r.Get("original_title")}
			Length of film: ${r.Get("runtime")}
			id film: ${r.Get("id")}
			For aduls: ${r.Get("adult")}
			Votes: ${r.Get("vote_count")}
			Rating: ${r.Get("vote_average")}
			Data: ${r.Get("release_date")}
			Description: ${r.Get("overview")}
			Image link: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("poster_path")}
			Link background: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("backdrop_path")}"$
	ListView1.Items.Add(opis)
End Sub

Sub TopMovie(value As Map)
	Dim r As Map = value
	
	Dim opis As String = _
			$"Title: ${r.Get("title")}
			Original title:${r.Get("original_title")}
			Length of film: ${r.Get("runtime")}
			id film: ${r.Get("id")}
			For aduls: ${r.Get("adult")}
			Votes: ${r.Get("vote_count")}
			Rating: ${r.Get("vote_average")}
			Data: ${r.Get("release_date")}
			Description: ${r.Get("overview")}
			Image link: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("poster_path")}
			Link background: https://www.themoviedb.org/t/p/w300_and_h450_bestv2${r.Get("backdrop_path")}"$
	ListView1.Items.Add(opis)
End Sub


Sub TMDB_Error(code As Int, error As Map)
	Log(error.Get("message"))
End Sub

Private Sub ComboBox1_SelectedIndexChanged(Index As Int, Value As Object)
	number = Index
End Sub