### Ollama4j library - Pnd_Ollama4j - Your local offline LLM like ChatGPT by Pendrush
### 01/16/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165003/)

What is Ollama?  
Ollama is a free and open-source project that lets you **run various open source LLMs locally.**  
For more info check [this link](https://itsfoss.com/ollama/).  
  
[Ollama for Windows and system requirements](https://github.com/ollama/ollama/blob/main/docs/windows.md)  
  
[Download Ollama server](https://ollama.com/)  
  
[Top LLMs for Coding All Developers Should Know About](https://autogpt.net/top-llms-for-coding-all-developers-should-know-about/)  
  
Short video (3 minutes) about Ollama on [You Tube](https://www.youtube.com/watch?v=EMC5QQN_vdU)  
  
When you finish Ollama server installation, you can run example app to get model of your choice.  
You can chat from application, download and delete models, for now.  
When you choose model and tag, check DOWNLOAD SIZE, right bottom on image below, some models are over 200GB.  
You can start with MODEL: **mistral** and TAG: **7b**, download size is **4.1GB**  
  
Hardware requirements:  
RAM: 8GB for running 3B models, 16GB for running 7B models, 32GB for running 13B models  
Disk Space: 5GB for installing Ollama, additional space required for storing model data, depending on the models you use.  
CPU: Any modern CPU with at least 4 cores is recommended, for running 13B models a CPU with at least 8 cores is recommended.  
GPU(Optional): A GPU is not required for running Ollama, but it can improve performance, especially for running larger models. If you have a GPU, you can use it to accelerate training of custom models.  
  
  
![](https://www.b4x.com/android/forum/attachments/160574)  
  
Chat example:  
![](https://www.b4x.com/android/forum/attachments/160576)  
  
  
> **Pnd\_Ollama4j  
>   
> Author:** Author: Ollama4j - B4j Wrapper: Pendrush  
> **Version:** 0.30  
>
> - **Pnd\_LibraryModel**
>
> - **Properties:**
>
> - **Description** As String [read only]
> *Returns: the description of the model. This is a brief summary of what the model does.  
>  It can be used to understand the purpose and capabilities of the model.*- **LastUpdated** As String [read only]
> *Returns: the last updated date of the model.  
>  The format of the timestamp may vary depending on the source of the information.*- **Name** As String [read only]
> *Returns: the name of the model. This is a unique identifier for the model.*- **Object** As io.github.ollama4j.models.response.LibraryModel [read only]
> - **PopularTags** As List [read only]
> *Returns: a list of popular tags associated with the model.  
>  These tags can help categorize and identify the model's purpose or features.*- **PullCount** As String [read only]
> *Returns: the number of times the model has been pulled or downloaded.  
>  This can be an indicator of its popularity and usage.  
>  The format may vary depending on the source.*- **ToString** As String [read only]
> *Returns a string representation of the Pnd\_LibraryModel object.*- **TotalTags** As Int [read only]
>
> - **Pnd\_LibraryModelDetail**
>
> - **Properties:**
>
> - **Tags** As List [read only]
> *Returns: List of Pnd\_LibraryModelTag objects. The tags associated with the model.*
> - **Pnd\_LibraryModelTag**
>
> - **Properties:**
>
> - **LastUpdated** As String [read only]
> *Returns: the last updated date of the model.*- **Name** As String [read only]
> *Returns: the name of the model.*- **Size** As String [read only]
> *Returns: the size of the model.*- **Tag** As String [read only]
> *Returns: the tag of the model.*- **ToString** As String [read only]
> *Returns: the ToString representation of the Pnd\_LibraryModelTag object.*
> - **Pnd\_Model**
>
> - **Properties:**
>
> - **Model** As String [read only]
> *Returns: The model identifier. It is the combination of the model name and version, separated by a slash.  
>  For example, "gpt-4/0314". This string can be used to uniquely identify the model in systems that support multiple versions of models.*- **ModelName** As String [read only]
> *Returns: the model name without its version.*- **ModelVersion** As String [read only]
> *Returns: The version of the model. For example, "0314". This string can be used to identify different versions of the same model.  
>  It is often a date or a sequence number indicating when the model was trained or updated.*- **Name** As String [read only]
> *Returns: A string representing the name of the model.*- **Size** As Long [read only]
> *Returns: The size of the model in kilobytes (KB). This value represents the amount of memory or storage required to store the model.  
>  It can be useful for understanding the resource requirements of running the model, especially in environments with limited resources.*
> - **Pnd\_Ollama4j**
>
> - **Events:**
>
> - **PullModelComplete**
> - **SyncStreamed** (Text As String)
>
> - **Functions:**
>
> - **Chat** (Pnd\_OllamaChatRequest As Pnd\_OllamaChatRequest) As Pnd\_OllamaChatResult
> *This method is used to generate a chat response based on the provided request.  
>  It takes an instance of the Pnd\_OllamaChatRequest class as a parameter.  
>  The method returns an instance of the Pnd\_OllamaChatResult class containing the chat response.*- **DeleteModel** (ModelName As String)
> *Delete a model from Ollama server.  
>  ModelName – the name of the model to be deleted*- **Embed** (ModelName As String, Inputs As List) As Pnd\_OllamaEmbedResponseModel
> *This method fetches the embeddings for a List of input texts using a specific model from the Ollama library.  
>  ModelName – the name of the model to be used for generating embeddings.  
>  Inputs – a List of Strings representing the input texts for which embeddings need to be generated.  
>  Returns: an Pnd\_OllamaEmbedResponseModel object containing the embeddings and other relevant information.*- **GenerateAsync** (Model As String, Prompt As String, Raw As Boolean) As Pnd\_OllamaAsyncResult
> *Model – The name or identifier of the AI model to use for generating the response.  
>  Prompt – The input text or prompt to provide to the AI model.  
>  Raw – In some cases, you may wish to bypass the templating system and provide a full prompt. In this case, you can use the raw parameter to disable templating. Also note that raw mode will not return a context.*- **GenerateSync** (Model As String, Prompt As String, Raw As Boolean) As Pnd\_OllamaResult
> *Model – The name or identifier of the AI model to use for generating the response.  
>  Prompt – The input text or prompt to provide to the AI model.  
>  Raw – In some cases, you may wish to bypass the templating system and provide a full prompt. In this case, you can use the raw parameter to disable templating. Also note that raw mode will not return a context.*- **GenerateSyncStreamed** (Model As String, Prompt As String, Raw As Boolean) As Pnd\_OllamaResult
> *Model – The name or identifier of the AI model to use for generating the response.  
>  Prompt – The input text or prompt to provide to the AI model.  
>  Raw – In some cases, you may wish to bypass the templating system and provide a full prompt. In this case, you can use the raw parameter to disable templating. Also note that raw mode will not return a context.  
>  Returns Text in event \_SyncStreamed (Text As String)*- **GenerateWithImageFiles** (Model As String, Prompt As String, ListOfFiles As List) As Pnd\_OllamaResult
> *Model – The name or identifier of the AI model to use for generating the response.  
>  Prompt – The input text or prompt to provide to the AI model.  
>  ListOfFiles - A List containing paths to image files.*- **GenerateWithImageURLs** (Model As String, Prompt As String, ListOfURLs As List) As Pnd\_OllamaResult
> *Model – The name or identifier of the AI model to use for generating the response.  
>  Prompt – The input text or prompt to provide to the AI model.  
>  ListOfURLs - A List containing URLs to image files.*- **Initialize** (EventName As String, Host As String)
> *Initializes the Ollama4J with a given host URL.  
>  EventName - Event name  
>  Host - The URL of the Ollama server.   
> Ollama.Initialize("Ollama", "<http://localhost:11434/>")*- **IsInitialized** As Boolean
> - **LibraryModelDetails** (LibraryModel As Pnd\_LibraryModel) As Pnd\_LibraryModelDetail
> *Fetches the tags associated with a specific model from Ollama library.  
>  This method fetches the available model tags directly from Ollama library model page, including model tag name, size and time when model was last updated into a list of LibraryModelTag objects.  
>  LibraryModel – the LibraryModel object which contains the name of the library model for which the tags need to be fetched.  
>  Returns: a List of Pnd\_LibraryModelDetail objects containing the extracted tags and their associated metadata.*- **ListModels** As List
> *Lists available models from the Ollama server.  
>  Returns: a List of models available on the server*- **ListModelsFromLibrary** As List
> *Retrieves a list of models from the Ollama library.  
>  This method fetches the available models directly from Ollama library page, including model details such as the name, pull count, popular tags, tag count, and the time when model was updated.  
>  Returns: a List of LibraryModel*- **Ping** As Boolean
> *API to check the reachability of Ollama server.  
>  Returns: True if the server is reachable, False otherwise.*- **PullModel** (ModelName As String)
> *Pull a model on the Ollama server from the list of available models.  
>  ModelName – the name of the model.*
> - **Properties:**
>
> - **RequestTimeoutSeconds** As Long [write only]
> *Sets the request timeout in seconds for API calls.  
>  RequestTimeoutSeconds - The timeout duration in seconds.*- **Verbose** As Boolean [write only]
> *Enables or disables verbose logging for API requests.*
> - **Pnd\_OllamaAsyncResult**
>
> - **Properties:**
>
> - **CompleteResponse** As String [read only]
> *Returns a string representation of the complete response associated with this `Pnd\_OllamaAsyncResult` object.  
>  It's important to note that this method should be called after the streaming process has completed to ensure that all parts of the response are included in the returned string.*- **HttpStatusCode** As Int [read only]
> *Returns the HTTP status code of the response associated with this `Pnd\_OllamaAsyncResult` object.  
>  This method can be useful for determining the success or failure of the API request that generated the response. Common status codes include:*- **IsAlive** As Boolean [read only]
> *Returns: True if the thread is alive. A thread is alive if it has been started and has not yet died.  
>  In a more practical sense, this method can be used to check if the asynchronous operation represented by the  
>  `Pnd\_OllamaAsyncResult` object is still ongoing or has completed.*- **IsDaemon** As Boolean [read only]
> *Returns: True if the thread is a daemon.  
>  A daemon thread is a low-priority thread that runs in the background.*- **IsInterrupted** As Boolean [read only]
> *Returns: True if the thread has been interrupted. A thread is interrupted when another thread invokes its interrupt method.  
>  This method can be used to check if the asynchronous operation has been interrupted or canceled.*- **IsSucceeded** As Boolean [read only]
> *Returns: True if the thread has finished execution. A thread is considered to have finished execution when its run method exits.  
>  This method can be used to check if the asynchronous operation represented by the `Pnd\_OllamaAsyncResult` object has completed successfully.*- **StreamPool** As String [read only]
> *Returns: String associated with this `Pnd\_OllamaAsyncResult` object.  
>  This stream contains the parts of the response that have been received so far.*- **ToString** As String [read only]
> *Returns the complete response as a string, including all parts of the streamed response.  
>  This method is useful when you need to access the entire content of the response after the streaming process has completed.*
> - **Pnd\_OllamaChatMessage**
>
> - **Properties:**
>
> - **Content** As String [read only]
> *Get content of the message.*- **Images** As List [read only]
> *Returns: a List of images associated with the message. Each image is represented as a byte array.*- **Role** As Pnd\_OllamaChatMessageRole [read only]
> *Returns: the role of the message as an Pnd\_OllamaChatMessageRole object.*- **ToolCalls** As List [read only]
> *Returns: a List of OllamaChatToolCalls associated with the message.*- **ToString** As String [read only]
> *Returns: object as string.*
> - **Pnd\_OllamaChatMessageRole**
>
> - **Functions:**
>
> - **ASSISTANT** As io.github.ollama4j.models.chat.OllamaChatMessageRole
> *A role that represents a assistant message.*- **getRole** (roleName As String) As io.github.ollama4j.models.chat.OllamaChatMessageRole
> - **getRoles** (roleName As String) As java.util.List
> - **Initialize**
> - **IsInitialized** As Boolean
> - **newCustomRole** (roleName As String) As io.github.ollama4j.models.chat.OllamaChatMessageRole
> - **SYSTEM** As io.github.ollama4j.models.chat.OllamaChatMessageRole
> *A role that represents a system message.*- **TOOL** As io.github.ollama4j.models.chat.OllamaChatMessageRole
> *A role that represents a tool message.*- **USER** As io.github.ollama4j.models.chat.OllamaChatMessageRole
> *A role that represents a user message.*
> - **Pnd\_OllamaChatRequest**
>
> - **Functions:**
>
> - **Initialize** (Pnd\_OllamaChatRequest As Pnd\_OllamaChatRequest)
> *Initialize the wrapper with an existing Pnd\_OllamaChatRequest object.*- **IsInitialized** As Boolean
> - **isStream** As Boolean
>
> - **Properties:**
>
> - **KeepAlive** As String [read only]
> - **Model** As String [read only]
> - **ReturnFormatJson** As Boolean [read only]
> - **Template** As String [read only]
> - **ToString** As String [read only]
> *Returns: Object as string*
> - **Pnd\_OllamaChatRequestBuilder**
>
> - **Functions:**
>
> - **Build** As Pnd\_OllamaChatRequest
> *Build chat request.*- **Initialize** (ModelName As String) As io.github.ollama4j.models.chat.OllamaChatRequestBuilder
> *Initialize the builder with a model name. This is required to create a valid chat request.*- **IsInitialized** As Boolean
> - **Reset**
> *Reset the builder to its initial state.*- **WithGetJsonResponse** As io.github.ollama4j.models.chat.OllamaChatRequestBuilder
> - **WithKeepAlive** (KeepAlive As String) As io.github.ollama4j.models.chat.OllamaChatRequestBuilder
> - **WithMessage** (role As Pnd\_OllamaChatMessageRole, Content As String) As io.github.ollama4j.models.chat.OllamaChatRequestBuilder
> *Add a message to the chat request.*- **WithMessages** (Messages As java.util.List) As io.github.ollama4j.models.chat.OllamaChatRequestBuilder
> *Add a list of messages to the chat request.*- **WithStreaming** As io.github.ollama4j.models.chat.OllamaChatRequestBuilder
> - **WithTemplate** (Template As String) As io.github.ollama4j.models.chat.OllamaChatRequestBuilder
>
> - **Pnd\_OllamaChatResponseModel**
>
> - **Properties:**
>
> - **Context** As List [read only]
> *Returns: a List that contains the context values integers.*- **CreatedAt** As String [read only]
> - **DoneReason** As String [read only]
> *Returns: A string that indicates the reason why the response is done.*- **Error** As String [read only]
> *Returns: A string that indicates the error message if there is an error in the response.*- **EvalCount** As Int [read only]
> *Returns: an integer that contains the evaluation count.*- **EvalDuration** As Long [read only]
> *Returns: a Long that contains the evaluation duration.*- **IsDone** As Boolean [read only]
> *Returns: A boolean indicating whether the response is done or not.*- **Message** As Pnd\_OllamaChatMessage [read only]
> *Returns: a Pns\_OllamaChatMessage that contains the message object.*- **Model** As String [read only]
> *Returns: The model used for the response.*- **PromptEvalCount** As Int [read only]
> *Returns: an integer that contains the prompt evaluation count.*- **PromptEvalDuration** As Long [read only]
> *Returns: a Long that contains the duration of the prompt evaluation.*- **ToString** As String [read only]
> *Returns: object as string*- **TotalDuration** As Long [read only]
> *Returns: a Long that contains the total duration of the response.*
> - **Pnd\_OllamaChatResult**
>
> - **Functions:**
>
> - **IsInitialized** As Boolean
>
> - **Properties:**
>
> - **ChatHistory** As java.util.List [read only]
> *Get Java list of the chat history from the chat result.  
>  This is used when you want to continue a conversation.  
>  It is a list of OllamaChatMessage objects.*- **ChatHistoryList** As List [read only]
> *ChatHistoryList is B4X List and have same values as ChatHistory.  
>  Returns: a B4X List of the chat history from the chat result.*- **ResponseModel** As Pnd\_OllamaChatResponseModel [read only]
> *Get the response model from the chat result.  
>  This method returns a object that provides access to the underlying Pnd\_OllamaChatResponse.*- **ToString** As String [read only]
> *Get the string representation of the chat result.*
> - **Pnd\_OllamaChatToolCalls**
>
> - **Functions:**
>
> - **toString** As String
> *Returns: the string representation of the Pnd\_OllamaChatToolCalls.*
> - **Properties:**
>
> - **Function** As Pnd\_OllamaToolCallsFunction [read only]
> *Return: an instance of the Pnd\_OllamaToolCallsFunction.*
> - **Pnd\_OllamaEmbedResponseModel**
>
> - **Properties:**
>
> - **Embeddings** As List [read only]
> *Returns a List of embeddings generated by the model. Each embedding is represented as a List of double values.  
>  The number of embeddings returned depends on the number of prompts/inputs provided to the model during evaluation.  
>  This method will return a List containing an List of Double values representing an embedding for each prompt.*- **LoadDuration** As Long [read only]
> *Returns the duration of loading the model in milliseconds.  
>  This value is set when the model is loaded and can be used to measure the performance of the model loading process.*- **Model** As String [read only]
> *Returns the name of the model used for generating the embeddings.*- **PromptEvalCount** As Int [read only]
> *Returns the number of times the prompt was evaluated.  
>  This value is typically set to 1 for a single prompt evaluation, but may be higher if the prompt is evaluated multiple times.*- **ToString** As String [read only]
> *Returns the embeddings generated by the model as string.*- **TotalDuration** As Long [read only]
> *Returns the total duration of the prompt evaluation in milliseconds.  
>  This includes the time taken to load the model and execute the prompt.  
>  Note that this value may vary depending on the hardware and software environment where the code is executed.*
> - **Pnd\_OllamaModelType**
>
> - **Fields:**
>
> - **ALFRED** As String
> - **ALL\_MINILM** As String
> - **BAKLLAVA** As String
> - **CODEBOOGA** As String
> - **CODELLAMA** As String
> - **CODESTRAL** As String
> - **CODEUP** As String
> - **DEEPSEEK\_CODER** As String
> - **DEEPSEEK\_LLM** As String
> - **DOLPHIN\_MISTRAL** As String
> - **DOLPHIN\_MIXTRAL** As String
> - **DOLPHIN\_PHI** As String
> - **DUCKDB\_NSQL** As String
> - **EVERYTHINGLM** As String
> - **FALCON** As String
> - **GEMMA** As String
> - **GEMMA2** As String
> - **GOLIATH** As String
> - **LLAMA2** As String
> - **LLAMA2\_CHINESE** As String
> - **LLAMA2\_UNCENSORED** As String
> - **LLAMA3** As String
> - **LLAMA3\_1** As String
> - **LLAMA\_PRO** As String
> - **LLAVA** As String
> - **LLAVA\_PHI3** As String
> - **MAGICODER** As String
> - **MEDITRON** As String
> - **MEDLLAMA2** As String
> - **MEGADOLPHIN** As String
> - **MISTRAL** As String
> - **MISTRAL\_OPENORCA** As String
> - **MISTRALLITE** As String
> - **MIXTRAL** As String
> - **NEURAL\_CHAT** As String
> - **NEXUSRAVEN** As String
> - **NOMIC\_EMBED\_TEXT** As String
> - **NOTUS** As String
> - **NOTUX** As String
> - **NOUS\_HERMES** As String
> - **NOUS\_HERMES2** As String
> - **NOUS\_HERMES2\_MIXTRAL** As String
> - **OPEN\_ORCA\_PLATYPUS2** As String
> - **OPENCHAT** As String
> - **OPENHERMES** As String
> - **ORCA2** As String
> - **ORCA\_MINI** As String
> - **PHI** As String
> - **PHI3** As String
> - **PHIND\_CODELLAMA** As String
> - **QWEN** As String
> - **QWEN2** As String
> - **SAMANTHA\_MISTRAL** As String
> - **SOLAR** As String
> - **SQLCODER** As String
> - **STABLE\_BELUGA** As String
> - **STABLE\_CODE** As String
> - **STABLELM2** As String
> - **STABLELM\_ZEPHYR** As String
> - **STARCODER** As String
> - **STARLING\_LM** As String
> - **TINYDOLPHIN** As String
> - **TINYLLAMA** As String
> - **VICUNA** As String
> - **WIZARD\_MATH** As String
> - **WIZARD\_VICUNA** As String
> - **WIZARD\_VICUNA\_UNCENSORED** As String
> - **WIZARDCODER** As String
> - **WIZARDLM** As String
> - **WIZARDLM\_UNCENSORED** As String
> - **XWINLM** As String
> - **YARN\_LLAMA2** As String
> - **YARN\_MISTRAL** As String
> - **YI** As String
> - **ZEPHYR** As String
>
> - **Pnd\_OllamaResult**
>
> - **Properties:**
>
> - **HttpStatusCode** As Int [read only]
> *Returns: An integer representing the HTTP status code.*- **Response** As String [read only]
> *Returns: A string representing the response from the API.*- **ResponseTime** As Long [read only]
> *Returns: A long representing the response time in milliseconds.*- **ToString** As String [read only]
> *Returns: A string that represents the object.*
> - **Pnd\_OllamaToolCallsFunction**
>
> - **Properties:**
>
> - **Arguments** As Map [read only]
> *Returns: the arguments of the tool call as a Map.  
>  The keys are the argument names as String and the values are the argument values as Objects of their respective types.*- **Name** As String [read only]
> *Returns: the name*- **ToString** As String [read only]
> *Returns: the string representation of the Pnd\_OllamaToolCallsFunction.*
> - **Pnd\_PromptBuilder**
>
> - **Functions:**
>
> - **Add** (Text As String) As io.github.ollama4j.utils.PromptBuilder
> *Appends the specified text to the prompt.  
>  Text – the text to be added to the prompt.*- **AddLine** (Text As String) As io.github.ollama4j.utils.PromptBuilder
> *Appends the specified text followed by a newline character to the prompt.  
>  Text – the text to be added as a line to the prompt*- **AddSeparator** As io.github.ollama4j.utils.PromptBuilder
> *Appends a separator line to the prompt.  
>  The separator is a newline followed by a line of dashes.*- **Build** As String
> *Builds and returns the final prompt as a string.*- **Initialize**
> *Initializes a the Pnd\_PromptBuilder class.*- **IsInitialized** As Boolean

  
[SIZE=5]**Versions:**[/SIZE]  
  
**v0.17**  

- New methods: GenerateWithImageFiles and GenerateWithImageURLs
- New example apps

  
**v0.18**  

- New class: Pnd\_OllamaEmbedResponseModel
- New method: Embed
- New example app

  
**v0.30**  

- Lots of new classes to support chat feature
- New method: Chat
- Original library update to v1.0.91
- New example apps

  
  
You can also check [B4X AI Assistant](https://www.b4x.com/android/forum/threads/b4x-ai-assistant.165039/#post-1011831) based on this library (including B4J source code).  
  
Wrapper is based on Ollama4j v1.0.91 from [HERE](https://github.com/ollama4j/ollama4j).  
This wrapper is in a **very early stage** of development, but you can try it.  
Download library from: <https://www.dropbox.com/scl/fi/e2wxiuwb3qsq2rkqegdm6/Ollama4jLibrary.zip?rlkey=fneim7i6rct2kzfsq8cvyp919&st=9ly5ihxr&dl=0>