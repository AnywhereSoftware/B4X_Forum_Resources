### BCP-47 Codes for all languages supported by Google's ML Kit by Michael2150
### 06/08/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/141092/)

Throw all of this in a code module and have access to some of the most used BCP-47 language codes.  
  

```B4X
'These codes found here: https://developers.google.com/ml-kit/language/identification/langid-support  
'BCP-47 Codes for all languages supported by Google's ML Kit  
  
Sub Process_Globals  
    Public Const Afrikaans As String = "af"  
    Public Const Amharic As String = "am"  
    Public Const Arabic As String = "ar"  
    Public Const Arabic_Latin As String = "ar-Latn"  
    Public Const Azerbaijani As String = "az"  
    Public Const Belarusian As String = "be"  
    Public Const Bulgarian As String = "bg"  
    Public Const Bulgarian_Latin As String = "bg-Latn"  
    Public Const Bengali As String = "bn"  
    Public Const Bosnian As String = "bs"  
    Public Const Catalan As String = "ca"  
    Public Const Cebuano As String = "ceb"  
    Public Const Corsican As String = "co"  
    Public Const Czech As String = "cs"  
    Public Const Welsh As String = "cy"  
    Public Const Danish As String = "da"  
    Public Const German As String = "de"  
    Public Const Greek As String = "el"  
    Public Const Greek_Latin As String = "el-Latn"  
    Public Const English As String = "en"  
    Public Const Esperanto As String = "eo"  
    Public Const Spanish As String = "es"  
    Public Const Estonian As String = "et"  
    Public Const Basque As String = "eu"  
    Public Const Persian As String = "fa"  
    Public Const Finnish As String = "fi"  
    Public Const Filipino As String = "fil"  
    Public Const French As String = "fr"  
    Public Const Western_Frisian As String = "fy"  
    Public Const Irish As String = "ga"  
    Public Const Scots_Gaelic As String = "gd"  
    Public Const Galician As String = "gl"  
    Public Const Gujarati As String = "gu"  
    Public Const Hausa As String = "ha"  
    Public Const Hawaiian As String = "haw"  
    Public Const Hebrew As String = "he"  
    Public Const Hindi As String = "hi"  
    Public Const Hindi_Latin As String = "hi-Latn"  
    Public Const Hmong As String = "hmn"  
    Public Const Croatian As String = "hr"  
    Public Const Haitian As String = "ht"  
    Public Const Hungarian As String = "hu"  
    Public Const Armenian As String = "hy"  
    Public Const Indonesian As String = "id"  
    Public Const Igbo As String = "ig"  
    Public Const Icelandic As String = "is"  
    Public Const Italian As String = "it"  
    Public Const Japanese As String = "ja"  
    Public Const Japanese_Latin As String = "ja-Latn"  
    Public Const Javanese As String = "jv"  
    Public Const Georgian As String = "ka"  
    Public Const Kazakh As String = "kk"  
    Public Const Khmer As String = "km"  
    Public Const Kannada As String = "kn"  
    Public Const Korean As String = "ko"  
    Public Const Kurdish As String = "ku"  
    Public Const Kyrgyz As String = "ky"  
    Public Const Latin As String = "la"  
    Public Const Luxembourgish As String = "lb"  
    Public Const Lao As String = "lo"  
    Public Const Lithuanian As String = "lt"  
    Public Const Latvian As String = "lv"  
    Public Const Malagasy As String = "mg"  
    Public Const Maori As String = "mi"  
    Public Const Macedonian As String = "mk"  
    Public Const Malayalam As String = "ml"  
    Public Const Mongolian As String = "mn"  
    Public Const Marathi As String = "mr"  
    Public Const Malay As String = "ms"  
    Public Const Maltese As String = "mt"  
    Public Const Burmese As String = "my"  
    Public Const Nepali As String = "ne"  
    Public Const Dutch As String = "nl"  
    Public Const Norwegian As String = "no"  
    Public Const Nyanja As String = "ny"  
    Public Const Punjabi As String = "pa"  
    Public Const Polish As String = "pl"  
    Public Const Pashto As String = "ps"  
    Public Const Portuguese As String = "pt"  
    Public Const Romanian As String = "ro"  
    Public Const Russian As String = "ru"  
    Public Const Russian_Latin As String = "ru-Latn"  
    Public Const Sindhi As String = "sd"  
    Public Const Sinhala As String = "si"  
    Public Const Slovak As String = "sk"  
    Public Const Slovenian As String = "sl"  
    Public Const Samoan As String = "sm"  
    Public Const Shona As String = "sn"  
    Public Const Somali As String = "so"  
    Public Const Albanian As String = "sq"  
    Public Const Serbian As String = "sr"  
    Public Const Sesotho As String = "st"  
    Public Const Sundanese As String = "su"  
    Public Const Swedish As String = "sv"  
    Public Const Swahili As String = "sw"  
    Public Const Tamil As String = "ta"  
    Public Const Telugu As String = "te"  
    Public Const Tajik As String = "tg"  
    Public Const Thai As String = "th"  
    Public Const Turkish As String = "tr"  
    Public Const Ukrainian As String = "uk"  
    Public Const Urdu As String = "ur"  
    Public Const Uzbek As String = "uz"  
    Public Const Vietnamese As String = "vi"  
    Public Const Xhosa As String = "xh"  
    Public Const Yiddish As String = "yi"  
    Public Const Yoruba As String = "yo"  
    Public Const Chinese As String = "zh"  
    Public Const Chinese_Latin As String = "zh-Latn"  
    Public Const Zulu As String = "zu"  
      
    Public Const Script_Latin As String = "Latin"  
    Public Const Script_Geez As String = "Ge'ez"  
    Public Const Script_Arabic As String = "Arabic"  
    Public Const Script_Cyrillic As String = "Cyrillic"  
    Public Const Script_Bengali As String = "Bengali"  
    Public Const Script_Greek As String = "Greek"  
    Public Const Script_Gujarati As String = "Gujarati"  
    Public Const Script_Hebrew As String = "Hebrew"  
    Public Const Script_Devanagari As String = "Devanagari"  
    Public Const Script_Armenian As String = "Armenian"  
    Public Const Script_Japanese As String = "Japanese"  
    Public Const Script_Georgian As String = "Georgian"  
    Public Const Script_Khmer As String = "Khmer"  
    Public Const Script_Kannada As String = "Kannada"  
    Public Const Script_Korean As String = "Korean"  
    Public Const Script_Lao As String = "Lao"  
    Public Const Script_Malayalam As String = "Malayalam"  
    Public Const Script_Myanmar As String = "Myanmar"  
    Public Const Script_Gurmukhi As String = "Gurmukhi"  
    Public Const Script_English As String = "English"  
    Public Const Script_Sinhala As String = "Sinhala"  
    Public Const Script_Tamil As String = "Tamil"  
    Public Const Script_Telugu As String = "Telugu"  
    Public Const Script_Thai As String = "Thai"  
    Public Const Script_Chinese As String = "Chinese"  
  
    Private names As Map  
    Private scripts As Map  
    Private Enabled As Map  
End Sub  
  
Public Sub NamesMap As Map  
    If names.IsInitialized Then Return names  
    names = CreateMap(Afrikaans:"Afrikaans", Amharic:"Amharic", Arabic:"Arabic", Arabic_Latin:"Arabic (Latin)", Azerbaijani:"Azerbaijani", Belarusian:"Belarusian", Bulgarian:"Bulgarian", Bulgarian_Latin:"Bulgarian (Latin)", Bengali:"Bengali", Bosnian:"Bosnian", Catalan:"Catalan", Cebuano:"Cebuano", Corsican:"Corsican", Czech:"Czech", Welsh:"Welsh", Danish:"Danish", German:"German", Greek:"Greek", Greek_Latin:"Greek (Latin)", English:"English", Esperanto:"Esperanto", Spanish:"Spanish", Estonian:"Estonian", Basque:"Basque", Persian:"Persian", Finnish:"Finnish", Filipino:"Filipino", French:"French", Western_Frisian:"Western Frisian", Irish:"Irish", Scots_Gaelic:"Scots Gaelic", Galician:"Galician", Gujarati:"Gujarati", Hausa:"Hausa", Hawaiian:"Hawaiian", Hebrew:"Hebrew", Hindi:"Hindi", Hindi_Latin:"Hindi (Latin)", Hmong:"Hmong", Croatian:"Croatian", Haitian:"Haitian", Hungarian:"Hungarian", Armenian:"Armenian", Indonesian:"Indonesian", Igbo:"Igbo", Icelandic:"Icelandic", Italian:"Italian", Japanese:"Japanese", Japanese_Latin:"Japanese (Latin)", Javanese:"Javanese", Georgian:"Georgian", Kazakh:"Kazakh", Khmer:"Khmer", Kannada:"Kannada", Korean:"Korean", Kurdish:"Kurdish", Kyrgyz:"Kyrgyz", Latin:"Latin", Luxembourgish:"Luxembourgish", Lao:"Lao", Lithuanian:"Lithuanian", Latvian:"Latvian", Malagasy:"Malagasy", Maori:"Maori", Macedonian:"Macedonian", Malayalam:"Malayalam", Mongolian:"Mongolian", Marathi:"Marathi", Malay:"Malay", Maltese:"Maltese", Burmese:"Burmese", Nepali:"Nepali", Dutch:"Dutch", Norwegian:"Norwegian", Nyanja:"Nyanja", Punjabi:"Punjabi", Polish:"Polish", Pashto:"Pashto", Portuguese:"Portuguese", Romanian:"Romanian", Russian:"Russian", Russian_Latin:"Russian (Latin)", Sindhi:"Sindhi", Sinhala:"Sinhala", Slovak:"Slovak", Slovenian:"Slovenian", Samoan:"Samoan", Shona:"Shona", Somali:"Somali", Albanian:"Albanian", Serbian:"Serbian", Sesotho:"Sesotho", Sundanese:"Sundanese", Swedish:"Swedish", Swahili:"Swahili", Tamil:"Tamil", Telugu:"Telugu", Tajik:"Tajik", Thai:"Thai", Turkish:"Turkish", Ukrainian:"Ukrainian", Urdu:"Urdu", Uzbek:"Uzbek", Vietnamese:"Vietnamese", Xhosa:"Xhosa", Yiddish:"Yiddish", Yoruba:"Yoruba", Chinese:"Chinese", Chinese_Latin:"Chinese (Latin)", Zulu:"Zulu")  
    Return names  
End Sub  
Public Sub ToString(Code As String) As String  
    Return NamesMap.Get(Code)  
End Sub  
  
Public Sub ScriptsMap As Map  
    If scripts.IsInitialized Then Return scripts  
    scripts = CreateMap(Afrikaans:Script_Latin, Amharic:Script_Geez, Arabic:Script_Arabic, Arabic_Latin:Script_Latin, Azerbaijani:Script_Latin, Belarusian:Script_Cyrillic, Bulgarian:Script_Cyrillic, Bulgarian_Latin:Script_Latin, Bengali:Script_Bengali, Bosnian:Script_Latin, Catalan:Script_Latin, Cebuano:Script_Latin, Corsican:Script_Latin, Czech:Script_Latin, Welsh:Script_Latin, Danish:Script_Latin, German:Script_Latin, Greek:Script_Greek, Greek_Latin:Script_Latin, English:Script_Latin, Esperanto:Script_Latin, Spanish:Script_Latin, Estonian:Script_Latin, Basque:Script_Latin, Persian:Script_Arabic, Finnish:Script_Latin, Filipino:Script_Latin, French:Script_Latin, Western_Frisian:Script_Latin, Irish:Script_Latin, Scots_Gaelic:Script_Latin, Galician:Script_Latin, Gujarati:Script_Gujarati, Hausa:Script_Latin, Hawaiian:Script_Latin, Hebrew:Script_Hebrew, Hindi:Script_Devanagari, Hindi_Latin:Script_Latin, Hmong:Script_Latin, Croatian:Script_Latin, Haitian:Script_Latin, Hungarian:Script_Latin, Armenian:Script_Armenian, Indonesian:Script_Latin, Igbo:Script_Latin, Icelandic:Script_Latin, Italian:Script_Latin, Japanese:Script_Japanese, Japanese_Latin:Script_Latin, Javanese:Script_Latin, Georgian:Script_Georgian, Kazakh:Script_Cyrillic, Khmer:Script_Khmer, Kannada:Script_Kannada, Korean:Script_Korean, Kurdish:Script_Latin, Kyrgyz:Script_Cyrillic, Latin:Script_Latin, Luxembourgish:Script_Latin, Lao:Script_Lao, Lithuanian:Script_Latin, Latvian:Script_Latin, Malagasy:Script_Latin, Maori:Script_Latin, Macedonian:Script_Cyrillic, Malayalam:Script_Malayalam, Mongolian:Script_Cyrillic, Marathi:Script_Devanagari, Malay:Script_Latin, Maltese:Script_Latin, Burmese:Script_Myanmar, Nepali:Script_Devanagari, Dutch:Script_Latin, Norwegian:Script_Latin, Nyanja:Script_Latin, Punjabi:Script_Gurmukhi, Polish:Script_Latin, Pashto:Script_Arabic, Portuguese:Script_Latin, Romanian:Script_Latin, Russian:Script_Cyrillic, Russian_Latin:Script_English, Sindhi:Script_Arabic, Sinhala:Script_Sinhala, Slovak:Script_Latin, Slovenian:Script_Latin, Samoan:Script_Latin, Shona:Script_Latin, Somali:Script_Latin, Albanian:Script_Latin, Serbian:Script_Cyrillic, Sesotho:Script_Latin, Sundanese:Script_Latin, Swedish:Script_Latin, Swahili:Script_Latin, Tamil:Script_Tamil, Telugu:Script_Telugu, Tajik:Script_Cyrillic, Thai:Script_Thai, Turkish:Script_Latin, Ukrainian:Script_Cyrillic, Urdu:Script_Arabic, Uzbek:Script_Latin, Vietnamese:Script_Latin, Xhosa:Script_Latin, Yiddish:Script_Hebrew, Yoruba:Script_Latin, Chinese:Script_Chinese, Chinese_Latin:Script_Latin, Zulu:Script_Latin)  
    Return scripts  
End Sub  
Public Sub GetScript(Code As String) As String  
    Return ScriptsMap.Get(Code)  
End Sub
```