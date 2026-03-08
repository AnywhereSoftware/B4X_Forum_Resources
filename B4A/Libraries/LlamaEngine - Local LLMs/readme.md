### LlamaEngine - Local LLMs by Blueforcer
### 03/07/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170526/)

[size=6]**LlamaEngine - Run LLM Models Locally on Android**[/size]  
  
Run large language models (LLMs) directly on your Android device - no internet, no API keys, no cloud services required!  
  
LlamaEngine wraps [llama.cpp](https://github.com/ggml-org/llama.cpp) into a native B4A library, allowing you to load and run GGUF model files with streaming token generation on-device.  
  
If you like my work, please consider supporting the me.  
<https://paypal.me/blueforcer>  
  
[size=5]**Features**[/size]  

- **GGUF Support**: Load any compatible GGUF model (Qwen, Llama, Gemma, Phi, Mistral, etc.)
- **Streaming Generation**: Receive events as each token is generated in real-time
- **Chat Templates**: Built-in support for ChatML, Llama 3, Gemma, Alpaca, and Raw modes
- **Multi-turn Chat**: History management (System, User, Assistant messages)
- **Configurable Sampling**: Fine-tune Temperature, Top-P, Top-K, Min-P, and Repeat Penalty
- **Low Memory Mode**: Dedicated toggle (**LowMemoryMode**) for devices with limited RAM (e.g., 2GB or 32-bit devices)
- **Debugging**: Enable **DebugMode** for detailed performance metrics and logging via **\_DebugLog** event
- **Completely Offline**: Runs entirely on the device CPU
- **Architecture Support**: Supports both modern 64-bit (**arm64-v8a**) and older 32-bit (**armeabi-v7a**) Android devices

  
[size=5]**Requirements**[/size]  

- Android 7.0+ (API 24)
- Supported Architectures: **arm64-v8a**, **armeabi-v7a**
- A GGUF model file downloaded to your device storage

  
[size=5]**Installation**[/size]  
The library is split into a Java wrapper and an AAR containing the compiled C++ binaries.  

1. Download the release archive containing:

- **LlamaEngine.jar**
- **LlamaEngine.xml**
- **LlamaEngine\_Native.aar**

2. Copy **all three files** to your B4A Additional Libraries folder.
3. In B4A IDE: Right-click the Libraries Manager -> **Refresh**.
4. Check **"LlamaEngine"**.

  
[size=5]**Basic Example**[/size]  

```B4X
Sub Globals  
    Dim llm As LlamaEngine  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    llm.Initialize(Me, "LLM")  
  
    ' Optional: Enable debug logs and low memory optimizations  
    llm.DebugMode = True  
    ' llm.LowMemoryMode = True ' Uncomment for low RAM devices  
  
    ' Load a GGUF model (adjust path to your model file)  
    ' Params: Path, Threads, ContextSize  
    llm.LoadModel("/sdcard/Download/Qwen3-0.6B-Q4_K_M.gguf", 4, 512)  
End Sub  
  
Sub LLM_LoadProgress(Progress As Float)  
    Log("Loading: " & Round(Progress * 100) & "%")  
End Sub  
  
Sub LLM_ModelLoaded(Success As Boolean)  
    Log("Model loaded: " & Success)  
    If Success Then  
        llm.AddSystemMessage("You are a helpful assistant.")  
        llm.AddUserMessage("What is the capital of France?")  
        llm.GenerateChat(256, 0.7) ' Generate max 256 tokens with 0.7 temperature  
    End If  
End Sub  
  
Sub LLM_TokenGenerated(Token As String)  
    ' Each token is streamed as it's generated  
    Log(Token)  
End Sub  
  
Sub LLM_Complete(Response As String)  
    Log("Full response: " & Response)  
End Sub  
  
Sub LLM_Error(Message As String)  
    Log("Error: " & Message)  
End Sub  
  
Sub LLM_DebugLog(Message As String)  
    ' Triggered if llm.DebugMode = True  
    Log("[LLM DEBUG] " & Message)  
End Sub
```

  
  
[size=5]**Chat Templates**[/size]  
Different models use different prompt formats. Set the template before generating:  

```B4X
' For Qwen, Yi, Mistral-Instruct (default)  
llm.ChatTemplate = "chatml"  
  
' For Llama 3 / 3.1  
llm.ChatTemplate = "llama3"  
  
' For Gemma / Gemma 2  
llm.ChatTemplate = "gemma"  
  
' For Alpaca-style fine-tuned models  
llm.ChatTemplate = "alpaca"  
  
' No template - you build the prompt yourself  
llm.ChatTemplate = "raw"
```

  
  
[size=5]**Sampling Parameters**[/size]  
Fine-tune the text generation:  

```B4X
llm.TopP = 0.9            ' Nucleus sampling (0.0-1.0)  
llm.TopK = 40             ' Top-K sampling (0 = disabled)  
llm.RepeatPenalty = 1.1   ' Penalize repetitions (1.0 = off)  
llm.MinP = 0.05           ' Min-P filtering (0.0-1.0)
```

  
  
[size=5]**Multi-Turn Conversation**[/size]  

```B4X
' Build a conversation  
llm.ClearHistory  
llm.AddSystemMessage("You are a cooking assistant.")  
llm.AddUserMessage("How do I make pasta?")  
llm.GenerateChat(512, 0.7)  
  
' After getting the response, continue the conversation:  
Sub LLM_Complete(Response As String)  
    llm.AddAssistantMessage(Response)  ' Save the AI's response  
    llm.AddUserMessage("What sauce goes best with it?")  
    llm.GenerateChat(512, 0.7)         ' Generate next response  
End Sub
```

  
  
[size=5]**Raw Prompt Mode**[/size]  
For full control over the prompt format without modifying chat history:  

```B4X
llm.GenerateRaw("Once upon a time,", 256, 0.8)
```

  
  
[size=5]**API Reference**[/size]  
  
**Methods:**  
[table]  
[tr]  
[th]Method[/th]  
[th]Description[/th]  
[/tr]  
[tr]  
[td]**Initialize(CallBack, EventName)**[/td]  
[td]Initialize the engine[/td]  
[/tr]  
[tr]  
[td]**LoadModel(Path, Threads, ContextSize)**[/td]  
[td]Load a GGUF model file asynchronously[/td]  
[/tr]  
[tr]  
[td]**AddSystemMessage(Text)**[/td]  
[td]Add system instruction to chat history[/td]  
[/tr]  
[tr]  
[td]**AddUserMessage(Text)**[/td]  
[td]Add user message to chat history[/td]  
[/tr]  
[tr]  
[td]**AddAssistantMessage(Text)**[/td]  
[td]Add AI response to chat history[/td]  
[/tr]  
[tr]  
[td]**ClearHistory**[/td]  
[td]Clear all chat messages[/td]  
[/tr]  
[tr]  
[td]**GenerateChat(MaxTokens, Temperature)**[/td]  
[td]Generate from chat history[/td]  
[/tr]  
[tr]  
[td]**Generate(SystemPrompt, UserPrompt, MaxTokens, Temp)**[/td]  
[td]Single-turn generation without history[/td]  
[/tr]  
[tr]  
[td]**GenerateRaw(Prompt, MaxTokens, Temperature)**[/td]  
[td]Generate from raw unformatted prompt[/td]  
[/tr]  
[tr]  
[td]**StopGeneration**[/td]  
[td]Stop current generation safely[/td]  
[/tr]  
[tr]  
[td]**Unload**[/td]  
[td]Free model and RAM memory[/td]  
[/tr]  
[/table]  
  
**Properties:**  
[table]  
[tr]  
[th]Property[/th]  
[th]Type[/th]  
[th]Default[/th]  
[th]Description[/th]  
[/tr]  
[tr]  
[td]**IsLoaded**[/td]  
[td]Boolean[/td]  
[td]-[/td]  
[td]True if a model is currently loaded[/td]  
[/tr]  
[tr]  
[td]**IsGenerating**[/td]  
[td]Boolean[/td]  
[td]-[/td]  
[td]True if text generation is running[/td]  
[/tr]  
[tr]  
[td]**DebugMode**[/td]  
[td]Boolean[/td]  
[td]False[/td]  
[td]Enables detailed logging and **\_DebugLog** events[/td]  
[/tr]  
[tr]  
[td]**LowMemoryMode**[/td]  
[td]Boolean[/td]  
[td]False[/td]  
[td]Reduces compute buffer allocation for low RAM devices[/td]  
[/tr]  
[tr]  
[td]**ChatTemplate**[/td]  
[td]String[/td]  
[td]"chatml"[/td]  
[td]Prompt template format[/td]  
[/tr]  
[tr]  
[td]**TopP**[/td]  
[td]Float[/td]  
[td]0.9[/td]  
[td]Nucleus sampling[/td]  
[/tr]  
[tr]  
[td]**TopK**[/td]  
[td]Int[/td]  
[td]40[/td]  
[td]Top-K sampling[/td]  
[/tr]  
[tr]  
[td]**RepeatPenalty**[/td]  
[td]Float[/td]  
[td]1.1[/td]  
[td]Repetition penalty[/td]  
[/tr]  
[tr]  
[td]**MinP**[/td]  
[td]Float[/td]  
[td]0.05[/td]  
[td]Min-P filtering[/td]  
[/tr]  
[tr]  
[td]**HistorySize**[/td]  
[td]Int[/td]  
[td]-[/td]  
[td]Number of chat messages currently in history[/td]  
[/tr]  
[/table]  
  
**Events:**  
[table]  
[tr]  
[th]Event[/th]  
[th]Description[/th]  
[/tr]  
[tr]  
[td]**\_ModelLoaded(Success As Boolean)**[/td]  
[td]Model loading finished[/td]  
[/tr]  
[tr]  
[td]**\_LoadProgress(Progress As Float)**[/td]  
[td]Loading progress (0.0-1.0)[/td]  
[/tr]  
[tr]  
[td]**\_TokenGenerated(Token As String)**[/td]  
[td]Emitted for each token as it's generated[/td]  
[/tr]  
[tr]  
[td]**\_Complete(Response As String)**[/td]  
[td]The fully combined response string[/td]  
[/tr]  
[tr]  
[td]**\_Error(Message As String)**[/td]  
[td]An error occurred[/td]  
[/tr]  
[tr]  
[td]**\_DebugLog(Message As String)**[/td]  
[td]Performance and debug info (requires **DebugMode = True**)[/td]  
[/tr]  
[/table]  
  
[size=5]**Recommended Models**[/size]  
You can download **.gguf** files directly from HuggingFace. Models must be stored on your device storage (e.g. **/sdcard/Download/**).  
  
[table]  
[tr]  
[th]Model[/th]  
[th]Size[/th]  
[th]Quality[/th]  
[th]Speed[/th]  
[th]Link[/th]  
[/tr]  
[tr]  
[td]Qwen3.5-0.8B-Instruct-Q4\_K\_M[/td]  
[td]~600 MB[/td]  
[td]Great for simple tasks[/td]  
[td]Very Fast[/td]  
[td][Download](https://huggingface.co/unsloth/Qwen3.5-0.8B-GGUF)[/td]  
[/tr]  
[tr]  
[td]Qwen3.5-2B-Instruct-Q4\_K\_M[/td]  
[td]~1.3 GB[/td]  
[td]Excellent daily assistant[/td]  
[td]Fast[/td]  
[td][Download](https://huggingface.co/unsloth/Qwen3.5-2B-GGUF)[/td]  
[/tr]  
[tr]  
[td]Phi-4-mini-instruct-Q4\_K\_M[/td]  
[td]~2.3 GB[/td]  
[td]Best for logic & coding[/td]  
[td]Medium[/td]  
[td][Download](https://huggingface.co/matrixportalx/Phi-4-mini-instruct-Q4_K_M-GGUF)[/td]  
[/tr]  
[tr]  
[td]Gemma-3-1B-It-Q4\_K\_M[/td]  
[td]~800 MB[/td]  
[td]Good general purpose[/td]  
[td]Fast[/td]  
[td][Download](https://huggingface.co/unsloth/gemma-3-1b-it-GGUF)[/td]  
[/tr]  
[/table]  
  
**Performance Tips:**  

- Start with a tiny model like **Qwen 3.5 0.8B** or **Gemma-3-1B** to test compatibility.
- Context size 512 or 1024 is usually sufficient for mobile scenarios.
- Use 4 threads on most devices. Going above 4 threads might actually slow down generation.
- Keep an eye on available RAM. The required RAM is roughly the file size of the GGUF model plus ~200MB overhead.

  
[size=5]**Version History**[/size]  

- **v1.3**:

- Re-architected as a combined Jar + Native AAR setup to support multiple CPU architectures properly (**arm64-v8a** & **armeabi-v7a**).
- Added **LowMemoryMode** for devices with 2GB RAM or 32-bit systems.
- Added **DebugMode** property and **\_DebugLog** event for performance tracking (tokens/sec).

- **v1.1**: Added Chat templates, extended sampling parameters, **GenerateRaw**.
- **v1.0**: Initial release.

  
[size=5]**Credits**[/size]  

- Core engine: [llama.cpp](https://github.com/ggml-org/llama.cpp) by Georgi Gerganov

  
[size=5]**Download**[/size]  
<https://filebin.net/oq0mgcpl4vl0328b>