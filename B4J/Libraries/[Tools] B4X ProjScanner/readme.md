### [Tools] B4X ProjScanner. by LucaMs
### 09/05/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171982/)

<https://www.b4x.com/android/forum/threads/tool-to-summarize-variable-names.171959/post-1051545>  
  
B4X ProjScanner is a lightweight yet useful analysis tool designed to inspect every source file inside a B4X project.  
It supports both classic B4A/B4J/B4i projects and full B4XPages structures, including platform‑specific modules.  
  
The scanner reads and processes all .bas files, project modules, and any linked external source files referenced (linked).  
  
It extracts detailed information such as:  
  
Declared Subs  
Variables (global, local, parameters)  
Constants  
  
File name, line number, scope and parent Sub  
  
It includes a robust statement splitter capable of handling multi‑instruction lines, ensuring accurate parsing even when multiple commands appear on the same line (e.g., Dim A As Int : Dim B As String).  
  
Key Features:  
  
Full support for B4XPages projects (root + platform folders)  
Automatic detection and parsing of linked modules  
Extraction of Subs, variables, parameters, and constants  
Correct handling of multi‑statement lines  
Clean, structured output ready for further processing or display ((with tabs, suitable for Excel)  
  
No dependencies — pure B4X code  
  
This tool is ideal for developers who need to inspect, document, or analyze large B4X projects, refactor code, or build higher‑level utilities such as project explorers, static analyzers, or documentation generators.  
  
![](https://www.b4x.com/android/forum/attachments/173425)  
  
  
![](https://www.b4x.com/android/forum/attachments/173426)