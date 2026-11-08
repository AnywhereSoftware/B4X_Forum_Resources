Type=Class
ModulesStructureVersion=1
Version=10.2
@EndOfDesignText@
' Impulse Tracker 2 player (port of it2play by 8bitbubsy).
Sub Class_Globals
  ' Structures 
  Type it2play_pattern_t(Rows As Int,PackedData() As Byte,PackedData_o As Int,Idx As Int)
  Type it2play_envNode_t(Magnitude As Byte,Tick As Int,Idx As Int)
  Type it2play_env_t(Flags As Short,Num As Short,LoopBegin As Short,LoopEnd As Short,SustainLoopBegin As Short,SustainLoopEnd As Short,NodePoints(25) As it2play_envNode_t)
  Type it2play_instrument_t(DOSFilename As String,NNA As Short,DCT As Short,DCA As Short,FadeOut As Int,PitchPanSep As Short,PitchPanCenter As Short,GlobVol As Short,DefPan As Short,RandVol As Short,RandPan As Short,InstrumentName As String,FilterCutoff As Short,FilterResonance As Short,MIDIChn As Short,MIDIProg As Short,MIDIBank As Int,SmpNoteTable(120) As Int,VolEnv As it2play_env_t,PanEnv As it2play_env_t,PitchEnv As it2play_env_t,Idx As Int)
  Type it2play_sample_t(DOSFilename As String,GlobVol As Short,Flags As Short,Vol As Short,SampleName As String,Cvt As Short,DefPan As Short,Length As Long,LoopBegin As Long,LoopEnd As Long,C5Speed As Long,SustainLoopBegin As Long,SustainLoopEnd As Long,OffsetInFile As Long,AutoVibratoSpeed As Short,AutoVibratoDepth As Short,AutoVibratoRate As Short,AutoVibratoWaveform As Short,Data8() As Byte,Data16() As Short,DataR8() As Byte,DataR16() As Short,Idx As Int)
  Type it2play_hostChn_t(Flags As Int,NotePackMask As Short,RawNote As Short,Ins As Short,RawVolColumn As Short,Cmd As Short,CmdVal As Short,OldCmd As Short,OldCmdVal As Short,VolCmd As Short,VolCmdVal As Short,MIDIChn As Short,MIDIProg As Short,TranslatedNote As Short,Smp As Short,EfxMem_DKL As Short,EfxMem_EFG As Short,EfxMem_O As Short,EfxMem_I As Short,EfxMem_J As Short,EfxMem_N As Short,EfxMem_P As Short,EfxMem_Q As Short,EfxMem_T As Short,EfxMem_S As Short,EfxMem_W As Short,EfxMem_G_Compat As Short,EfxMem_SFx As Short,HighSmpOffs As Short,HostChnNum As Short,VolSet As Short,SlaveChnPtr As it2play_slaveChn_t,PattLoopStartRow As Short,PattLoopCount As Short,PanbrelloWaveform As Short,PanbrelloPos As Short,PanbrelloDepth As Short,PanbrelloSpeed As Short,LastPanbrelloData As Short,LastVibratoData As Byte,LastTremoloData As Byte,ChnPan As Short,ChnVol As Short,VolSlideDelta As Byte,TremorCount As Short,TremorOnOff As Short,RetrigCount As Short,PortaFreq As Int,VibratoWaveform As Short,VibratoPos As Short,VibratoDepth As Short,VibratoSpeed As Short,TremoloWaveform As Short,TremoloPos As Short,TremoloDepth As Short,TremoloSpeed As Short,MiscEfxData(16) As Byte,Idx As Int)
  Type it2play_envState_t(Value As Int,Delta As Int,Tick As Short,CurNode As Short,NextTick As Short)
  Type it2play_slaveChn_t(SmpIs16Bit As Boolean,Flags As Int,LoopMode As Short,LoopDirection As Short,Frequency As Int,FrequencySet As Int,AutoVibratoPos As Short,AutoVibratoDepth As Int,FinalVol128 As Short,Vol As Short,VolSet As Short,ChnVol As Short,SmpVol As Short,FinalPan As Short,FadeOut As Int,DCT As Short,DCA As Short,Pan As Short,PanSet As Short,InsPtr As it2play_instrument_t,SmpPtr As it2play_sample_t,Note As Short,Ins As Short,Smp As Short,HostChnPtr As it2play_hostChn_t,HostChnNum As Short,NNA As Short,MIDIChn As Short,MIDIProg As Short,MIDIBank As Int,LoopBegin As Int,LoopEnd As Int,Frac32 As Long,FinalVol32768 As Int,SamplingPosition As Int,VolEnvState As it2play_envState_t,PanEnvState As it2play_envState_t,PitchEnvState As it2play_envState_t,Delta32 As Long,fOldSamples(4) As Float,fFiltera As Float,fFilterb As Float,fFilterc As Float,HasLooped As Boolean,fOldLeftVolume As Float,fOldRightVolume As Float,fLeftVolume As Float,fRightVolume As Float,fCurrVolL As Float,fCurrVolR As Float,Frac64 As Long,Delta64 As Long,leftTmpSamples16(3) As Short,rightTmpSamples16(4) As Short,leftTmpSamples8(3) As Byte,rightTmpSamples8(4) As Byte,leftTmpSamples16_R(3) As Short,rightTmpSamples16_R(4) As Short,leftTmpSamples8_R(3) As Byte,rightTmpSamples8_R(4) As Byte,Idx As Int)
  Type it2play_it_header_t(SongName As String,OrdNum As Int,InsNum As Int,SmpNum As Int,PatNum As Int,Cwtv As Int,Cmwt As Int,Flags As Int,Special As Int,GlobalVol As Short,MixVolume As Short,InitialSpeed As Short,InitialTempo As Short,PanSep As Short,MessageLength As Int,MessageOffset As Long,ChnlPan(64) As Short,ChnlVol(64) As Short)
  Type it2play_driver_t(NumChannels As Long,Flags As Short,FilterParameters(128) As Short,MixFrequency As Long,Delta64 As Long,QualityFactorTable(128) As Float,FreqParameterMultiplier As Float,FreqMultiplier As Float,fSincLUT() As Float,fSincLUT_o As Int,fLastLeftValue As Float,fLastRightValue As Float)
  Type it2play_song_t(Header As it2play_it_header_t,Orders(256) As Short,Ins(100) As it2play_instrument_t,Smp(100) As it2play_sample_t,Patt(200) As it2play_pattern_t,Message As String,Playing As Boolean,Loaded As Boolean,PatternOffset() As Byte,PatternOffset_o As Int,LastMIDIByte As Short,CurrentOrder As Int,CurrentPattern As Int,CurrentRow As Int,ProcessOrder As Int,ProcessRow As Int,BreakRow As Int,RowDelay As Short,RowDelayOn As Boolean,StopSong As Boolean,PatternLooping As Boolean,NumberOfRows As Int,CurrentTick As Int,CurrentSpeed As Int,ProcessTick As Int,Tempo As Int,GlobalVolume As Int,DecodeExpectedPattern As Int,DecodeExpectedRow As Int)
  Type it2play_MEMFILE(eof_ As Boolean,ptr_() As Byte,ptr__o As Int,base_() As Byte,base__o As Int,cnt_ As Long,bufsiz_ As Long)
  
  ' global 
  Private RetOfs As Int
  Private Driver As it2play_driver_t  
  Private hChn(64) As it2play_hostChn_t
  Private sChn(256) As it2play_slaveChn_t
  Private MIDIDataArea(4896) As Byte 
  Private FineSineData(768) As Byte

  ' music
  Private AllocateSlaveOffset As it2play_slaveChn_t
  Private LastSlaveChannel As it2play_slaveChn_t
  Private MIDIInterpretState As Int
  Private MIDIInterpretType As Short
  Private AllocateNumChannels As Long
  Private FirstTimeInit As Boolean = True
  Private RandSeed1 As Int = 4660
  Private RandSeed2 As Int = 22136
  Private ChannelLocationTable(100) As it2play_slaveChn_t  
  Private ChannelCountTable(100) As Int  
  Private ChannelVolumeTable(100) As Short 
  Private FineLinearSlideUpTable(16) As Long
  Private LinearSlideUpTable(257) As Long
  Private FineLinearSlideDownTable(16) As Int
  Private LinearSlideDownTable(257) As Int
  Private EmptyPattern(72) As Byte

  ' hq
  Private fMixBuffer() As Float
  Private fMixBuffer_o As Int
  Private MixVolume As Int
  Private RealBytesToMix As Int
  Private BytesToMix As Int
  Private MixTransferRemaining As Int
  Private MixTransferOffset As Int
  Private FreqMulVal As Int
  Private BytesToMixFractional As Long
  Private CurrentFractional As Long
  Private RandSeed As Long
  Private fLastClickRemovalLeft As Float
  Private fLastClickRemovalRight As Float
  Private fPrngStateL As Float
  Private fPrngStateR As Float
  Private MixGain As Float = 32768.0
  Private SamplesPerTickInt(225) As Int
  Private SamplesPerTickFrac(225) As Long
  
  ' effects
  Private PitchTable(120) As Long
  Private SlideTable(9) As Short
  
  ' load
  Private FirstTimeLoading As Boolean = True  

  ' mixer
  Private mixLine As JavaObject
  Private tmrMix As Timer
  Private mixShorts() As Short
  Private bufferSize As Int
  Private mixerOpened As Int
  Private mixerLocked As Boolean  
  #If B4J
    Private mixBytes() As Byte
  #Else 
    Private trackFrames As Int
    Private writtenFrames As Int    
  #End If
 
  ' public
  Public Song As it2play_song_t  
End Sub
  
' +++++ Initialize 

' Class initialization
Public Sub Initialize 
  Driver.Initialize
  
  Clear_Song
  Clear_hChn
  Clear_sChn
  
  ' Generation table
  For i = 0 To PitchTable.Length - 1
    PitchTable(i) = D2L(RoundTo(Power(2.0, (i - 5 * 12) / 12.0) * 65536.0))
  Next
  
  For i = 0 To FineSineData.Length / 3 - 1
    FineSineData(i) = D2L(RoundTo(Sin(i * (2.0 * cPI / 256.0)) * 64.0))
    FineSineData(256 + i) = Bit.ShiftRight(128 - i, 1)
    FineSineData(512 + i) = Bit.ShiftRight(Bit.And(Bit.Xor(i, 255), 128), 1)
  Next
  
  For i = 0 To FineLinearSlideUpTable.Length - 1
    FineLinearSlideUpTable(i) = D2L(RoundTo(Power(2.0, i / 768.0) * 65536.0))
  Next
  
  For i = 0 To LinearSlideUpTable.Length - 1
    LinearSlideUpTable(i) = D2L(RoundTo(Power(2.0, i / 192.0) * 65536.0))
  Next
  
  Dim x As Int
  For i = 0 To FineLinearSlideDownTable.Length - 1
    x = D2L(RoundTo(Power(2.0, i / -768.0) * 65536.0))
    If x > 65535 Then x = 65535
    FineLinearSlideDownTable(i) = x
  Next
  
  For i = 0 To LinearSlideDownTable.Length - 1
    x = D2L(RoundTo(Power(2.0, i / -192.0) * 65536.0))
    If x > 65535 Then x = 65535
    LinearSlideDownTable(i) = x
  Next
  
  EmptyPattern(0) = 64
  EmptyPattern(2) = 64
  
  Dim SlideTable() As Short = Array As Short(1, 4, 8, 16, 32, 64, 96, 128, 255)
End Sub
  
' ----- Initialize   

' +++++ Clearing and initializing structures

Private Sub Clear_Song
  Song.Initialize 
  Song.Header.Initialize

  For i = 0 To Song.Ins.Length - 1
    Song.Ins(i).Initialize
    Song.Ins(i).Idx = i
  
    Song.Ins(i).VolEnv.Initialize
    Song.Ins(i).PanEnv.Initialize    
    Song.Ins(i).PitchEnv.Initialize    
    For k = 0 To Song.Ins(i).VolEnv.NodePoints.Length - 1
      Song.Ins(i).VolEnv.NodePoints(k).Initialize
      Song.Ins(i).VolEnv.NodePoints(k).Idx = k
    
      Song.Ins(i).PanEnv.NodePoints(k).Initialize
      Song.Ins(i).PanEnv.NodePoints(k).Idx = k
    
      Song.Ins(i).PitchEnv.NodePoints(k).Initialize
      Song.Ins(i).PitchEnv.NodePoints(k).Idx = k
    Next    
  Next  
  
  For i = 0 To Song.Smp.Length - 1
    Song.Smp(i).Initialize
    Song.Smp(i).Data8 = Null
    Song.Smp(i).Data16 = Null
    Song.Smp(i).DataR8 = Null
    Song.Smp(i).DataR16 = Null    
    Song.Smp(i).Idx = i
  Next

  For i = 0 To Song.Patt.Length - 1
    Song.Patt(i).Initialize
    Song.Patt(i).PackedData = Null
    Song.Patt(i).Idx = i
  Next  
End Sub
  
Private Sub Clear_hChn
  For i = 0 To hChn.Length - 1
    hChn(i).Initialize
    hChn(i).Idx = i
  Next
End Sub  
  
Private Sub Clear_sChn
  For i = 0 To sChn.Length - 1
    sChn(i).Initialize
    sChn(i).Idx = i
    sChn(i).VolEnvState.Initialize
    sChn(i).PanEnvState.Initialize
    sChn(i).PitchEnvState.Initialize
  Next  
End Sub    
  
' ----- Clearing and initializing structures  

' +++++ Exchange and copy structures

Private Sub AdvIdx(p As Object, d As Int) As Object
  Dim i As Int
  If p Is it2play_pattern_t Then
    i = p.As(it2play_pattern_t).Idx + d
    If i >= 0 And i < Song.Patt.Length Then Return Song.Patt(i)
  Else If p Is it2play_instrument_t Then
    i = p.As(it2play_instrument_t).Idx + d
    If i >= 0 And i < Song.Ins.Length Then Return Song.Ins(i)
  Else If p Is it2play_sample_t Then
    i = p.As(it2play_sample_t).Idx + d
    If i >= 0 And i < Song.Smp.Length Then Return Song.Smp(i)    
  Else If p Is it2play_hostChn_t Then
    i = p.As(it2play_hostChn_t).Idx + d
    If i >= 0 And i < hChn.Length Then Return hChn(i)      
  Else If p Is it2play_slaveChn_t Then
    i = p.As(it2play_slaveChn_t).Idx + d
    If i >= 0 And i < sChn.Length Then Return sChn(i)            
  End If
  Return Null
End Sub  

Private Sub Copy_envState_t(d As it2play_envState_t, s As it2play_envState_t)
  d.Value = s.Value
  d.Delta = s.Delta
  d.Tick = s.Tick
  d.CurNode = s.CurNode
  d.NextTick = s.NextTick
End Sub

Private Sub Copy_slaveChn_t(d As it2play_slaveChn_t, s As it2play_slaveChn_t)
  d.SmpIs16Bit = s.SmpIs16Bit
  d.Flags = s.Flags
  d.LoopMode = s.LoopMode
  d.LoopDirection = s.LoopDirection
  d.Frequency = s.Frequency
  d.FrequencySet = s.FrequencySet
  d.AutoVibratoPos = s.AutoVibratoPos
  d.AutoVibratoDepth = s.AutoVibratoDepth
  d.FinalVol128 = s.FinalVol128
  d.Vol = s.Vol
  d.VolSet = s.VolSet
  d.ChnVol = s.ChnVol
  d.SmpVol = s.SmpVol
  d.FinalPan = s.FinalPan
  d.FadeOut = s.FadeOut
  d.DCT = s.DCT
  d.DCA = s.DCA
  d.Pan = s.Pan
  d.PanSet = s.PanSet
  d.InsPtr = s.InsPtr
  d.SmpPtr = s.SmpPtr
  d.Note = s.Note
  d.Ins = s.Ins
  d.Smp = s.Smp
  d.HostChnPtr = s.HostChnPtr
  d.HostChnNum = s.HostChnNum
  d.NNA = s.NNA
  d.MIDIChn = s.MIDIChn
  d.MIDIProg = s.MIDIProg
  d.MIDIBank = s.MIDIBank
  d.LoopBegin = s.LoopBegin
  d.LoopEnd = s.LoopEnd
  d.Frac32 = s.Frac32
  d.FinalVol32768 = s.FinalVol32768
  d.SamplingPosition = s.SamplingPosition
  Copy_envState_t(d.VolEnvState, s.VolEnvState)
  Copy_envState_t(d.PanEnvState, s.PanEnvState)
  Copy_envState_t(d.PitchEnvState, s.PitchEnvState)
  d.Delta32 = s.Delta32
  For i = 0 To s.fOldSamples.Length - 1
    d.fOldSamples(i) = s.fOldSamples(i)
  Next
  d.fFiltera = s.fFiltera
  d.fFilterb = s.fFilterb
  d.fFilterc = s.fFilterc
  d.HasLooped = s.HasLooped
  d.fOldLeftVolume = s.fOldLeftVolume
  d.fOldRightVolume = s.fOldRightVolume
  d.fLeftVolume = s.fLeftVolume
  d.fRightVolume = s.fRightVolume
  d.fCurrVolL = s.fCurrVolL
  d.fCurrVolR = s.fCurrVolR
  d.Frac64 = s.Frac64
  d.Delta64 = s.Delta64
  For i = 0 To s.leftTmpSamples16.Length - 1
    d.leftTmpSamples16(i) = s.leftTmpSamples16(i)
  Next
  For i = 0 To s.rightTmpSamples16.Length - 1
    d.rightTmpSamples16(i) = s.rightTmpSamples16(i)
  Next
  For i = 0 To s.leftTmpSamples8.Length - 1
    d.leftTmpSamples8(i) = s.leftTmpSamples8(i)
  Next
  For i = 0 To s.rightTmpSamples8.Length - 1
    d.rightTmpSamples8(i) = s.rightTmpSamples8(i)
  Next
  For i = 0 To s.leftTmpSamples16_R.Length - 1
    d.leftTmpSamples16_R(i) = s.leftTmpSamples16_R(i)
  Next
  For i = 0 To s.rightTmpSamples16_R.Length - 1
    d.rightTmpSamples16_R(i) = s.rightTmpSamples16_R(i)
  Next
  For i = 0 To s.leftTmpSamples8_R.Length - 1
    d.leftTmpSamples8_R(i) = s.leftTmpSamples8_R(i)
  Next
  For i = 0 To s.rightTmpSamples8_R.Length - 1
    d.rightTmpSamples8_R(i) = s.rightTmpSamples8_R(i)
  Next
End Sub
  
' ----- Exchange and copy structures  

' +++++ Small helper functions

Private Sub Load16LE(p() As Byte, p_o As Int) As Int
  Return Bit.Or(Bit.And(p(p_o), 255), Bit.ShiftLeft(Bit.And(p(p_o + 1), 255), 8))
End Sub

Private Sub Load32LE(p() As Byte, p_o As Int) As Long
  Return Bit.OrLong(Bit.OrLong(Bit.OrLong(I2L(Bit.And(p(p_o), 255)), Bit.ShiftLeftLong(I2L(Bit.And(p(p_o + 1), 255)), 8)), Bit.ShiftLeftLong(I2L(Bit.And(p(p_o + 2), 255)), 16)), Bit.ShiftLeftLong(I2L(Bit.And(p(p_o + 3), 255)), 24))
End Sub

Private Sub SignExt8(v As Int) As Int
  Return Bit.Xor(Bit.And(v, 255), 128) - 128
End Sub

Private Sub SignExt16(v As Int) As Int
  Return Bit.Xor(Bit.And(v, 65535), 32768) - 32768
End Sub

Private Sub MiscGetU8(hc As it2play_hostChn_t, idx As Int) As Int
  Return Bit.And(hc.MiscEfxData(idx), 255)
End Sub

Private Sub MiscSetU8(hc As it2play_hostChn_t, idx As Int, v As Int)
  hc.MiscEfxData(idx) = ToS8(SignExt8(v))
End Sub

Private Sub MiscGetU16(hc As it2play_hostChn_t, idx As Int) As Int
  Return Bit.Or(Bit.And(hc.MiscEfxData(idx), 255), Bit.ShiftLeft(Bit.And(hc.MiscEfxData(idx + 1), 255), 8))
End Sub

Private Sub MiscSetU16(hc As it2play_hostChn_t, idx As Int, v As Int)
  hc.MiscEfxData(idx) = ToS8(SignExt8(v))
  hc.MiscEfxData((idx + 1)) = ToS8(SignExt8(Bit.ShiftRight(v, 8)))
End Sub

Private Sub ToS8(v As Int) As Int
  Return Bit.ShiftRight(Bit.ShiftLeft(v, 24), 24)
End Sub

Private Sub ToS16(v As Int) As Int
  Return Bit.ShiftRight(Bit.ShiftLeft(v, 16), 16)
End Sub

Private Sub L2I(v As Long) As Int
  Dim lo As Long = Bit.AndLong(v, 4294967295)
  If lo >= 2147483648 Then lo = lo - 4294967296
  Return lo
End Sub

Private Sub I2L(v As Int) As Long
  Return v
End Sub

Private Sub B2I(b As Boolean) As Int
  If b Then Return 1
  Return 0
End Sub

Private Sub D2I(d As Double) As Int
  If d >= 0 Then Return Floor(d)
  Return Ceil(d)
End Sub

Private Sub D2L(d As Double) As Long
  If d >= 0 Then Return Floor(d)
  Return Ceil(d)
End Sub

Private Sub RoundTo(x As Double) As Double
  If x >= 0 Then Return Floor(x + 0.5)
  Return Ceil(x - 0.5)
End Sub

Private Sub IDiv(a As Int, b As Int) As Int
  Dim d As Double = a / b
  If d >= 0 Then Return Floor(d)
  Return Ceil(d)
End Sub

Private Sub IDivL(a As Long, b As Long) As Long
  Dim neg As Boolean = (a < 0) <> (b < 0)
  Dim x As Long = a
  Dim y As Long = b
  If x < 0 Then x = -x
  If y < 0 Then y = -y
  Dim q As Long = Floor(x / y)
  Dim r As Long = x - q * y
  Do While r < 0
    q = q - 1
    r = r + y
  Loop
  Do While r >= y
    q = q + 1
    r = r - y
  Loop
  If neg Then Return -q
  Return q
End Sub

Private Sub NewByteArr(n As Int) As Byte()
  Dim a(n) As Byte
  Return a
End Sub

Private Sub NewShortArr(n As Int) As Short()
  Dim a(n) As Short
  Return a
End Sub

'Private Sub NewIntArr(n As Int) As Int()
'  Dim a(n) As Int
'  Return a
'End Sub

Private Sub NewFloatArr(n As Int) As Float()
  Dim a(n) As Float
  Return a
End Sub

Private Sub CopyStr(arr() As Byte, ofs As Int, s As String)
  For i = 0 To s.Length - 1
    arr(ofs + i) = Asc(s.CharAt(i))
  Next
End Sub  
  
' ----- Small helper functions  

' +++++ Music engine

Private Sub RecalculateAllVolumes
  Dim sc As it2play_slaveChn_t = sChn(0)
  Dim i As Long = 0
  Do While i < Driver.NumChannels
    sc.Flags = Bit.Or(sc.Flags, 18)
    i = i + 1
    sc = AdvIdx(sc, 1)
  Loop
End Sub

Private Sub Music_SetDefaultMIDIDataArea
  For tmp1 = 0 To 4895
    MIDIDataArea(0 + tmp1) = 0
  Next
  CopyStr(MIDIDataArea, 0, "FF")
  CopyStr(MIDIDataArea, 32, "FC")
  CopyStr(MIDIDataArea, 96, "9c n v")
  CopyStr(MIDIDataArea, 128, "9c n 0")
  CopyStr(MIDIDataArea, 224, "Bc 0 a 20 b")
  CopyStr(MIDIDataArea, 256, "Cc p")
  CopyStr(MIDIDataArea, 288, "F0F000z")
  CopyStr(MIDIDataArea, 800, "F0F00100")
  CopyStr(MIDIDataArea, 832, "F0F00108")
  CopyStr(MIDIDataArea, 864, "F0F00110")
  CopyStr(MIDIDataArea, 896, "F0F00118")
  CopyStr(MIDIDataArea, 928, "F0F00120")
  CopyStr(MIDIDataArea, 960, "F0F00128")
  CopyStr(MIDIDataArea, 992, "F0F00130")
  CopyStr(MIDIDataArea, 1024, "F0F00138")
  CopyStr(MIDIDataArea, 1056, "F0F00140")
  CopyStr(MIDIDataArea, 1088, "F0F00148")
  CopyStr(MIDIDataArea, 1120, "F0F00150")
  CopyStr(MIDIDataArea, 1152, "F0F00158")
  CopyStr(MIDIDataArea, 1184, "F0F00160")
  CopyStr(MIDIDataArea, 1216, "F0F00168")
  CopyStr(MIDIDataArea, 1248, "F0F00170")
  CopyStr(MIDIDataArea, 1280, "F0F00178")
End Sub

Private Sub MIDISendFilter(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, Data1 As Int)
  Data1 = ToS16(Bit.And(Data1, 255))
  If Not(Bit.And(Driver.Flags, 1) <> 0) Then Return
  If Data1 >= 128 And Data1 < 240 Then
    If Data1 = Song.LastMIDIByte Then Return
    Song.LastMIDIByte = Data1
  End If
  If MIDIInterpretState < 2 Then
    If Data1 = 240 Then
      MIDIInterpretState = MIDIInterpretState + 1
    Else
      If Data1 = 250 Or Data1 = 252 Or Data1 = 255 Then
        For i = 0 To 63
          Driver.FilterParameters(i) = 127
          Driver.FilterParameters(64 + i) = 0
        Next
      End If
      MIDIInterpretState = 0
    End If
  Else If MIDIInterpretState = 2 Then
    If Data1 < 2 Then
      MIDIInterpretType = Data1
      MIDIInterpretState = MIDIInterpretState + 1
    Else
      MIDIInterpretState = 0
    End If
  Else If MIDIInterpretState = 3 Then
    If Data1 <= 127 Then
      Dim IsFilterQ As Boolean = MIDIInterpretType = 1
      If IsFilterQ Then
        Driver.FilterParameters(Bit.And(64 + hc.HostChnNum, 127)) = Data1
      Else
        Driver.FilterParameters(Bit.And(hc.HostChnNum, 127)) = Data1
      End If
      If sc <> Null Then
        sc.Flags = Bit.Or(sc.Flags, 64)
      End If
    End If
    MIDIInterpretState = 0
  End If
End Sub

Private Sub SetFilterCutoff(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, value As Int)
  MIDISendFilter(hc, sc, 240)
  MIDISendFilter(hc, sc, 240)
  MIDISendFilter(hc, sc, 0)
  MIDISendFilter(hc, sc, value)
End Sub

Private Sub SetFilterResonance(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, value As Int)
  MIDISendFilter(hc, sc, 240)
  MIDISendFilter(hc, sc, 240)
  MIDISendFilter(hc, sc, 1)
  MIDISendFilter(hc, sc, value)
End Sub

Private Sub MIDITranslate(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, Input1 As Int)
  Input1 = Bit.And(Input1, 65535)
  If Not(Bit.And(Driver.Flags, 1) <> 0) Then Return
  If Input1 >= 61440 Then Return
  If IDiv(Input1, 32) >= 153 Then Return
  Dim MIDIData As Int = 0
  Dim CharsParsed As Int = 0
  Do While True
    Dim Byte_l As Int = MIDIDataArea(Input1)
    Input1 = Bit.And((Input1 + 1), 65535)
    If (Byte_l = 0) Then
      If (CharsParsed > 0) Then
        MIDISendFilter(hc, sc, MIDIData)
      End If
      Exit
    End If
    If (Byte_l = 32) Then
      If (CharsParsed > 0) Then
        MIDISendFilter(hc, sc, MIDIData)
      End If
      Continue
    End If
    Byte_l = ToS16((Byte_l - 48))
    If (Byte_l < 0) Then
      Continue
    End If
    If (Byte_l <= 9) Then
      MIDIData = Bit.And((Bit.Or((Bit.ShiftLeft(MIDIData, 4)), (Bit.And(Byte_l, 255)))), 255)
      CharsParsed = Bit.And((CharsParsed + 1), 255)
      If (CharsParsed >= 2) Then
        MIDISendFilter(hc, sc, MIDIData)
        CharsParsed = 0
        MIDIData = 0
      End If
      Continue
    End If
    Byte_l = ToS16((Byte_l - 17))
    If (Byte_l < 0) Then
      Continue
    End If
    If (Byte_l <= 5) Then
      MIDIData = Bit.And((Bit.Or((Bit.ShiftLeft(MIDIData, 4)), (Bit.And((Byte_l + 10), 255)))), 255)
      CharsParsed = Bit.And((CharsParsed + 1), 255)
      If (CharsParsed >= 2) Then
        MIDISendFilter(hc, sc, MIDIData)
        CharsParsed = 0
        MIDIData = 0
      End If
      Continue
    End If
    Byte_l = ToS16((Byte_l - 32))
    If (Byte_l < 0) Then
      Continue
    End If
    If (Byte_l > 25) Then
      Continue
    End If
    If (Byte_l = 2) Then
      If (sc = Null) Then
        Continue
      End If
      MIDIData = Bit.And((Bit.Or((Bit.ShiftLeft(MIDIData, 4)), (sc.MIDIChn - 1))), 255)
      CharsParsed = Bit.And((CharsParsed + 1), 255)
      If (CharsParsed >= 2) Then
        MIDISendFilter(hc, sc, MIDIData)
        CharsParsed = 0
        MIDIData = 0
      End If
      Continue
    End If
    If (CharsParsed > 0) Then
      MIDISendFilter(hc, sc, MIDIData)
      MIDIData = 0
    End If
    If (Byte_l = 25) Then
      MIDISendFilter(hc, sc, hc.CmdVal)
    Else If (Byte_l = 14) Then
      MIDISendFilter(hc, sc, hc.EfxMem_O)
    Else If (sc <> Null) Then
      If (Byte_l = 13) Then
        MIDISendFilter(hc, sc, sc.Note)
      Else If (Byte_l = 12) Then
        MIDISendFilter(hc, sc, sc.LoopDirection)
      Else If (Byte_l = 21) Then
        If (Bit.And(sc.Flags, 2048) <> 0) Then
          MIDISendFilter(hc, sc, 0)
        Else
          Dim volume As Int = Bit.And((Bit.ShiftRight(((sc.VolSet * Song.GlobalVolume) * sc.ChnVol), 4)), 65535)
          Dim value As Int = Bit.And((Bit.ShiftRight((volume * sc.SmpVol), 15)), 255)
          If (value = 0) Then
            value = 1
          Else If (value >= 128) Then
            value = Bit.And((value - 1), 255)
          End If
          MIDISendFilter(hc, sc, value)
        End If
      Else If (Byte_l = 20) Then
        If (Bit.And(sc.Flags, 2048) <> 0) Then
          MIDISendFilter(hc, sc, 0)
        Else
          Dim value_2 As Int = sc.FinalVol128
          If (value_2 = 0) Then
            value_2 = 1
          Else If (value_2 >= 128) Then
            value_2 = Bit.And((value_2 - 1), 255)
          End If
          MIDISendFilter(hc, sc, value_2)
        End If
      Else If (Byte_l = 7) Then
        MIDISendFilter(hc, sc, Bit.And(sc.HostChnNum, 127))
      Else If (Byte_l = 23) Then
        Dim value_3 As Int = (Bit.And((sc.Pan * 2), 255))
        If (value_3 >= 128) Then
          value_3 = Bit.And((value_3 - 1), 255)
        End If
        If (value_3 >= 128) Then
          value_3 = 64
        End If
        MIDISendFilter(hc, sc, value_3)
      Else If (Byte_l = 15) Then
        MIDISendFilter(hc, sc, sc.MIDIProg)
      Else If (Byte_l = 1) Then
        MIDISendFilter(hc, sc, Bit.And(sc.MIDIBank, 255))
      Else If (Byte_l = 0) Then
        MIDISendFilter(hc, sc, Bit.ShiftRight(sc.MIDIBank, 8))
      End If
    End If
    MIDIData = 0
    CharsParsed = 0
  Loop
End Sub

Private Sub InitPlayInstrument(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, ins As it2play_instrument_t)
  sc.InsPtr = ins
  sc.NNA = ins.NNA
  sc.DCT = ins.DCT
  sc.DCA = ins.DCA
  If (hc.MIDIChn <> 0) Then
    sc.MIDIChn = ins.MIDIChn
    sc.MIDIProg = ins.MIDIProg
    sc.MIDIBank = ins.MIDIBank
    sc.LoopDirection = hc.RawNote
  End If
  sc.ChnVol = hc.ChnVol
  Dim pan As Int = Bit.And((IIf((Bit.And(ins.DefPan, 128) <> 0), hc.ChnPan, ins.DefPan)), 255)
  If (hc.Smp <> 0) Then
    Dim s As it2play_sample_t = Song.Smp((hc.Smp - 1))
    If (Bit.And(s.DefPan, 128) <> 0) Then
      pan = Bit.And(s.DefPan, 127)
    End If
  End If
  If (pan <> 100) Then
    Dim newPan As Int = ToS16((pan + (Bit.ShiftRight((ToS8((hc.RawNote - ins.PitchPanCenter)) * ToS8(ins.PitchPanSep)), 3))))
    If (newPan < 0) Then
      newPan = 0
    Else If (newPan > 64) Then
      newPan = 64
    End If
    pan = (Bit.And(newPan, 255))
  End If
  sc.PanSet = pan
  sc.Pan = sc.PanSet
  sc.VolEnvState.Value = 4194304
  sc.VolEnvState.NextTick = 0
  sc.VolEnvState.Tick = sc.VolEnvState.NextTick
  sc.VolEnvState.CurNode = 0
  sc.PanEnvState.Value = 0
  sc.PanEnvState.NextTick = 0
  sc.PanEnvState.Tick = sc.PanEnvState.NextTick
  sc.PanEnvState.CurNode = 0
  sc.PitchEnvState.Value = 0
  sc.PitchEnvState.NextTick = 0
  sc.PitchEnvState.Tick = sc.PitchEnvState.NextTick
  sc.PitchEnvState.CurNode = 0
  sc.Flags = 307
  If (Bit.And(ins.VolEnv.Flags, 1) <> 0) Then
    sc.Flags = Bit.Or(sc.Flags, 4096)
  End If
  If (Bit.And(ins.PanEnv.Flags, 1) <> 0) Then
    sc.Flags = Bit.Or(sc.Flags, 8192)
  End If
  If (Bit.And(ins.PitchEnv.Flags, 1) <> 0) Then
    sc.Flags = Bit.Or(sc.Flags, 16384)
  End If
  If (LastSlaveChannel <> Null) Then
    Dim lastSC As it2play_slaveChn_t = LastSlaveChannel
    If ((Bit.And(ins.VolEnv.Flags, 9)) = 9) Then
      sc.VolEnvState.Value = lastSC.VolEnvState.Value
      sc.VolEnvState.Delta = lastSC.VolEnvState.Delta
      sc.VolEnvState.Tick = lastSC.VolEnvState.Tick
      sc.VolEnvState.CurNode = lastSC.VolEnvState.CurNode
      sc.VolEnvState.NextTick = lastSC.VolEnvState.NextTick
    End If
    If ((Bit.And(ins.PanEnv.Flags, 9)) = 9) Then
      sc.PanEnvState.Value = lastSC.PanEnvState.Value
      sc.PanEnvState.Delta = lastSC.PanEnvState.Delta
      sc.PanEnvState.Tick = lastSC.PanEnvState.Tick
      sc.PanEnvState.CurNode = lastSC.PanEnvState.CurNode
      sc.PanEnvState.NextTick = lastSC.PanEnvState.NextTick
    End If
    If ((Bit.And(ins.PitchEnv.Flags, 9)) = 9) Then
      sc.PitchEnvState.Value = lastSC.PitchEnvState.Value
      sc.PitchEnvState.Delta = lastSC.PitchEnvState.Delta
      sc.PitchEnvState.Tick = lastSC.PitchEnvState.Tick
      sc.PitchEnvState.CurNode = lastSC.PitchEnvState.CurNode
      sc.PitchEnvState.NextTick = lastSC.PitchEnvState.NextTick
    End If
  End If
  hc.Flags = Bit.Or(hc.Flags, 128)
  If (hc.MIDIChn = 0) Then
    sc.MIDIBank = 255
    If (Bit.And(ins.FilterCutoff, 128) <> 0) Then
      Dim filterCutOff As Int = Bit.And(ins.FilterCutoff, 127)
      SetFilterCutoff(hc, sc, filterCutOff)
    End If
    If (Bit.And(ins.FilterResonance, 128) <> 0) Then
      Dim filterQ As Int = Bit.And(ins.FilterResonance, 127)
      sc.MIDIBank = Bit.And((Bit.Or((Bit.ShiftLeft(filterQ, 8)), (Bit.And(sc.MIDIBank, 255)))), 65535)
      SetFilterResonance(hc, sc, filterQ)
    End If
  End If
End Sub

Private Sub AllocateChannelSample(hc As it2play_hostChn_t, hcFlags() As Short, hcFlags_o As Int) As it2play_slaveChn_t
  Dim sc As it2play_slaveChn_t = sChn(hc.HostChnNum)
  If ((Bit.And(Driver.Flags, 2) <> 0) And (Bit.And(sc.Flags, 1) <> 0)) Then
    sc.Flags = Bit.Or(sc.Flags, 512)
    sc.HostChnNum = Bit.Or(sc.HostChnNum, 128)
    Copy_slaveChn_t(sChn(sc.Idx + 64), sc)
  End If
  hc.SlaveChnPtr = sc
  sc.HostChnPtr = hc
  sc.HostChnNum = hc.HostChnNum
  sc.ChnVol = hc.ChnVol
  sc.PanSet = hc.ChnPan
  sc.Pan = sc.PanSet
  sc.FadeOut = 1024
  sc.VolEnvState.Value = Bit.Or(4194304, (Bit.And(sc.VolEnvState.Value, 65535)))
  sc.MIDIBank = 255
  sc.Note = hc.RawNote
  sc.Ins = hc.Ins
  sc.Flags = 307
  If (hc.Smp > 0) Then
    sc.Smp = Bit.And((hc.Smp - 1), 255)
    sc.SmpPtr = Song.Smp(sc.Smp)
    Dim s As it2play_sample_t = sc.SmpPtr
    sc.SmpIs16Bit = False
    sc.AutoVibratoPos = 0
    sc.AutoVibratoDepth = sc.AutoVibratoPos
    sc.PanEnvState.Value = Bit.And(sc.PanEnvState.Value, 65535)
    sc.PitchEnvState.Value = Bit.And(sc.PitchEnvState.Value, 65535)
    sc.LoopDirection = 0
    If ((s.Length = 0) Or Not((Bit.And(s.Flags, 1) <> 0))) Then
      sc.Flags = 512
      hcFlags(hcFlags_o) = Bit.And(hcFlags(hcFlags_o), Bit.Not(4))
      Return Null
    End If
    sc.SmpIs16Bit = (Bit.And(s.Flags, 2) <> 0)
    sc.SmpVol = Bit.And((s.GlobVol * 2), 255)
    Return sc
  Else
    sc.Flags = 512
    hcFlags(hcFlags_o) = Bit.And(hcFlags(hcFlags_o), Bit.Not(4))
    Return Null
  End If
End Sub

Private Sub AllocateChannelInstrument(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, ins As it2play_instrument_t, hcFlags() As Short, hcFlags_o As Int) As it2play_slaveChn_t
  hc.SlaveChnPtr = sc
  sc.HostChnNum = hc.HostChnNum
  sc.HostChnPtr = hc
  sc.SmpIs16Bit = False
  sc.AutoVibratoPos = 0
  sc.AutoVibratoDepth = sc.AutoVibratoPos
  sc.LoopDirection = 0
  InitPlayInstrument(hc, sc, ins)
  sc.SmpVol = ins.GlobVol
  sc.FadeOut = 1024
  sc.Note = Bit.And((IIf((hc.Smp = 101), hc.TranslatedNote, hc.RawNote)), 255)
  sc.Ins = hc.Ins
  If (hc.Smp = 0) Then
    sc.Flags = 512
    hcFlags(hcFlags_o) = Bit.And(hcFlags(hcFlags_o), Bit.Not(4))
    Return Null
  End If
  sc.Smp = Bit.And((hc.Smp - 1), 255)
  sc.SmpPtr = Song.Smp(sc.Smp)
  Dim s As it2play_sample_t = sc.SmpPtr
  If ((s.Length = 0) Or Not((Bit.And(s.Flags, 1) <> 0))) Then
    sc.Flags = 512
    hcFlags(hcFlags_o) = Bit.And(hcFlags(hcFlags_o), Bit.Not(4))
    Return Null
  End If
  sc.SmpIs16Bit = (Bit.And(s.Flags, 2) <> 0)
  sc.SmpVol = Bit.And((Bit.ShiftRight((s.GlobVol * sc.SmpVol), 6)), 255)
  Return sc
End Sub

Private Sub DuplicateCheck(scOut() As it2play_slaveChn_t, scOut_o As Int, hc As it2play_hostChn_t, hostChnNum As Int, ins As it2play_instrument_t, DCT As Int, DCVal As Int) As Boolean
  Dim sc As it2play_slaveChn_t = AllocateSlaveOffset
  Dim i As Long = 0
  Do While (i < AllocateNumChannels)
    scOut(scOut_o) = sc
    If ((Not((Bit.And(sc.Flags, 1) <> 0)) Or ((hc.Smp <> 101) And (sc.HostChnNum <> hostChnNum))) Or (sc.Ins <> hc.Ins)) Then
      i = (i + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    If ((DCT = 1) And (sc.Note <> DCVal)) Then
      i = (i + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    If ((DCT = 2) And (sc.Smp <> DCVal)) Then
      i = (i + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    If ((DCT = 3) And (sc.Ins <> DCVal)) Then
      i = (i + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    If (hc.Smp = 101) Then
      If ((sc.Smp = 100) And (sc.MIDIChn = hostChnNum)) Then
        sc.Flags = Bit.Or(sc.Flags, 512)
        If Not((Bit.And(sc.HostChnNum, 128) <> 0)) Then
          sc.HostChnNum = Bit.Or(sc.HostChnNum, 128)
          sc.HostChnPtr.Flags = Bit.And(sc.HostChnPtr.Flags, Bit.Not(4))
        End If
      End If
    Else If (sc.DCA = ins.DCA) Then
      Return True
    End If
    i = (i + 1)
    sc = AdvIdx(sc, 1)
  Loop
  Return False
End Sub

Private Sub AllocateChannel(hc As it2play_hostChn_t, hcFlags() As Short, hcFlags_o As Int) As it2play_slaveChn_t
  LastSlaveChannel = Null
  If (Not((Bit.And(Song.Header.Flags, 4) <> 0)) Or (hc.Ins = 255)) Then
    Return AllocateChannelSample(hc, hcFlags, hcFlags_o)
  End If
  If (hc.Ins = 0) Then
    Return Null
  End If
  If ((hc.Smp = 101) And (Driver.NumChannels < 256)) Then
    AllocateNumChannels = Bit.AndLong((256 - Driver.NumChannels), 4294967295)
    AllocateSlaveOffset = sChn(L2I(Driver.NumChannels))
  Else
    AllocateNumChannels = Driver.NumChannels
    AllocateSlaveOffset = sChn(0)
  End If
  Dim NNA As Int = 0
  Dim sc As it2play_slaveChn_t = Null
  Dim hostChnNum As Int
  Dim DCT As Int
  Dim DCVal As Int
  Dim ins As it2play_instrument_t = Song.Ins((hc.Ins - 1))
  Dim scInitialized As Boolean = False
  If (Bit.And((hcFlags(hcFlags_o)), 4) <> 0) Then
    sc = hc.SlaveChnPtr
    If (sc.InsPtr = ins) Then
      LastSlaveChannel = sc
    End If
    NNA = sc.NNA
    If (NNA <> 0) Then
      sc.HostChnNum = Bit.Or(sc.HostChnNum, 128)
    End If
    scInitialized = True
  End If
  Do While True
    Dim skipMIDITest As Boolean = False
    If scInitialized Then
      If ((((NNA <> 0) And (sc.VolSet > 0)) And (sc.ChnVol > 0)) And (sc.SmpVol > 0)) Then
        If (NNA = 2) Then
          sc.Flags = Bit.Or(sc.Flags, 4)
          GetLoopInformation(sc)
        Else If (NNA >= 3) Then
          sc.Flags = Bit.Or(sc.Flags, 8)
        End If
      Else
        If (sc.Smp = 100) Then
          sc.Flags = Bit.Or(sc.Flags, 512)
          sc.HostChnNum = Bit.Or(sc.HostChnNum, 128)
          If (hc.Smp <> 101) Then
            Exit
          End If
        Else
          If (Bit.And(Driver.Flags, 2) <> 0) Then
            sc.Flags = Bit.Or(sc.Flags, 512)
            sc.HostChnNum = Bit.Or(sc.HostChnNum, 128)
            Exit
          End If
          sc.Flags = 512
          If (ins.DCT = 0) Then
            Return AllocateChannelInstrument(hc, sc, ins, hcFlags, hcFlags_o)
          End If
          skipMIDITest = True
        End If
      End If
    End If
    DCVal = 0
    DCT = DCVal
    hostChnNum = DCT
    Dim doDupeCheck As Boolean = False
    If (Not(skipMIDITest) And (hc.Smp = 101)) Then
      hostChnNum = hc.MIDIChn
      DCT = 1
      DCVal = hc.TranslatedNote
      doDupeCheck = True
    Else If (ins.DCT <> 0) Then
      hostChnNum = ToS16(Bit.Or(hc.HostChnNum, 128))
      DCT = ins.DCT
      If (ins.DCT = 1) Then
        DCVal = hc.RawNote
      Else If (ins.DCT = 3) Then
        DCVal = hc.Ins
      Else
        DCVal = Bit.And((hc.Smp - 1), 255)
        If (ToS8(DCVal) < 0) Then
          Exit
        End If
      End If
      doDupeCheck = True
    End If
    If doDupeCheck Then
      sc = AllocateSlaveOffset
      Dim tmp2(1) As it2play_slaveChn_t
      tmp2(0) = sc
      Dim tmp3 As Boolean = DuplicateCheck(tmp2, 0, hc, hostChnNum, ins, DCT, DCVal)
      sc = tmp2(0)
      If tmp3 Then
        scInitialized = True
        If (ins.DCA = 0) Then
          NNA = 0
        Else
          sc.DCT = 0
          sc.DCA = 0
          NNA = Bit.And((ins.DCA + 1), 255)
        End If
        Continue
      End If
    End If
    Exit
  Loop
  sc = AllocateSlaveOffset
  If (hc.Smp <> 101) Then
    Dim i As Long = 0
    Do While (i < AllocateNumChannels)
      If Not((Bit.And(sc.Flags, 1) <> 0)) Then
        Return AllocateChannelInstrument(hc, sc, ins, hcFlags, hcFlags_o)
      End If
      i = (i + 1)
      sc = AdvIdx(sc, 1)
    Loop
  Else
    Dim i_2 As Long = 0
    Do While (i_2 < AllocateNumChannels)
      If Not((Bit.And(sc.Flags, 1) <> 0)) Then
        Dim hcTmp As it2play_hostChn_t = sc.HostChnPtr
        If ((hcTmp = Null) Or (hcTmp.SlaveChnPtr <> sc)) Then
          Return AllocateChannelInstrument(hc, sc, ins, hcFlags, hcFlags_o)
        End If
      End If
      i_2 = (i_2 + 1)
      sc = AdvIdx(sc, 1)
    Loop
  End If
  For tmp4 = 0 To ChannelCountTable.Length - 1
    ChannelCountTable(0 + tmp4) = 0
  Next
  For i_3 = 0 To 99
    ChannelVolumeTable(i_3) = 255
  Next
  For tmp5 = 0 To ChannelLocationTable.Length - 1
    ChannelLocationTable(0 + tmp5) = Null
  Next
  sc = AllocateSlaveOffset
  Dim i_4 As Long = 0
  Do While (i_4 < AllocateNumChannels)
    If (sc.Smp > 99) Then
      i_4 = (i_4 + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    ChannelCountTable(sc.Smp) = (ChannelCountTable(sc.Smp) + 1)
    If ((Bit.And(sc.HostChnNum, 128) <> 0) And (sc.FinalVol128 < ChannelVolumeTable(sc.Smp))) Then
      ChannelLocationTable(sc.Smp) = sc
      ChannelVolumeTable(sc.Smp) = sc.FinalVol128
    End If
    i_4 = (i_4 + 1)
    sc = AdvIdx(sc, 1)
  Loop
  sc = Null
  Dim count As Int = 2
  For i_5 = 0 To 99
    If (ChannelCountTable(i_5) > count) Then
      count = Bit.And((ChannelCountTable(i_5)), 255)
      sc = ChannelLocationTable(i_5)
    End If
  Next
  If (sc <> Null) Then
    Return AllocateChannelInstrument(hc, sc, ins, hcFlags, hcFlags_o)
  End If
  For tmp6 = 0 To 64 - 1
    ChannelCountTable(0 + tmp6) = 0
  Next
  sc = AllocateSlaveOffset
  Dim i_6 As Long = 0
  Do While (i_6 < AllocateNumChannels)
    ChannelCountTable(Bit.And(sc.HostChnNum, 63)) = (ChannelCountTable(Bit.And(sc.HostChnNum, 63)) + 1)
    i_6 = (i_6 + 1)
    sc = AdvIdx(sc, 1)
  Loop
  Dim lowestVol As Int
  Do While True
    hostChnNum = 0
    count = 1
    For i_7 = 0 To 63
      If (ChannelCountTable(i_7) > count) Then
        count = Bit.And((ChannelCountTable(i_7)), 255)
        hostChnNum = Bit.And(i_7, 255)
      End If
    Next
    If (count <= 1) Then
      sc = Null
      Dim scTmp As it2play_slaveChn_t = AllocateSlaveOffset
      lowestVol = 255
      Dim i_8 As Long = 0
      Do While (i_8 < AllocateNumChannels)
        If ((Bit.And(scTmp.HostChnNum, 128) <> 0) And (scTmp.FinalVol128 <= lowestVol)) Then
          sc = scTmp
          lowestVol = scTmp.FinalVol128
        End If
        i_8 = (i_8 + 1)
        scTmp = AdvIdx(scTmp, 1)
      Loop
      If (sc = Null) Then
        hcFlags(hcFlags_o) = Bit.And(hcFlags(hcFlags_o), Bit.Not(4))
        Return Null
      End If
      Return AllocateChannelInstrument(hc, sc, ins, hcFlags, hcFlags_o)
    End If
    hostChnNum = ToS16(Bit.Or(hostChnNum, 128))
    sc = Null
    lowestVol = 255
    Dim targetSmp As Int = Bit.And((hc.Smp - 1), 255)
    Dim scTmp_2 As it2play_slaveChn_t = AllocateSlaveOffset
    Dim i_9 As Long = 0
    Do While (i_9 < AllocateNumChannels)
      If ((scTmp_2.HostChnNum <> hostChnNum) Or (scTmp_2.FinalVol128 >= lowestVol)) Then
        i_9 = (i_9 + 1)
        scTmp_2 = AdvIdx(scTmp_2, 1)
        Continue
      End If
      If (scTmp_2.Smp = targetSmp) Then
        sc = scTmp_2
        lowestVol = scTmp_2.FinalVol128
        i_9 = (i_9 + 1)
        scTmp_2 = AdvIdx(scTmp_2, 1)
        Continue
      End If
      Dim scTmp2 As it2play_slaveChn_t = AllocateSlaveOffset
      Dim scSmp As Int = scTmp_2.Smp
      scTmp_2.Smp = 255
      Dim j As Long = 0
      Do While (j < AllocateNumChannels)
        If ((scTmp2.Smp = targetSmp) Or (scTmp2.Smp = scSmp)) Then
          sc = scTmp_2
          lowestVol = scTmp_2.FinalVol128
          Exit
        End If
        j = (j + 1)
        scTmp2 = AdvIdx(scTmp2, 1)
      Loop
      scTmp_2.Smp = scSmp
      i_9 = (i_9 + 1)
      scTmp_2 = AdvIdx(scTmp_2, 1)
    Loop
    If (sc <> Null) Then
      Exit
    End If
    ChannelCountTable(Bit.And(hostChnNum, 63)) = 0
  Loop
  lowestVol = 255
  Dim scTmp_3 As it2play_slaveChn_t = AllocateSlaveOffset
  Dim i_10 As Long = 0
  Do While (i_10 < AllocateNumChannels)
    If (((scTmp_3.Smp = sc.Smp) And (Bit.And(scTmp_3.HostChnNum, 128) <> 0)) And (scTmp_3.FinalVol128 < lowestVol)) Then
      sc = scTmp_3
      lowestVol = scTmp_3.FinalVol128
    End If
    i_10 = (i_10 + 1)
    scTmp_3 = AdvIdx(scTmp_3, 1)
  Loop
  Return AllocateChannelInstrument(hc, sc, ins, hcFlags, hcFlags_o)
End Sub

Private Sub ITRandom As Int
  Dim r1 As Int
  Dim r2 As Int
  Dim r3 As Int
  Dim r4 As Int
  r1 = RandSeed1
  r4 = RandSeed2
  r3 = r4
  r2 = r3
  r1 = Bit.And((r1 + r2), 65535)
  r1 = Bit.And((Bit.Or((Bit.ShiftLeft(r1, (Bit.And(r3, 15)))), (Bit.ShiftRight(r1, (Bit.And((16 - r3), 15)))))), 65535)
  r1 = Bit.And((Bit.Xor(r1, r4)), 65535)
  r3 = Bit.And((Bit.Or((Bit.ShiftRight(r3, 8)), (Bit.ShiftLeft(r3, 8)))), 65535)
  r2 = Bit.And((r2 + r3), 65535)
  r4 = Bit.And((r4 + r2), 65535)
  r3 = Bit.And((r3 + r1), 65535)
  r1 = Bit.And((r1 - (r4 + (Bit.And(r2, 1)))), 65535)
  r2 = Bit.And((Bit.Or((Bit.ShiftLeft(r2, 15)), (Bit.ShiftRight(r2, 1)))), 65535)
  RandSeed2 = r4
  RandSeed1 = r1
  Return (Bit.And(r1, 255))
End Sub

Private Sub GetLoopInformation(sc As it2play_slaveChn_t)
  Dim LoopMode As Int
  Dim LoopBegin As Int
  Dim LoopEnd As Int
  Dim s As it2play_sample_t = sc.SmpPtr
  Dim LoopEnabled As Boolean = (Bit.And(s.Flags, 48) <> 0)
  Dim SustainLoopOnlyAndNoteOff As Boolean = (((Bit.And(s.Flags, 32) <> 0) And (Bit.And(sc.Flags, 4) <> 0)) And Not((Bit.And(s.Flags, 16) <> 0)))
  If (Not(LoopEnabled) Or SustainLoopOnlyAndNoteOff) Then
    LoopBegin = 0
    LoopEnd = L2I(s.Length)
    LoopMode = 0
  Else
    LoopBegin = L2I(s.LoopBegin)
    LoopEnd = L2I(s.LoopEnd)
    LoopMode = s.Flags
    If (Bit.And(s.Flags, 32) <> 0) Then
      If Not((Bit.And(sc.Flags, 4) <> 0)) Then
        LoopBegin = L2I(s.SustainLoopBegin)
        LoopEnd = L2I(s.SustainLoopEnd)
        LoopMode = ToS16(Bit.ShiftRight(LoopMode, 1))
      End If
    End If
    LoopMode = Bit.And((IIf((Bit.And(LoopMode, 64) <> 0), 24, 8)), 255)
  End If
  If (((sc.LoopMode <> LoopMode) Or (sc.LoopBegin <> LoopBegin)) Or (sc.LoopEnd <> LoopEnd)) Then
    sc.LoopMode = LoopMode
    sc.LoopBegin = LoopBegin
    sc.LoopEnd = LoopEnd
    sc.Flags = Bit.Or(sc.Flags, 1024)
    If (sc.SamplingPosition < sc.LoopBegin) Then
      sc.HasLooped = False
    End If
  End If
End Sub

Private Sub ApplyRandomValues(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  Dim ins As it2play_instrument_t = sc.InsPtr
  hc.Flags = Bit.And(hc.Flags, Bit.Not(128))
  Dim value As Int = ToS8(ITRandom)
  If (ins.RandVol <> 0) Then
    Dim vol As Int = ToS16(((Bit.ShiftRight((ToS8(ins.RandVol) * value), 6)) + 1))
    vol = ToS16((sc.SmpVol + (IDiv((vol * ToS16(sc.SmpVol)), 199))))
    If (vol < 0) Then
      vol = 0
    Else If (vol > 128) Then
      vol = 128
    End If
    sc.SmpVol = (Bit.And(vol, 255))
  End If
  value = ToS8(ITRandom)
  If ((ins.RandPan <> 0) And (sc.Pan <> 100)) Then
    Dim pan As Int = ToS16((sc.Pan + (Bit.ShiftRight((ToS8(ins.RandPan) * value), 7))))
    If (pan < 0) Then
      pan = 0
    Else If (pan > 64) Then
      pan = 64
    End If
    sc.PanSet = (Bit.And(pan, 255))
    sc.Pan = sc.PanSet
  End If
End Sub

Private Sub PitchSlideUp(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, SlideValue As Int)
  If (Bit.And(Song.Header.Flags, 8) <> 0) Then
    PitchSlideUpLinear(hc, sc, SlideValue)
  Else
    sc.Flags = Bit.Or(sc.Flags, 32)
    Dim PeriodBase As Long = 14317456
    If (SlideValue < 0) Then
      SlideValue = ToS16((-SlideValue))
      Dim FreqSlide64 As Long = (I2L(sc.Frequency) * (Bit.AndLong(SlideValue, 4294967295)))
      If (FreqSlide64 > 4294967295) Then
        sc.Flags = Bit.Or(sc.Flags, 512)
        hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
        Return
      End If
      FreqSlide64 = (FreqSlide64 + PeriodBase)
      Dim ShiftValue As Long = 0
      Do While (FreqSlide64 > 4294967295)
        FreqSlide64 = Bit.ShiftRightLong(FreqSlide64, 1)
        ShiftValue = Bit.AndLong((ShiftValue + 1), 4294967295)
      Loop
      Dim Temp32 As Long = (Bit.AndLong(FreqSlide64, 4294967295))
      Dim Temp64 As Long = (I2L(sc.Frequency) * PeriodBase)
      If (ShiftValue > 0) Then
        Temp64 = Bit.ShiftRightLong(Temp64, L2I(ShiftValue))
      End If
      If (Temp32 <= Bit.ShiftRightLong(Temp64, 32)) Then
        sc.Flags = Bit.Or(sc.Flags, 512)
        hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
        Return
      End If
      sc.Frequency = L2I((Bit.AndLong((IDivL(Temp64, Temp32)), 4294967295)))
    Else
      Dim FreqSlide64_2 As Long = (I2L(sc.Frequency) * (Bit.AndLong(SlideValue, 4294967295)))
      If (FreqSlide64_2 > 4294967295) Then
        sc.Flags = Bit.Or(sc.Flags, 512)
        hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
        Return
      End If
      Dim FreqSlide32 As Long = (Bit.AndLong(FreqSlide64_2, 4294967295))
      Dim Temp32_2 As Long = Bit.AndLong((PeriodBase - FreqSlide32), 4294967295)
      If (L2I(Temp32_2) <= 0) Then
        sc.Flags = Bit.Or(sc.Flags, 512)
        hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
        Return
      End If
      Dim Temp64_2 As Long = (I2L(sc.Frequency) * PeriodBase)
      If (Temp32_2 <= Bit.ShiftRightLong(Temp64_2, 32)) Then
        sc.Flags = Bit.Or(sc.Flags, 512)
        hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
        Return
      End If
      sc.Frequency = L2I((Bit.AndLong((IDivL(Temp64_2, Temp32_2)), 4294967295)))
    End If
  End If
End Sub

Private Sub PitchSlideUpLinear(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, SlideValue As Int)
  sc.Flags = Bit.Or(sc.Flags, 32)
  If (SlideValue < 0) Then
    SlideValue = ToS16((-SlideValue))
    Dim SlideTable2() As Int
    Dim SlideTable2_o As Int
    If (SlideValue <= 15) Then
      SlideTable2 = FineLinearSlideDownTable
      SlideTable2_o = 0
    Else
      SlideTable2 = LinearSlideDownTable
      SlideTable2_o = 0
      SlideValue = ToS16(Bit.ShiftRight(SlideValue, 2))
    End If
    sc.Frequency = L2I(Bit.ShiftRightLong((I2L(sc.Frequency) * SlideTable2((SlideTable2_o + SlideValue))), 16))
  Else
    Dim SlideTable2_2() As Long
    Dim SlideTable2_2_o As Int
    If (SlideValue <= 15) Then
      SlideTable2_2 = FineLinearSlideUpTable
      SlideTable2_2_o = 0
    Else
      SlideTable2_2 = LinearSlideUpTable
      SlideTable2_2_o = 0
      SlideValue = ToS16(Bit.ShiftRight(SlideValue, 2))
    End If
    Dim Frequency As Long = Bit.ShiftRightLong((I2L(sc.Frequency) * SlideTable2_2((SlideTable2_2_o + SlideValue))), 16)
    If (Bit.AndLong(Frequency, (-281474976710656)) <> 0) Then
      sc.Flags = Bit.Or(sc.Flags, 512)
      hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
    Else
      sc.Frequency = L2I((Bit.AndLong(Frequency, 4294967295)))
    End If
  End If
End Sub

Private Sub PitchSlideDown(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, SlideValue As Int)
  PitchSlideUp(hc, sc, (-SlideValue))
End Sub

Private Sub Music_GetPattern(pattern As Long, numRows() As Int, numRows_o As Int) As Byte()
  Dim p As it2play_pattern_t = Song.Patt(L2I(pattern))
  If (p.PackedData = Null) Then
    numRows(numRows_o) = 64
    RetOfs = 0
    Return EmptyPattern
  End If
  numRows(numRows_o) = p.Rows
  RetOfs = p.PackedData_o
  Return p.PackedData
End Sub

Private Sub PreInitCommand(hc As it2play_hostChn_t)
  If (Bit.And(hc.NotePackMask, 51) <> 0) Then
    If ((Not((Bit.And(Song.Header.Flags, 4) <> 0)) Or (hc.RawNote >= 120)) Or (hc.Ins = 0)) Then
      hc.TranslatedNote = hc.RawNote
      hc.Smp = hc.Ins
    Else
      Dim ins As it2play_instrument_t = Song.Ins((hc.Ins - 1))
      hc.TranslatedNote = Bit.And(ins.SmpNoteTable(hc.RawNote), 255)
      If ((ins.MIDIChn = 0) Or (ins.MIDIChn > 128)) Then
        hc.Smp = Bit.And((Bit.ShiftRight(ins.SmpNoteTable(hc.RawNote), 8)), 255)
      Else
        hc.MIDIChn = Bit.And((IIf((ins.MIDIChn = 17), ((Bit.And(hc.HostChnNum, 15)) + 1), ins.MIDIChn)), 255)
        hc.MIDIProg = ins.MIDIProg
        hc.Smp = 101
      End If
      If (hc.Smp = 0) Then
        Return
      End If
    End If
  End If
  InitCommandTableProccessor(Bit.And(hc.Cmd, 31), hc)
  hc.Flags = Bit.Or(hc.Flags, 64)
  Dim ChannelMuted As Boolean = (Bit.And(Song.Header.ChnlPan(hc.HostChnNum), 128) <> 0)
  If ((ChannelMuted And Not((Bit.And(hc.Flags, 32) <> 0))) And (Bit.And(hc.Flags, 4) <> 0)) Then
    hc.SlaveChnPtr.Flags = Bit.Or(hc.SlaveChnPtr.Flags, 2048)
  End If
End Sub

Private Sub UpdateGOTONote
  Song.DecodeExpectedPattern = Song.CurrentPattern
  Dim p() As Byte
  Dim p_o As Int
  Dim tmp7(1) As Int
  tmp7(0) = Song.NumberOfRows
  p = Music_GetPattern(Song.DecodeExpectedPattern, tmp7, 0)
  p_o = RetOfs
  Song.NumberOfRows = tmp7(0)
  If (Song.ProcessRow >= Song.NumberOfRows) Then
    Song.ProcessRow = 0
  End If
  Song.CurrentRow = Song.ProcessRow
  Song.DecodeExpectedRow = Song.CurrentRow
  Dim rowsTodo As Int = Song.ProcessRow
  If (rowsTodo > 0) Then
    Do While True
      Dim tmp9 As Int = p(p_o)
      p_o = p_o + 1
      Dim chnNum As Int = Bit.And(tmp9, 255)
      If (chnNum = 0) Then
        rowsTodo = Bit.And((rowsTodo - 1), 65535)
        If (rowsTodo = 0) Then
          Exit
        End If
        Continue
      End If
      Dim hc As it2play_hostChn_t = hChn(((Bit.And(chnNum, 127)) - 1))
      If (Bit.And(chnNum, 128) <> 0) Then
        Dim tmp11 As Int = p(p_o)
        p_o = p_o + 1
        hc.NotePackMask = Bit.And(tmp11, 255)
      End If
      If (Bit.And(hc.NotePackMask, 1) <> 0) Then
        Dim tmp13 As Int = p(p_o)
        p_o = p_o + 1
        hc.RawNote = Bit.And(tmp13, 255)
      End If
      If (Bit.And(hc.NotePackMask, 2) <> 0) Then
        Dim tmp15 As Int = p(p_o)
        p_o = p_o + 1
        hc.Ins = Bit.And(tmp15, 255)
      End If
      If (Bit.And(hc.NotePackMask, 4) <> 0) Then
        Dim tmp17 As Int = p(p_o)
        p_o = p_o + 1
        hc.RawVolColumn = Bit.And(tmp17, 255)
      End If
      If (Bit.And(hc.NotePackMask, 8) <> 0) Then
        Dim tmp19 As Int = p(p_o)
        p_o = p_o + 1
        hc.OldCmd = Bit.And(tmp19, 255)
        Dim tmp21 As Int = p(p_o)
        p_o = p_o + 1
        hc.OldCmdVal = Bit.And(tmp21, 255)
      End If
    Loop
  End If
  Song.PatternOffset = p
  Song.PatternOffset_o = p_o
End Sub

Private Sub UpdateNoteData
  Dim hc As it2play_hostChn_t
  Song.PatternLooping = False
  Song.DecodeExpectedRow = Bit.And((Song.DecodeExpectedRow + 1), 65535)
  If ((Song.CurrentPattern <> Song.DecodeExpectedPattern) Or (Song.DecodeExpectedRow <> Song.CurrentRow)) Then
    UpdateGOTONote
  End If
  hc = hChn(0)
  Dim i As Int = 0
  Do While (i < 64)
    hc.Flags = Bit.And(hc.Flags, Bit.Not(323))
    i = (i + 1)
    hc = AdvIdx(hc, 1)
  Loop
  Dim p() As Byte
  Dim p_o As Int
  p = Song.PatternOffset
  p_o = Song.PatternOffset_o
  Do While True
    Dim tmp23 As Int = p(p_o)
    p_o = p_o + 1
    Dim chnNum As Int = Bit.And(tmp23, 255)
    If (chnNum = 0) Then
      Exit
    End If
    hc = hChn(((Bit.And(chnNum, 127)) - 1))
    If (Bit.And(chnNum, 128) <> 0) Then
      Dim tmp25 As Int = p(p_o)
      p_o = p_o + 1
      hc.NotePackMask = Bit.And(tmp25, 255)
    End If
    If (Bit.And(hc.NotePackMask, 1) <> 0) Then
      Dim tmp27 As Int = p(p_o)
      p_o = p_o + 1
      hc.RawNote = Bit.And(tmp27, 255)
    End If
    If (Bit.And(hc.NotePackMask, 2) <> 0) Then
      Dim tmp29 As Int = p(p_o)
      p_o = p_o + 1
      hc.Ins = Bit.And(tmp29, 255)
    End If
    If (Bit.And(hc.NotePackMask, 4) <> 0) Then
      Dim tmp31 As Int = p(p_o)
      p_o = p_o + 1
      hc.RawVolColumn = Bit.And(tmp31, 255)
    End If
    If (Bit.And(hc.NotePackMask, 8) <> 0) Then
      Dim tmp33 As Int = p(p_o)
      p_o = p_o + 1
      hc.OldCmd = Bit.And(tmp33, 255)
      hc.Cmd = hc.OldCmd
      Dim tmp35 As Int = p(p_o)
      p_o = p_o + 1
      hc.OldCmdVal = Bit.And(tmp35, 255)
      hc.CmdVal = hc.OldCmdVal
    Else If (Bit.And(hc.NotePackMask, 128) <> 0) Then
      hc.Cmd = hc.OldCmd
      hc.CmdVal = hc.OldCmdVal
    Else
      hc.Cmd = 0
      hc.CmdVal = 0
    End If
    PreInitCommand(hc)
  Loop
  Song.PatternOffset = p
  Song.PatternOffset_o = p_o
End Sub

Private Sub UpdateData
  Song.ProcessTick = Bit.And((Song.ProcessTick - 1), 65535)
  Song.CurrentTick = Bit.And((Song.CurrentTick - 1), 65535)
  If (Song.CurrentTick = 0) Then
    Song.CurrentTick = Song.CurrentSpeed
    Song.ProcessTick = Song.CurrentTick
    Song.RowDelay = Bit.And((Song.RowDelay - 1), 255)
    If (Song.RowDelay = 0) Then
      Song.RowDelay = 1
      Song.RowDelayOn = False
      Dim NewRow As Int = Bit.And((Song.ProcessRow + 1), 65535)
      If (NewRow >= Song.NumberOfRows) Then
        Dim NewOrder As Int = Bit.And((Song.ProcessOrder + 1), 65535)
        Do While True
          If (NewOrder >= 256) Then
            NewOrder = 0
            Continue
          End If
          Dim NewPattern As Int = Song.Orders(NewOrder)
          If (NewPattern >= 200) Then
            If (NewPattern = 254) Then
              NewOrder = Bit.And((NewOrder + 1), 65535)
            Else
              NewOrder = 0
              Song.StopSong = True
            End If
          Else
            Song.CurrentPattern = NewPattern
            Exit
          End If
        Loop
        Song.ProcessOrder = NewOrder
        Song.CurrentOrder = Song.ProcessOrder
        NewRow = Song.BreakRow
        Song.BreakRow = 0
      End If
      Song.ProcessRow = NewRow
      Song.CurrentRow = Song.ProcessRow
      UpdateNoteData
    Else
      Dim hc As it2play_hostChn_t = hChn(0)
      Dim i As Int = 0
      Do While (i < 64)
        If (Not((Bit.And(hc.Flags, 64) <> 0)) Or Not((Bit.And(hc.NotePackMask, 136) <> 0))) Then
          i = (i + 1)
          hc = AdvIdx(hc, 1)
          Continue
        End If
        Dim OldNotePackMask As Int = hc.NotePackMask
        hc.NotePackMask = Bit.And(hc.NotePackMask, 136)
        InitCommandTableProccessor(Bit.And(hc.Cmd, 31), hc)
        hc.NotePackMask = OldNotePackMask
        i = (i + 1)
        hc = AdvIdx(hc, 1)
      Loop
    End If
  Else
    Dim hc_2 As it2play_hostChn_t = hChn(0)
    Dim i_2 As Int = 0
    Do While (i_2 < 64)
      If ((Bit.And(hc_2.Flags, 4) <> 0) And (Bit.And(hc_2.Flags, 256) <> 0)) Then
        VolumeEffectTableProccessor(Bit.And(hc_2.VolCmd, 7), hc_2)
      End If
      If ((Bit.And(hc_2.Flags, 3) <> 0) And ((Bit.And(hc_2.Flags, 2) <> 0) Or (Bit.And(hc_2.Flags, 4) <> 0))) Then
        CommandTableProccessor(Bit.And(hc_2.Cmd, 31), hc_2)
      End If
      i_2 = (i_2 + 1)
      hc_2 = AdvIdx(hc_2, 1)
    Loop
  End If
End Sub

Private Sub UpdateAutoVibrato(sc As it2play_slaveChn_t)
  Dim smp As it2play_sample_t = sc.SmpPtr
  If (smp.AutoVibratoDepth = 0) Then
    Return
  End If
  sc.AutoVibratoDepth = Bit.And((sc.AutoVibratoDepth + smp.AutoVibratoRate), 65535)
  If (Bit.ShiftRight(sc.AutoVibratoDepth, 8) > smp.AutoVibratoDepth) Then
    sc.AutoVibratoDepth = Bit.And((Bit.Or((Bit.ShiftLeft(smp.AutoVibratoDepth, 8)), (Bit.And(sc.AutoVibratoDepth, 255)))), 65535)
  End If
  If (smp.AutoVibratoSpeed = 0) Then
    Return
  End If
  Dim VibratoData As Int
  If (smp.AutoVibratoWaveform = 3) Then
    VibratoData = ToS16(((Bit.And(ITRandom, 127)) - 64))
  Else
    sc.AutoVibratoPos = Bit.And((sc.AutoVibratoPos + smp.AutoVibratoSpeed), 255)
    VibratoData = FineSineData(((Bit.ShiftLeft(smp.AutoVibratoWaveform, 8)) + sc.AutoVibratoPos))
  End If
  VibratoData = ToS16(Bit.ShiftRight((VibratoData * ToS16((Bit.ShiftRight(sc.AutoVibratoDepth, 8)))), 6))
  If (VibratoData <> 0) Then
    PitchSlideUpLinear(sc.HostChnPtr, sc, VibratoData)
  End If
End Sub

Private Sub UpdateEnvelope(env As it2play_env_t, envState As it2play_envState_t, SustainReleased As Boolean) As Boolean
  If (envState.Tick < envState.NextTick) Then
    envState.Tick = (envState.Tick + 1)
    envState.Value = (envState.Value + envState.Delta)
    Return False
  End If
  Dim Nodes() As it2play_envNode_t = env.NodePoints
  envState.Value = Bit.ShiftLeft(Nodes(Bit.And(envState.CurNode, 255)).Magnitude, 16)
  Dim NextNode As Int = ToS16(((Bit.And(envState.CurNode, 255)) + 1))
  If (Bit.And(env.Flags, 6) <> 0) Then
    Dim LoopBegin As Int = env.LoopBegin
    Dim LoopEnd As Int = env.LoopEnd
    Dim HasLoop As Boolean = (Bit.And(env.Flags, 2) <> 0)
    Dim HasSustainLoop As Boolean = (Bit.And(env.Flags, 4) <> 0)
    Dim Looping As Boolean = True
    If HasSustainLoop Then
      If Not(SustainReleased) Then
        LoopBegin = env.SustainLoopBegin
        LoopEnd = env.SustainLoopEnd
      Else If Not(HasLoop) Then
        Looping = False
      End If
    End If
    If (Looping And (NextNode > LoopEnd)) Then
      envState.CurNode = Bit.Or((Bit.And(envState.CurNode, 65280)), LoopBegin)
      envState.NextTick = Nodes(Bit.And(envState.CurNode, 255)).Tick
      envState.Tick = envState.NextTick
      Return False
    End If
  End If
  If (NextNode >= env.Num) Then
    Return True
  End If
  envState.NextTick = Nodes(NextNode).Tick
  envState.Tick = (Nodes(Bit.And(envState.CurNode, 255)).Tick + 1)
  Dim TickDelta As Int = ToS16((envState.NextTick - Nodes(Bit.And(envState.CurNode, 255)).Tick))
  If (TickDelta = 0) Then
    TickDelta = 1
  End If
  Dim Delta As Int = ToS16((Nodes(NextNode).Magnitude - Nodes(Bit.And(envState.CurNode, 255)).Magnitude))
  envState.Delta = IDiv((Bit.ShiftLeft(Delta, 16)), TickDelta)
  envState.CurNode = Bit.Or((Bit.And(envState.CurNode, 65280)), (Bit.And(NextNode, 255)))
  Return False
End Sub

Private Sub UpdateInstruments
  Dim sc As it2play_slaveChn_t = sChn(0)
  Dim i As Int = 0
  Do While (i < 256)
    If Not((Bit.And(sc.Flags, 1) <> 0)) Then
      i = (i + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    If (sc.Ins <> 255) Then
      Dim EnvVal As Int
      Dim ins As it2play_instrument_t = sc.InsPtr
      Dim SustainReleased As Boolean = (Bit.And(sc.Flags, 4) <> 0)
      If (Bit.And(sc.Flags, 16384) <> 0) Then
        If UpdateEnvelope(ins.PitchEnv, sc.PitchEnvState, SustainReleased) Then
          sc.Flags = Bit.And(sc.Flags, Bit.Not(16384))
        End If
      End If
      If Not((Bit.And(ins.PitchEnv.Flags, 128) <> 0)) Then
        EnvVal = ToS16(ToS16(L2I((Bit.ShiftRightLong((Bit.AndLong(sc.PitchEnvState.Value, 4294967295)), 8)))))
        EnvVal = ToS16(Bit.ShiftRight(EnvVal, 3))
        If (EnvVal <> 0) Then
          PitchSlideUpLinear(sc.HostChnPtr, sc, EnvVal)
          sc.Flags = Bit.Or(sc.Flags, 32)
        End If
      Else If (sc.Smp <> 100) Then
        EnvVal = ToS16(ToS16(L2I((Bit.ShiftRightLong((Bit.AndLong(sc.PitchEnvState.Value, 4294967295)), 8)))))
        EnvVal = ToS16(Bit.ShiftRight(EnvVal, 6))
        EnvVal = ToS16((EnvVal + 128))
        If (Bit.And(EnvVal, 65280) <> 0) Then
          EnvVal = ToS16((EnvVal - 1))
        End If
        sc.MIDIBank = Bit.Or((Bit.And(sc.MIDIBank, 65280)), (Bit.And(EnvVal, 255)))
        sc.Flags = Bit.Or(sc.Flags, 64)
      End If
      If (Bit.And(sc.Flags, 8192) <> 0) Then
        sc.Flags = Bit.Or(sc.Flags, 2)
        If UpdateEnvelope(ins.PanEnv, sc.PanEnvState, SustainReleased) Then
          sc.Flags = Bit.And(sc.Flags, Bit.Not(8192))
        End If
      End If
      Dim HandleNoteFade As Boolean = False
      Dim TurnOffCh As Boolean = False
      If (Bit.And(sc.Flags, 4096) <> 0) Then
        sc.Flags = Bit.Or(sc.Flags, 16)
        If UpdateEnvelope(ins.VolEnv, sc.VolEnvState, SustainReleased) Then
          sc.Flags = Bit.And(sc.Flags, Bit.Not(4096))
          If ((Bit.And(sc.VolEnvState.Value, 16711680)) = 0) Then
            TurnOffCh = True
          Else
            sc.Flags = Bit.Or(sc.Flags, 8)
            HandleNoteFade = True
          End If
        Else
          If Not((Bit.And(sc.Flags, 8) <> 0)) Then
            If (SustainReleased And (Bit.And(ins.VolEnv.Flags, 2) <> 0)) Then
              sc.Flags = Bit.Or(sc.Flags, 8)
              HandleNoteFade = True
            End If
          Else
            HandleNoteFade = True
          End If
        End If
      Else If (Bit.And(sc.Flags, 8) <> 0) Then
        HandleNoteFade = True
      Else If (Bit.And(sc.Flags, 4) <> 0) Then
        sc.Flags = Bit.Or(sc.Flags, 8)
        HandleNoteFade = True
      End If
      If HandleNoteFade Then
        sc.FadeOut = Bit.And((sc.FadeOut - ins.FadeOut), 65535)
        If (ToS16(sc.FadeOut) <= 0) Then
          sc.FadeOut = 0
          TurnOffCh = True
        End If
        sc.Flags = Bit.Or(sc.Flags, 16)
      End If
      If TurnOffCh Then
        If Not((Bit.And(sc.HostChnNum, 128) <> 0)) Then
          sc.HostChnNum = Bit.Or(sc.HostChnNum, 128)
          sc.HostChnPtr.Flags = Bit.And(sc.HostChnPtr.Flags, Bit.Not(4))
        End If
        sc.Flags = Bit.Or(sc.Flags, 528)
      End If
    End If
    If (Bit.And(sc.Flags, 16) <> 0) Then
      sc.Flags = Bit.And(sc.Flags, Bit.Not(16))
      sc.Flags = Bit.Or(sc.Flags, 64)
      Dim volume As Int = Bit.And((Bit.ShiftRight(((sc.Vol * sc.ChnVol) * sc.FadeOut), 7)), 65535)
      volume = Bit.And((Bit.ShiftRight((volume * sc.SmpVol), 7)), 65535)
      volume = L2I(Bit.AndLong((Bit.ShiftRightLong((volume * (Bit.AndLong((Bit.ShiftRightLong((Bit.AndLong(sc.VolEnvState.Value, 4294967295)), 8)), 65535))), 14)), 65535))
      volume = Bit.And((Bit.ShiftRight((volume * Song.GlobalVolume), 7)), 65535)
      sc.FinalVol32768 = volume
      sc.FinalVol128 = Bit.And((Bit.ShiftRight(volume, 8)), 255)
    End If
    If (Bit.And(sc.Flags, 2) <> 0) Then
      sc.Flags = Bit.And(sc.Flags, Bit.Not(2))
      sc.Flags = Bit.Or(sc.Flags, 32768)
      If (sc.Pan = 100) Then
        sc.FinalPan = sc.Pan
      Else
        Dim PanVal As Int = ToS8((32 - sc.Pan))
        If (PanVal < 0) Then
          PanVal = ToS8(Bit.Xor(PanVal, 255))
          PanVal = ToS8((PanVal - 255))
        End If
        PanVal = ToS8((-PanVal))
        PanVal = ToS8((PanVal + 32))
        Dim PanEnvVal As Int = ToS8(ToS8((Bit.ShiftRight(sc.PanEnvState.Value, 16))))
        PanVal = ToS8((sc.Pan + (Bit.ShiftRight((PanVal * PanEnvVal), 5))))
        PanVal = ToS8((PanVal - 32))
        sc.FinalPan = Bit.And((ToS8(((Bit.ShiftRight((PanVal * ToS8((Bit.ShiftRight(Song.Header.PanSep, 1)))), 6)) + 32))), 255)
      End If
    End If
    UpdateAutoVibrato(sc)
    i = (i + 1)
    sc = AdvIdx(sc, 1)
  Loop
End Sub

Private Sub UpdateSamples
  Dim sc As it2play_slaveChn_t = sChn(0)
  Dim i As Long = 0
  Do While (i < Driver.NumChannels)
    If Not((Bit.And(sc.Flags, 1) <> 0)) Then
      i = (i + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    If (Bit.And(sc.Flags, 16) <> 0) Then
      sc.Flags = Bit.And(sc.Flags, Bit.Not(16))
      sc.Flags = Bit.Or(sc.Flags, 64)
      Dim volume As Int = Bit.And((Bit.ShiftRight(((Bit.ShiftRight(((sc.Vol * sc.ChnVol) * sc.SmpVol), 4)) * Song.GlobalVolume), 7)), 65535)
      sc.FinalVol32768 = volume
      sc.FinalVol128 = Bit.And((Bit.ShiftRight(volume, 8)), 255)
    End If
    If (Bit.And(sc.Flags, 2) <> 0) Then
      sc.Flags = Bit.And(sc.Flags, Bit.Not(2))
      sc.Flags = Bit.Or(sc.Flags, 32768)
      If (sc.Pan = 100) Then
        sc.FinalPan = sc.Pan
      Else
        sc.FinalPan = Bit.And(((Bit.ShiftRight(((ToS8(sc.Pan) - 32) * ToS8((Bit.ShiftRight(Song.Header.PanSep, 1)))), 6)) + 32), 255)
      End If
    End If
    UpdateAutoVibrato(sc)
    i = (i + 1)
    sc = AdvIdx(sc, 1)
  Loop
End Sub

Private Sub UpdateIT
  Dim sc As it2play_slaveChn_t = sChn(0)
  Dim i As Long = 0
  Do While (i < 256)
    If Not((Bit.And(sc.Flags, 1) <> 0)) Then
      i = (i + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    If (sc.Vol <> sc.VolSet) Then
      sc.Vol = sc.VolSet
      sc.Flags = Bit.Or(sc.Flags, 16)
    End If
    If (sc.Frequency <> sc.FrequencySet) Then
      sc.Frequency = sc.FrequencySet
      sc.Flags = Bit.Or(sc.Flags, 32)
    End If
    i = (i + 1)
    sc = AdvIdx(sc, 1)
  Loop
  UpdateData
  If (Bit.And(Song.Header.Flags, 4) <> 0) Then
    UpdateInstruments
  Else
    UpdateSamples
  End If
End Sub

Private Sub Music_FillAudioBuffer(buffer() As Short, buffer_o As Int, numSamples As Int)
  If Not(Song.Playing) Then
    For tmp36 = 0 To (numSamples * 2) - 1
      buffer(buffer_o + tmp36) = 0
    Next
    Return
  End If
  HQ_Mix(numSamples, buffer, buffer_o)
End Sub

Public Sub Music_Init(mixingFrequency As Int, mixingBufferSize As Int) As Boolean
  If FirstTimeInit Then
    FirstTimeInit = False
  Else
    Music_Close
  End If
  If Not(openMixer(mixingFrequency, mixingBufferSize)) Then
    Return False
  End If
  HQ_InitDriver(mixingFrequency)
  Return True
End Sub

Private Sub Music_CalculateFilterTables(mixingFrequency As Long)
  If Bit.And(Driver.Flags, 8) <> 0 Then
    Dim filterStep As Double
    If ((Bit.And(Song.Header.Flags, 4096) <> 0) And (Bit.And(Driver.Flags, 16) <> 0)) Then
      filterStep = 20.0
    Else
      filterStep = 24.0
    End If
    For i = 0 To 127
      Driver.QualityFactorTable(i) = Power(10.0, (((-i) * filterStep) / (128.0 * 20.0)))
    Next
    Driver.FreqParameterMultiplier = ((-1.0) / (filterStep * 256.0))
    Driver.FreqMultiplier = ((1.0 / (((2.0 * cPI) * 110.0) * Power(2, 0.25))) * mixingFrequency)
  End If
End Sub

Public Sub Music_Close
  closeMixer
  HQ_CloseDriver
End Sub

Private Sub Music_InitTempo
  HQ_SetTempo(Bit.And(Song.Tempo, 255))
End Sub

Public Sub Music_Stop
  Song.Playing = False
  lockMixer
  MIDITranslate(Null, sChn(0), 32)
  Song.DecodeExpectedPattern = 65534
  Song.DecodeExpectedRow = 65534
  Song.RowDelay = 1
  Song.RowDelayOn = False
  Song.CurrentRow = 0
  Song.CurrentOrder = 0
  Song.CurrentTick = 1
  Song.BreakRow = 0

  Clear_hChn
  Clear_sChn
  
  Dim hc As it2play_hostChn_t = hChn(0)
  Dim i As Int = 0
  Do While (i < 64)
    hc.HostChnNum = Bit.And(i, 255)
    hc.ChnPan = Bit.And(Song.Header.ChnlPan(i), 127)
    hc.ChnVol = Song.Header.ChnlVol(i)
    i = ToS16((i + 1))
    hc = AdvIdx(hc, 1)
  Loop
  Dim sc As it2play_slaveChn_t = sChn(0)
  Dim i_2 As Long = 0
  Do While (i_2 < 256)
    sc.Flags = 512
    i_2 = (i_2 + 1)
    sc = AdvIdx(sc, 1)
  Loop
  If Song.Loaded Then
    Song.GlobalVolume = Song.Header.GlobalVol
    Song.CurrentSpeed = Song.Header.InitialSpeed
    Song.ProcessTick = Song.CurrentSpeed
    Song.Tempo = Song.Header.InitialTempo
    Music_InitTempo
  End If
  unlockMixer
End Sub

Public Sub Music_StopChannels
  lockMixer
  Dim hc As it2play_hostChn_t = hChn(0)
  Dim i As Int = 0
  Do While (i < 64)
    hc.Flags = 0
    hc.PattLoopCount = 0
    hc.PattLoopStartRow = hc.PattLoopCount
    i = (i + 1)
    hc = AdvIdx(hc, 1)
  Loop
  Dim sc As it2play_slaveChn_t = sChn(0)
  Dim i_2 As Int = 0
  Do While (i_2 < 256)
    sc.Flags = 512
    i_2 = (i_2 + 1)
    sc = AdvIdx(sc, 1)
  Loop
  unlockMixer
End Sub

Public Sub Music_PreviousOrder
  If Not(Song.Playing) Then
    Return
  End If
  If (Song.CurrentOrder > 0) Then
    Music_StopChannels
    lockMixer
    Song.CurrentOrder = Bit.And((Song.CurrentOrder - 2), 65535)
    Song.ProcessOrder = Song.CurrentOrder
    Song.ProcessRow = 65534
    Song.CurrentTick = 1
    Song.RowDelay = 1
    Song.RowDelayOn = False
    unlockMixer
  End If
End Sub

Public Sub Music_NextOrder
  If Not(Song.Playing) Then
    Return
  End If
  If (Song.CurrentOrder < 255) Then
    Music_StopChannels
    lockMixer
    Song.ProcessRow = 65534
    Song.CurrentTick = 1
    Song.RowDelay = 1
    Song.RowDelayOn = False
    unlockMixer
  End If
End Sub

Public Sub Music_PlaySong(order As Int)
  If Not(Song.Loaded) Then
    Return
  End If
  Music_Stop
  MIDITranslate(Null, sChn(0), 0)
  Song.CurrentOrder = order
  Song.ProcessOrder = Bit.And((order - 1), 65535)
  Song.ProcessRow = 65534
  RandSeed1 = 4660
  RandSeed2 = 22136
  MIDIInterpretType = 0
  MIDIInterpretState = MIDIInterpretType
  Song.Playing = True
End Sub

Private Sub Music_ReleasePattern(pattern As Long)
  pattern = Bit.AndLong(pattern, 4294967295)
  lockMixer
  Dim p As it2play_pattern_t = Song.Patt(L2I(pattern))
  p.Rows = 0
  p.PackedData = Null
  p.PackedData_o = 0
  unlockMixer
End Sub
  
Private Sub Music_ReleaseSample(sample As Long)
  sample = Bit.AndLong(sample, 4294967295)
  lockMixer
  Dim s As it2play_sample_t = Song.Smp(sample)
  s.Data8 = Null
  s.Data16 = Null
  s.DataR8 = Null
  s.DataR16 = Null
  unlockMixer
End Sub

Private Sub Music_ReleaseAllPatterns
  For i = 0 To 199
    Music_ReleasePattern(i)
  Next
End Sub

Private Sub Music_ReleaseAllSamples
  For i = 0 To 99
    Music_ReleaseSample(i)
  Next
End Sub

Public Sub Music_FreeSong
  lockMixer
  Music_Stop
  Music_ReleaseAllPatterns
  Music_ReleaseAllSamples
  Clear_Song
  For i = 0 To 255
    Song.Orders(i) = 255
  Next
  Song.Loaded = False
  unlockMixer
End Sub

Public Sub Music_GetActiveVoices As Int
  Dim activeVoices As Int = 0
  Dim sc As it2play_slaveChn_t = sChn(0)
  Dim i As Int = 0
  Do While (i < 256)
    If (Not((Bit.And(sc.Flags, 512) <> 0)) And (Bit.And(sc.Flags, 1) <> 0)) Then
      activeVoices = (activeVoices + 1)
    End If
    i = (i + 1)
    sc = AdvIdx(sc, 1)
  Loop
  Return activeVoices
End Sub

' ----- Music engine

' +++++ Effects

Private Sub NoCommand(hc As it2play_hostChn_t)
  Return
End Sub
  
Private Sub CommandEChain(hc As it2play_hostChn_t, SlideValue As Int)
  SlideValue = Bit.And(SlideValue, 65535)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  PitchSlideDown(hc, sc, SlideValue)
  sc.FrequencySet = sc.Frequency
End Sub

Private Sub CommandFChain(hc As it2play_hostChn_t, SlideValue As Int)
  SlideValue = Bit.And(SlideValue, 65535)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  PitchSlideUp(hc, sc, SlideValue)
  sc.FrequencySet = sc.Frequency
End Sub

Private Sub CommandD2(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, vol As Int)
  vol = ToS16(Bit.And(vol, 255))
  hc.VolSet = vol
  sc.VolSet = hc.VolSet
  sc.Vol = sc.VolSet
  sc.Flags = Bit.Or(sc.Flags, 16)
End Sub

Private Sub InitVibrato(hc As it2play_hostChn_t)
  If Bit.And(Song.Header.Flags, 16) <> 0 Then
    Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
    sc.Flags = Bit.Or(sc.Flags, 32)
    CommandH5(hc, sc, hc.LastVibratoData)
  Else
    CommandH(hc)
  End If
End Sub

Private Sub InitCommandD7(hc As it2play_hostChn_t, sc As it2play_slaveChn_t)
  sc.Flags = Bit.Or(sc.Flags, 16)
  Dim hi As Int = Bit.And(hc.EfxMem_DKL, 240)
  Dim lo As Int = Bit.And(hc.EfxMem_DKL, 15)
  If lo = 0 Then
    hc.VolSlideDelta = Bit.ShiftRight(hi, 4)
    hc.Flags = Bit.Or(hc.Flags, 1)
    If hc.VolSlideDelta = 15 Then
      CommandD(hc)
    End If
  Else If hi = 0 Then
    hc.VolSlideDelta = -lo
    hc.Flags = Bit.Or(hc.Flags, 1)
    If hc.VolSlideDelta = -15 Then
      CommandD(hc)
    End If
  Else If lo = 15 Then
    hc.VolSlideDelta = 0
    Dim vol As Int = Bit.And(sc.VolSet + (Bit.ShiftRight(hi, 4)), 255)
    If vol > 64 Then
      vol = 64
    End If
    hc.VolSet = vol
    sc.VolSet = hc.VolSet
    sc.Vol = sc.VolSet
  Else If hi = 240 Then
    hc.VolSlideDelta = 0
    Dim vol_2 As Int = Bit.And(sc.VolSet - lo, 255)
    If ToS8(vol_2) < 0 Then
      vol_2 = 0
    End If
    hc.VolSet = vol_2
    sc.VolSet = hc.VolSet
    sc.Vol = sc.VolSet
  End If
End Sub

Private Sub InitVolumeEffect(hc As it2play_hostChn_t)
  If Not((Bit.And(hc.NotePackMask, 68) <> 0)) Then
    Return
  End If
  Dim volCmd As Int = ToS8(((Bit.And(hc.RawVolColumn, 127)) - 65))
  If (volCmd < 0) Then
    Return
  End If
  If (Bit.And(hc.RawVolColumn, 128) <> 0) Then
    volCmd = ToS8((volCmd + 60))
  End If
  Dim cmd As Int = ToS16(IDiv((Bit.And(volCmd, 255)), 10))
  Dim val As Int = ToS16(((Bit.And(volCmd, 255)) Mod 10))
  hc.VolCmd = cmd
  If (val > 0) Then
    If (cmd < 4) Then
      hc.VolCmdVal = val
    Else If (cmd < 6) Then
      hc.EfxMem_EFG = Bit.And((Bit.ShiftLeft(val, 2)), 255)
    Else If (cmd = 6) Then
      If (Bit.And(Song.Header.Flags, 32) <> 0) Then
        hc.EfxMem_G_Compat = SlideTable((val - 1))
      Else
        hc.EfxMem_EFG = SlideTable((val - 1))
      End If
    End If
  End If
  If (Bit.And(hc.Flags, 4) <> 0) Then
    Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
    If (cmd > 1) Then
      hc.Flags = Bit.Or(hc.Flags, 256)
      If (cmd > 6) Then
        If (val <> 0) Then
          hc.VibratoDepth = Bit.And((Bit.ShiftLeft(val, 2)), 255)
        End If
        If (Bit.And(hc.Flags, 4) <> 0) Then
          InitVibrato(hc)
        End If
      Else If (cmd = 6) Then
        InitCommandG11(hc)
      End If
    Else If (cmd = 1) Then
      Dim vol As Int = ToS8((sc.VolSet - hc.VolCmdVal))
      If (vol < 0) Then
        vol = 0
      End If
      CommandD2(hc, sc, vol)
    Else
      Dim vol_2 As Int = ToS8((sc.VolSet + hc.VolCmdVal))
      If (vol_2 > 64) Then
        vol_2 = 64
      End If
      CommandD2(hc, sc, vol_2)
    End If
  Else
    If (cmd = 7) Then
      If (val <> 0) Then
        hc.VibratoDepth = Bit.And((Bit.ShiftLeft(val, 2)), 255)
      End If
      If (Bit.And(hc.Flags, 4) <> 0) Then
        InitVibrato(hc)
      End If
    End If
  End If
End Sub

Private Sub VolumeCommandC(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  Dim vol As Int = ToS8((sc.VolSet + hc.VolCmdVal))
  If (vol > 64) Then
    hc.Flags = Bit.And(hc.Flags, Bit.Not(256))
    vol = 64
  End If
  CommandD2(hc, sc, vol)
End Sub

Private Sub VolumeCommandD(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  Dim vol As Int = ToS8((sc.VolSet - hc.VolCmdVal))
  If (vol < 0) Then
    hc.Flags = Bit.And(hc.Flags, Bit.Not(256))
    vol = 0
  End If
  CommandD2(hc, sc, vol)
End Sub

Private Sub VolumeCommandE(hc As it2play_hostChn_t)
  CommandEChain(hc, Bit.ShiftLeft(hc.EfxMem_EFG, 2))
End Sub

Private Sub VolumeCommandF(hc As it2play_hostChn_t)
  CommandFChain(hc, Bit.ShiftLeft(hc.EfxMem_EFG, 2))
End Sub

Private Sub VolumeCommandG(hc As it2play_hostChn_t)
  If Not((Bit.And(hc.Flags, 16) <> 0)) Then
    Return
  End If
  Dim SlideValue As Int = ToS16(IIf((Bit.And(Song.Header.Flags, 32) <> 0), (Bit.ShiftLeft(hc.EfxMem_G_Compat, 2)), (Bit.ShiftLeft(hc.EfxMem_EFG, 2))))
  If (SlideValue = 0) Then
    Return
  End If
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  If (MiscGetU8(hc, 2) = 1) Then
    PitchSlideUp(hc, sc, SlideValue)
    sc.FrequencySet = sc.Frequency
    If ((Bit.And(sc.Flags, 512) <> 0) Or (sc.Frequency >= hc.PortaFreq)) Then
      sc.Flags = Bit.And(sc.Flags, Bit.Not(512))
      hc.Flags = Bit.Or(hc.Flags, 4)
      sc.Frequency = hc.PortaFreq
      sc.FrequencySet = sc.Frequency
      hc.Flags = Bit.And(hc.Flags, Bit.Not(272))
    End If
  Else
    PitchSlideDown(hc, sc, SlideValue)
    If (sc.Frequency <= hc.PortaFreq) Then
      sc.Frequency = hc.PortaFreq
      hc.Flags = Bit.And(hc.Flags, Bit.Not(272))
    End If
    sc.FrequencySet = sc.Frequency
  End If
End Sub

Private Sub InitNoCommand3(hc As it2play_hostChn_t, hcFlags As Int)
  Dim ApplyRandomVolume As Boolean = (Bit.And(hc.Flags, 128) <> 0)
  hc.Flags = Bit.Or((Bit.And(hc.Flags, 65280)), hcFlags)
  If ApplyRandomVolume Then
    ApplyRandomValues(hc)
  End If
  InitVolumeEffect(hc)
End Sub

Private Sub NoOldEffect(hc As it2play_hostChn_t, hcFlags As Int)
  Dim vol As Int = hc.RawVolColumn
  If (Not((Bit.And(hc.NotePackMask, 68) <> 0)) Or (vol > 64)) Then
    If ((Bit.And(hc.NotePackMask, 68) <> 0) And ((Bit.And(vol, 127)) < 65)) Then
      hc.Flags = Bit.Or((Bit.And(hc.Flags, 65280)), hcFlags)
      InitCommandX2(hc, (vol - 128))
    End If
    If (Not((Bit.And(hc.NotePackMask, 34) <> 0)) Or (hc.Smp = 0)) Then
      InitNoCommand3(hc, hcFlags)
      Return
    End If
    vol = Bit.And((Song.Smp((hc.Smp - 1)).Vol), 255)
  End If
  hc.VolSet = vol
  If (Bit.And(hcFlags, 4) <> 0) Then
    Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
    sc.VolSet = vol
    sc.Vol = sc.VolSet
    sc.Flags = Bit.Or(sc.Flags, 16)
  End If
  InitNoCommand3(hc, hcFlags)
End Sub

Private Sub InitNoCommand11(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, hcFlags As Int)
  GetLoopInformation(sc)
  If Not((Bit.And(hc.NotePackMask, 102) <> 0)) Then
    InitNoCommand3(hc, hcFlags)
    Return
  End If
  If ((Bit.And(Song.Header.Flags, 20)) = 20) Then
    If ((Bit.And(hc.NotePackMask, 34) <> 0) And (hc.Ins <> 255)) Then
      sc.FadeOut = 1024
      InitPlayInstrument(hc, sc, Song.Ins((hc.Ins - 1)))
    End If
  End If
  NoOldEffect(hc, hcFlags)
End Sub

Private Sub InitNoCommand(hc As it2play_hostChn_t)
  Dim hcFlags As Int = Bit.And(hc.Flags, 255)
  If Not((Bit.And(hc.NotePackMask, 51) <> 0)) Then
    NoOldEffect(hc, hcFlags)
    Return
  End If
  If (hc.TranslatedNote >= 120) Then
    If (Bit.And(hcFlags, 4) <> 0) Then
      Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
      If (hc.TranslatedNote = 255) Then
        sc.Flags = Bit.Or(sc.Flags, 4)
        InitNoCommand11(hc, sc, hcFlags)
        Return
      Else If (hc.TranslatedNote = 254) Then
        hcFlags = ToS16(Bit.And(hcFlags, Bit.Not(4)))
        If ((sc.Smp = 100) Or (Bit.And(Driver.Flags, 2) <> 0)) Then
          sc.Flags = Bit.Or(sc.Flags, 512)
        Else
          sc.Flags = 512
        End If
      Else
        sc.Flags = Bit.Or(sc.Flags, 8)
      End If
    End If
    NoOldEffect(hc, hcFlags)
    Return
  End If
  If (Bit.And(hcFlags, 4) <> 0) Then
    Dim sc_2 As it2play_slaveChn_t = hc.SlaveChnPtr
    If ((Not((Bit.And(hc.NotePackMask, 17) <> 0)) And (sc_2.Note = hc.RawNote)) And (sc_2.Ins = hc.Ins)) Then
      NoOldEffect(hc, hcFlags)
      Return
    End If
  End If
  Dim volColumnPortamento As Boolean = ((hc.RawVolColumn >= 193) And (hc.RawVolColumn <= 202))
  If (((Bit.And(hc.NotePackMask, 68) <> 0) And volColumnPortamento) And (Bit.And(hc.Flags, 4) <> 0)) Then
    InitVolumeEffect(hc)
    Return
  End If
  Dim tmp40(1) As Short
  tmp40(0) = hcFlags
  Dim sc_3 As it2play_slaveChn_t = AllocateChannel(hc, tmp40, 0)
  hcFlags = tmp40(0)
  If (sc_3 = Null) Then
    NoOldEffect(hc, hcFlags)
    Return
  End If
  Dim s As it2play_sample_t = sc_3.SmpPtr
  sc_3.VolSet = hc.VolSet
  sc_3.Vol = sc_3.VolSet
  If Not((Bit.And(Song.Header.Flags, 4) <> 0)) Then
    If (Bit.And(s.DefPan, 128) <> 0) Then
      sc_3.Pan = Bit.And(s.DefPan, 127)
      hc.ChnPan = sc_3.Pan
    End If
  End If
  sc_3.SamplingPosition = 0
  sc_3.Frac32 = 0
  sc_3.Frac64 = 0
  sc_3.HasLooped = False
  sc_3.FrequencySet = L2I(Bit.ShiftRightLong((s.C5Speed * PitchTable(hc.TranslatedNote)), 16))
  sc_3.Frequency = sc_3.FrequencySet
  hcFlags = ToS16(Bit.Or(hcFlags, 4))
  hcFlags = ToS16(Bit.And(hcFlags, Bit.Not(16)))
  InitNoCommand11(hc, sc_3, hcFlags)
End Sub

Private Sub InitCommandA(hc As it2play_hostChn_t)
  If (hc.CmdVal <> 0) Then
    Song.CurrentTick = Bit.And(((Song.CurrentTick - Song.CurrentSpeed) + hc.CmdVal), 65535)
    Song.CurrentSpeed = hc.CmdVal
  End If
  InitNoCommand(hc)
End Sub

Private Sub InitCommandB(hc As it2play_hostChn_t)
  Song.ProcessOrder = Bit.And((hc.CmdVal - 1), 65535)
  Song.ProcessRow = 65534
  InitNoCommand(hc)
End Sub

Private Sub InitCommandC(hc As it2play_hostChn_t)
  If Not(Song.PatternLooping) Then
    Song.BreakRow = hc.CmdVal
    Song.ProcessRow = 65534
  End If
  InitNoCommand(hc)
End Sub

Private Sub InitCommandD(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal = 0) Then
    CmdVal = hc.EfxMem_DKL
  End If
  hc.EfxMem_DKL = CmdVal
  If Not((Bit.And(hc.Flags, 4) <> 0)) Then
    Return
  End If
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  InitCommandD7(hc, sc)
End Sub

Private Sub InitCommandE(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal = 0) Then
    CmdVal = hc.EfxMem_EFG
  End If
  hc.EfxMem_EFG = CmdVal
  If (Not((Bit.And(hc.Flags, 4) <> 0)) Or (hc.EfxMem_EFG = 0)) Then
    Return
  End If
  If ((Bit.And(hc.EfxMem_EFG, 240)) < 224) Then
    MiscSetU16(hc, 0, Bit.ShiftLeft(hc.EfxMem_EFG, 2))
    hc.Flags = Bit.Or(hc.Flags, 1)
    Return
  End If
  If ((Bit.And(hc.EfxMem_EFG, 15)) = 0) Then
    Return
  End If
  Dim SlideVal As Int = Bit.And(hc.EfxMem_EFG, 15)
  If ((Bit.And(hc.EfxMem_EFG, 240)) <> 224) Then
    SlideVal = Bit.And((Bit.ShiftLeft(SlideVal, 2)), 65535)
  End If
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  PitchSlideDown(hc, sc, SlideVal)
  sc.FrequencySet = sc.Frequency
End Sub

Private Sub InitCommandF(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal = 0) Then
    CmdVal = hc.EfxMem_EFG
  End If
  hc.EfxMem_EFG = CmdVal
  If (Not((Bit.And(hc.Flags, 4) <> 0)) Or (hc.EfxMem_EFG = 0)) Then
    Return
  End If
  If ((Bit.And(hc.EfxMem_EFG, 240)) < 224) Then
    MiscSetU16(hc, 0, Bit.ShiftLeft(hc.EfxMem_EFG, 2))
    hc.Flags = Bit.Or(hc.Flags, 1)
    Return
  End If
  If ((Bit.And(hc.EfxMem_EFG, 15)) = 0) Then
    Return
  End If
  Dim SlideVal As Int = Bit.And(hc.EfxMem_EFG, 15)
  If ((Bit.And(hc.EfxMem_EFG, 240)) <> 224) Then
    SlideVal = Bit.And((Bit.ShiftLeft(SlideVal, 2)), 65535)
  End If
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  PitchSlideUp(hc, sc, SlideVal)
  sc.FrequencySet = sc.Frequency
End Sub

Private Sub Gxx_ChangeSample(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, sample As Int) As Boolean
  sc.Flags = Bit.And(sc.Flags, Bit.Not(65024))
  sc.Flags = Bit.Or(sc.Flags, 256)
  sc.SmpPtr = Song.Smp(sample)
  Dim s As it2play_sample_t = sc.SmpPtr
  sc.Smp = sample
  sc.AutoVibratoDepth = 0
  sc.LoopDirection = 0
  sc.Frac32 = 0
  sc.Frac64 = 0
  sc.HasLooped = False
  sc.SamplingPosition = 0
  sc.SmpVol = Bit.And((s.GlobVol * 2), 255)
  If Not((Bit.And(s.Flags, 1) <> 0)) Then
    sc.Flags = 512
    hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
    Return False
  End If
  sc.SmpIs16Bit = (Bit.And(s.Flags, 2) <> 0)
  GetLoopInformation(sc)
  Return True
End Sub

Private Sub InitCommandG11(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  If ((Bit.And(hc.NotePackMask, 34) <> 0) And (hc.Smp > 0)) Then
    Dim ChangeInstrument As Boolean = False
    If (Bit.And(Song.Header.Flags, 32) <> 0) Then
      hc.Smp = Bit.And((sc.Smp + 1), 255)
      sc.SmpVol = Bit.And((Song.Smp(sc.Smp).GlobVol * 2), 255)
      ChangeInstrument = True
    Else If (hc.Smp <> 101) Then
      Dim hcSmp As Int = Bit.And((hc.Smp - 1), 255)
      Dim oldSlaveIns As Int = sc.Ins
      sc.Note = hc.RawNote
      sc.Ins = hc.Ins
      If (sc.Ins <> oldSlaveIns) Then
        If (sc.Smp <> hcSmp) Then
          If Not(Gxx_ChangeSample(hc, sc, hcSmp)) Then
            Return
          End If
        End If
        ChangeInstrument = True
      Else If (sc.Smp <> hcSmp) Then
        If Not(Gxx_ChangeSample(hc, sc, hcSmp)) Then
          Return
        End If
        ChangeInstrument = True
      End If
    End If
    If ((Bit.And(Song.Header.Flags, 4) <> 0) And ChangeInstrument) Then
      Dim ins As it2play_instrument_t = Song.Ins((hc.Ins - 1))
      sc.FadeOut = 1024
      Dim oldSCFlags As Int = sc.Flags
      InitPlayInstrument(hc, sc, ins)
      If (Bit.And(oldSCFlags, 1) <> 0) Then
        sc.Flags = Bit.And(sc.Flags, Bit.Not(256))
      End If
      sc.SmpVol = Bit.And((Bit.ShiftRight((ins.GlobVol * sc.SmpVol), 7)), 255)
    End If
  End If
  If ((Bit.And(Song.Header.Flags, 4) <> 0) Or (Bit.And(hc.NotePackMask, 17) <> 0)) Then
    If (hc.TranslatedNote < 120) Then
      If (hc.Smp <> 101) Then
        sc.Note = hc.TranslatedNote
      End If
      Dim s As it2play_sample_t = sc.SmpPtr
      hc.PortaFreq = L2I(Bit.ShiftRightLong((s.C5Speed * PitchTable(hc.TranslatedNote)), 16))
      hc.Flags = Bit.Or(hc.Flags, 16)
    Else If (Bit.And(hc.Flags, 4) <> 0) Then
      If (hc.TranslatedNote = 255) Then
        sc.Flags = Bit.Or(sc.Flags, 4)
        GetLoopInformation(sc)
      Else If (hc.TranslatedNote = 254) Then
        hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
        sc.Flags = 512
      Else
        sc.Flags = Bit.Or(sc.Flags, 8)
      End If
    End If
  End If
  Dim volFromVolColumn As Boolean = False
  Dim vol As Int = 0
  If (Bit.And(hc.NotePackMask, 68) <> 0) Then
    If (hc.RawVolColumn <= 64) Then
      vol = hc.RawVolColumn
      volFromVolColumn = True
    Else
      If ((Bit.And(hc.RawVolColumn, 127)) < 65) Then
        InitCommandX2(hc, (hc.RawVolColumn - 128))
      End If
    End If
  End If
  If (volFromVolColumn Or (Bit.And(hc.NotePackMask, 34) <> 0)) Then
    If Not(volFromVolColumn) Then
      vol = sc.SmpPtr.Vol
    End If
    sc.Flags = Bit.Or(sc.Flags, 16)
    hc.VolSet = vol
    sc.VolSet = hc.VolSet
    sc.Vol = sc.VolSet
  End If
  If (Bit.And(hc.Flags, 16) <> 0) Then
    Dim SlideSpeed As Int = Bit.And((IIf((Bit.And(Song.Header.Flags, 32) <> 0), (Bit.ShiftLeft(hc.EfxMem_G_Compat, 2)), (Bit.ShiftLeft(hc.EfxMem_EFG, 2)))), 65535)
    If (SlideSpeed > 0) Then
      MiscSetU16(hc, 0, SlideSpeed)
      If (sc.FrequencySet <> hc.PortaFreq) Then
        If (sc.FrequencySet > hc.PortaFreq) Then
          MiscSetU8(hc, 2, 0)
        Else
          MiscSetU8(hc, 2, 1)
        End If
        If Not((Bit.And(hc.Flags, 256) <> 0)) Then
          hc.Flags = Bit.Or(hc.Flags, 1)
        End If
      End If
    End If
  End If
  If Not((Bit.And(hc.Flags, 256) <> 0)) Then
    InitVolumeEffect(hc)
  End If
End Sub

Private Sub InitCommandG(hc As it2play_hostChn_t)
  If (hc.CmdVal <> 0) Then
    If (Bit.And(Song.Header.Flags, 32) <> 0) Then
      hc.EfxMem_G_Compat = hc.CmdVal
    Else
      hc.EfxMem_EFG = hc.CmdVal
    End If
  End If
  If Not((Bit.And(hc.Flags, 4) <> 0)) Then
    InitNoCommand(hc)
    Return
  End If
  InitCommandG11(hc)
End Sub

Private Sub InitCommandH(hc As it2play_hostChn_t)
  If ((Bit.And(hc.NotePackMask, 17) <> 0) And (hc.RawNote < 120)) Then
    hc.LastVibratoData = 0
    hc.VibratoPos = hc.LastVibratoData
  End If
  Dim speed As Int = Bit.And((Bit.ShiftLeft((Bit.ShiftRight(hc.CmdVal, 4)), 2)), 255)
  Dim depth As Int = Bit.And((Bit.ShiftLeft((Bit.And(hc.CmdVal, 15)), 2)), 255)
  If (speed > 0) Then
    hc.VibratoSpeed = speed
  End If
  If (depth > 0) Then
    If (Bit.And(Song.Header.Flags, 16) <> 0) Then
      depth = Bit.And((Bit.ShiftLeft(depth, 1)), 255)
    End If
    hc.VibratoDepth = depth
  End If
  InitNoCommand(hc)
  If (Bit.And(hc.Flags, 4) <> 0) Then
    hc.Flags = Bit.Or(hc.Flags, 1)
    InitVibrato(hc)
  End If
End Sub

Private Sub InitCommandI(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal > 0) Then
    hc.EfxMem_I = CmdVal
  End If
  If (Bit.And(hc.Flags, 4) <> 0) Then
    hc.Flags = Bit.Or(hc.Flags, 1)
    Dim OffTime As Int = Bit.And(hc.EfxMem_I, 15)
    Dim OnTime As Int = ToS16(Bit.ShiftRight(hc.EfxMem_I, 4))
    If (Bit.And(Song.Header.Flags, 16) <> 0) Then
      OffTime = Bit.And((OffTime + 1), 255)
      OnTime = Bit.And((OnTime + 1), 255)
    End If
    MiscSetU8(hc, 0, OffTime)
    MiscSetU8(hc, 1, OnTime)
    CommandI(hc)
  End If
End Sub

Private Sub InitCommandJ(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  MiscSetU16(hc, 0, 0)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal = 0) Then
    CmdVal = hc.EfxMem_J
  End If
  hc.EfxMem_J = CmdVal
  If (Bit.And(hc.Flags, 4) <> 0) Then
    hc.Flags = Bit.Or(hc.Flags, 1)
    MiscSetU16(hc, 2, (60 + (Bit.ShiftRight(hc.EfxMem_J, 4))))
    MiscSetU16(hc, 4, (60 + (Bit.And(hc.EfxMem_J, 15))))
  End If
End Sub

Private Sub InitCommandK(hc As it2play_hostChn_t)
  If (hc.CmdVal > 0) Then
    hc.EfxMem_DKL = hc.CmdVal
  End If
  InitNoCommand(hc)
  If (Bit.And(hc.Flags, 4) <> 0) Then
    InitVibrato(hc)
    InitCommandD7(hc, hc.SlaveChnPtr)
    hc.Flags = Bit.Or(hc.Flags, 2)
  End If
End Sub

Private Sub InitCommandL(hc As it2play_hostChn_t)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal > 0) Then
    hc.EfxMem_DKL = CmdVal
  End If
  If (Bit.And(hc.Flags, 4) <> 0) Then
    InitCommandG11(hc)
    InitCommandD7(hc, hc.SlaveChnPtr)
  End If
End Sub

Private Sub InitCommandM2(hc As it2play_hostChn_t, vol As Int)
  If (Bit.And(hc.Flags, 4) <> 0) Then
    Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
    sc.ChnVol = vol
    sc.Flags = Bit.Or(sc.Flags, 16)
  End If
  hc.ChnVol = vol
End Sub

Private Sub InitCommandM(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  If (hc.CmdVal <= 64) Then
    InitCommandM2(hc, hc.CmdVal)
  End If
End Sub

Private Sub InitCommandN(hc As it2play_hostChn_t)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal > 0) Then
    hc.EfxMem_N = CmdVal
  End If
  InitNoCommand(hc)
  Dim hi As Int = Bit.And(hc.EfxMem_N, 240)
  Dim lo As Int = Bit.And(hc.EfxMem_N, 15)
  If (lo = 0) Then
    MiscSetU8(hc, 0, Bit.ShiftRight(hi, 4))
    hc.Flags = Bit.Or(hc.Flags, 2)
  Else If (hi = 0) Then
    MiscSetU8(hc, 0, (-lo))
    hc.Flags = Bit.Or(hc.Flags, 2)
  Else If (lo = 15) Then
    Dim vol As Int = Bit.And((hc.ChnVol + (Bit.ShiftRight(hi, 4))), 255)
    If (vol > 64) Then
      vol = 64
    End If
    InitCommandM2(hc, vol)
  Else If (hi = 240) Then
    Dim vol_2 As Int = Bit.And((hc.ChnVol - lo), 255)
    If (ToS8(vol_2) < 0) Then
      vol_2 = 0
    End If
    InitCommandM2(hc, vol_2)
  End If
End Sub

Private Sub InitCommandO(hc As it2play_hostChn_t)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal = 0) Then
    CmdVal = hc.EfxMem_O
  End If
  hc.EfxMem_O = CmdVal
  InitNoCommand(hc)
  If (((Bit.And(hc.NotePackMask, 51) <> 0) And (hc.TranslatedNote < 120)) And (Bit.And(hc.Flags, 4) <> 0)) Then
    Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
    Dim offset As Int = Bit.ShiftLeft((Bit.Or((Bit.ShiftLeft(hc.HighSmpOffs, 8)), hc.EfxMem_O)), 8)
    If (offset >= sc.LoopEnd) Then
      If Not((Bit.And(Song.Header.Flags, 16) <> 0)) Then
        Return
      End If
      offset = (sc.LoopEnd - 1)
    End If
    sc.SamplingPosition = offset
    sc.Frac32 = 0
    sc.Frac64 = 0
  End If
End Sub

Private Sub InitCommandP(hc As it2play_hostChn_t)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal > 0) Then
    hc.EfxMem_P = CmdVal
  End If
  InitNoCommand(hc)
  Dim pan As Int = hc.ChnPan
  If (Bit.And(hc.Flags, 4) <> 0) Then
    pan = Bit.And(hc.SlaveChnPtr.PanSet, 255)
  End If
  If (pan = 100) Then
    Return
  End If
  Dim hi As Int = Bit.And(hc.EfxMem_P, 240)
  Dim lo As Int = Bit.And(hc.EfxMem_P, 15)
  If (lo = 0) Then
    MiscSetU8(hc, 0, (-(Bit.ShiftRight(hi, 4))))
    hc.Flags = Bit.Or(hc.Flags, 2)
  Else If (hi = 0) Then
    MiscSetU8(hc, 0, lo)
    hc.Flags = Bit.Or(hc.Flags, 2)
  Else If (lo = 15) Then
    pan = Bit.And((pan - (Bit.ShiftRight(hi, 4))), 255)
    If (ToS8(pan) < 0) Then
      pan = 0
    End If
    InitCommandX2(hc, pan)
  Else If (hi = 240) Then
    pan = Bit.And((pan + lo), 255)
    If (pan > 64) Then
      pan = 64
    End If
    InitCommandX2(hc, pan)
  End If
End Sub

Private Sub InitCommandQ(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  If (hc.CmdVal > 0) Then
    hc.EfxMem_Q = hc.CmdVal
  End If
  If Not((Bit.And(hc.Flags, 4) <> 0)) Then
    Return
  End If
  hc.Flags = Bit.Or(hc.Flags, 1)
  If (Bit.And(hc.NotePackMask, 17) <> 0) Then
    hc.RetrigCount = Bit.And(hc.EfxMem_Q, 15)
  Else
    CommandQ(hc)
  End If
End Sub

Private Sub InitTremolo(hc As it2play_hostChn_t)
  If (Bit.And(Song.Header.Flags, 16) <> 0) Then
    Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
    sc.Flags = Bit.Or(sc.Flags, 64)
    CommandR2(hc, sc, hc.LastTremoloData)
  Else
    CommandR(hc)
  End If
End Sub

Private Sub InitCommandR(hc As it2play_hostChn_t)
  Dim speed As Int = ToS16(Bit.ShiftRight(hc.CmdVal, 4))
  Dim depth As Int = Bit.And(hc.CmdVal, 15)
  If (speed > 0) Then
    hc.TremoloSpeed = Bit.And((Bit.ShiftLeft(speed, 2)), 255)
  End If
  If (depth > 0) Then
    hc.TremoloDepth = Bit.And((Bit.ShiftLeft(depth, 1)), 255)
  End If
  InitNoCommand(hc)
  If (Bit.And(hc.Flags, 4) <> 0) Then
    hc.Flags = Bit.Or(hc.Flags, 1)
    InitTremolo(hc)
  End If
End Sub

Private Sub InitCommandS(hc As it2play_hostChn_t)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal = 0) Then
    CmdVal = hc.EfxMem_S
  End If
  hc.EfxMem_S = CmdVal
  Dim cmd As Int = Bit.And(CmdVal, 240)
  Dim val As Int = Bit.And(CmdVal, 15)
  MiscSetU8(hc, 0, cmd)
  MiscSetU8(hc, 1, val)
  Select cmd
    Case 48
      If (val <= 3) Then
        hc.VibratoWaveform = val
      End If
      InitNoCommand(hc)
    Case 64
      If (val <= 3) Then
        hc.TremoloWaveform = val
      End If
      InitNoCommand(hc)
    Case 80
      If (val <= 3) Then
        hc.PanbrelloWaveform = val
        hc.PanbrelloPos = 0
      End If
      InitNoCommand(hc)
    Case 96
      Song.CurrentTick = Bit.And((Song.CurrentTick + val), 65535)
      Song.ProcessTick = Bit.And((Song.ProcessTick + val), 65535)
      InitNoCommand(hc)
    Case 112
      Select val
        Case 0
          InitNoCommand(hc)
          Dim targetHostChnNum As Int = ToS16(Bit.Or(hc.HostChnNum, 128))
          Dim sc As it2play_slaveChn_t = sChn(0)
          Dim i As Int = 0
          Do While (i < 256)
            If (sc.HostChnNum = targetHostChnNum) Then
              If (Bit.And(Driver.Flags, 2) <> 0) Then
                sc.Flags = Bit.Or(sc.Flags, 512)
              Else
                sc.Flags = 512
              End If
            End If
            i = (i + 1)
            sc = AdvIdx(sc, 1)
          Loop
        Case 1
          InitNoCommand(hc)
          Dim targetHostChnNum_2 As Int = ToS16(Bit.Or(hc.HostChnNum, 128))
          Dim sc_2 As it2play_slaveChn_t = sChn(0)
          Dim i_2 As Int = 0
          Do While (i_2 < 256)
            If (sc_2.HostChnNum = targetHostChnNum_2) Then
              sc_2.Flags = Bit.Or(sc_2.Flags, 4)
            End If
            i_2 = (i_2 + 1)
            sc_2 = AdvIdx(sc_2, 1)
          Loop
        Case 2
          InitNoCommand(hc)
          Dim targetHostChnNum_3 As Int = ToS16(Bit.Or(hc.HostChnNum, 128))
          Dim sc_3 As it2play_slaveChn_t = sChn(0)
          Dim i_3 As Int = 0
          Do While (i_3 < 256)
            If (sc_3.HostChnNum = targetHostChnNum_3) Then
              sc_3.Flags = Bit.Or(sc_3.Flags, 8)
            End If
            i_3 = (i_3 + 1)
            sc_3 = AdvIdx(sc_3, 1)
          Loop
        Case 3
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.NNA = 0
          End If
        Case 4
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.NNA = 1
          End If
        Case 5
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.NNA = 2
          End If
        Case 6
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.NNA = 3
          End If
        Case 7
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.Flags = Bit.And(hc.SlaveChnPtr.Flags, Bit.Not(4096))
          End If
        Case 8
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.Flags = Bit.Or(hc.SlaveChnPtr.Flags, 4096)
          End If
        Case 9
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.Flags = Bit.And(hc.SlaveChnPtr.Flags, Bit.Not(8192))
          End If
        Case 10
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.Flags = Bit.Or(hc.SlaveChnPtr.Flags, 8192)
          End If
        Case 11
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.Flags = Bit.And(hc.SlaveChnPtr.Flags, Bit.Not(16384))
          End If
        Case 12
          InitNoCommand(hc)
          If (Bit.And(hc.Flags, 4) <> 0) Then
            hc.SlaveChnPtr.Flags = Bit.Or(hc.SlaveChnPtr.Flags, 16384)
          End If
        Case Else
          InitNoCommand(hc)
      End Select
    Case 128
      Dim pan As Int = Bit.And((Bit.ShiftRight(((Bit.Or((Bit.ShiftLeft(val, 4)), val)) + 2), 2)), 255)
      InitNoCommand(hc)
      InitCommandX2(hc, pan)
    Case 144
      InitNoCommand(hc)
      If (val = 1) Then
        InitCommandX2(hc, 100)
      End If
    Case 160
      hc.HighSmpOffs = val
      InitNoCommand(hc)
    Case 176
      InitNoCommand(hc)
      If (val = 0) Then
        hc.PattLoopStartRow = (Bit.And(Song.CurrentRow, 255))
      Else If (hc.PattLoopCount = 0) Then
        hc.PattLoopCount = val
        Song.ProcessRow = Bit.And((hc.PattLoopStartRow - 1), 65535)
        Song.PatternLooping = True
      Else
        hc.PattLoopCount = Bit.And((hc.PattLoopCount - 1), 255)
        If (hc.PattLoopCount <> 0) Then
          Song.ProcessRow = Bit.And((hc.PattLoopStartRow - 1), 65535)
          Song.PatternLooping = True
        Else
          hc.PattLoopStartRow = Bit.And(((Bit.And(Song.CurrentRow, 255)) + 1), 255)
        End If
      End If
    Case 192
      hc.Flags = Bit.Or(hc.Flags, 1)
      InitNoCommand(hc)
    Case 208
      hc.Flags = Bit.Or(hc.Flags, 2)
    Case 224
      If Not(Song.RowDelayOn) Then
        Song.RowDelay = Bit.And((val + 1), 255)
        Song.RowDelayOn = True
      End If
      InitNoCommand(hc)
    Case 240
      hc.EfxMem_SFx = val
      InitNoCommand(hc)
    Case Else
      InitNoCommand(hc)
  End Select
End Sub

Private Sub InitCommandT(hc As it2play_hostChn_t)
  Dim CmdVal As Int = hc.CmdVal
  If (CmdVal = 0) Then
    CmdVal = hc.EfxMem_T
  End If
  hc.EfxMem_T = CmdVal
  If (CmdVal >= 32) Then
    Song.Tempo = CmdVal
    Music_InitTempo
    InitNoCommand(hc)
  Else
    InitNoCommand(hc)
    hc.Flags = Bit.Or(hc.Flags, 2)
  End If
End Sub

Private Sub InitCommandU(hc As it2play_hostChn_t)
  If (Bit.And(hc.NotePackMask, 17) <> 0) Then
    hc.LastVibratoData = 0
    hc.VibratoPos = hc.LastVibratoData
  End If
  Dim speed As Int = Bit.And((Bit.ShiftLeft((Bit.ShiftRight(hc.CmdVal, 4)), 2)), 255)
  Dim depth As Int = Bit.And(hc.CmdVal, 15)
  If (speed > 0) Then
    hc.VibratoSpeed = speed
  End If
  If (depth > 0) Then
    If (Bit.And(Song.Header.Flags, 16) <> 0) Then
      depth = Bit.And((Bit.ShiftLeft(depth, 1)), 255)
    End If
    hc.VibratoDepth = depth
  End If
  InitNoCommand(hc)
  If (Bit.And(hc.Flags, 4) <> 0) Then
    hc.Flags = Bit.Or(hc.Flags, 1)
    InitVibrato(hc)
  End If
End Sub

Private Sub InitCommandV(hc As it2play_hostChn_t)
  If (hc.CmdVal <= 128) Then
    Song.GlobalVolume = hc.CmdVal
    RecalculateAllVolumes
  End If
  InitNoCommand(hc)
End Sub

Private Sub InitCommandW(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  If (hc.CmdVal > 0) Then
    hc.EfxMem_W = hc.CmdVal
  End If
  If (hc.EfxMem_W = 0) Then
    Return
  End If
  Dim hi As Int = Bit.And(hc.EfxMem_W, 240)
  Dim lo As Int = Bit.And(hc.EfxMem_W, 15)
  If (lo = 0) Then
    MiscSetU8(hc, 0, Bit.ShiftRight(hi, 4))
    hc.Flags = Bit.Or(hc.Flags, 2)
  Else If (hi = 0) Then
    MiscSetU8(hc, 0, (-lo))
    hc.Flags = Bit.Or(hc.Flags, 2)
  Else If (lo = 15) Then
    Dim vol As Int = Bit.And((Song.GlobalVolume + (Bit.ShiftRight(hi, 4))), 65535)
    If (vol > 128) Then
      vol = 128
    End If
    Song.GlobalVolume = vol
    RecalculateAllVolumes
  Else If (hi = 240) Then
    Dim vol_2 As Int = Bit.And((Song.GlobalVolume - lo), 65535)
    If (ToS16(vol_2) < 0) Then
      vol_2 = 0
    End If
    Song.GlobalVolume = vol_2
    RecalculateAllVolumes
  End If
End Sub

Private Sub InitCommandX2(hc As it2play_hostChn_t, pan As Int)
  pan = ToS16(Bit.And(pan, 255))
  If (Bit.And(hc.Flags, 4) <> 0) Then
    Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
    sc.PanSet = pan
    sc.Pan = sc.PanSet
    sc.Flags = Bit.Or(sc.Flags, 66)
  End If
  hc.ChnPan = pan
End Sub

Private Sub InitCommandX(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  Dim pan As Int = Bit.And((Bit.ShiftRight((hc.CmdVal + 2), 2)), 255)
  InitCommandX2(hc, pan)
End Sub

Private Sub InitCommandY(hc As it2play_hostChn_t)
  Dim speed As Int = ToS16(Bit.ShiftRight(hc.CmdVal, 4))
  Dim depth As Int = Bit.And(hc.CmdVal, 15)
  If (speed > 0) Then
    hc.PanbrelloSpeed = speed
  End If
  If (depth > 0) Then
    hc.PanbrelloDepth = Bit.And((Bit.ShiftLeft(depth, 1)), 255)
  End If
  InitNoCommand(hc)
  If (Bit.And(hc.Flags, 4) <> 0) Then
    hc.Flags = Bit.Or(hc.Flags, 1)
    CommandY(hc)
  End If
End Sub

Private Sub InitCommandZ(hc As it2play_hostChn_t)
  InitNoCommand(hc)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  If (hc.CmdVal >= 128) Then
    MIDITranslate(hc, sc, (800 + (Bit.ShiftLeft((Bit.And(hc.CmdVal, 127)), 5))))
  Else
    MIDITranslate(hc, sc, (288 + (Bit.ShiftLeft((Bit.And(hc.EfxMem_SFx, 15)), 5))))
  End If
End Sub

Private Sub CommandD(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  Dim vol As Int = Bit.And((sc.VolSet + hc.VolSlideDelta), 255)
  If (ToS8(vol) < 0) Then
    hc.Flags = Bit.And(hc.Flags, Bit.Not(1))
    vol = 0
  Else If (vol > 64) Then
    hc.Flags = Bit.And(hc.Flags, Bit.Not(1))
    vol = 64
  End If
  CommandD2(hc, sc, vol)
End Sub

Private Sub CommandE(hc As it2play_hostChn_t)
  CommandEChain(hc, MiscGetU16(hc, 0))
End Sub

Private Sub CommandF(hc As it2play_hostChn_t)
  CommandFChain(hc, MiscGetU16(hc, 0))
End Sub

Private Sub CommandG(hc As it2play_hostChn_t)
  If Not((Bit.And(hc.Flags, 16) <> 0)) Then
    Return
  End If
  Dim SlideValue As Int = MiscGetU16(hc, 0)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  If (MiscGetU8(hc, 2) = 1) Then
    PitchSlideUp(hc, sc, SlideValue)
    If (Not((Bit.And(sc.Flags, 512) <> 0)) And (sc.Frequency < hc.PortaFreq)) Then
      sc.FrequencySet = sc.Frequency
    Else
      sc.Flags = Bit.And(sc.Flags, Bit.Not(512))
      hc.Flags = Bit.Or(hc.Flags, 4)
      sc.FrequencySet = hc.PortaFreq
      sc.Frequency = sc.FrequencySet
      hc.Flags = Bit.And(hc.Flags, Bit.Not(19))
    End If
  Else
    PitchSlideDown(hc, sc, SlideValue)
    If (sc.Frequency > hc.PortaFreq) Then
      sc.FrequencySet = sc.Frequency
    Else
      sc.FrequencySet = hc.PortaFreq
      sc.Frequency = sc.FrequencySet
      hc.Flags = Bit.And(hc.Flags, Bit.Not(19))
    End If
  End If
End Sub

Private Sub CommandH5(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, VibratoData As Int)
  VibratoData = ToS8(Bit.ShiftRight(((Bit.ShiftLeft((VibratoData * ToS8(hc.VibratoDepth)), 2)) + 128), 8))
  If (Bit.And(Song.Header.Flags, 16) <> 0) Then
    VibratoData = ToS8((-VibratoData))
  End If
  If (VibratoData < 0) Then
    PitchSlideDown(hc, sc, (-VibratoData))
  Else
    PitchSlideUp(hc, sc, VibratoData)
  End If
End Sub

Private Sub CommandH(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  sc.Flags = Bit.Or(sc.Flags, 32)
  hc.VibratoPos = Bit.And((hc.VibratoPos + hc.VibratoSpeed), 255)
  Dim VibratoData As Int
  If (hc.VibratoWaveform = 3) Then
    VibratoData = ToS8(((Bit.And(ITRandom, 127)) - 64))
  Else
    VibratoData = FineSineData(((Bit.ShiftLeft(hc.VibratoWaveform, 8)) + hc.VibratoPos))
  End If
  hc.LastVibratoData = VibratoData
  CommandH5(hc, sc, VibratoData)
End Sub

Private Sub CommandI(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  sc.Flags = Bit.Or(sc.Flags, 16)
  hc.TremorCount = Bit.And((hc.TremorCount - 1), 255)
  If (ToS8(hc.TremorCount) <= 0) Then
    hc.TremorOnOff = Bit.And((Bit.Xor(hc.TremorOnOff, 1)), 255)
    hc.TremorCount = MiscGetU8(hc, hc.TremorOnOff)
  End If
  If (hc.TremorOnOff <> 1) Then
    sc.Vol = 0
  End If
End Sub

Private Sub CommandJ(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  Dim tick As Int = MiscGetU16(hc, 0)
  sc.Flags = Bit.Or(sc.Flags, 32)
  tick = Bit.And((tick + 2), 65535)
  If (tick >= 6) Then
    MiscSetU16(hc, 0, 0)
    Return
  End If
  MiscSetU16(hc, 0, tick)
  Dim arpNote As Int = MiscGetU16(hc, tick)
  Dim freq As Long = (I2L(sc.Frequency) * PitchTable(arpNote))
  If (Bit.AndLong(freq, (-281474976710656)) <> 0) Then
    sc.Frequency = 0
  Else
    sc.Frequency = L2I((Bit.AndLong((Bit.ShiftRightLong(freq, 16)), 4294967295)))
  End If
End Sub

Private Sub CommandK(hc As it2play_hostChn_t)
  CommandH(hc)
  CommandD(hc)
End Sub

Private Sub CommandL(hc As it2play_hostChn_t)
  If (Bit.And(hc.Flags, 16) <> 0) Then
    CommandG(hc)
    hc.Flags = Bit.Or(hc.Flags, 1)
  End If
  CommandD(hc)
End Sub

Private Sub CommandN(hc As it2play_hostChn_t)
  Dim vol As Int = Bit.And((hc.ChnVol + ToS8(hc.MiscEfxData(0))), 255)
  If (ToS8(vol) < 0) Then
    vol = 0
  Else If (vol > 64) Then
    vol = 64
  End If
  InitCommandM2(hc, vol)
End Sub

Private Sub CommandP(hc As it2play_hostChn_t)
  Dim pan As Int = hc.ChnPan
  If (Bit.And(hc.Flags, 4) <> 0) Then
    pan = Bit.And(hc.SlaveChnPtr.PanSet, 255)
  End If
  pan = Bit.And((pan + MiscGetU8(hc, 0)), 255)
  If (ToS8(pan) < 0) Then
    pan = 0
  Else If (pan > 64) Then
    pan = 64
  End If
  InitCommandX2(hc, pan)
End Sub

Private Sub CommandQ(hc As it2play_hostChn_t)
  hc.RetrigCount = Bit.And((hc.RetrigCount - 1), 255)
  If (ToS8(hc.RetrigCount) > 0) Then
    Return
  End If
  hc.RetrigCount = Bit.And(hc.EfxMem_Q, 15)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  If (Bit.And(Driver.Flags, 2) <> 0) Then
    If (Bit.And(Song.Header.Flags, 4) <> 0) Then
      Dim scTmp As it2play_slaveChn_t = sChn(0)
      Dim i As Int = 0
      Do While (i < 256)
        If Not((Bit.And(scTmp.Flags, 1) <> 0)) Then
          Copy_slaveChn_t(scTmp, sc)
          sc.Flags = Bit.Or(sc.Flags, 512)
          sc.HostChnNum = Bit.Or(sc.HostChnNum, 128)
          sc = scTmp
          hc.SlaveChnPtr = scTmp
          Exit
        End If
        i = (i + 1)
        scTmp = AdvIdx(scTmp, 1)
      Loop
    Else
      Dim scTmp_2 As it2play_slaveChn_t = sChn(sc.Idx + 64)
      Copy_slaveChn_t(scTmp_2, sc)
      scTmp_2.Flags = Bit.Or(scTmp_2.Flags, 512)
      scTmp_2.HostChnNum = Bit.Or(scTmp_2.HostChnNum, 128)
    End If
  End If
  sc.Frac32 = 0
  sc.Frac64 = 0
  sc.HasLooped = False
  sc.SamplingPosition = 0
  sc.Flags = Bit.Or(sc.Flags, 1344)
  Dim vol As Int = sc.VolSet
  Select Bit.ShiftRight(hc.EfxMem_Q, 4)
    Case 1
      vol = ToS16((vol - 1))
    Case 2
      vol = ToS16((vol - 2))
    Case 3
      vol = ToS16((vol - 4))
    Case 4
      vol = ToS16((vol - 8))
    Case 5
      vol = ToS16((vol - 16))
    Case 6
      vol = ToS16(IDiv((Bit.ShiftLeft(vol, 1)), 3))
    Case 7
      vol = ToS16(Bit.ShiftRight(vol, 1))
    Case 8
      Return
    Case 9
      vol = ToS16((vol + 1))
    Case 10
      vol = ToS16((vol + 2))
    Case 11
      vol = ToS16((vol + 4))
    Case 12
      vol = ToS16((vol + 8))
    Case 13
      vol = ToS16((vol + 16))
    Case 14
      vol = ToS16(Bit.ShiftRight((vol * 3), 1))
    Case 15
      vol = ToS16(Bit.ShiftLeft(vol, 1))
    Case Else
      Return
  End Select
  If (ToS8(vol) < 0) Then
    vol = 0
  Else If (vol > 64) Then
    vol = 64
  End If
  hc.VolSet = vol
  sc.Vol = hc.VolSet
  sc.VolSet = sc.Vol
  sc.Flags = Bit.Or(sc.Flags, 16)
  If (hc.Smp = 101) Then
    MIDITranslate(hc, sc, 128)
  End If
End Sub

Private Sub CommandR2(hc As it2play_hostChn_t, sc As it2play_slaveChn_t, TremoloData As Int)
  TremoloData = ToS8(Bit.ShiftRight(((Bit.ShiftLeft((TremoloData * ToS8(hc.TremoloDepth)), 2)) + 128), 8))
  Dim vol As Int = ToS16((sc.Vol + TremoloData))
  If (vol < 0) Then
    vol = 0
  Else If (vol > 64) Then
    vol = 64
  End If
  sc.Vol = (Bit.And(vol, 255))
End Sub

Private Sub CommandR(hc As it2play_hostChn_t)
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  sc.Flags = Bit.Or(sc.Flags, 16)
  hc.TremoloPos = Bit.And((hc.TremoloPos + hc.TremoloSpeed), 255)
  Dim TremoloData As Int
  If (hc.TremoloWaveform = 3) Then
    TremoloData = ToS8(((Bit.And(ITRandom, 127)) - 64))
  Else
    TremoloData = FineSineData(((Bit.ShiftLeft(hc.TremoloWaveform, 8)) + hc.TremoloPos))
  End If
  hc.LastTremoloData = TremoloData
  CommandR2(hc, sc, TremoloData)
End Sub

Private Sub CommandS(hc As it2play_hostChn_t)
  Dim SCmd As Int = ToS16(MiscGetU8(hc, 0))
  If (SCmd = 208) Then
    MiscSetU8(hc, 1, (MiscGetU8(hc, 1) - 1))
    If (SignExt8(MiscGetU8(hc, 1)) > 0) Then
      Return
    End If
    hc.Flags = Bit.And(hc.Flags, Bit.Not(3))
    InitNoCommand(hc)
    hc.Flags = Bit.Or(hc.Flags, 64)
    Dim ChannelMuted As Boolean = (Bit.And(Song.Header.ChnlPan(hc.HostChnNum), 128) <> 0)
    If ((ChannelMuted And Not((Bit.And(hc.Flags, 32) <> 0))) And (Bit.And(hc.Flags, 4) <> 0)) Then
      hc.SlaveChnPtr.Flags = Bit.Or(hc.SlaveChnPtr.Flags, 2048)
    End If
  Else If (SCmd = 192) Then
    If Not((Bit.And(hc.Flags, 4) <> 0)) Then
      Return
    End If
    MiscSetU8(hc, 1, (MiscGetU8(hc, 1) - 1))
    If (SignExt8(MiscGetU8(hc, 1)) > 0) Then
      Return
    End If
    Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
    hc.Flags = Bit.And(hc.Flags, Bit.Not(4))
    If ((sc.Smp = 100) Or (Bit.And(Driver.Flags, 2) <> 0)) Then
      sc.Flags = Bit.Or(sc.Flags, 512)
    Else
      sc.Flags = 512
    End If
  End If
End Sub

Private Sub CommandT(hc As it2play_hostChn_t)
  Dim Tempo As Int = ToS16(Song.Tempo)
  If (Bit.And(hc.EfxMem_T, 240) <> 0) Then
    Tempo = ToS16((Tempo + (hc.EfxMem_T - 16)))
    If (Tempo > 255) Then
      Tempo = 255
    End If
  Else
    Tempo = ToS16((Tempo - hc.EfxMem_T))
    If (Tempo < 32) Then
      Tempo = 32
    End If
  End If
  Song.Tempo = Bit.And(Tempo, 65535)
  HQ_SetTempo(Bit.And(Tempo, 255))
End Sub

Private Sub CommandW(hc As it2play_hostChn_t)
  Dim vol As Int = Bit.And((Song.GlobalVolume + ToS8(hc.MiscEfxData(0))), 65535)
  If (ToS16(vol) < 0) Then
    vol = 0
  Else If (vol > 128) Then
    vol = 128
  End If
  Song.GlobalVolume = vol
  RecalculateAllVolumes
End Sub

Private Sub CommandY(hc As it2play_hostChn_t)
  If Not((Bit.And(hc.Flags, 4) <> 0)) Then
    Return
  End If
  Dim sc As it2play_slaveChn_t = hc.SlaveChnPtr
  Dim panData As Int
  If (hc.PanbrelloWaveform >= 3) Then
    hc.PanbrelloPos = Bit.And((hc.PanbrelloPos - 1), 255)
    If (ToS8(hc.PanbrelloPos) <= 0) Then
      hc.PanbrelloPos = hc.PanbrelloSpeed
      panData = ToS8(((Bit.And(ITRandom, 127)) - 64))
      hc.LastPanbrelloData = Bit.And(panData, 255)
    Else
      panData = ToS8(hc.LastPanbrelloData)
    End If
  Else
    hc.PanbrelloPos = Bit.And((hc.PanbrelloPos + hc.PanbrelloSpeed), 255)
    panData = FineSineData(((Bit.ShiftLeft(hc.PanbrelloWaveform, 8)) + hc.PanbrelloPos))
  End If
  If (sc.PanSet <> 100) Then
    panData = ToS8(Bit.ShiftRight(((Bit.ShiftLeft((panData * ToS8(hc.PanbrelloDepth)), 2)) + 128), 8))
    panData = ToS8((panData + sc.PanSet))
    If (panData < 0) Then
      panData = 0
    Else If (panData > 64) Then
      panData = 64
    End If
    sc.Flags = Bit.Or(sc.Flags, 2)
    sc.Pan = Bit.And(panData, 255)
  End If
End Sub

Private Sub InitCommandTableProccessor(numfunc As Int, hc As it2play_hostChn_t)
  If numfunc >= 0 And numfunc <= 31 Then 
    Select numfunc
      Case 0,27,28,29,30,31
        InitNoCommand(hc)
      Case Else
        CallSub2(Me, "InitCommand" & Chr(numfunc + 64), hc)
    End Select      
  End If
End Sub

Private Sub CommandTableProccessor(numfunc As Int, hc As it2play_hostChn_t)
  If numfunc >= 0 And numfunc <= 29 Then 
    Select numfunc
      Case 0,1,2,3,13,15,22,24,26,27,28,29
        NoCommand(hc)
      Case 21
        CommandH(hc)
      Case Else
        CallSub2(Me, "Command" & Chr(numfunc + 64), hc)
    End Select      
  End If
End Sub

Private Sub VolumeEffectTableProccessor(numfunc As Int, hc As it2play_hostChn_t)
  If numfunc >= 0 And numfunc <= 7 Then 
    Select numfunc
      Case 0,1
        NoCommand(hc)
      Case 7
        CommandH(hc)
      Case Else
        CallSub2(Me, "VolumeCommand" & Chr(numfunc + 65), hc)
    End Select      
  End If
End Sub

' ----- Effects

' +++++ HQ: driver, fixsample, zeronull

Private Sub setHQDriverMixGain
  MixGain = 32768.0
  Dim PreAmpTable() As Float = Array As Float((64.0 / 96), (64.0 / 96), (64.0 / 96), (64.0 / 112), (64.0 / 128), (64.0 / 136), (64.0 / 144), (64.0 / 152), (64.0 / 160), (64.0 / 164), (64.0 / 168), (64.0 / 172), (64.0 / 176), (64.0 / 180), (64.0 / 184), (64.0 / 188))
  If (((Song.Header.Cwtv = 532) And (Song.Header.Cmwt = 514)) Or ((Song.Header.Cwtv = 535) And (Song.Header.Cmwt = 512))) Then
    Dim highestChannel As Int = 0
    Dim maskvar(128) As Short
    For tmp41 = 0 To maskvar.Length - 1
      maskvar(0 + tmp41) = 0
    Next
    Dim pat As it2play_pattern_t = Song.Patt(0)
    Dim i As Int = 0
    Do While (i < Song.Header.PatNum)
      Dim p() As Byte
      Dim p_o As Int
      p = pat.PackedData
      p_o = pat.PackedData_o
      If ((p = Null) Or (pat.Rows = 0)) Then
        i = (i + 1)
        pat = AdvIdx(pat, 1)
        Continue
      End If
      Dim row As Int = 0
      Do While True
        Dim tmp43 As Int = p(p_o)
        p_o = p_o + 1
        Dim byte_l As Int = Bit.And(tmp43, 255)
        If (byte_l = 0) Then
          row = Bit.And((row + 1), 65535)
          If (row >= pat.Rows) Then
            Exit
          End If
        Else
          Dim ch As Int = Bit.And((byte_l - 1), 127)
          If (ch > highestChannel) Then
            highestChannel = ch
          End If
          If (highestChannel > 31) Then
            highestChannel = 31
            Exit
          End If
          If (Bit.And(byte_l, 128) <> 0) Then
            Dim tmp45 As Int = p(p_o)
            p_o = p_o + 1
            maskvar(ch) = Bit.And(tmp45, 255)
          End If
          If (Bit.And(maskvar(ch), 1) <> 0) Then
            p_o = p_o + 1
          End If
          If (Bit.And(maskvar(ch), 2) <> 0) Then
            p_o = p_o + 1
          End If
          If (Bit.And(maskvar(ch), 4) <> 0) Then
            p_o = p_o + 1
          End If
          If (Bit.And(maskvar(ch), 8) <> 0) Then
            p_o = p_o + 2
          End If
        End If
      Loop
      If (highestChannel >= 31) Then
        Exit
      End If
      i = (i + 1)
      pat = AdvIdx(pat, 1)
    Loop
    MixGain = (MixGain * PreAmpTable(IDiv(highestChannel, 2)))
  End If
End Sub

Private Sub BesselI0(z As Double) As Double
  Dim s As Double = 1.0
  Dim ds As Double = 1.0
  Dim d As Double = 2.0
  Dim zz As Double = (z * z)
  Do While True
    ds = (ds * (zz / (d * d)))
    s = (s + ds)
    d = (d + 2.0)
    If Not((ds > (s * (1E-12)))) Then
      Exit
    End If
  Loop
  Return s
End Sub

Private Sub SincFn(x As Double) As Double
  If (x = 0.0) Then
    Return 1.0
  Else
    x = (x * cPI)
    Return (Sin(x) / x)
  End If
End Sub

Private Sub CreateWindowedSincKernel
  Driver.fSincLUT = NewFloatArr(32768)
  Driver.fSincLUT_o = 0
  Dim kaiserBeta As Double = 9.6377
  Dim besselI0BetaMul As Double = (1.0 / BesselI0(kaiserBeta))
  For i = 0 To 32767
    Dim x As Double = (((Bit.And(i, 7)) - 3) - ((Bit.ShiftRight(i, 3)) * (1.0 / 4096)))
    Dim n As Double = (x * (1.0 / 4))
    Dim window As Double = (BesselI0((kaiserBeta * Sqrt((1.0 - (n * n))))) * besselI0BetaMul)
    Driver.fSincLUT((Driver.fSincLUT_o + i)) = (SincFn(x) * window)
  Next
End Sub

Private Sub HQ_MixSamples
  MixTransferOffset = 0
  RealBytesToMix = BytesToMix
  CurrentFractional = (CurrentFractional + BytesToMixFractional)
  If (CurrentFractional >= 2147483648) Then
    CurrentFractional = Bit.AndLong(CurrentFractional, 2147483647)
    RealBytesToMix = (RealBytesToMix + 1)
  End If
  Dim fMixBufPtr() As Float
  Dim fMixBufPtr_o As Int
  fMixBufPtr = fMixBuffer
  fMixBufPtr_o = fMixBuffer_o
  For i = 0 To RealBytesToMix - 1
    fMixBufPtr(fMixBufPtr_o) = fLastClickRemovalLeft
    fMixBufPtr_o = fMixBufPtr_o + 1
    fMixBufPtr(fMixBufPtr_o) = fLastClickRemovalRight
    fMixBufPtr_o = fMixBufPtr_o + 1
    fLastClickRemovalLeft = (fLastClickRemovalLeft - (fLastClickRemovalLeft * (1.0 / 4096.0)))
    fLastClickRemovalRight = (fLastClickRemovalRight - (fLastClickRemovalRight * (1.0 / 4096.0)))
  Next
  Dim sc As it2play_slaveChn_t = sChn(0)
  Dim i_2 As Long = 0
  Do While (i_2 < Driver.NumChannels)
    If (Not((Bit.And(sc.Flags, 1) <> 0)) Or (sc.Smp = 100)) Then
      i_2 = (i_2 + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    Dim s As it2play_sample_t = sc.SmpPtr
    If (Bit.And(sc.Flags, 512) <> 0) Then
      sc.Flags = Bit.And(sc.Flags, Bit.Not(1))
      sc.FinalVol32768 = 0
      sc.Flags = Bit.Or(sc.Flags, 64)
    End If
    If (Bit.And(sc.Flags, 32) <> 0) Then
      If ((Bit.AndLong(sc.Frequency, 4294967295)) >= 1073741823) Then
        sc.Flags = 512
        If Not((Bit.And(sc.HostChnNum, 128) <> 0)) Then
          sc.HostChnPtr.Flags = Bit.And(sc.HostChnPtr.Flags, Bit.Not(4))
        End If
        i_2 = (i_2 + 1)
        sc = AdvIdx(sc, 1)
        Continue
      End If
      sc.Delta64 = Bit.ShiftRightLong((I2L(sc.Frequency) * FreqMulVal), 14)
    End If
    If (Bit.And(sc.Flags, 256) <> 0) Then
      sc.fOldRightVolume = 0.0
      sc.fOldLeftVolume = sc.fOldRightVolume
      sc.fCurrVolR = 0.0
      sc.fCurrVolL = sc.fCurrVolR
      sc.fOldSamples(3) = 0.0
      sc.fOldSamples(2) = sc.fOldSamples(3)
      sc.fOldSamples(1) = sc.fOldSamples(2)
      sc.fOldSamples(0) = sc.fOldSamples(1)
      sc.fFiltera = 1.0
      sc.fFilterc = 0.0
      sc.fFilterb = sc.fFilterc
    End If
    If (Bit.And(sc.Flags, 33856) <> 0) Then
      Dim FilterQ As Int
      If (Bit.And(sc.HostChnNum, 128) <> 0) Then
        FilterQ = Bit.And((Bit.ShiftRight(sc.MIDIBank, 8)), 255)
      Else
        Dim filterCutOff As Int = Driver.FilterParameters(sc.HostChnNum)
        FilterQ = Driver.FilterParameters((64 + sc.HostChnNum))
        sc.VolEnvState.CurNode = Bit.Or((Bit.ShiftLeft(filterCutOff, 8)), (Bit.And(sc.VolEnvState.CurNode, 255)))
        sc.MIDIBank = Bit.And((Bit.Or((Bit.ShiftLeft(FilterQ, 8)), (Bit.And(sc.MIDIBank, 255)))), 65535)
      End If
      Dim FilterFreqValue As Int = Bit.And(((Bit.And(sc.MIDIBank, 255)) * (Bit.And((Bit.ShiftRight((Bit.And(sc.VolEnvState.CurNode, 65535)), 8)), 255))), 65535)
      If ((FilterFreqValue <> 32385) Or (FilterQ <> 0)) Then
        Dim r As Float = (Power(2, (FilterFreqValue * Driver.FreqParameterMultiplier)) * Driver.FreqMultiplier)
        Dim p As Float = Driver.QualityFactorTable(FilterQ)
        Dim d As Float = ((p * r) + (p - 1.0))
        Dim e As Float = (r * r)
        sc.fFiltera = (1.0 / ((1.0 + d) + e))
        sc.fFilterb = (((d + e) + e) * sc.fFiltera)
        sc.fFilterc = ((1.0 - sc.fFiltera) - sc.fFilterb)
      End If
      If (Bit.And(sc.Flags, 2048) <> 0) Then
        sc.fRightVolume = 0.0
        sc.fLeftVolume = sc.fRightVolume
      Else
        Dim Vol As Int = (sc.FinalVol32768 * MixVolume)
        If Not((Bit.And(Song.Header.Flags, 1) <> 0)) Then
          sc.fRightVolume = (Vol * (1.0 / (32768.0 * 128.0)))
          sc.fLeftVolume = sc.fRightVolume
        Else If (sc.FinalPan = 100) Then
          sc.fRightVolume = (Vol * (0.5 / (32768.0 * 128.0)))
          sc.fLeftVolume = sc.fRightVolume
        Else
          sc.fLeftVolume = (((64 - sc.FinalPan) * Vol) * (1.0 / ((64.0 * 32768.0) * 128.0)))
          sc.fRightVolume = ((sc.FinalPan * Vol) * (1.0 / ((64.0 * 32768.0) * 128.0)))
        End If
      End If
    End If
    If (sc.Delta64 = 0) Then
      i_2 = (i_2 + 1)
      sc = AdvIdx(sc, 1)
      Continue
    End If
    Dim MixBlockSize As Long = Bit.AndLong(RealBytesToMix, 4294967295)
    Dim FilterActive As Boolean = ((sc.fFilterb > 0.0) Or (sc.fFilterc > 0.0))
    If (((((sc.fLeftVolume = 0.0) And (sc.fRightVolume = 0.0)) And (sc.fOldLeftVolume <= 0.000001)) And (sc.fOldRightVolume <= 0.000001)) And Not(FilterActive)) Then
      Dim LoopLength As Long = Bit.AndLong((sc.LoopEnd - sc.LoopBegin), 4294967295)
      If (L2I(LoopLength) > 0) Then
        If (sc.LoopMode = 24) Then
          UpdatePingPongLoopHQ(sc, MixBlockSize)
        Else If (sc.LoopMode = 8) Then
          UpdateForwardsLoopHQ(sc, MixBlockSize)
        Else
          UpdateNoLoopHQ(sc, MixBlockSize)
        End If
      End If
    Else
      Dim Surround As Boolean = (sc.FinalPan = 100)
      Dim Stereo As Boolean = (Bit.And(s.Flags, 4) <> 0)
      Dim MixScene As Int = Bit.And(((((Bit.ShiftLeft(B2I(FilterActive), 3)) + (Bit.ShiftLeft(B2I(Stereo), 2))) + (Bit.ShiftLeft(B2I(Surround), 1))) + B2I(sc.SmpIs16Bit)), 255)
      Dim LoopLength_2 As Long = Bit.AndLong((sc.LoopEnd - sc.LoopBegin), 4294967295)
      If (L2I(LoopLength_2) > 0) Then
        Dim fMixBufferPtr() As Float
        Dim fMixBufferPtr_o As Int
        fMixBufferPtr = fMixBuffer
        fMixBufferPtr_o = fMixBuffer_o
        If (sc.LoopMode = 24) Then
          Do While (MixBlockSize > 0)
            Dim NewLoopPos As Long
            Dim SamplesToMix As Long
            If (sc.LoopDirection = 1) Then
              If (sc.SamplingPosition = sc.LoopBegin) Then
                sc.LoopDirection = 0
                sc.Frac64 = (Bit.AndLong((0 - sc.Frac64), 4294967295))
                SamplesToMix = Bit.AndLong(((sc.LoopEnd - 1) - sc.SamplingPosition), 4294967295)
                SamplesToMix = (Bit.AndLong(((IDivL((Bit.OrLong((Bit.ShiftLeftLong(SamplesToMix, 32)), (Bit.XorLong((Bit.AndLong(sc.Frac64, 4294967295)), 4294967295)))), sc.Delta64)) + 1), 4294967295))
                Driver.Delta64 = sc.Delta64
              Else
                SamplesToMix = Bit.AndLong((sc.SamplingPosition - (sc.LoopBegin + 1)), 4294967295)
                SamplesToMix = (Bit.AndLong(((IDivL((Bit.OrLong((Bit.ShiftLeftLong(SamplesToMix, 32)), (Bit.AndLong(sc.Frac64, 4294967295)))), sc.Delta64)) + 1), 4294967295))
                Driver.Delta64 = (0 - sc.Delta64)
              End If
            Else
              SamplesToMix = Bit.AndLong(((sc.LoopEnd - 1) - sc.SamplingPosition), 4294967295)
              SamplesToMix = (Bit.AndLong(((IDivL((Bit.OrLong((Bit.ShiftLeftLong(SamplesToMix, 32)), (Bit.XorLong((Bit.AndLong(sc.Frac64, 4294967295)), 4294967295)))), sc.Delta64)) + 1), 4294967295))
              Driver.Delta64 = sc.Delta64
            End If
            If (SamplesToMix > MixBlockSize) Then
              SamplesToMix = MixBlockSize
            End If
            fixSamplesPingpong(s, sc)
            MixerProccessor(MixScene, sc, fMixBufferPtr, fMixBufferPtr_o, L2I(SamplesToMix))
            unfixSamplesPingpong(s, sc)
            MixBlockSize = Bit.AndLong((MixBlockSize - SamplesToMix), 4294967295)
            fMixBufferPtr_o = fMixBufferPtr_o + L2I(Bit.ShiftLeftLong(SamplesToMix, 1))
            If (sc.LoopDirection = 1) Then
              If (sc.SamplingPosition <= sc.LoopBegin) Then
                NewLoopPos = Bit.AndLong(((Bit.AndLong((sc.LoopBegin - sc.SamplingPosition), 4294967295)) Mod (Bit.AndLong((Bit.ShiftLeftLong(LoopLength_2, 1)), 4294967295))), 4294967295)
                If (NewLoopPos >= LoopLength_2) Then
                  sc.SamplingPosition = L2I(((sc.LoopEnd - 1) - (NewLoopPos - LoopLength_2)))
                  If (sc.SamplingPosition = sc.LoopBegin) Then
                    sc.LoopDirection = 0
                    sc.Frac64 = (Bit.AndLong((0 - sc.Frac64), 4294967295))
                  End If
                Else
                  sc.LoopDirection = 0
                  sc.SamplingPosition = L2I((sc.LoopBegin + NewLoopPos))
                  sc.Frac64 = (Bit.AndLong((0 - sc.Frac64), 4294967295))
                End If
                sc.HasLooped = True
              End If
            Else
              If ((Bit.AndLong(sc.SamplingPosition, 4294967295)) >= (Bit.AndLong(sc.LoopEnd, 4294967295))) Then
                NewLoopPos = Bit.AndLong(((Bit.AndLong((sc.SamplingPosition - sc.LoopEnd), 4294967295)) Mod (Bit.AndLong((Bit.ShiftLeftLong(LoopLength_2, 1)), 4294967295))), 4294967295)
                If (NewLoopPos >= LoopLength_2) Then
                  sc.SamplingPosition = L2I((sc.LoopBegin + (NewLoopPos - LoopLength_2)))
                Else
                  sc.SamplingPosition = L2I(((sc.LoopEnd - 1) - NewLoopPos))
                  If (sc.SamplingPosition <> sc.LoopBegin) Then
                    sc.LoopDirection = 1
                    sc.Frac64 = (Bit.AndLong((0 - sc.Frac64), 4294967295))
                  End If
                End If
                sc.HasLooped = True
              End If
            End If
          Loop
        Else If (sc.LoopMode = 8) Then
          Do While (MixBlockSize > 0)
            Dim SamplesToMix_2 As Long = Bit.AndLong(((sc.LoopEnd - 1) - sc.SamplingPosition), 4294967295)
            SamplesToMix_2 = (Bit.AndLong(((IDivL((Bit.OrLong((Bit.ShiftLeftLong(SamplesToMix_2, 32)), (Bit.XorLong((Bit.AndLong(sc.Frac64, 4294967295)), 4294967295)))), sc.Delta64)) + 1), 4294967295))
            Driver.Delta64 = sc.Delta64
            If (SamplesToMix_2 > MixBlockSize) Then
              SamplesToMix_2 = MixBlockSize
            End If
            fixSamplesFwdLoop(s, sc)
            MixerProccessor(MixScene, sc, fMixBufferPtr, fMixBufferPtr_o, L2I(SamplesToMix_2))
            unfixSamplesFwdLoop(s, sc)
            MixBlockSize = Bit.AndLong((MixBlockSize - SamplesToMix_2), 4294967295)
            fMixBufferPtr_o = fMixBufferPtr_o + L2I(Bit.ShiftLeftLong(SamplesToMix_2, 1))
            If ((Bit.AndLong(sc.SamplingPosition, 4294967295)) >= (Bit.AndLong(sc.LoopEnd, 4294967295))) Then
              sc.SamplingPosition = L2I((sc.LoopBegin + ((Bit.AndLong((sc.SamplingPosition - sc.LoopEnd), 4294967295)) Mod LoopLength_2)))
              sc.HasLooped = True
            End If
          Loop
        Else
          Do While (MixBlockSize > 0)
            Dim SamplesToMix_3 As Long = Bit.AndLong(((sc.LoopEnd - 1) - sc.SamplingPosition), 4294967295)
            SamplesToMix_3 = (Bit.AndLong(((IDivL((Bit.OrLong((Bit.ShiftLeftLong(SamplesToMix_3, 32)), (Bit.XorLong((Bit.AndLong(sc.Frac64, 4294967295)), 4294967295)))), sc.Delta64)) + 1), 4294967295))
            Driver.Delta64 = sc.Delta64
            If (SamplesToMix_3 > MixBlockSize) Then
              SamplesToMix_3 = MixBlockSize
            End If
            fixSamplesNoLoop(s, sc)
            MixerProccessor(MixScene, sc, fMixBufferPtr, fMixBufferPtr_o, L2I(SamplesToMix_3))
            MixBlockSize = Bit.AndLong((MixBlockSize - SamplesToMix_3), 4294967295)
            fMixBufferPtr_o = fMixBufferPtr_o + L2I(Bit.ShiftLeftLong(SamplesToMix_3, 1))
            If ((Bit.AndLong(sc.SamplingPosition, 4294967295)) >= (Bit.AndLong(sc.LoopEnd, 4294967295))) Then
              sc.Flags = 512
              If Not((Bit.And(sc.HostChnNum, 128) <> 0)) Then
                sc.HostChnPtr.Flags = Bit.And(sc.HostChnPtr.Flags, Bit.Not(4))
              End If
              Do While (MixBlockSize > 0)
                fMixBufferPtr(fMixBufferPtr_o) = (fMixBufferPtr(fMixBufferPtr_o) + Driver.fLastLeftValue)
                fMixBufferPtr_o = fMixBufferPtr_o + 1
                fMixBufferPtr(fMixBufferPtr_o) = (fMixBufferPtr(fMixBufferPtr_o) + Driver.fLastRightValue)
                fMixBufferPtr_o = fMixBufferPtr_o + 1
                Driver.fLastLeftValue = (Driver.fLastLeftValue - (Driver.fLastLeftValue * (1.0 / 4096.0)))
                Driver.fLastRightValue = (Driver.fLastRightValue - (Driver.fLastRightValue * (1.0 / 4096.0)))
                MixBlockSize = (MixBlockSize - 1)
              Loop
              fLastClickRemovalLeft = (fLastClickRemovalLeft + Driver.fLastLeftValue)
              fLastClickRemovalRight = (fLastClickRemovalRight + Driver.fLastRightValue)
              Exit
            End If
          Loop
        End If
      End If
      sc.fOldLeftVolume = sc.fCurrVolL
      If Not(Surround) Then
        sc.fOldRightVolume = sc.fCurrVolR
      End If
    End If
    sc.Flags = Bit.And(sc.Flags, Bit.Not(34674))
    i_2 = (i_2 + 1)
    sc = AdvIdx(sc, 1)
  Loop
End Sub

Private Sub HQ_SetTempo(Tempo As Int)
  If (Tempo < 31) Then
    Tempo = 31
  End If
  Dim index As Long = Bit.AndLong((Tempo - 31), 4294967295)
  BytesToMix = SamplesPerTickInt(L2I(index))
  BytesToMixFractional = SamplesPerTickFrac(L2I(index))
End Sub

Private Sub HQ_SetMixVolume(Vol As Int)
  MixVolume = Vol
  RecalculateAllVolumes
End Sub

Private Sub ITRandom32 As Int
  RandSeed = Bit.AndLong((RandSeed * 134775813), 4294967295)
  RandSeed = Bit.AndLong((RandSeed + 1), 4294967295)
  Return L2I(RandSeed)
End Sub

Private Sub HQ_PostMix(AudioOut16() As Short, AudioOut16_o As Int, SamplesToOutput As Int) As Int
  Dim out32 As Int
  Dim fOut As Float
  Dim fPrng As Float
  Dim SamplesTodo As Int = IIf((SamplesToOutput = 0), RealBytesToMix, SamplesToOutput)
  For i = 0 To SamplesTodo - 1
    fPrng = (ITRandom32 * (0.5 / 2147483647))
    Dim tmp51 As Int = MixTransferOffset
    MixTransferOffset = MixTransferOffset + 1
    fOut = (fMixBuffer((fMixBuffer_o + tmp51)) * MixGain)
    fOut = ((fOut + fPrng) - fPrngStateL)
    fPrngStateL = fPrng
    out32 = D2I(fOut)
    AudioOut16(AudioOut16_o) = HQ_Clamp(out32)
    AudioOut16_o = AudioOut16_o + 1
    fPrng = (ITRandom32 * (0.5 / 2147483647))
    Dim tmp54 As Int = MixTransferOffset
    MixTransferOffset = MixTransferOffset + 1
    fOut = (fMixBuffer((fMixBuffer_o + tmp54)) * MixGain)
    fOut = ((fOut + fPrng) - fPrngStateR)
    fPrngStateR = fPrng
    out32 = D2I(fOut)
    AudioOut16(AudioOut16_o) = HQ_Clamp(out32)
    AudioOut16_o = AudioOut16_o + 1
  Next
  Return SamplesTodo
End Sub

Private Sub HQ_Mix(numSamples As Int, audioOut() As Short, audioOut_o As Int)
  Dim SamplesLeft As Int = numSamples
  Do While (SamplesLeft > 0)
    If (MixTransferRemaining = 0) Then
      UpdateIT
      HQ_MixSamples
      MixTransferRemaining = RealBytesToMix
    End If
    Dim SamplesToTransfer As Int = SamplesLeft
    If (SamplesToTransfer > MixTransferRemaining) Then
      SamplesToTransfer = MixTransferRemaining
    End If
    HQ_PostMix(audioOut, audioOut_o, SamplesToTransfer)
    audioOut_o = audioOut_o + (SamplesToTransfer * 2)
    MixTransferRemaining = (MixTransferRemaining - SamplesToTransfer)
    SamplesLeft = (SamplesLeft - SamplesToTransfer)
  Loop
End Sub

Private Sub HQ_CloseDriver
  If (fMixBuffer <> Null) Then
    fMixBuffer = Null
    fMixBuffer_o = 0
  End If
  If (Driver.fSincLUT <> Null) Then
    Driver.fSincLUT = Null
    Driver.fSincLUT_o = 0
  End If
End Sub

Private Sub HQ_InitDriver(mixingFrequency As Int)
  If (mixingFrequency > 768000) Then
    mixingFrequency = 768000
  Else If (mixingFrequency < 32769) Then
    mixingFrequency = 32769
  End If
  FreqMulVal = D2I(RoundTo((70368744177664 / mixingFrequency)))
  Dim maxSamplesToMix As Int = (D2I(Ceil(((mixingFrequency * 2.5) / 31))) + 1)
  fMixBuffer = NewFloatArr((maxSamplesToMix * 2))
  fMixBuffer_o = 0
  Driver.Flags = 27
  Driver.NumChannels = 256
  Driver.MixFrequency = Bit.AndLong(mixingFrequency, 4294967295)
  Dim dMixFreq25 As Double = (Driver.MixFrequency * 2.5)
  For bpm = 31 To 255
    Dim dSamplesPerTick As Double = (dMixFreq25 / bpm)
    Dim samplesPerTickFp As Long = D2L(((dSamplesPerTick * 2147483648) + 0.5))
    Dim i As Long = Bit.AndLong((bpm - 31), 4294967295)
    SamplesPerTickInt(L2I(i)) = L2I((Bit.AndLong((Bit.ShiftRightLong(samplesPerTickFp, 31)), 4294967295)))
    SamplesPerTickFrac(L2I(i)) = (Bit.AndLong(samplesPerTickFp, 2147483647))
  Next
  CreateWindowedSincKernel
End Sub

Private Sub HQ_Clamp(fOut As Int) As Int
  If (fOut > 32767) Then
    Return 32767
  Else If (fOut < (-32768)) Then
    Return (-32768)
  Else
    Return fOut
  End If
End Sub

Private Sub GetSincTable(sc As it2play_slaveChn_t) As Float()
  RetOfs = (Driver.fSincLUT_o + L2I((Bit.AndLong((Bit.ShiftRightLong((Bit.AndLong(sc.Frac64, 4294967295)), 17)), 32760))))
  Return Driver.fSincLUT
End Sub

Private Sub SincInterpolation8(s() As Byte, s_o As Int, t() As Float, t_o As Int, scale As Float) As Float
  Return (((((((((s((s_o + (-3))) * t(t_o)) + (s((s_o + (-2))) * t((t_o + 1)))) + (s((s_o + (-1))) * t((t_o + 2)))) + (s(s_o) * t((t_o + 3)))) + (s((s_o + 1)) * t((t_o + 4)))) + (s((s_o + 2)) * t((t_o + 5)))) + (s((s_o + 3)) * t((t_o + 6)))) + (s((s_o + 4)) * t((t_o + 7)))) * (1.0 / scale))
End Sub

Private Sub SincInterpolation16(s() As Short, s_o As Int, t() As Float, t_o As Int, scale As Float) As Float
  Return (((((((((s((s_o + (-3))) * t(t_o)) + (s((s_o + (-2))) * t((t_o + 1)))) + (s((s_o + (-1))) * t((t_o + 2)))) + (s(s_o) * t((t_o + 3)))) + (s((s_o + 1)) * t((t_o + 4)))) + (s((s_o + 2)) * t((t_o + 5)))) + (s((s_o + 3)) * t((t_o + 6)))) + (s((s_o + 4)) * t((t_o + 7)))) * (1.0 / scale))
End Sub

Private Sub ClipFilterSample(x As Float) As Float
  If (x < (-2.0)) Then
    Return (-2.0)
  End If
  If (x > 2.0) Then
    Return 2.0
  End If
  Return x
End Sub

Private Sub FilterSample(sc As it2play_slaveChn_t, fSample As Float) As Float
  fSample = (((fSample * sc.fFiltera) + (sc.fOldSamples(0) * sc.fFilterb)) + (sc.fOldSamples(1) * sc.fFilterc))
  fSample = ClipFilterSample(fSample)
  sc.fOldSamples(1) = sc.fOldSamples(0)
  sc.fOldSamples(0) = fSample
  Return fSample
End Sub

Private Sub FilterStereoSample(sc As it2play_slaveChn_t, fSample() As Float, fSample_o As Int, fSampleR() As Float, fSampleR_o As Int)
  Dim l As Float = (((fSample(fSample_o) * sc.fFiltera) + (sc.fOldSamples(0) * sc.fFilterb)) + (sc.fOldSamples(1) * sc.fFilterc))
  Dim r As Float = (((fSampleR(fSampleR_o) * sc.fFiltera) + (sc.fOldSamples(2) * sc.fFilterb)) + (sc.fOldSamples(3) * sc.fFilterc))
  l = ClipFilterSample(l)
  r = ClipFilterSample(r)
  sc.fOldSamples(1) = sc.fOldSamples(0)
  sc.fOldSamples(0) = l
  sc.fOldSamples(3) = sc.fOldSamples(2)
  sc.fOldSamples(2) = r
  fSample(fSample_o) = l
  fSampleR(fSampleR_o) = r
End Sub

Private Sub MixSample(sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, fSample As Float)
  Driver.fLastLeftValue = (fSample * sc.fCurrVolL)
  Driver.fLastRightValue = (fSample * sc.fCurrVolR)
  fMixBufPtr(fMixBufPtr_o) = (fMixBufPtr(fMixBufPtr_o) + Driver.fLastLeftValue)
  fMixBufPtr((fMixBufPtr_o + 1)) = (fMixBufPtr((fMixBufPtr_o + 1)) + Driver.fLastRightValue)
End Sub

Private Sub MixSampleSurround(sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, fSample As Float)
  Driver.fLastLeftValue = (fSample * sc.fCurrVolL)
  fMixBufPtr(fMixBufPtr_o) = (fMixBufPtr(fMixBufPtr_o) + Driver.fLastLeftValue)
  fMixBufPtr((fMixBufPtr_o + 1)) = (fMixBufPtr((fMixBufPtr_o + 1)) - Driver.fLastLeftValue)
End Sub

Private Sub MixStereoSample(sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, fSample As Float, fSampleR As Float)
  Driver.fLastLeftValue = (fSample * sc.fCurrVolL)
  Driver.fLastRightValue = (fSampleR * sc.fCurrVolR)
  fMixBufPtr(fMixBufPtr_o) = (fMixBufPtr(fMixBufPtr_o) + Driver.fLastLeftValue)
  fMixBufPtr((fMixBufPtr_o + 1)) = (fMixBufPtr((fMixBufPtr_o + 1)) + Driver.fLastRightValue)
End Sub

Private Sub MixStereoSampleSurround(sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, fSample As Float, fSampleR As Float)
  Driver.fLastLeftValue = (fSample * sc.fCurrVolL)
  Driver.fLastRightValue = (fSampleR * sc.fCurrVolL)
  fMixBufPtr(fMixBufPtr_o) = (fMixBufPtr(fMixBufPtr_o) + Driver.fLastLeftValue)
  fMixBufPtr((fMixBufPtr_o + 1)) = (fMixBufPtr((fMixBufPtr_o + 1)) - Driver.fLastRightValue)
End Sub

Private Sub RampCurrVolumeL(sc As it2play_slaveChn_t)
  sc.fCurrVolL = (sc.fCurrVolL + ((sc.fLeftVolume - sc.fCurrVolL) * 0.015625))
End Sub

Private Sub RampCurrVolumeR(sc As it2play_slaveChn_t)
  sc.fCurrVolR = (sc.fCurrVolR + ((sc.fRightVolume - sc.fCurrVolR) * 0.015625))
End Sub

Private Sub UpdatePos(sc As it2play_slaveChn_t) As Int
  sc.Frac64 = (sc.Frac64 + Driver.Delta64)
  Dim wholeSamples As Int = L2I((Bit.ShiftRightLong(sc.Frac64, 32)))
  sc.Frac64 = Bit.AndLong(sc.Frac64, 4294967295)
  Return wholeSamples
End Sub

Private Sub MixMono8Core(sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, NumSamples As Int, filtered As Boolean, surround As Boolean)
  Dim s As it2play_sample_t = sc.SmpPtr
  Dim base() As Byte
  Dim base_o As Int
  base = s.Data8
  base_o = 8
  Dim smp() As Byte
  Dim smp_o As Int
  smp = base
  smp_o = (base_o + sc.SamplingPosition)
  For i = 0 To NumSamples - 1
    Dim fSample As Float = SincInterpolation8(smp, smp_o, GetSincTable(sc), RetOfs, 128.0)
    If filtered Then
      fSample = FilterSample(sc, fSample)
    End If
    If surround Then
      MixSampleSurround(sc, fMixBufPtr, fMixBufPtr_o, fSample)
    Else
      MixSample(sc, fMixBufPtr, fMixBufPtr_o, fSample)
    End If
    fMixBufPtr_o = fMixBufPtr_o + 2
    smp_o = smp_o + UpdatePos(sc)
    RampCurrVolumeL(sc)
    If Not(surround) Then
      RampCurrVolumeR(sc)
    End If
  Next
  If surround Then
    Driver.fLastRightValue = (-Driver.fLastLeftValue)
  End If
  sc.SamplingPosition = L2I((smp_o - base_o))
End Sub

Private Sub MixMono16Core(sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, NumSamples As Int, filtered As Boolean, surround As Boolean)
  Dim s As it2play_sample_t = sc.SmpPtr
  Dim base() As Short
  Dim base_o As Int
  base = s.Data16
  base_o = 4
  Dim smp() As Short
  Dim smp_o As Int
  smp = base
  smp_o = (base_o + sc.SamplingPosition)
  For i = 0 To NumSamples - 1
    Dim fSample As Float = SincInterpolation16(smp, smp_o, GetSincTable(sc), RetOfs, 32768.0)
    If filtered Then
      fSample = FilterSample(sc, fSample)
    End If
    If surround Then
      MixSampleSurround(sc, fMixBufPtr, fMixBufPtr_o, fSample)
    Else
      MixSample(sc, fMixBufPtr, fMixBufPtr_o, fSample)
    End If
    fMixBufPtr_o = fMixBufPtr_o + 2
    smp_o = smp_o + UpdatePos(sc)
    RampCurrVolumeL(sc)
    If Not(surround) Then
      RampCurrVolumeR(sc)
    End If
  Next
  If surround Then
    Driver.fLastRightValue = (-Driver.fLastLeftValue)
  End If
  sc.SamplingPosition = L2I((smp_o - base_o))
End Sub

Private Sub MixStereo8Core(sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, NumSamples As Int, filtered As Boolean, surround As Boolean)
  Dim s As it2play_sample_t = sc.SmpPtr
  Dim base() As Byte
  Dim base_o As Int
  base = s.Data8
  base_o = 8
  Dim baseR() As Byte
  Dim baseR_o As Int
  baseR = s.DataR8
  baseR_o = 8
  Dim smp() As Byte
  Dim smp_o As Int
  smp = base
  smp_o = (base_o + sc.SamplingPosition)
  Dim smpR() As Byte
  Dim smpR_o As Int
  smpR = baseR
  smpR_o = (baseR_o + sc.SamplingPosition)
  For i = 0 To NumSamples - 1
    Dim fSample As Float
    Dim fSampleR As Float
    Dim t() As Float
    Dim t_o As Int
    t = GetSincTable(sc)
    t_o = RetOfs
    fSample = SincInterpolation8(smp, smp_o, t, t_o, 128.0)
    fSampleR = SincInterpolation8(smpR, smpR_o, t, t_o, 128.0)
    If filtered Then
      Dim tmp56(1) As Float
      tmp56(0) = fSample
      Dim tmp57(1) As Float
      tmp57(0) = fSampleR
      FilterStereoSample(sc, tmp56, 0, tmp57, 0)
      fSample = tmp56(0)
      fSampleR = tmp57(0)
    End If
    If surround Then
      MixStereoSampleSurround(sc, fMixBufPtr, fMixBufPtr_o, fSample, fSampleR)
    Else
      MixStereoSample(sc, fMixBufPtr, fMixBufPtr_o, fSample, fSampleR)
    End If
    fMixBufPtr_o = fMixBufPtr_o + 2
    Dim wholeSamples As Int = UpdatePos(sc)
    smp_o = smp_o + wholeSamples
    smpR_o = smpR_o + wholeSamples
    RampCurrVolumeL(sc)
    If Not(surround) Then
      RampCurrVolumeR(sc)
    End If
  Next
  If surround Then
    Driver.fLastRightValue = (-Driver.fLastRightValue)
  End If
  sc.SamplingPosition = L2I((smp_o - base_o))
End Sub

Private Sub MixStereo16Core(sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, NumSamples As Int, filtered As Boolean, surround As Boolean)
  Dim s As it2play_sample_t = sc.SmpPtr
  Dim base() As Short
  Dim base_o As Int
  base = s.Data16
  base_o = 4
  Dim baseR() As Short
  Dim baseR_o As Int
  baseR = s.DataR16
  baseR_o = 4
  Dim smp() As Short
  Dim smp_o As Int
  smp = base
  smp_o = (base_o + sc.SamplingPosition)
  Dim smpR() As Short
  Dim smpR_o As Int
  smpR = baseR
  smpR_o = (baseR_o + sc.SamplingPosition)
  For i = 0 To NumSamples - 1
    Dim fSample As Float
    Dim fSampleR As Float
    Dim t() As Float
    Dim t_o As Int
    t = GetSincTable(sc)
    t_o = RetOfs
    fSample = SincInterpolation16(smp, smp_o, t, t_o, 32768.0)
    fSampleR = SincInterpolation16(smpR, smpR_o, t, t_o, 32768.0)
    If filtered Then
      Dim tmp58(1) As Float
      tmp58(0) = fSample
      Dim tmp59(1) As Float
      tmp59(0) = fSampleR
      FilterStereoSample(sc, tmp58, 0, tmp59, 0)
      fSample = tmp58(0)
      fSampleR = tmp59(0)
    End If
    If surround Then
      MixStereoSampleSurround(sc, fMixBufPtr, fMixBufPtr_o, fSample, fSampleR)
    Else
      MixStereoSample(sc, fMixBufPtr, fMixBufPtr_o, fSample, fSampleR)
    End If
    fMixBufPtr_o = fMixBufPtr_o + 2
    Dim wholeSamples As Int = UpdatePos(sc)
    smp_o = smp_o + wholeSamples
    smpR_o = smpR_o + wholeSamples
    RampCurrVolumeL(sc)
    If Not(surround) Then
      RampCurrVolumeR(sc)
    End If
  Next
  If surround Then
    Driver.fLastRightValue = (-Driver.fLastRightValue)
  End If
  sc.SamplingPosition = L2I((smp_o - base_o))
End Sub

Private Sub MixerProccessor(numfunc As Int, sc As it2play_slaveChn_t, fMixBufPtr() As Float, fMixBufPtr_o As Int, numSamples As Int)
  Dim p1 As Boolean = Bit.And(numfunc, 8) <> 0
  Dim p2 As Boolean = Bit.And(numfunc, 2) <> 0   
  Dim n As Int = Bit.Or(Bit.And(numfunc, 1), Bit.ShiftRight(Bit.And(numfunc, 4), 1))
  
  Select n
    Case 0
    MixMono8Core(sc, fMixBufPtr, fMixBufPtr_o, numSamples, p1, p2)
    
    Case 1
    MixMono16Core(sc, fMixBufPtr, fMixBufPtr_o, numSamples, p1, p2)

    Case 2
    MixStereo8Core(sc, fMixBufPtr, fMixBufPtr_o, numSamples, p1, p2)

    Case 3
    MixStereo16Core(sc, fMixBufPtr, fMixBufPtr_o, numSamples, p1, p2)
  End Select
End Sub

Private Sub UpdateNoLoopHQ(sc As it2play_slaveChn_t, numSamples As Long)
  Dim SamplingPosition As Long = Bit.AndLong(sc.SamplingPosition, 4294967295)
  Dim Delta As Long = (sc.Delta64 * numSamples)
  Dim IntSamples As Long = (Bit.AndLong((Bit.ShiftRightLong(Delta, 32)), 4294967295))
  Dim FracSamples As Long = Bit.AndLong(Delta, 4294967295)
  sc.Frac64 = (sc.Frac64 + FracSamples)
  SamplingPosition = Bit.AndLong((SamplingPosition + (Bit.ShiftRightLong(sc.Frac64, 32))), 4294967295)
  SamplingPosition = Bit.AndLong((SamplingPosition + IntSamples), 4294967295)
  sc.Frac64 = Bit.AndLong(sc.Frac64, 4294967295)
  If (SamplingPosition >= (Bit.AndLong(sc.LoopEnd, 4294967295))) Then
    sc.Flags = 512
    If Not((Bit.And(sc.HostChnNum, 128) <> 0)) Then
      sc.HostChnPtr.Flags = Bit.And(sc.HostChnPtr.Flags, Bit.Not(4))
      Return
    End If
  End If
  sc.SamplingPosition = L2I(SamplingPosition)
End Sub

Private Sub UpdateForwardsLoopHQ(sc As it2play_slaveChn_t, numSamples As Long)
  Dim Delta As Long = (sc.Delta64 * numSamples)
  Dim IntSamples As Long = Bit.AndLong((Bit.ShiftRightLong(Delta, 32)), 4294967295)
  Dim FracSamples As Long = Bit.AndLong(Delta, 4294967295)
  sc.Frac64 = (sc.Frac64 + FracSamples)
  sc.SamplingPosition = L2I((sc.SamplingPosition + Bit.ShiftRightLong(sc.Frac64, 32)))
  sc.SamplingPosition = L2I((sc.SamplingPosition + IntSamples))
  sc.Frac64 = Bit.AndLong(sc.Frac64, 4294967295)
  If ((Bit.AndLong(sc.SamplingPosition, 4294967295)) >= (Bit.AndLong(sc.LoopEnd, 4294967295))) Then
    Dim LoopLength As Long = Bit.AndLong((sc.LoopEnd - sc.LoopBegin), 4294967295)
    If (LoopLength = 0) Then
      sc.SamplingPosition = 0
    Else
      sc.SamplingPosition = L2I((sc.LoopBegin + ((sc.SamplingPosition - sc.LoopEnd) Mod LoopLength)))
    End If
    sc.HasLooped = True
  End If
End Sub

Private Sub UpdatePingPongLoopHQ(sc As it2play_slaveChn_t, numSamples As Long)
  Dim Delta As Long = (sc.Delta64 * numSamples)
  Dim IntSamples As Long = Bit.AndLong((Bit.ShiftRightLong(Delta, 32)), 4294967295)
  Dim FracSamples As Long = Bit.AndLong(Delta, 4294967295)
  Dim LoopLength As Long = Bit.AndLong((sc.LoopEnd - sc.LoopBegin), 4294967295)
  If (sc.LoopDirection = 1) Then
    sc.Frac64 = (sc.Frac64 - FracSamples)
    sc.SamplingPosition = (sc.SamplingPosition + L2I((Bit.ShiftRightLong(sc.Frac64, 32))))
    sc.SamplingPosition = L2I((sc.SamplingPosition - IntSamples))
    sc.Frac64 = Bit.AndLong(sc.Frac64, 4294967295)
    If (sc.SamplingPosition <= sc.LoopBegin) Then
      Dim NewLoopPos As Long = Bit.AndLong(((Bit.AndLong((sc.LoopBegin - sc.SamplingPosition), 4294967295)) Mod (Bit.AndLong((Bit.ShiftLeftLong(LoopLength, 1)), 4294967295))), 4294967295)
      If (NewLoopPos >= LoopLength) Then
        sc.SamplingPosition = L2I(((sc.LoopEnd - 1) - (NewLoopPos - LoopLength)))
        If (sc.SamplingPosition = sc.LoopBegin) Then
          sc.LoopDirection = 0
          sc.Frac64 = (Bit.AndLong((0 - sc.Frac64), 4294967295))
        End If
      Else
        sc.LoopDirection = 0
        sc.SamplingPosition = L2I((sc.LoopBegin + NewLoopPos))
        sc.Frac64 = (Bit.AndLong((0 - sc.Frac64), 4294967295))
      End If
      sc.HasLooped = True
    End If
  Else
    sc.Frac64 = (sc.Frac64 + FracSamples)
    sc.SamplingPosition = (sc.SamplingPosition + L2I((Bit.ShiftRightLong(sc.Frac64, 32))))
    sc.SamplingPosition = L2I((sc.SamplingPosition + IntSamples))
    sc.Frac64 = Bit.AndLong(sc.Frac64, 4294967295)
    If ((Bit.AndLong(sc.SamplingPosition, 4294967295)) >= (Bit.AndLong(sc.LoopEnd, 4294967295))) Then
      Dim NewLoopPos_2 As Long = Bit.AndLong(((Bit.AndLong((sc.SamplingPosition - sc.LoopEnd), 4294967295)) Mod (Bit.AndLong((Bit.ShiftLeftLong(LoopLength, 1)), 4294967295))), 4294967295)
      If (NewLoopPos_2 >= LoopLength) Then
        sc.SamplingPosition = L2I((sc.LoopBegin + (NewLoopPos_2 - LoopLength)))
      Else
        sc.SamplingPosition = L2I(((sc.LoopEnd - 1) - NewLoopPos_2))
        If (sc.SamplingPosition <> sc.LoopBegin) Then
          sc.LoopDirection = 1
          sc.Frac64 = (Bit.AndLong((0 - sc.Frac64), 4294967295))
        End If
      End If
      sc.HasLooped = True
    End If
  End If
End Sub

Private Sub fixSamplesPingpong(s As it2play_sample_t, sc As it2play_slaveChn_t)
  Dim LoopLength As Int = (sc.LoopEnd - sc.LoopBegin)
  If (LoopLength <= 4) Then
    Return
  End If
  If sc.SmpIs16Bit Then
    Dim ptr() As Short
    Dim ptr_o As Int
    ptr = s.Data16
    ptr_o = 4
    Dim loopBegin() As Short
    Dim loopBegin_o As Int
    loopBegin = s.Data16
    loopBegin_o = (4 + sc.LoopBegin)
    Dim loopEnd() As Short
    Dim loopEnd_o As Int
    loopEnd = s.Data16
    loopEnd_o = (4 + sc.LoopEnd)
    If sc.HasLooped Then
      sc.leftTmpSamples16(0) = loopBegin((loopBegin_o + (-1)))
      sc.leftTmpSamples16(1) = loopBegin((loopBegin_o + (-2)))
      sc.leftTmpSamples16(2) = loopBegin((loopBegin_o + (-3)))
      loopBegin((loopBegin_o + (-1))) = loopBegin(loopBegin_o)
      loopBegin((loopBegin_o + (-2))) = loopBegin((loopBegin_o + 1))
      loopBegin((loopBegin_o + (-3))) = loopBegin((loopBegin_o + 2))
    Else
      ptr((ptr_o + (-1))) = ptr(ptr_o)
      ptr((ptr_o + (-2))) = ptr(ptr_o)
      ptr((ptr_o + (-3))) = ptr(ptr_o)
    End If
    sc.rightTmpSamples16(0) = loopEnd(loopEnd_o)
    sc.rightTmpSamples16(1) = loopEnd((loopEnd_o + 1))
    sc.rightTmpSamples16(2) = loopEnd((loopEnd_o + 2))
    sc.rightTmpSamples16(3) = loopEnd((loopEnd_o + 3))
    loopEnd(loopEnd_o) = loopEnd((loopEnd_o + (-1)))
    loopEnd((loopEnd_o + 1)) = loopEnd((loopEnd_o + (-2)))
    loopEnd((loopEnd_o + 2)) = loopEnd((loopEnd_o + (-3)))
    loopEnd((loopEnd_o + 3)) = loopEnd((loopEnd_o + (-4)))
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      ptr = s.DataR16
      ptr_o = 4
      loopBegin = s.DataR16
      loopBegin_o = (4 + sc.LoopBegin)
      loopEnd = s.DataR16
      loopEnd_o = (4 + sc.LoopEnd)
      If sc.HasLooped Then
        sc.leftTmpSamples16_R(0) = loopBegin((loopBegin_o + (-1)))
        sc.leftTmpSamples16_R(1) = loopBegin((loopBegin_o + (-2)))
        sc.leftTmpSamples16_R(2) = loopBegin((loopBegin_o + (-3)))
        loopBegin((loopBegin_o + (-1))) = loopBegin(loopBegin_o)
        loopBegin((loopBegin_o + (-2))) = loopBegin((loopBegin_o + 1))
        loopBegin((loopBegin_o + (-3))) = loopBegin((loopBegin_o + 2))
      Else
        ptr((ptr_o + (-1))) = ptr(ptr_o)
        ptr((ptr_o + (-2))) = ptr(ptr_o)
        ptr((ptr_o + (-3))) = ptr(ptr_o)
      End If
      sc.rightTmpSamples16_R(0) = loopEnd(loopEnd_o)
      sc.rightTmpSamples16_R(1) = loopEnd((loopEnd_o + 1))
      sc.rightTmpSamples16_R(2) = loopEnd((loopEnd_o + 2))
      sc.rightTmpSamples16_R(3) = loopEnd((loopEnd_o + 3))
      loopEnd(loopEnd_o) = loopEnd((loopEnd_o + (-1)))
      loopEnd((loopEnd_o + 1)) = loopEnd((loopEnd_o + (-2)))
      loopEnd((loopEnd_o + 2)) = loopEnd((loopEnd_o + (-3)))
      loopEnd((loopEnd_o + 3)) = loopEnd((loopEnd_o + (-4)))
    End If
  Else
    Dim ptr_2() As Byte
    Dim ptr_2_o As Int
    ptr_2 = s.Data8
    ptr_2_o = 8
    Dim loopBegin_2() As Byte
    Dim loopBegin_2_o As Int
    loopBegin_2 = s.Data8
    loopBegin_2_o = (8 + sc.LoopBegin)
    Dim loopEnd_2() As Byte
    Dim loopEnd_2_o As Int
    loopEnd_2 = s.Data8
    loopEnd_2_o = (8 + sc.LoopEnd)
    If sc.HasLooped Then
      sc.leftTmpSamples8(0) = loopBegin_2((loopBegin_2_o + (-1)))
      sc.leftTmpSamples8(1) = loopBegin_2((loopBegin_2_o + (-2)))
      sc.leftTmpSamples8(2) = loopBegin_2((loopBegin_2_o + (-3)))
      loopBegin_2((loopBegin_2_o + (-1))) = loopBegin_2(loopBegin_2_o)
      loopBegin_2((loopBegin_2_o + (-2))) = loopBegin_2((loopBegin_2_o + 1))
      loopBegin_2((loopBegin_2_o + (-3))) = loopBegin_2((loopBegin_2_o + 2))
    Else
      ptr_2((ptr_2_o + (-1))) = ptr_2(ptr_2_o)
      ptr_2((ptr_2_o + (-2))) = ptr_2(ptr_2_o)
      ptr_2((ptr_2_o + (-3))) = ptr_2(ptr_2_o)
    End If
    sc.rightTmpSamples8(0) = loopEnd_2(loopEnd_2_o)
    sc.rightTmpSamples8(1) = loopEnd_2((loopEnd_2_o + 1))
    sc.rightTmpSamples8(2) = loopEnd_2((loopEnd_2_o + 2))
    sc.rightTmpSamples8(3) = loopEnd_2((loopEnd_2_o + 3))
    loopEnd_2(loopEnd_2_o) = loopEnd_2((loopEnd_2_o + (-1)))
    loopEnd_2((loopEnd_2_o + 1)) = loopEnd_2((loopEnd_2_o + (-2)))
    loopEnd_2((loopEnd_2_o + 2)) = loopEnd_2((loopEnd_2_o + (-3)))
    loopEnd_2((loopEnd_2_o + 3)) = loopEnd_2((loopEnd_2_o + (-4)))
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      ptr_2 = s.DataR8
      ptr_2_o = 8
      loopBegin_2 = s.DataR8
      loopBegin_2_o = (8 + sc.LoopBegin)
      loopEnd_2 = s.DataR8
      loopEnd_2_o = (8 + sc.LoopEnd)
      If sc.HasLooped Then
        sc.leftTmpSamples8_R(0) = loopBegin_2((loopBegin_2_o + (-1)))
        sc.leftTmpSamples8_R(1) = loopBegin_2((loopBegin_2_o + (-2)))
        sc.leftTmpSamples8_R(2) = loopBegin_2((loopBegin_2_o + (-3)))
        loopBegin_2((loopBegin_2_o + (-1))) = loopBegin_2(loopBegin_2_o)
        loopBegin_2((loopBegin_2_o + (-2))) = loopBegin_2((loopBegin_2_o + 1))
        loopBegin_2((loopBegin_2_o + (-3))) = loopBegin_2((loopBegin_2_o + 2))
      Else
        ptr_2((ptr_2_o + (-1))) = ptr_2(ptr_2_o)
        ptr_2((ptr_2_o + (-2))) = ptr_2(ptr_2_o)
        ptr_2((ptr_2_o + (-3))) = ptr_2(ptr_2_o)
      End If
      sc.rightTmpSamples8_R(0) = loopEnd_2(loopEnd_2_o)
      sc.rightTmpSamples8_R(1) = loopEnd_2((loopEnd_2_o + 1))
      sc.rightTmpSamples8_R(2) = loopEnd_2((loopEnd_2_o + 2))
      sc.rightTmpSamples8_R(3) = loopEnd_2((loopEnd_2_o + 3))
      loopEnd_2(loopEnd_2_o) = loopEnd_2((loopEnd_2_o + (-1)))
      loopEnd_2((loopEnd_2_o + 1)) = loopEnd_2((loopEnd_2_o + (-2)))
      loopEnd_2((loopEnd_2_o + 2)) = loopEnd_2((loopEnd_2_o + (-3)))
      loopEnd_2((loopEnd_2_o + 3)) = loopEnd_2((loopEnd_2_o + (-4)))
    End If
  End If
End Sub

Private Sub unfixSamplesPingpong(s As it2play_sample_t, sc As it2play_slaveChn_t)
  Dim LoopLength As Int = (sc.LoopEnd - sc.LoopBegin)
  If (LoopLength <= 4) Then
    Return
  End If
  If sc.SmpIs16Bit Then
    Dim loopEnd() As Short
    Dim loopEnd_o As Int
    loopEnd = s.Data16
    loopEnd_o = (4 + sc.LoopEnd)
    loopEnd(loopEnd_o) = sc.rightTmpSamples16(0)
    loopEnd((loopEnd_o + 1)) = sc.rightTmpSamples16(1)
    loopEnd((loopEnd_o + 2)) = sc.rightTmpSamples16(2)
    loopEnd((loopEnd_o + 3)) = sc.rightTmpSamples16(3)
    If sc.HasLooped Then
      Dim loopBegin() As Short
      Dim loopBegin_o As Int
      loopBegin = s.Data16
      loopBegin_o = (4 + sc.LoopBegin)
      loopBegin((loopBegin_o + (-1))) = sc.leftTmpSamples16(0)
      loopBegin((loopBegin_o + (-2))) = sc.leftTmpSamples16(1)
      loopBegin((loopBegin_o + (-3))) = sc.leftTmpSamples16(2)
    End If
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      loopEnd = s.DataR16
      loopEnd_o = (4 + sc.LoopEnd)
      loopEnd(loopEnd_o) = sc.rightTmpSamples16_R(0)
      loopEnd((loopEnd_o + 1)) = sc.rightTmpSamples16_R(1)
      loopEnd((loopEnd_o + 2)) = sc.rightTmpSamples16_R(2)
      loopEnd((loopEnd_o + 3)) = sc.rightTmpSamples16_R(3)
      If sc.HasLooped Then
        Dim loopBegin_2() As Short
        Dim loopBegin_2_o As Int
        loopBegin_2 = s.DataR16
        loopBegin_2_o = (4 + sc.LoopBegin)
        loopBegin_2((loopBegin_2_o + (-1))) = sc.leftTmpSamples16_R(0)
        loopBegin_2((loopBegin_2_o + (-2))) = sc.leftTmpSamples16_R(1)
        loopBegin_2((loopBegin_2_o + (-3))) = sc.leftTmpSamples16_R(2)
      End If
    End If
  Else
    Dim loopEnd_2() As Byte
    Dim loopEnd_2_o As Int
    loopEnd_2 = s.Data8
    loopEnd_2_o = (8 + sc.LoopEnd)
    loopEnd_2(loopEnd_2_o) = sc.rightTmpSamples8(0)
    loopEnd_2((loopEnd_2_o + 1)) = sc.rightTmpSamples8(1)
    loopEnd_2((loopEnd_2_o + 2)) = sc.rightTmpSamples8(2)
    loopEnd_2((loopEnd_2_o + 3)) = sc.rightTmpSamples8(3)
    If sc.HasLooped Then
      Dim loopBegin_3() As Byte
      Dim loopBegin_3_o As Int
      loopBegin_3 = s.Data8
      loopBegin_3_o = (8 + sc.LoopBegin)
      loopBegin_3((loopBegin_3_o + (-1))) = sc.leftTmpSamples8(0)
      loopBegin_3((loopBegin_3_o + (-2))) = sc.leftTmpSamples8(1)
      loopBegin_3((loopBegin_3_o + (-3))) = sc.leftTmpSamples8(2)
    End If
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      loopEnd_2 = s.DataR8
      loopEnd_2_o = (8 + sc.LoopEnd)
      loopEnd_2(loopEnd_2_o) = sc.rightTmpSamples8_R(0)
      loopEnd_2((loopEnd_2_o + 1)) = sc.rightTmpSamples8_R(1)
      loopEnd_2((loopEnd_2_o + 2)) = sc.rightTmpSamples8_R(2)
      loopEnd_2((loopEnd_2_o + 3)) = sc.rightTmpSamples8_R(3)
      If sc.HasLooped Then
        Dim loopBegin_4() As Byte
        Dim loopBegin_4_o As Int
        loopBegin_4 = s.DataR8
        loopBegin_4_o = (8 + sc.LoopBegin)
        loopBegin_4((loopBegin_4_o + (-1))) = sc.leftTmpSamples8_R(0)
        loopBegin_4((loopBegin_4_o + (-2))) = sc.leftTmpSamples8_R(1)
        loopBegin_4((loopBegin_4_o + (-3))) = sc.leftTmpSamples8_R(2)
      End If
    End If
  End If
End Sub

Private Sub fixSamplesFwdLoop(s As it2play_sample_t, sc As it2play_slaveChn_t)
  Dim LoopLength As Int = (sc.LoopEnd - sc.LoopBegin)
  If (LoopLength <= 4) Then
    Return
  End If
  If sc.SmpIs16Bit Then
    Dim ptr() As Short
    Dim ptr_o As Int
    ptr = s.Data16
    ptr_o = 4
    Dim loopBegin() As Short
    Dim loopBegin_o As Int
    loopBegin = s.Data16
    loopBegin_o = (4 + sc.LoopBegin)
    Dim loopEnd() As Short
    Dim loopEnd_o As Int
    loopEnd = s.Data16
    loopEnd_o = (4 + sc.LoopEnd)
    If sc.HasLooped Then
      sc.leftTmpSamples16(0) = loopBegin((loopBegin_o + (-1)))
      sc.leftTmpSamples16(1) = loopBegin((loopBegin_o + (-2)))
      sc.leftTmpSamples16(2) = loopBegin((loopBegin_o + (-3)))
      loopBegin((loopBegin_o + (-1))) = loopEnd((loopEnd_o + (-1)))
      loopBegin((loopBegin_o + (-2))) = loopEnd((loopEnd_o + (-2)))
      loopBegin((loopBegin_o + (-3))) = loopEnd((loopEnd_o + (-3)))
    Else
      ptr((ptr_o + (-1))) = ptr(ptr_o)
      ptr((ptr_o + (-2))) = ptr(ptr_o)
      ptr((ptr_o + (-3))) = ptr(ptr_o)
    End If
    sc.rightTmpSamples16(0) = loopEnd(loopEnd_o)
    sc.rightTmpSamples16(1) = loopEnd((loopEnd_o + 1))
    sc.rightTmpSamples16(2) = loopEnd((loopEnd_o + 2))
    sc.rightTmpSamples16(3) = loopEnd((loopEnd_o + 3))
    loopEnd(loopEnd_o) = loopBegin(loopBegin_o)
    loopEnd((loopEnd_o + 1)) = loopBegin((loopBegin_o + 1))
    loopEnd((loopEnd_o + 2)) = loopBegin((loopBegin_o + 2))
    loopEnd((loopEnd_o + 3)) = loopBegin((loopBegin_o + 3))
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      ptr = s.DataR16
      ptr_o = 4
      loopBegin = s.DataR16
      loopBegin_o = (4 + sc.LoopBegin)
      loopEnd = s.DataR16
      loopEnd_o = (4 + sc.LoopEnd)
      If sc.HasLooped Then
        sc.leftTmpSamples16_R(0) = loopBegin((loopBegin_o + (-1)))
        sc.leftTmpSamples16_R(1) = loopBegin((loopBegin_o + (-2)))
        sc.leftTmpSamples16_R(2) = loopBegin((loopBegin_o + (-3)))
        loopBegin((loopBegin_o + (-1))) = loopEnd((loopEnd_o + (-1)))
        loopBegin((loopBegin_o + (-2))) = loopEnd((loopEnd_o + (-2)))
        loopBegin((loopBegin_o + (-3))) = loopEnd((loopEnd_o + (-3)))
      Else
        ptr((ptr_o + (-1))) = ptr(ptr_o)
        ptr((ptr_o + (-2))) = ptr(ptr_o)
        ptr((ptr_o + (-3))) = ptr(ptr_o)
      End If
      sc.rightTmpSamples16_R(0) = loopEnd(loopEnd_o)
      sc.rightTmpSamples16_R(1) = loopEnd((loopEnd_o + 1))
      sc.rightTmpSamples16_R(2) = loopEnd((loopEnd_o + 2))
      sc.rightTmpSamples16_R(3) = loopEnd((loopEnd_o + 3))
      loopEnd(loopEnd_o) = loopBegin(loopBegin_o)
      loopEnd((loopEnd_o + 1)) = loopBegin((loopBegin_o + 1))
      loopEnd((loopEnd_o + 2)) = loopBegin((loopBegin_o + 2))
      loopEnd((loopEnd_o + 3)) = loopBegin((loopBegin_o + 3))
    End If
  Else
    Dim ptr_2() As Byte
    Dim ptr_2_o As Int
    ptr_2 = s.Data8
    ptr_2_o = 8
    Dim loopBegin_2() As Byte
    Dim loopBegin_2_o As Int
    loopBegin_2 = s.Data8
    loopBegin_2_o = (8 + sc.LoopBegin)
    Dim loopEnd_2() As Byte
    Dim loopEnd_2_o As Int
    loopEnd_2 = s.Data8
    loopEnd_2_o = (8 + sc.LoopEnd)
    If sc.HasLooped Then
      sc.leftTmpSamples8(0) = loopBegin_2((loopBegin_2_o + (-1)))
      sc.leftTmpSamples8(1) = loopBegin_2((loopBegin_2_o + (-2)))
      sc.leftTmpSamples8(2) = loopBegin_2((loopBegin_2_o + (-3)))
      loopBegin_2((loopBegin_2_o + (-1))) = loopEnd_2((loopEnd_2_o + (-1)))
      loopBegin_2((loopBegin_2_o + (-2))) = loopEnd_2((loopEnd_2_o + (-2)))
      loopBegin_2((loopBegin_2_o + (-3))) = loopEnd_2((loopEnd_2_o + (-3)))
    Else
      ptr_2((ptr_2_o + (-1))) = ptr_2(ptr_2_o)
      ptr_2((ptr_2_o + (-2))) = ptr_2(ptr_2_o)
      ptr_2((ptr_2_o + (-3))) = ptr_2(ptr_2_o)
    End If
    sc.rightTmpSamples8(0) = loopEnd_2(loopEnd_2_o)
    sc.rightTmpSamples8(1) = loopEnd_2((loopEnd_2_o + 1))
    sc.rightTmpSamples8(2) = loopEnd_2((loopEnd_2_o + 2))
    sc.rightTmpSamples8(3) = loopEnd_2((loopEnd_2_o + 3))
    loopEnd_2(loopEnd_2_o) = loopBegin_2(loopBegin_2_o)
    loopEnd_2((loopEnd_2_o + 1)) = loopBegin_2((loopBegin_2_o + 1))
    loopEnd_2((loopEnd_2_o + 2)) = loopBegin_2((loopBegin_2_o + 2))
    loopEnd_2((loopEnd_2_o + 3)) = loopBegin_2((loopBegin_2_o + 3))
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      ptr_2 = s.DataR8
      ptr_2_o = 8
      loopBegin_2 = s.DataR8
      loopBegin_2_o = (8 + sc.LoopBegin)
      loopEnd_2 = s.DataR8
      loopEnd_2_o = (8 + sc.LoopEnd)
      If sc.HasLooped Then
        sc.leftTmpSamples8_R(0) = loopBegin_2((loopBegin_2_o + (-1)))
        sc.leftTmpSamples8_R(1) = loopBegin_2((loopBegin_2_o + (-2)))
        sc.leftTmpSamples8_R(2) = loopBegin_2((loopBegin_2_o + (-3)))
        loopBegin_2((loopBegin_2_o + (-1))) = loopEnd_2((loopEnd_2_o + (-1)))
        loopBegin_2((loopBegin_2_o + (-2))) = loopEnd_2((loopEnd_2_o + (-2)))
        loopBegin_2((loopBegin_2_o + (-3))) = loopEnd_2((loopEnd_2_o + (-3)))
      Else
        ptr_2((ptr_2_o + (-1))) = ptr_2(ptr_2_o)
        ptr_2((ptr_2_o + (-2))) = ptr_2(ptr_2_o)
        ptr_2((ptr_2_o + (-3))) = ptr_2(ptr_2_o)
      End If
      sc.rightTmpSamples8_R(0) = loopEnd_2(loopEnd_2_o)
      sc.rightTmpSamples8_R(1) = loopEnd_2((loopEnd_2_o + 1))
      sc.rightTmpSamples8_R(2) = loopEnd_2((loopEnd_2_o + 2))
      sc.rightTmpSamples8_R(3) = loopEnd_2((loopEnd_2_o + 3))
      loopEnd_2(loopEnd_2_o) = loopBegin_2(loopBegin_2_o)
      loopEnd_2((loopEnd_2_o + 1)) = loopBegin_2((loopBegin_2_o + 1))
      loopEnd_2((loopEnd_2_o + 2)) = loopBegin_2((loopBegin_2_o + 2))
      loopEnd_2((loopEnd_2_o + 3)) = loopBegin_2((loopBegin_2_o + 3))
    End If
  End If
End Sub

Private Sub unfixSamplesFwdLoop(s As it2play_sample_t, sc As it2play_slaveChn_t)
  Dim LoopLength As Int = (sc.LoopEnd - sc.LoopBegin)
  If (LoopLength <= 4) Then
    Return
  End If
  If sc.SmpIs16Bit Then
    Dim loopEnd() As Short
    Dim loopEnd_o As Int
    loopEnd = s.Data16
    loopEnd_o = (4 + sc.LoopEnd)
    loopEnd(loopEnd_o) = sc.rightTmpSamples16(0)
    loopEnd((loopEnd_o + 1)) = sc.rightTmpSamples16(1)
    loopEnd((loopEnd_o + 2)) = sc.rightTmpSamples16(2)
    loopEnd((loopEnd_o + 3)) = sc.rightTmpSamples16(3)
    If sc.HasLooped Then
      Dim loopBegin() As Short
      Dim loopBegin_o As Int
      loopBegin = s.Data16
      loopBegin_o = (4 + sc.LoopBegin)
      loopBegin((loopBegin_o + (-1))) = sc.leftTmpSamples16(0)
      loopBegin((loopBegin_o + (-2))) = sc.leftTmpSamples16(1)
      loopBegin((loopBegin_o + (-3))) = sc.leftTmpSamples16(2)
    End If
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      loopEnd = s.DataR16
      loopEnd_o = (4 + sc.LoopEnd)
      loopEnd(loopEnd_o) = sc.rightTmpSamples16_R(0)
      loopEnd((loopEnd_o + 1)) = sc.rightTmpSamples16_R(1)
      loopEnd((loopEnd_o + 2)) = sc.rightTmpSamples16_R(2)
      loopEnd((loopEnd_o + 3)) = sc.rightTmpSamples16_R(3)
      If sc.HasLooped Then
        Dim loopBegin_2() As Short
        Dim loopBegin_2_o As Int
        loopBegin_2 = s.DataR16
        loopBegin_2_o = (4 + sc.LoopBegin)
        loopBegin_2((loopBegin_2_o + (-1))) = sc.leftTmpSamples16_R(0)
        loopBegin_2((loopBegin_2_o + (-2))) = sc.leftTmpSamples16_R(1)
        loopBegin_2((loopBegin_2_o + (-3))) = sc.leftTmpSamples16_R(2)
      End If
    End If
  Else
    Dim loopEnd_2() As Byte
    Dim loopEnd_2_o As Int
    loopEnd_2 = s.Data8
    loopEnd_2_o = (8 + sc.LoopEnd)
    loopEnd_2(loopEnd_2_o) = sc.rightTmpSamples8(0)
    loopEnd_2((loopEnd_2_o + 1)) = sc.rightTmpSamples8(1)
    loopEnd_2((loopEnd_2_o + 2)) = sc.rightTmpSamples8(2)
    loopEnd_2((loopEnd_2_o + 3)) = sc.rightTmpSamples8(3)
    If sc.HasLooped Then
      Dim loopBegin_3() As Byte
      Dim loopBegin_3_o As Int
      loopBegin_3 = s.Data8
      loopBegin_3_o = (8 + sc.LoopBegin)
      loopBegin_3((loopBegin_3_o + (-1))) = sc.leftTmpSamples8(0)
      loopBegin_3((loopBegin_3_o + (-2))) = sc.leftTmpSamples8(1)
      loopBegin_3((loopBegin_3_o + (-3))) = sc.leftTmpSamples8(2)
    End If
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      loopEnd_2 = s.DataR8
      loopEnd_2_o = (8 + sc.LoopEnd)
      loopEnd_2(loopEnd_2_o) = sc.rightTmpSamples8_R(0)
      loopEnd_2((loopEnd_2_o + 1)) = sc.rightTmpSamples8_R(1)
      loopEnd_2((loopEnd_2_o + 2)) = sc.rightTmpSamples8_R(2)
      loopEnd_2((loopEnd_2_o + 3)) = sc.rightTmpSamples8_R(3)
      If sc.HasLooped Then
        Dim loopBegin_4() As Byte
        Dim loopBegin_4_o As Int
        loopBegin_4 = s.DataR8
        loopBegin_4_o = (8 + sc.LoopBegin)
        loopBegin_4((loopBegin_4_o + (-1))) = sc.leftTmpSamples8_R(0)
        loopBegin_4((loopBegin_4_o + (-2))) = sc.leftTmpSamples8_R(1)
        loopBegin_4((loopBegin_4_o + (-3))) = sc.leftTmpSamples8_R(2)
      End If
    End If
  End If
End Sub

Private Sub fixSamplesNoLoop(s As it2play_sample_t, sc As it2play_slaveChn_t)
  If sc.SmpIs16Bit Then
    Dim data() As Short
    Dim data_o As Int
    data = s.Data16
    data_o = 4
    Dim end_l() As Short
    Dim end_l_o As Int
    end_l = s.Data16
    end_l_o = (4 + sc.LoopEnd)
    data((data_o + (-1))) = data(data_o)
    data((data_o + (-2))) = data(data_o)
    data((data_o + (-3))) = data(data_o)
    end_l(end_l_o) = end_l((end_l_o + (-1)))
    end_l((end_l_o + 1)) = end_l((end_l_o + (-1)))
    end_l((end_l_o + 2)) = end_l((end_l_o + (-1)))
    end_l((end_l_o + 3)) = end_l((end_l_o + (-1)))
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      data = s.DataR16
      data_o = 4
      end_l = s.DataR16
      end_l_o = (4 + sc.LoopEnd)
      data((data_o + (-1))) = data(data_o)
      data((data_o + (-2))) = data(data_o)
      data((data_o + (-3))) = data(data_o)
      end_l(end_l_o) = end_l((end_l_o + (-1)))
      end_l((end_l_o + 1)) = end_l((end_l_o + (-1)))
      end_l((end_l_o + 2)) = end_l((end_l_o + (-1)))
      end_l((end_l_o + 3)) = end_l((end_l_o + (-1)))
    End If
  Else
    Dim data_2() As Byte
    Dim data_2_o As Int
    data_2 = s.Data8
    data_2_o = 8
    Dim end_l_2() As Byte
    Dim end_l_2_o As Int
    end_l_2 = s.Data8
    end_l_2_o = (8 + sc.LoopEnd)
    data_2((data_2_o + (-1))) = data_2(data_2_o)
    data_2((data_2_o + (-2))) = data_2(data_2_o)
    data_2((data_2_o + (-3))) = data_2(data_2_o)
    end_l_2(end_l_2_o) = end_l_2((end_l_2_o + (-1)))
    end_l_2((end_l_2_o + 1)) = end_l_2((end_l_2_o + (-1)))
    end_l_2((end_l_2_o + 2)) = end_l_2((end_l_2_o + (-1)))
    end_l_2((end_l_2_o + 3)) = end_l_2((end_l_2_o + (-1)))
    If (s.DataR8 <> Null Or s.DataR16 <> Null) Then
      data_2 = s.DataR8
      data_2_o = 8
      end_l_2 = s.DataR8
      end_l_2_o = (8 + sc.LoopEnd)
      data_2((data_2_o + (-1))) = data_2(data_2_o)
      data_2((data_2_o + (-2))) = data_2(data_2_o)
      data_2((data_2_o + (-3))) = data_2(data_2_o)
      end_l_2(end_l_2_o) = end_l_2((end_l_2_o + (-1)))
      end_l_2((end_l_2_o + 1)) = end_l_2((end_l_2_o + (-1)))
      end_l_2((end_l_2_o + 2)) = end_l_2((end_l_2_o + (-1)))
      end_l_2((end_l_2_o + 3)) = end_l_2((end_l_2_o + (-1)))
    End If
  End If
End Sub
  
' ----- HQ: driver, fixsample, zeronull

' +++++ Loader

Private Sub GetModuleType(m As it2play_MEMFILE) As Boolean
  Dim Header(48) As Byte
  Dim OldOffset As Long = mtell(m)
  mseek(m, 0, 2)
  Dim DataLen As Long = mtell(m)
  mseek(m, 0, 0)
  mread(Header, 0, 1, 48, m)
  Dim Format As Boolean = False
  If DataLen >= 4 And BytesToString(Header, 0, 4) = "IMPM" Then Format = True
  mseek(m, OldOffset, 0)
  Return Format
End Sub

Public Sub Music_LoadFromData(Data1() As Byte) As Int
  If Data1.Length < 8 Then Return 0

  ' find out if module is MMCMP compressed (ziRCONia)
  If BytesToString(Data1, 0, 8) = "ziRCONia" Then Return 2

  Dim m As it2play_MEMFILE
  m.Initialize
  m.base_ = Data1
  m.base__o = 0
  m.ptr_ = Data1
  m.ptr__o = 0
  m.cnt_ = Data1.Length
  m.bufsiz_ = Data1.Length
  m.eof_ = False
  
  If FirstTimeLoading Then
    FirstTimeLoading = False
  Else
    Music_FreeSong
  End If

  Dim Result As Int = 3

  If GetModuleType(m) Then
    Music_SetDefaultMIDIDataArea
    Result = LoadIT(m)
  End If
    
  If Result = 0 Then
    HQ_SetMixVolume(Song.Header.MixVolume)
    Music_CalculateFilterTables(Driver.MixFrequency)
    setHQDriverMixGain
    Song.Loaded = True
    Return Result
  Else
    Music_FreeSong
    Song.Loaded = False
  End If
    
  Return Result
End Sub

Private Sub mread(buffer() As Byte, buffer_o As Int, size As Long, count As Long, buf As it2play_MEMFILE) As Long
  If buf = Null Or buf.ptr_ = Null Then Return 0  
  If size = 0 Or buf.eof_ Then Return 0

  Dim wrcnt As Long = size * count
  Dim pcnt As Int = L2I(IIf(buf.cnt_ > Bit.AndLong(wrcnt, 4294967295), Bit.AndLong(wrcnt, 4294967295), buf.cnt_))
  
  Bit.ArrayCopy(buf.ptr_, buf.ptr__o, buffer, buffer_o, pcnt)

  buf.cnt_ = Bit.AndLong(buf.cnt_ - pcnt, 4294967295)
  buf.ptr__o = buf.ptr__o + pcnt
  If buf.cnt_ <= 0 Then
    buf.ptr_ = buf.base_
    buf.ptr__o = buf.base__o + L2I(buf.bufsiz_)
    buf.cnt_ = 0
    buf.eof_ = True
  End If
  Return IDivL(pcnt, size)
End Sub

Private Sub mtell(buf As it2play_MEMFILE) As Long
  Return buf.ptr__o - buf.base__o
End Sub

Private Sub meof(buf As it2play_MEMFILE) As Int
  If buf = Null Then Return B2I(True)
  Return B2I(buf.eof_)
End Sub

Private Sub mseek(buf As it2play_MEMFILE, offset As Long, whence As Int)
  If buf = Null Then Return
  If buf.base_ <> Null Then
    Select whence
      Case 0
        buf.ptr_ = buf.base_
        buf.ptr__o = buf.base__o + L2I(offset)
      Case 1
        buf.ptr__o = buf.ptr__o + L2I(offset)
      Case 2
        buf.ptr_ = buf.base_
        buf.ptr__o = buf.base__o + L2I(buf.bufsiz_) + L2I(offset)
      Case Else
    End Select
    buf.eof_ = False
    If buf.ptr__o >= buf.base__o + L2I(buf.bufsiz_) Then
      buf.ptr_ = buf.base_
      buf.ptr__o = buf.base__o + L2I(buf.bufsiz_)
      buf.eof_ = True
    End If
    buf.cnt_ = Bit.AndLong(buf.base__o + L2I(buf.bufsiz_) - buf.ptr__o, 4294967295)
  End If
End Sub

Private Sub ReadBytes(m As it2play_MEMFILE, dst() As Byte, dst_o As Int, num As Long) As Boolean
  If m = Null Or meof(m) <> 0 Then Return False
  If mread(dst, dst_o, 1, Bit.AndLong(num, 4294967295), m) <> num Then Return False
  Return True
End Sub

Private Sub LoadIT(m As it2play_MEMFILE) As Int
  Dim tmpByte(1) As Byte
  Dim tmpShort(1) As Short
  Dim tmpInt(1) As Int  
  Dim tmpLong(1) As Long
  Dim tmpBuffer() As Byte

  mseek(m, 4, 1)
  tmpBuffer = NewByteArr(26)
  If Not(ReadBytes(m, tmpBuffer, 0, 25)) Then Return 1
  Song.Header.SongName = BytesToString(tmpBuffer).trim

  mseek(m, 3, 1)
  
  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.OrdNum = tmpInt(0)
  
  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.InsNum = tmpInt(0)

  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.SmpNum = tmpInt(0)

  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.PatNum = tmpInt(0)

  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.Cwtv = tmpInt(0)

  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.Cmwt = tmpInt(0)

  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.Flags = tmpInt(0)

  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.Special = tmpInt(0)

  If Not(ReadU8(m, tmpShort, 0)) Then Return 1
  Song.Header.GlobalVol = tmpShort(0)

  If Not(ReadU8(m, tmpShort, 0)) Then Return 1
  Song.Header.MixVolume = tmpShort(0)
  
  If Not(ReadU8(m, tmpShort, 0)) Then Return 1
  Song.Header.InitialSpeed = tmpShort(0)

  If Not(ReadU8(m, tmpShort, 0)) Then Return 1
  Song.Header.InitialTempo = tmpShort(0)
  
  If Not(ReadU8(m, tmpShort, 0)) Then Return 1
  Song.Header.PanSep = tmpShort(0)

  mseek(m, 1, 1)
  
  If Not(ReadU16(m, tmpInt, 0)) Then Return 1
  Song.Header.MessageLength = tmpInt(0)
  
  If Not(ReadU32(m, tmpLong, 0)) Then Return 1
  Song.Header.MessageOffset = tmpLong(0)
  
  mseek(m, 4, 1)
  
  If Not(ReadU8Array(m, Song.Header.ChnlPan, 0, 64)) Then Return 1
  If Not(ReadU8Array(m, Song.Header.ChnlVol, 0, 64)) Then Return 1

  If Song.Header.OrdNum > 257 Or Song.Header.InsNum > 100 Or _ 
    Song.Header.SmpNum > 100 Or Song.Header.PatNum > 200 Then Return 3
    
  If Song.Header.MessageLength > 8000 Then Song.Header.MessageLength = 8000
  If Song.Header.InitialTempo < 31 Then  Song.Header.InitialTempo = 31

  Dim PtrListOffset As Int = 192 + Song.Header.OrdNum
  Dim OrdersToLoad As Int = ToS16(Song.Header.OrdNum - 1)
  If OrdersToLoad > 0 Then
    If Not(ReadU8Array(m, Song.Orders, 0, OrdersToLoad)) Then Return 1
    If OrdersToLoad < 256 Then
      For i = OrdersToLoad To 255
        Song.Orders(i) = 255
      Next
    End If
  Else
    For i = 0 To 255
      Song.Orders(i) = 255
    Next
  End If
    
  mseek(m, (192 + Song.Header.OrdNum) + (((Song.Header.InsNum + Song.Header.SmpNum) + Song.Header.PatNum) * 4), 0)
  
  If Bit.And(Song.Header.Special, 2) <> 0 Then
    ReadU16(m, tmpInt, 0)
    mseek(m, (tmpInt(0) * 8), 1)
  End If
   
  RetOfs = 0 
  Dim MIDIDataArea2() As Byte = MIDIDataArea
  Dim MIDIDataArea2_o As Int = RetOfs
  
  If Bit.And(Song.Header.Special, 8) <> 0 Then ReadBytes(m, MIDIDataArea2, MIDIDataArea2_o, 4896)

  If Bit.And(Song.Header.Special, 1) <> 0 And Song.Header.MessageLength > 0 And Song.Header.MessageOffset > 0 Then
    mseek(m, Song.Header.MessageOffset, 0)
    tmpBuffer = NewByteArr(8001)
    mread(tmpBuffer, 0, 1, Song.Header.MessageLength, m)
    Song.Message = BytesToString(tmpBuffer).trim      
  End If

  mseek(m, PtrListOffset, 0)
  Dim InsPtrOffset As Long = mtell(m)
  Dim ins As it2play_instrument_t = Song.Ins(0)
  Dim i_3 As Long = 0
  
  Do While (i_3 < Song.Header.InsNum)
    mseek(m, InsPtrOffset + (i_3 * 4), 0)
    If meof(m) <> 0 Then Return 1
      
    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    Dim InsOffset As Long = tmpLong(0)

    If InsOffset = 0 Then
      i_3 = (i_3 + 1)
      ins = AdvIdx(ins, 1)
      Continue
    End If
      
    mseek(m, InsOffset, 0)
    If meof(m) <> 0 Then Return 1

    If Song.Header.Cmwt >= 512 Then
      mseek(m, 4, 1)
      tmpBuffer = NewByteArr(13)
      If Not(ReadBytes(m, tmpBuffer, 0, 13)) Then Return 1
      ins.DOSFilename = BytesToString(tmpBuffer).trim

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.NNA = tmpShort(0)

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.DCT = tmpShort(0)

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.DCA = tmpShort(0)
      
      If Not(ReadU16(m, tmpInt, 0)) Then Return 1
      ins.FadeOut = tmpInt(0)
      
      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.PitchPanSep = tmpShort(0)
      
      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.PitchPanCenter = tmpShort(0)
      
      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.GlobVol = tmpShort(0)

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.DefPan = tmpShort(0)
      
      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.RandVol = tmpShort(0)
      
      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.RandPan = tmpShort(0)

      mseek(m, 4, 1)
      tmpBuffer = NewByteArr(26)
      If Not(ReadBytes(m, tmpBuffer, 0, 26)) Then Return 1
      ins.InstrumentName = BytesToString(tmpBuffer).trim      

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.FilterCutoff = tmpShort(0)

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.FilterResonance = tmpShort(0)

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.MIDIChn = tmpShort(0)

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.MIDIProg = tmpShort(0)
      
      If Not(ReadU16(m, tmpInt, 0)) Then Return 1
      ins.MIDIBank = tmpInt(0)
      
      If Not(ReadU16Array(m, ins.SmpNoteTable, 0, 120)) Then Return 1

      For j = 0 To 2
        Dim env As it2play_env_t
        If j = 0 Then
          env = ins.VolEnv
        Else If j = 1 Then
          env = ins.PanEnv
        Else
          env = ins.PitchEnv
        End If
          
        If Not(ReadU8(m, tmpShort, 0)) Then Return 1
        env.Flags = tmpShort(0)          

        If Not(ReadU8(m, tmpShort, 0)) Then Return 1
        env.Num = tmpShort(0)          

        If Not(ReadU8(m, tmpShort, 0)) Then Return 1
        env.LoopBegin = tmpShort(0)          

        If Not(ReadU8(m, tmpShort, 0)) Then Return 1
        env.LoopEnd = tmpShort(0)          

        If Not(ReadU8(m, tmpShort, 0)) Then Return 1
        env.SustainLoopBegin = tmpShort(0)          

        If Not(ReadU8(m, tmpShort, 0)) Then Return 1
        env.SustainLoopEnd = tmpShort(0)          
          
        Dim k As Long = 0
        Do While k < 25
          Dim node As it2play_envNode_t = env.NodePoints(L2I(k))
          
          If Not(ReadBytes(m, tmpByte, 0, 1)) Then Return 1
          node.Magnitude = tmpByte(0)
          
          If Not(ReadU16(m, tmpInt, 0)) Then Return 1
          node.Tick = tmpInt(0)          
          
          k = k + 1
        Loop
        mseek(m, 1, 1)
      Next
    Else
      mseek(m, 4, 1)
      tmpBuffer = NewByteArr(13)
      If Not(ReadBytes(m, tmpBuffer, 0, 13)) Then Return 1
      ins.DOSFilename = BytesToString(tmpBuffer).trim

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.VolEnv.Flags = tmpShort(0)            

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.VolEnv.LoopBegin = tmpShort(0)            

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.VolEnv.LoopEnd = tmpShort(0)            

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.VolEnv.SustainLoopBegin = tmpShort(0)            

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.VolEnv.SustainLoopEnd = tmpShort(0)            

      mseek(m, 2, 1)
      
      If Not(ReadU16(m, tmpInt, 0)) Then Return 1
      ins.FadeOut = Bit.And((tmpInt(0) * 2), 65535)
      
      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.NNA = tmpShort(0)            

      If Not(ReadU8(m, tmpShort, 0)) Then Return 1
      ins.DCT = tmpShort(0)            
      
      mseek(m, 4, 1)
      
      tmpBuffer = NewByteArr(26)
      If Not(ReadBytes(m, tmpBuffer, 0, 26)) Then Return 1
      ins.InstrumentName = BytesToString(tmpBuffer).trim      

      mseek(m, 6, 1)

      If Not(ReadU16Array(m, ins.SmpNoteTable, 0, 120)) Then Return 1

      ins.PitchPanCenter = 60
      ins.GlobVol = 128
      ins.DefPan = 160
      
      mseek(m, 200, 1)
      
      Dim j_2 As Int
      j_2 = 0
      Do While (j_2 < 25)
        Dim node_2 As it2play_envNode_t = ins.VolEnv.NodePoints(j_2)
        
        If Not(ReadU16(m, tmpInt, 0)) Then Return 1
        Dim word As Int = tmpInt(0)        

        If word = 65535 Then  Exit
        node_2.Tick = Bit.And(word, 255)
        node_2.Magnitude = Bit.ShiftRight(word, 8)
        j_2 = ToS16((j_2 + 1))
      Loop
      ins.VolEnv.Num = j_2
      ins.PanEnv.Num = 2
      ins.PanEnv.NodePoints(1).Tick = 99
      ins.PitchEnv.Num = 2
      ins.PitchEnv.NodePoints(1).Tick = 99
    End If
    i_3 = i_3 + 1
    ins = AdvIdx(ins, 1)
  Loop
  
  mseek(m, PtrListOffset + (Song.Header.InsNum * 4), 0)
  
  Dim SmpPtrOffset As Long = mtell(m)
  Dim s As it2play_sample_t = Song.Smp(0)
  Dim i_4 As Long = 0

  Do While (i_4 < Song.Header.SmpNum)
    mseek(m, SmpPtrOffset + (i_4 * 4), 0)
    If meof(m) <> 0 Then Return 1

    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    Dim SmpOffset As Long = tmpLong(0)  

    If SmpOffset = 0 Then
      i_4 = (i_4 + 1)
      s = AdvIdx(s, 1)
      Continue
    End If
      
    mseek(m, SmpOffset, 0)
    If meof(m) <> 0 Then Return 1

    mseek(m, 4, 1)
    tmpBuffer = NewByteArr(13)
    If Not(ReadBytes(m, tmpBuffer, 0, 13)) Then Return 1
    s.DOSFilename = BytesToString(tmpBuffer).trim

    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.GlobVol = tmpShort(0)

    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.Flags = tmpShort(0)

    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.Vol = tmpShort(0)

    tmpBuffer = NewByteArr(26)
    If Not(ReadBytes(m, tmpBuffer, 0, 26)) Then Return 1
    s.SampleName = BytesToString(tmpBuffer).trim

    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.Cvt = tmpShort(0)

    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.DefPan = tmpShort(0)
    
    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    s.Length = tmpLong(0)

    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    s.LoopBegin = tmpLong(0)

    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    s.LoopEnd = tmpLong(0)
    
    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    s.C5Speed = tmpLong(0)

    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    s.SustainLoopBegin = tmpLong(0)

    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    s.SustainLoopEnd = tmpLong(0)

    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    s.OffsetInFile = tmpLong(0)
    
    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.AutoVibratoSpeed = tmpShort(0)    

    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.AutoVibratoDepth = tmpShort(0)    

    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.AutoVibratoRate = tmpShort(0)    

    If Not(ReadU8(m, tmpShort, 0)) Then Return 1
    s.AutoVibratoWaveform = tmpShort(0)    

    i_4 = i_4 + 1
    s = AdvIdx(s, 1)
  Loop
  
  s = Song.Smp(0)
  Dim i_5 As Long = 0
  Do While i_5 < Song.Header.SmpNum
    If s.OffsetInFile = 0 Or Not(Bit.And(s.Flags, 1) <> 0) Then
      i_5 = i_5 + 1
      s = AdvIdx(s, 1)
      Continue
    End If
      
    mseek(m, s.OffsetInFile, 0)
    If meof(m) <> 0 Then Return 1

    Dim Stereo As Boolean = Bit.And(s.Flags, 4) <> 0
    Dim Compressed As Boolean = Bit.And(s.Flags, 8) <> 0
    Dim Sample16Bit As Boolean = Bit.And(s.Flags, 2) <> 0
    Dim SignedSamples As Boolean = Bit.And(s.Cvt, 1) <> 0
    Dim DeltaEncoded As Boolean = Bit.And(s.Cvt, 4) <> 0
    
    If DeltaEncoded And Not(Compressed) Then
      i_5 = (i_5 + 1)
      s = AdvIdx(s, 1)
      Continue
    End If
      
    If s.Length = 0 Or Not(Bit.And(s.Flags, 1) <> 0) Then
      i_5 = i_5 + 1
      s = AdvIdx(s, 1)
      Continue
    End If
      
    If Bit.And(s.Cvt, 250) <> 0 Then
      i_5 = i_5 + 1
      s = AdvIdx(s, 1)
      Continue
    End If
      
    Music_AllocateSample(i_5, Bit.ShiftLeftLong(s.Length, B2I(Sample16Bit)))
    If Stereo Then Music_AllocateRightSample(i_5, Bit.ShiftLeftLong(s.Length, B2I(Sample16Bit)))
      
    If Compressed Then
      If Sample16Bit Then
        If Not(LoadCompressed16BitSample(m, s, Stereo, DeltaEncoded)) Then Return 1
      Else
        If Not(LoadCompressed8BitSample(m, s, Stereo, DeltaEncoded)) Then Return 1
      End If
    Else
      mread_smp(s, False, L2I(s.Length), m)
      If Stereo Then
        mread_smp(s, True, L2I(s.Length), m)
      End If
    End If

    If Not(SignedSamples) Then
      If Sample16Bit Then
        Dim Ptr16() As Short
        Dim Ptr16_o As Int
        Ptr16 = s.Data16
        Ptr16_o = 4
        For j_3 = 0 To Bit.ShiftRight(L2I(s.Length), 1) - 1
          Ptr16((Ptr16_o + L2I(j_3))) = Bit.Xor(Ptr16((Ptr16_o + L2I(j_3))), 32768)
        Next
      Else
        Dim Ptr8() As Byte
        Dim Ptr8_o As Int
        Ptr8 = s.Data8
        Ptr8_o = 8
        For j_4 = 0 To L2I(s.Length) - 1
          Ptr8((Ptr8_o + L2I(j_4))) = Bit.Xor(Ptr8((Ptr8_o + L2I(j_4))), 128)
        Next
      End If
    End If
      
    If Sample16Bit Then s.Length = Bit.ShiftRightLong(s.Length, 1)
    i_5 = i_5 + 1
    s = AdvIdx(s, 1)
  Loop
  
  mseek(m, ((PtrListOffset + (Song.Header.InsNum * 4)) + (Song.Header.SmpNum * 4)), 0)

  Dim PatPtrOffset As Long = mtell(m)
  Dim p As it2play_pattern_t = Song.Patt(0)
  Dim i_6 As Long = 0
  Do While i_6 < Song.Header.PatNum
    mseek(m, (PatPtrOffset + (i_6 * 4)), 0)
    If meof(m) <> 0 Then Return 1
      
    If Not(ReadU32(m, tmpLong, 0)) Then Return 1
    Dim PatOffset As Long = tmpLong(0)      

    If PatOffset = 0 Then
      i_6 = i_6 + 1
      p = AdvIdx(p, 1)
      Continue
    End If
      
    mseek(m, PatOffset, 0)
    If meof(m) <> 0 Then Return 1
      
    If Not(ReadU16(m, tmpInt, 0)) Then Return 1
    Dim PatLength As Int = tmpInt(0)
    
    If Not(ReadU16(m, tmpInt, 0)) Then Return 1
    p.Rows = tmpInt(0)      

    If PatLength = 0 Or p.Rows = 0 Then
      i_6 = i_6 + 1
      p = AdvIdx(p, 1)
      Continue
    End If
      
    mseek(m, 4, 1)
    
    Music_AllocatePattern(i_6, PatLength)
    If Not(ReadBytes(m, p.PackedData, p.PackedData_o, PatLength)) Then Return 1

    i_6 = i_6 + 1
    p = AdvIdx(p, 1)
  Loop
  Return 0
End Sub

Private Sub ReadU8(m As it2play_MEMFILE, dst() As Short, dst_o As Int) As Boolean
  Dim b(1) As Byte
  If Not(ReadBytes(m, b, 0, 1)) Then Return False
  dst(dst_o) = Bit.And(b(0), 255)
  Return True
End Sub

Private Sub ReadU16(m As it2play_MEMFILE, dst() As Int, dst_o As Int) As Boolean
  Dim b(2) As Byte
  If Not(ReadBytes(m, b, 0, 2)) Then Return False
  dst(dst_o) = Load16LE(b, 0)
  Return True
End Sub

Private Sub ReadU32(m As it2play_MEMFILE, dst() As Long, dst_o As Int) As Boolean
  Dim b(4) As Byte
  If Not(ReadBytes(m, b, 0, 4)) Then Return False
  dst(dst_o) = Load32LE(b, 0)
  Return True
End Sub

Private Sub ReadU8Array(m As it2play_MEMFILE, dst() As Short, dst_o As Int, num As Long) As Boolean
  Dim i As Long = 0
  Do While i < num
    If Not(ReadU8(m, dst, dst_o + L2I(i))) Then Return False
    i = i + 1
  Loop
  Return True
End Sub

Private Sub ReadU16Array(m As it2play_MEMFILE, dst() As Int, dst_o As Int, num As Long) As Boolean
  Dim i As Long = 0
  Do While (i < num)
    If Not(ReadU16(m, dst, dst_o + L2I(i))) Then Return False
    i = i + 1
  Loop
  Return True
End Sub

Private Sub mReadU16(m As it2play_MEMFILE) As Int
  Dim b(2) As Byte
  mread(b, 0, 1, 2, m)
  Return Load16LE(b, 0)
End Sub

Private Sub Decompress16BitData(Dst() As Short, Dst_o As Int, Src() As Byte, Src_o As Int, BlockLength As Long)
  Dim Byte8 As Int
  Dim BitDepth As Int
  Dim BitDepthInv As Int
  Dim BitsRead As Int
  Dim Bytes16 As Int
  Dim LastVal As Int
  Dim Bytes32 As Long
  LastVal = 0
  BitDepth = 17
  BitsRead = 0
  BitDepthInv = BitsRead
  BlockLength = Bit.ShiftRightLong(BlockLength, 1)
  Do While BlockLength <> 0
    Bytes32 = Bit.ShiftRightLong(Load32LE(Src, Src_o), BitsRead)
    BitsRead = Bit.And((BitsRead + BitDepth), 255)
    Src_o = Src_o + Bit.ShiftRight(BitsRead, 3)
    BitsRead = ToS16(Bit.And(BitsRead, 7))
    If BitDepth <= 6 Then
      Bytes32 = Bit.AndLong((Bit.ShiftLeftLong(Bytes32, (Bit.And(BitDepthInv, 31)))), 4294967295)
      Bytes16 = L2I((Bit.AndLong(Bytes32, 65535)))
      If Bytes16 <> 32768 Then
        LastVal = Bit.And((LastVal + (Bit.ShiftRight(SignExt16(Bytes16), (Bit.And(BitDepthInv, 31))))), 65535)
        Dst(Dst_o) = ToS16(SignExt16(LastVal))
        Dst_o = Dst_o + 1
        BlockLength = Bit.AndLong((BlockLength - 1), 4294967295)
      Else
        Byte8 = L2I(Bit.AndLong(((Bit.AndLong((Bit.ShiftRightLong(Bytes32, 16)), 15)) + 1), 255))
        If (Byte8 >= BitDepth) Then
          Byte8 = Bit.And((Byte8 + 1), 255)
        End If
        BitDepth = Byte8
        BitDepthInv = 16
        If (BitDepthInv < BitDepth) Then
          BitDepthInv = Bit.And((BitDepthInv + 1), 255)
        End If
        BitDepthInv = Bit.And((BitDepthInv - BitDepth), 255)
        BitsRead = Bit.And((BitsRead + 4), 255)
      End If
      Continue
    End If
    Bytes16 = L2I((Bit.AndLong(Bytes32, 65535)))
    If (BitDepth <= 16) Then
      Dim DX As Int = Bit.ShiftRight(65535, (Bit.And(BitDepthInv, 31)))
      Bytes16 = Bit.And(Bytes16, DX)
      DX = Bit.And(((Bit.ShiftRight(DX, 1)) - 8), 65535)
      If ((Bytes16 > (DX + 16)) Or (Bytes16 <= DX)) Then
        Bytes16 = Bit.And((Bit.ShiftLeft(Bytes16, (Bit.And(BitDepthInv, 31)))), 65535)
        Bytes16 = Bit.And((Bit.ShiftRight(SignExt16(Bytes16), (Bit.And(BitDepthInv, 31)))), 65535)
        LastVal = Bit.And((LastVal + Bytes16), 65535)
        Dst(Dst_o) = ToS16(SignExt16(LastVal))
        Dst_o = Dst_o + 1
        BlockLength = Bit.AndLong((BlockLength - 1), 4294967295)
        Continue
      End If
      Byte8 = (Bit.And((Bytes16 - DX), 255))
      If (Byte8 >= BitDepth) Then
        Byte8 = Bit.And((Byte8 + 1), 255)
      End If
      BitDepth = Byte8
      BitDepthInv = 16
      If (BitDepthInv < BitDepth) Then
        BitDepthInv = Bit.And((BitDepthInv + 1), 255)
      End If
      BitDepthInv = Bit.And((BitDepthInv - BitDepth), 255)
      Continue
    End If
    If (Bit.AndLong(Bytes32, 65536) <> 0) Then
      BitDepth = (Bit.And((Bytes16 + 1), 255))
      BitDepthInv = Bit.And((16 - BitDepth), 255)
    Else
      LastVal = Bit.And((LastVal + Bytes16), 65535)
      Dst(Dst_o) = ToS16(SignExt16(LastVal))
      Dst_o = Dst_o + 1
      BlockLength = Bit.AndLong((BlockLength - 1), 4294967295)
    End If
  Loop
End Sub

Private Sub Decompress8BitData(Dst() As Byte, Dst_o As Int, Src() As Byte, Src_o As Int, BlockLength As Long)
  Dim LastVal As Int
  Dim Byte8 As Int
  Dim BitDepth As Int
  Dim BitDepthInv As Int
  Dim BitsRead As Int
  Dim Bytes16 As Int
  LastVal = 0
  BitDepth = 9
  BitsRead = 0
  BitDepthInv = BitsRead
  Do While BlockLength <> 0
    Bytes16 = Bit.ShiftRight(Load16LE(Src, Src_o), BitsRead)
    BitsRead = Bit.And((BitsRead + BitDepth), 255)
    Src_o = Src_o + (Bit.ShiftRight(BitsRead, 3))
    BitsRead = ToS16(Bit.And(BitsRead, 7))
    Byte8 = Bit.And(Bytes16, 255)
    If BitDepth <= 6 Then
      Bytes16 = Bit.And((Bit.ShiftLeft(Bytes16, (Bit.And(BitDepthInv, 31)))), 65535)
      Byte8 = Bit.And(Bytes16, 255)
      If (Byte8 <> 128) Then
        LastVal = Bit.And((LastVal + (Bit.ShiftRight(SignExt8(Byte8), (Bit.And(BitDepthInv, 31))))), 255)
        Dst(Dst_o) = ToS8(SignExt8(LastVal))
        Dst_o = Dst_o + 1
        BlockLength = Bit.AndLong((BlockLength - 1), 4294967295)
        Continue
      End If
      Byte8 = Bit.And((Bit.ShiftRight(Bytes16, 8)), 7)
      BitsRead = Bit.And((BitsRead + 3), 255)
      Src_o = Src_o + (Bit.ShiftRight(BitsRead, 3))
      BitsRead = ToS16(Bit.And(BitsRead, 7))
    Else
      If (BitDepth = 8) Then
        If ((Byte8 < 124) Or (Byte8 > 131)) Then
          LastVal = Bit.And((LastVal + Byte8), 255)
          Dst(Dst_o) = ToS8(SignExt8(LastVal))
          Dst_o = Dst_o + 1
          BlockLength = Bit.AndLong((BlockLength - 1), 4294967295)
          Continue
        End If
        Byte8 = Bit.And((Byte8 - 124), 255)
      Else If (BitDepth < 8) Then
        Byte8 = Bit.And((Bit.ShiftLeft(Byte8, 1)), 255)
        If ((Byte8 < 120) Or (Byte8 > 134)) Then
          LastVal = Bit.And((LastVal + (Bit.ShiftRight(SignExt8(Byte8), (Bit.And(BitDepthInv, 31))))), 255)
          Dst(Dst_o) = ToS8(SignExt8(LastVal))
          Dst_o = Dst_o + 1
          BlockLength = Bit.AndLong((BlockLength - 1), 4294967295)
          Continue
        End If
        Byte8 = Bit.And(((Bit.ShiftRight(Byte8, 1)) - 60), 255)
      Else
        Bytes16 = Bit.And(Bytes16, 511)
        If ((Bit.And(Bytes16, 256)) = 0) Then
          LastVal = Bit.And((LastVal + Byte8), 255)
          Dst(Dst_o) = ToS8(SignExt8(LastVal))
          Dst_o = Dst_o + 1
          BlockLength = Bit.AndLong((BlockLength - 1), 4294967295)
          Continue
        End If
      End If
    End If
    Byte8 = Bit.And((Byte8 + 1), 255)
    If (Byte8 >= BitDepth) Then
      Byte8 = Bit.And((Byte8 + 1), 255)
    End If
    BitDepth = Byte8
    BitDepthInv = 8
    If (BitDepthInv < BitDepth) Then
      BitDepthInv = Bit.And((BitDepthInv + 1), 255)
    End If
    BitDepthInv = Bit.And((BitDepthInv - BitDepth), 255)
  Loop
End Sub

Private Sub LoadCompressed8BitSample(m As it2play_MEMFILE, s As it2play_sample_t, Stereo As Boolean, DeltaEncoded As Boolean) As Boolean
  Dim DstPtr() As Byte
  Dim DstPtr_o As Int
  DstPtr = s.Data8
  DstPtr_o = 8
  Dim DecompBuffer() As Byte
  Dim DecompBuffer_o As Int
  DecompBuffer = NewByteArr(65536)
  DecompBuffer_o = 0
  If (DecompBuffer = Null) Then
    Return False
  End If
  Dim i As Long = s.Length
  Do While (i > 0)
    Dim BytesToUnpack As Long = 32768
    If (BytesToUnpack > i) Then
      BytesToUnpack = i
    End If
    Dim PackedLen As Int = mReadU16(m)
    mread(DecompBuffer, DecompBuffer_o, 1, PackedLen, m)
    Decompress8BitData(DstPtr, DstPtr_o, DecompBuffer, DecompBuffer_o, BytesToUnpack)
    If DeltaEncoded Then
      Dim LastSmp8 As Int = 0
      For j = 0 To L2I(BytesToUnpack) - 1
        LastSmp8 = ToS8((LastSmp8 + DstPtr((DstPtr_o + L2I(j)))))
        DstPtr((DstPtr_o + L2I(j))) = LastSmp8
      Next
    End If
    DstPtr_o = DstPtr_o + L2I(BytesToUnpack)
    i = Bit.AndLong((i - BytesToUnpack), 4294967295)
  Loop
  If Stereo Then
    DstPtr = s.DataR8
    DstPtr_o = 8
    i = s.Length
    Do While (i > 0)
      Dim BytesToUnpack_2 As Long = 32768
      If (BytesToUnpack_2 > i) Then
        BytesToUnpack_2 = i
      End If
      Dim PackedLen_2 As Int = mReadU16(m)
      mread(DecompBuffer, DecompBuffer_o, 1, PackedLen_2, m)
      Decompress8BitData(DstPtr, DstPtr_o, DecompBuffer, DecompBuffer_o, BytesToUnpack_2)
      If DeltaEncoded Then
        Dim LastSmp8_2 As Int = 0
        For j_2 = 0 To L2I(BytesToUnpack_2) - 1
          LastSmp8_2 = ToS8((LastSmp8_2 + DstPtr((DstPtr_o + L2I(j_2)))))
          DstPtr((DstPtr_o + L2I(j_2))) = LastSmp8_2
        Next
      End If
      DstPtr_o = DstPtr_o + L2I(BytesToUnpack_2)
      i = Bit.AndLong((i - BytesToUnpack_2), 4294967295)
    Loop
  End If
  Return True
End Sub

Private Sub Music_AllocateSample(sample As Long, length As Long)
  length = Bit.AndLong(length, 4294967295)
  Dim s As it2play_sample_t = Song.Smp(sample)
  If Bit.And(s.Flags, 2) <> 0 Then
'zeroed: 4 taps before, 4 after
    s.Data16 = NewShortArr(Bit.ShiftRight(L2I(length), 1) + 8) 
    s.Data8 = Null
  Else
    s.Data8 = NewByteArr(L2I(length) + 16)
    s.Data16 = Null
  End If
  s.Length = length
  s.Flags = Bit.Or(s.Flags, 1)
End Sub

Private Sub Music_AllocateRightSample(sample As Long, length As Long)
  length = Bit.AndLong(length, 4294967295)
  Dim s As it2play_sample_t = Song.Smp(sample)
  If Bit.And(s.Flags, 2) <> 0 Then
    s.DataR16 = NewShortArr(Bit.ShiftRight(L2I(length), 1) + 8)
    s.DataR8 = Null
  Else
    s.DataR8 = NewByteArr(L2I(length) + 16)
    s.DataR16 = Null
  End If
End Sub
  
Private Sub Music_AllocatePattern(pattern As Long, length As Long) As Boolean
  Dim p As it2play_pattern_t = Song.Patt(L2I(pattern))
  If p.PackedData <> Null Then Return True
  p.PackedData = NewByteArr(length)
  p.PackedData_o = 0
  Return True
End Sub  

Private Sub mread_smp(s As it2play_sample_t, isR As Boolean, count As Int, m As it2play_MEMFILE)
  If Bit.And(s.Flags, 2) = 0 Then
    If isR Then
      mread(s.DataR8, 8, 1, count, m)
    Else
      mread(s.Data8, 8, 1, count, m)
    End If
  Else
    Dim tmp() As Byte = NewByteArr(count)
    mread(tmp, 0, 1, count, m)
    Dim dst() As Short = s.Data16
    If isR Then dst = s.DataR16
    Dim n As Int = Bit.ShiftRight(count, 1)
    For j = 0 To n - 1
      dst(4 + j) = ToS16(Bit.Or(Bit.And(tmp(2 * j), 255), Bit.ShiftLeft(Bit.And(tmp(2 * j + 1), 255), 8)))
    Next
  End If
End Sub

Private Sub LC16Pass(m As it2play_MEMFILE, dst() As Short, dst_o As Int, length As Long, decomp() As Byte, delta As Boolean)
  Dim i As Long = length
  Dim ofs As Int = dst_o
  Do While i > 0
    Dim bytesToUnpack As Long = 32768
    If bytesToUnpack > i Then bytesToUnpack = i
    Dim packedLen As Int = mReadU16(m)
    mread(decomp, 0, 1, packedLen, m)
    Decompress16BitData(dst, ofs, decomp, 0, bytesToUnpack)
    Dim n As Int = Bit.ShiftRight(L2I(bytesToUnpack), 1)
    If delta Then
      Dim last As Int = 0
      For j = 0 To n - 1
        last = ToS16(last + dst(ofs + j))
        dst(ofs + j) = last
      Next
    End If
    ofs = ofs + n
    i = i - bytesToUnpack
  Loop
End Sub

Private Sub LoadCompressed16BitSample(m As it2play_MEMFILE, s As it2play_sample_t, Stereo As Boolean, DeltaEncoded As Boolean) As Boolean
  Dim decomp() As Byte = NewByteArr(65536)
  LC16Pass(m, s.Data16, 4, s.Length, decomp, DeltaEncoded)
  If Stereo Then LC16Pass(m, s.DataR16, 4, s.Length, decomp, DeltaEncoded)
  Return True
End Sub

' ----- Loader

' +++++ Mixer

Private Sub lockMixer
  mixerLocked = True
End Sub

Private Sub unlockMixer
  mixerLocked = False
End Sub

Private Sub closeMixer
  mixerOpened = 0
  If tmrMix.IsInitialized Then tmrMix.Enabled = False
  If mixLine.IsInitialized Then
    Try
      #If B4J
        mixLine.RunMethod("stop", Null)
        mixLine.RunMethod("flush", Null)
        mixLine.RunMethod("close", Null)
      #Else
        mixLine.RunMethod("pause", Null)
        mixLine.RunMethod("flush", Null)
        mixLine.RunMethod("stop", Null)
        mixLine.RunMethod("release", Null)
      #End If
    Catch
      Log(LastException)
    End Try
  End If
End Sub

Private Sub openMixer(mixingFrequency As Int, mixingBufferSize As Int) As Boolean
  closeMixer
  bufferSize = mixingBufferSize
  Try
    #If B4J
      Dim fmt As JavaObject
      Dim f As Float = mixingFrequency
      fmt.InitializeNewInstance("javax.sound.sampled.AudioFormat", Array As Object(f, 16, 2, True, False))
      Dim asys As JavaObject
      asys.InitializeStatic("javax.sound.sampled.AudioSystem")
      mixLine = asys.RunMethod("getSourceDataLine", Array As Object(fmt))
      mixLine.RunMethod("open", Array As Object(fmt, mixingBufferSize * 16))
      mixLine.RunMethod("start", Null)
    #Else
      Dim STREAM_MUSIC As Int = 3
      Dim CHANNEL_OUT_STEREO As Int = 12
      Dim ENCODING_PCM_16BIT As Int = 2
      Dim MODE_STREAM As Int = 1
  
      Dim at As JavaObject
      at.InitializeStatic("android.media.AudioTrack")
      Dim minBytes As Int = at.RunMethod("getMinBufferSize", _
        Array As Object(mixingFrequency, CHANNEL_OUT_STEREO, ENCODING_PCM_16BIT))
  
      Dim bufBytes As Int = Max(minBytes, mixingBufferSize * 4 * 4)
      trackFrames = bufBytes / 4
  
      mixLine.InitializeNewInstance("android.media.AudioTrack", _
        Array As Object(STREAM_MUSIC, mixingFrequency, CHANNEL_OUT_STEREO, ENCODING_PCM_16BIT, bufBytes, MODE_STREAM))
  
      If mixLine.RunMethod("getState", Null) <> 1 Then Return False
      mixLine.RunMethod("play", Null)
      writtenFrames = 0
    #End If
  Catch
    Log(LastException)
    Return False
  End Try

  mixShorts = NewShortArr(mixingBufferSize * 2)
  #If B4J
    mixBytes = NewByteArr(mixingBufferSize * 4)
  #End If
  mixerOpened = 1
  tmrMix.Initialize("tmrMix", Max(2, mixingBufferSize * 1000 / mixingFrequency / 3))
  tmrMix.Enabled = True
  
  Return True
End Sub

Private Sub tmrMix_Tick
  If mixerOpened = 0 Then Return
  Do While mixerOpened <> 0
    #If B4J
      Dim av As Int = mixLine.RunMethod("available", Null)
      If av < bufferSize * 4 Then Exit
    #Else
      Dim head As Int = mixLine.RunMethod("getPlaybackHeadPosition", Null)
      Dim freeFrames As Int = trackFrames - (writtenFrames - head)
      If freeFrames < bufferSize Then Exit
    #End If

    If mixerLocked Then
      mixShorts = NewShortArr(bufferSize * 2)
    Else
      Music_FillAudioBuffer(mixShorts, 0, bufferSize)
    End If

    #If B4J
      For i = 0 To bufferSize * 2 - 1
        Dim v As Int = mixShorts(i)
        mixBytes(2 * i) = Bit.And(v, 255)
        mixBytes(2 * i + 1) = Bit.ShiftRight(v, 8)
      Next
      mixLine.RunMethod("write", Array As Object(mixBytes, 0, bufferSize * 4))
    #Else
      Dim n As Int = mixLine.RunMethod("write", Array As Object(mixShorts, 0, bufferSize * 2))
      If n <= 0 Then Exit
      writtenFrames = writtenFrames + n / 2
    #End If
  Loop
End Sub

' ----- Mixer
