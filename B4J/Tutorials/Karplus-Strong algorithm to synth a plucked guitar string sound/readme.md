### Karplus-Strong algorithm to synth a plucked guitar string sound by kimstudio
### 11/04/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/124204/)

Not a tutorial exactly but a fast prototyping for basic Karplus-Strong algorithm realized by B4J and would like to share with someone who is interested.  
I want to make my [GuitarRhythm](https://www.b4x.com/android/forum/threads/guitar-rhythm.123303/) app using synth guitar sound as an option along with sampled guitar sound so I found this:  
  
"The Karplus-Strong algorithm was first published in 1983 in a paper titled "Digital Synthesis of Plucked-String and Drum Timbres" by Kevin Karplus and Alex Strong. The great thing about this algorithm is that it yields realistic sounds despite being relatively simple."   
  
This is one of the detailed introduction (<http://crypto.stanford.edu/~blynn/sound/karplusstrong.html>) and there are many implementations on Github using other lanuages:  
  
![](https://www.b4x.com/android/forum/attachments/102451)  
  
The B4J code for the basic algorithm is:  

```B4X
Sub Button1_Click  
    Dim f As Float = TextField1.Text  
    Dim d As Float = Slider1.Value  
    Button1.Text = "Wait …"  
    Karplus(f, d)  
    DrawGraph  
    Sleep(10)  
    PDA.SendDataPlayer(AudioBufferByte)  
    Button1.Text = "Play"  
End Sub  
  
Sub Karplus(freq As Float, decay As Float)  
    Dim N As Int = Round(SampleRate / freq - 0.5)  
    Dim HD As Float = decay / 2.0  
    For i = 0 To N-1  
        AudioBuffer(i) = Rnd(-32768, 32768)  
    Next  
    AudioBuffer(N) = Round(HD * AudioBuffer(0))  
    For i = N+1 To BufferLength-1  
        AudioBuffer(i) = Round(HD * (AudioBuffer(i-N) + AudioBuffer(i-N-1)))  
    Next  
      
    AudioBufferByte = BC.ShortsToBytes(AudioBuffer)  
End Sub
```

  
  
For fast prototyping I used [PlayDataAudio.bas](https://www.b4x.com/android/forum/attachments/playdataaudio-bas.97840/) to play sound and didn't use the threading library, hence playing audio will suspend main UI, but at least sleep(10) will make UI updated before audio playing. It is better to use Threading and JAudiotrack library.  
  
![](https://www.b4x.com/android/forum/attachments/102453)  
  
It is clear that the extended version of this algorithm should be realized to make the pitch correct at higher frequency and add more other synth parameters as next step.  
  
Sourcecode attached.