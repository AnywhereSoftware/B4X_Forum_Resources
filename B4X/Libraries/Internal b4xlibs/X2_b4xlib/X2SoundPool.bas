B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
'Load sound files with AddSound and play sounds with PlaySound.
Sub Class_Globals
	Private sounds As Map
	Private mp As MediaPlayer
	#if B4J
	Private gmh As GameViewHelper
	#Else If B4i
	Private pool As GameView 'ignore
	#else if B4A
	Private pool As SoundPool
	#End If
	Public MuteSounds As Boolean
End Sub

Public Sub Initialize
	sounds.Initialize
	#if B4i
	pool.Initialize("", Null)
	#else if B4A
	pool.Initialize(4)
	mp.Initialize
	'set the default audio stream to MUSIC. This allows changing the sounds volume with the volume keys.
	Dim jo As JavaObject
	jo.InitializeContext
	jo.RunMethod("setVolumeControlStream", Array(3))
	#Else If B4J
	#End If
End Sub

Public Sub PlayMusic (Dir As String, FileName As String)
	If mp.IsInitialized Then mp.Stop
	#if B4J
	mp.Initialize("", File.GetUri(Dir, FileName))
	mp.CycleCount = -1
	mp.Play
	#Else If B4A
	mp.Load(Dir, FileName)
	mp.Looping = True
	mp.Play
	#Else If B4i
	mp.Initialize(Dir, FileName, "")
	mp.Looping = True
	mp.Play
	#End If
End Sub

Public Sub StopMusic
	If mp.IsInitialized Then mp.Stop
End Sub

'Loads a sound file and map it to the given name.
Public Sub AddSound (Name As String, Dir As String, FileName As String)
	Name = Name.ToLowerCase
	#if B4J
	sounds.Put(Name, gmh.LoadAudioClip(File.GetUri(Dir, FileName)))
	#Else If B4i
	pool.PrepareSoundEffect(Dir, FileName)
	sounds.Put(Name, Array As String(Dir, FileName))
	#else if B4A
	sounds.Put(Name, pool.Load(Dir, FileName))
	#End If
End Sub

'Plays the sound mapped to the given name.
Public Sub PlaySound (Name As String)
	PlaySound2(Name, 1)
End Sub

'Plays the sound mapped to the given name.
'Volume - 0 to 1.
Public Sub PlaySound2 (Name As String, Volume As Float)
	If MuteSounds Then Return
	Name = Name.ToLowerCase
	#if B4J
	gmh.PlayAudioClip(sounds.Get(Name), Volume)
	#else if B4i
	Dim s() As String = sounds.Get(Name)
	pool.PlaySoundEffect(s(0), s(1), Volume)
	#else if B4A
	pool.Play(sounds.Get(Name), Volume, Volume, 1, 0, 1)
	#End If
End Sub