### Index ScrollTo Heights in BBCodeView - Marked Sections & Words Occurrences by William Lancee
### 05/03/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/147773/)

A recent Forum thread inspired this snippet.  
<https://www.b4x.com/android/forum/threads/scrollto-in-bbcodeview.147720/>  
  
There is a on-the-fly search method created by [USER=8972]@T201016[/USER]  
<https://www.b4x.com/android/forum/threads/solved-bbcodeview-scrolling-the-page-to-the-word-position.143556/>  
  
In my snippet, indexing is done once (in the attached example about 500 msec)  
The example has under 200 lines of code (incl. the sample text).  
  
Method:  
1. Insert invisible markers between sections and measure height to each marker.  
2. Index words by marker height.  
   
Use the code in any way you like.  
  
  
  

```B4X
#Region Shared Files  
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region  
  
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private BBCodeView1 As BBCodeView  
    Private TextEngine1 As BCTextEngine  
    Private markerHeights As B4XOrderedMap  
    Private wordPositions As Map  
    Private minWordLength As Int = 4  
    Private BBCVClr As String  
    Private ScrollToYOffset As Float = 50dip  
    Private actionLabel As Label  
    Private wordHighlighted As Boolean  
End Sub  
  
Public Sub Initialize  
    markerHeights.Initialize  
    markerHeights.Put("", 0)   'create default top position  
    wordPositions.Initialize   'each word will have a list of heights  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_RGB(220, 220, 220)  
     
    Dim BBCVPanel As B4XView = xui.CreatePanel("")  
    Root.AddView(BBCVPanel, 50dip, 50dip, Root.Width - 100dip, Root.Height - 100dip)  
    Dim actionLabel As Label: actionLabel.Initialize("")  
    Dim NotePanel As B4XView = actionLabel  
    NotePanel.TextSize = 22  
    NotePanel.TextColor = xui.Color_Blue  
    NotePanel.SetTextAlignment("CENTER", "CENTER")  
    Root.AddView(NotePanel, 50dip, Root.Height - 45dip, Root.Width - 100dip, 40dip)  
  
    BBCVPanel.LoadLayout("BBCV")  
    TextEngine1.Initialize(BBCVPanel)  
    Sleep(50)  
    BBCodeView1.TextEngine = TextEngine1  
     
    Dim margin As Int = 25dip  
    Dim margins As B4XRect: margins.Initialize(margin, margin, margin, margin)  
    BBCodeView1.Padding = margins  
    BBCodeView1.mBase.Visible = False  
     
    Dim markTime As Long = DateTime.now  
    BBCVClr = IntToHex(BBCodeView1.mBase.Color)  
    BBCodeView1.Text = getBBCVText            'although not visible this creates all the marks  
  
' for each mark compute height of substring to mark    
    For Each mrkName As String In markerHeights.keys  
        BBCodeView1.Text = getBBCVText.SubString2(0, getBBCVText.IndexOf(mrkName))  
        Dim h As Int = BBCodeView1.Paragraph.Height / TextEngine1.mScale + BBCodeView1.Padding.Top + BBCodeView1.Padding.Bottom  
        markerHeights.Put(mrkName, h)  
    Next  
    BBCodeView1.Text = getBBCVText  
    indexWords(getBBCVText)  
  
    BBCodeView1.mBase.Visible = True        'finally make it visible  
  
    Log(DateTime.Now - markTime)        '467 msec  
     
    showAction("Initial Scroll = Top")  
    Sleep(2000)  
    scrollToWord("Alice", 2)        'go to section with 2nd occurrence of Alice  
    showAction($"scrollToWord("Alice", 2)"$)  
    Sleep(3000)  
    scrollToMarker(5)   'scroll to mark 3 = paragraph 3  (as an example)  
    showAction("scrollToMarker(5)")  
    Sleep(2000)  
    scrollToTop  
    showAction("scrollToTop")  
    Sleep(2000)  
    scrollToLastMarker  
    showAction("scrollToLastMarker")  
End Sub  
  
Private Sub showAction(s As String)  
    actionLabel.Text = s  
End Sub  
  
Private Sub scrollToTop  
    If wordHighlighted Then  
        BBCodeView1.Text = getBBCVText  
        wordHighlighted = False  
    End If  
    BBCodeView1.sv.ScrollViewOffsetY = 0  
End Sub  
  
Private Sub scrollToWord(wrd As String, occurrence As Int)  
    Dim heights As List = wordPositions.Get(wrd.ToLowerCase)  
    Dim ar() As Object = heights.Get(occurrence - 1)  
    Dim h As Int = ar(0)  
    BBCodeView1.Text = getBBCVText.Replace(ar(1), $"${ar(1)}"$)  
    BBCodeView1.sv.ScrollViewOffsetY = h - ScrollToYOffset    'provide a little headroom  
    wordHighlighted = True  
End Sub  
  
Private Sub scrollToMarker(index As Int)  'ignore  
    If wordHighlighted Then  
        BBCodeView1.Text = getBBCVText  
        wordHighlighted = False  
    End If  
    Dim h As Int = markerHeights.Get($"~${index}~"$)  
    BBCodeView1.sv.ScrollViewOffsetY = h - ScrollToYOffset    'provide a little headroom  
End Sub  
  
Private Sub scrollToLastMarker  
    If wordHighlighted Then  
        BBCodeView1.Text = getBBCVText  
        wordHighlighted = False  
    End If  
    Dim h As Int = markerHeights.Values.Get(markerHeights.Size - 1)  
    BBCodeView1.sv.ScrollViewOffsetY = h - ScrollToYOffset    'provide a little headroom  
End Sub  
  
Private Sub mark(index As Int) As String  
    Dim name As String = $"~${index}~"$  
    If markerHeights.ContainsKey(name)  = False Then    'make sure not do it again during height measurements  
        markerHeights.Put(name, -1)  
    End If  
    Return $"~${index}~"$            'make mark invisible - set color to background  
End Sub  
  
Private Sub getBBCVText As String  
    Dim s As String = $"  
~~~  
[TextSize=22]Chapter I: Down the Rabbit-Hole[/TextSize]  
${mark(1)}  
Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, “and what is the use of a book,” thought Alice “without pictures or conversations?”  
${mark(2)}  
So she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her.  
${mark(3)}  
There was nothing so very remarkable in that; nor did Alice think it so very much out of the way to hear the Rabbit say to itself, “Oh dear! Oh dear! I shall be late!” (when she thought it over afterwards, it occurred to her that she ought to have wondered at this, but at the time it all seemed quite natural); but when the Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then hurried on, Alice started to her feet, for it flashed across her mind that she had never before seen a rabbit with either a waistcoat-pocket, or a watch to take out of it, and burning with curiosity, she ran across the field after it, and fortunately was just in time to see it pop down a large rabbit-hole under the hedge.  
${mark(4)}  
In another moment down went Alice after it, never once considering how in the world she was to get out again.  
${mark(5)}  
The rabbit-hole went straight on like a tunnel for some way, and then dipped suddenly down, so suddenly that Alice had not a moment to think about stopping herself before she found herself falling down a very deep well.  
${mark(6)}  
Either the well was very deep, or she fell very slowly, for she had plenty of time as she went down to look about her and to wonder what was going to happen next. First, she tried to look down and make out what she was coming to, but it was too dark to see anything; then she looked at the sides of the well, and noticed that they were filled with cupboards and book-shelves; here and there she saw maps and pictures hung upon pegs. She took down a jar from one of the shelves as she passed; it was labelled “ORANGE MARMALADE”, but to her great disappointment it was empty: she did not like to drop the jar for fear of killing somebody underneath, so managed to put it into one of the cupboards as she fell past it.  
${mark(7)}  
“Well!” thought Alice to herself, “after such a fall as this, I shall think nothing of tumbling down stairs! How brave they’ll all think me at home! Why, I wouldn’t say anything about it, even if I fell off the top of the house!” (Which was very likely true.)  
${mark(8)}  
Down, down, down. Would the fall never come to an end? “I wonder how many miles I’ve fallen by this time?” she said aloud. “I must be getting somewhere near the centre of the earth. Let me see: that would be four thousand miles down, I think—” (for, you see, Alice had learnt several things of this sort in her lessons in the schoolroom, and though this was not a very good opportunity for showing off her knowledge, as there was no one to listen to her, still it was good practice to say it over) “—yes, that’s about the right distance—but then I wonder what Latitude or Longitude I’ve got to?” (Alice had no idea what Latitude was, or Longitude either, but thought they were nice grand words to say.)  
${mark(9)}  
Presently she began again. “I wonder if I shall fall right through the earth! How funny it’ll seem to come out among the people that walk with their heads downward! The Antipathies, I think—” (she was rather glad there was no one listening, this time, as it didn’t sound at all the right word) “—but I shall have to ask them what the name of the country is, you know. Please, Ma’am, is this New Zealand or Australia?” (and she tried to curtsey as she spoke—fancy curtseying as you’re falling through the air! Do you think you could manage it?) “And what an ignorant little girl she’ll think me for asking! No, it’ll never do to ask: perhaps I shall see it written up somewhere.”  
~~~  
    "$  
    Return s.SubString2(s.IndexOf("~~~") + 4, s.LastIndexOf("~~~") - 1)  
End Sub  
  
Public Sub IntToHex(Color As Int) As String  
    Dim bcx As ByteConverter  
    Dim r As Int = Bit.And(0xff, Bit.UnsignedShiftRight(Color, 16))  
    Dim g As Int = Bit.And(0xff, Bit.UnsignedShiftRight(Color, 8))  
    Dim b As Int = Bit.And(0xff, Bit.UnsignedShiftRight(Color, 0))  
    Dim result As String = bcx.HexFromBytes(Array As Byte(r, g, b))  
    Return "#" & result.toLowerCase  
End Sub  
  
Public Sub indexWords(text As String)  
    Dim ignoreChars As String = $"~!@#$%^&*()_+-={}|[]\:";<>?,./“”'""$  
    Dim v() As String = Regex.Split(CRLF, text)  
    Dim currentMark As String  
    For Each s As String In v  
        If s.StartsWith($"~"$) Then  
            currentMark = s.SubString2(s.IndexOf("~"), s.LastIndexOf("~") + 1)  
        Else  
            Dim w() As String = Regex.Split(" ", s)  
            For Each t As String In w  
                t = t.Trim  
                If t.Length < minWordLength Then Continue  
                Dim sb As StringBuilder: sb.Initialize  
                For k = 0 To t.Length - 1  
                    Dim c As String = t.CharAt(k)  
                    If ignoreChars.Contains© = False Then sb.Append©  
                Next  
                t = sb.toString  
                Dim tlower As String = t.toLowerCase  
                Dim h As Int = markerHeights.Get(currentMark)  
                If wordPositions.containsKey(tlower) Then  
                    Dim heights As List = wordPositions.Get(tlower)  
                Else  
                    Dim heights As List: heights.Initialize  
                    wordPositions.Put(tlower, heights)  
                End If  
                heights.Add(Array(h, t))  
            Next  
        End If  
    Next  
End Sub  
  
Private Sub BBCodeView1_LinkClicked (URL As String)  
    Log(URL)  
End Sub
```

  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/141703)