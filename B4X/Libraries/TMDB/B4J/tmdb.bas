B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Public apikey As String
	Private mCallBack As Object
	Private lang As String = "pl-PL"
	
	Public const POPULARITY_ASC As String = "popularity.asc"
	Public const POPULARITY_DESC As String = "popularity.desc"
	Public const VOTE_ASC As String = "vote.asc"
	Public const VOTE_DESC As String = "vote.desc"
	Public const REVENUE_ASC As String = "revenue.asc"
	Public const REVENUE_DESC As String = "revenue.desc"
End Sub



'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(key As String, CallBack As Object, language As String)
	mCallBack = CallBack
	apikey = key
	If language <>Null Then
		lang = language
	End If

End Sub

Sub PopularMovie(page As Int)
	Dim web As HttpJob
	web.Initialize("PopularMovie", Me)
	web.Download($"https://api.themoviedb.org/3/movie/popular?api_key=${apikey}&language=${lang}&page=${page}"$)
	
End Sub

Sub GetMovie(id As Int)
	Dim web As HttpJob
	web.Initialize("GetMovie", Me)
	web.Download($"https://api.themoviedb.org/3/movie/${id}?api_key=${apikey}&language=${lang}"$)
	
End Sub


Sub SearchMovie(page As Int,value As String)
	Dim web As HttpJob
	web.Initialize("SearchMovie", Me)
	web.Download($"https://api.themoviedb.org/3/search/movie?api_key=${apikey}&query=${value}$&language=${lang}&page=${page}&include_adult=True"$)
	
End Sub

Sub DiscoverMovie(page As Int, year As Int, sort As String)
	Dim web As HttpJob
	web.Initialize("DiscoverMovie", Me)
	web.Download($"https://api.themoviedb.org/3/discover/movie?api_key=${apikey}&language=${lang}&sort_by=${sort}&year=${year}&include_adult=true&include_video=false&page=${page}"$)
	
End Sub

Sub NowMovie(page As Int)
	Dim web As HttpJob
	web.Initialize("NowMovie", Me)
	web.Download($"https://api.themoviedb.org/3/movie/now_playing?api_key=${apikey}&language=${lang}&page=${page}"$)
	
End Sub


Sub JobDone(web As HttpJob)
	
	If web.Success Then
		If web.JobName = "NowMovie" Then
			Dim j As JSONParser
			j.Initialize(web.GetString)
			Dim l1a As Map = j.NextObject
			
			If SubExists(mCallBack, "NowMovie") Then
				CallSub2(mCallBack, "NowMovie", l1a)
			End If
		End If
		
		If web.JobName = "PopularMovie" Then
			Dim j As JSONParser
			j.Initialize(web.GetString)
			Dim l1 As Map = j.NextObject
			
			If SubExists(mCallBack, "PopularMovie") Then
				CallSub2(mCallBack, "PopularMovie", l1)
			End If
		End If
		
		If web.JobName = "DiscoverMovie" Then
			Dim j As JSONParser
			j.Initialize(web.GetString)
			Dim l1 As Map = j.NextObject
			
			If SubExists(mCallBack, "DiscoverMovie") Then
				CallSub2(mCallBack, "DiscoverMovie", l1)
			End If
		End If
		
		If web.JobName = "SearchMovie" Then
			Dim j As JSONParser
			j.Initialize(web.GetString)
			Dim l1 As Map = j.NextObject
			
			If SubExists(mCallBack, "SearchMovie") Then
				CallSub2(mCallBack, "SearchMovie", l1)
			End If
		End If
		
		If web.JobName = "TopMovie" Then
			Dim j As JSONParser
			j.Initialize(web.GetString)
			Dim l1 As Map = j.NextObject
			Dim jj As JSONGenerator
			jj.Initialize(l1)
			Log(jj.ToPrettyString(3))
			If SubExists(mCallBack, "TopMovie") Then
				CallSub2(mCallBack, "TopMovie", l1)
			End If
		End If
		
		If web.JobName = "GetMovie" Then
			Dim j As JSONParser
			j.Initialize(web.GetString)
			Dim l1 As Map = j.NextObject
			
			If SubExists(mCallBack, "GetMovie") Then
				CallSub2(mCallBack, "GetMovie", l1)
			End If
		End If
	Else
		Dim e As String = web.ErrorMessage
		Log(e)
		If SubExists(mCallBack, "TMDB_Error") Then
			CallSub3(mCallBack, "TMDB_Error", 400, CreateMap("message":e))
		End If
	End If
End Sub

