### [BANanoClippy] - 🎬 Bringing Classic Microsoft Agent Characters to Life with JavaScript! 🧙‍♂️🐵📎 by Mashiane
### 05/01/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166830/)

Hi Fam  
  
[Demo](https://ba-nano-clippy.vercel.app/)  
[B4xlib](https://www.b4x.com/android/forum/threads/web-bananoclippy-pure-javascript-joy-with-sounds-and-animations.166813/)  
  
![](https://www.b4x.com/android/forum/attachments/163817)  
  
  
Recently we released BANanoClippy, A web based version of Microsoft Agent characters to use in your web app. For those who dont know, let me refresh you.  
  
Remember Clippy, Bonzi, Rover, and the rest of the quirky animated assistants from the late '90s and early 2000s? In this video, we revive these nostalgic Microsoft Agent characters and bring them into the browser using JavaScript! 😄💻  
  
👾 Characters featured:  

- Bonzi (yes, *that* purple gorilla) 🐵
- Clippy (the paperclip we all "loved") 📎
- F1 (the helpful robot) 🤖
- Genie (your magical assistant) ✨
- Genius (the wise old man) 🧓
- Links (the cool cat) 🐱
- Merlin (the wizard) 🧙‍♂️
- Peedy (the parrot) 🦜
- Rocky (the rockstar) 🎸
- Rover (the search dog) 🐶

💡 What you’ll learn:  

- How to use JavaScript to load and animate these agents
- Play animations, show messages, and interact with them
- Add a touch of nostalgia and fun to your web projects

📦 We'll be using modern tools and libraries to work with these old-school agents in new-school ways.  
⚠️ Note: This is all for fun and nostalgia—some of these characters have quite the internet history (looking at you, Bonzi).  
🌐 Learn more about Microsoft Agent: <https://en.wikipedia.org/wiki/Microsoft_Agent>  
  
**Step 1**  
  
Get the b4xlib from Github and refer it to your app.  
  
**Step 2: Code Sequence**  
  
*2.1 Define the variable*  
  

```B4X
Private clippy1 As BANanoClippy
```

  
  
*2.2 Initialize the variable* and also get the agent names. Inside the Demo project, you will have to copy the agents folder to your assets folder \*after\* you build your app. To ensure that the asset folder is not deleted, add this to transpiler options and specify your assets folder for your project  
  

```B4X
BANano.TranspilerOptions.DoNotDeleteFolderOnCompilation(?)
```

  
  

```B4X
'initialize the agent  
    clippy1.Initialize(Me, "clippy1", "./assets/agents/")  
    'get the names of the agents, here we load these to a combo box  
    For Each a As String In clippy1.GetAgents  
        cboAgents.AddMenuItem(a, a)  
    Next
```

  
  
*2.3 Load an agent*  
  
These are the names of the agents that you can use  
  

```B4X
Public CONST Bonzi As String = "Bonzi"  
    Public CONST Clippy As String = "Clippy"  
    Public CONST F1 As String = "F1"  
    Public CONST Genie As String = "Genie"  
    Public CONST Genius As String = "Genius"  
    Public CONST Links As String = "Links"  
    Public CONST Merlin As String = "Merlin"  
    Public CONST Peedy As String = "Peedy"  
    Public CONST Rocky As String = "Rocky"  
    Public CONST Rover As String = "Rover"
```

  
  
You pass the agent name to load. This will fire a loaded event  
  

```B4X
'load a new agent  
    clippy1.LoadAgent(thisAgent)
```

  
  
2.4 When loaded you can *show the agent*. Here we are gettings its animations, there are some generic animations across all of them. You get Log(?) these out to see which ones are applicable to each agent.  
  

```B4X
Private Sub clippy1_Loaded  
    'get clippy animations  
    Dim animations As List = BANano.await(clippy1.GetAnimations)  
    animeContainer.Empty  
    For Each anime As String In animations  
        Dim btn As MDUComponent = animeContainer.AddButton(anime, anime)  
        btn.SetData("anime", anime)  
        btn.SetMargin("5px").OnClick("SelectAnime")  
    Next  
'    cboAnimations.Clear  
'    For Each a As String In animations  
'        cboAnimations.AddSelectItem(a, a)  
'    Next      
    clippy1.show  
End Sub
```

  
  
2.5 You can then, *play an animation* against an agent  
  

```B4X
clippy1.Play(sanime)
```

  
  
2.6. You can *move an agent using*  
  

```B4X
clippy1.MoveTo(20, 20)
```

  
  
2.7. You can *hide an agent* with  
  

```B4X
'hide any existing agent  
    clippy1.Hide(True)
```

  
  
2.8 Get it *to "speak"*  
  

```B4X
clippy1.Speak(txtField.GetValue)
```

  
  
Have Fun and enjoy!