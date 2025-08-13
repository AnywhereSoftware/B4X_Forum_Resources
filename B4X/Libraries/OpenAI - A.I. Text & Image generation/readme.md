###  OpenAI - A.I. Text & Image generation by Blueforcer
### 03/18/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/159877/)

Only tested in B4A so far  
  
This library is designed to facilitate communication with the *multimodal* **OpenAI API**, enabling your B4X applications to leverage the capabilities of OpenAI's models for  
**text generation** (GPT-3.5 Turbo and GPT-4),  
**image generation** (DALL-E 3),  
**text-to-speech** functionalities.  
**Vision API** will be added soon!  
  
get your API key [here](https://platform.openai.com/api-keys).  
Used tokens arent calculated yet.  
OpenAI pricing is pay-as-you-go, meaning you only pay for what you use without needing a subscription.  
Text generation costs are low. For example, generating text equivalent to the length of "The Hobbit" (around 95,000 words) with GPT-3.5 would cost about $0.25.  
Image generation costs are also affordable. Generating a single 1024x1024 image costs around $0.040.  
  
You will see all prices here:  
<https://openai.com/pricing>  
  
DependsOn: XUI, JSON and OkHttpUtils2  
  

```B4X
Dim oai As OpenAI  
oai.Initialize(Me, "OpenAI", "your-api-key")  
  
'In conjunction with ChatGPT, the library will buffer all messages from GPT  
'and the user to maintain the context of the chat history. Use .ResetChat to start over.  
oai.ChatModel=oai.MODEL_GPT35_TURBO 'or MODEL_GPT4  
oai.SystemMessage("Act like a math teacher called Tom, write witty but informative.") 'optional, tell the bot once how to interpret the chat /act  
oai.ChatMessage("Hello tom, please explain the determinant method to me!")  
  
' Interact with DALL-E 3  
oai.ImageAspectRatio(oai.IMAGE_16_9) 'optional, IMAGE_1_1; IMAGE_16_9, IMAGE_9_16  
oai.generateImage("A blue elephant in a Greenhouse")  
  
' Interact withTTS  
oai.TTSVoice=oai.TTS_FABLE 'optional, TTS_ALLOY,TTS_ECHO,TTS_FABLE,TTS_ONYX,TTS_NOVA,TTS_SHIMMER  
oai.TextToSpeech("Hello, this is a test")  
  
' Implement corresponding event handlers in your activity or class  
Sub OpenAI_ChatResponse(response As String)  
    Log(response)  
End Sub  
  
Sub OpenAI_ImageResponse(image As B4XBitmap)  
    ImageView.SetBitmap(image)  
End Sub  
  
Sub OpenAI_TTSResponse(folder As String, filename As String)  
    MediaPlayer.Load(folder, filename)  
    MediaPlayer.Play  
End Sub  
  
Sub OpenAI_Error(message As String)  
    Log("Error: " & message)  
End Sub
```

  
  
  
Have Fun!