###  Tips for AI - Vibe Coding !!!! by Magma
### 03/15/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/170592/)

B4J 10.5 is a fact, and I think Erel should take the next step—we can help him somehow. I've already made some presentations on B4X and AI-powered coding to our Greek Union for Business Programmers… I believe B4X will gain more fans.  
  
After some weeks of many tests and Excellent results - i am here to share some knowledge to all members of forums that will help them go at next level…  
  
First of all I want to check this thread ([USER=75340]@Blueforcer[/USER] gave me great instructions):  
<https://www.b4x.com/android/forum/threads/b4xcopilot-a-i-assistant.161801/page-2#post-1042640>  
  
After a lot of tests and creation of projects - I am sure that… gemini-cli can help you a lot !  
  
I have some tips to share for GEMINI-CLI and specifically for GEMINI.MD - add those lines and you will remember me:  

```B4X
## Project Overview  
…  
- **SQLite**: In the `b4j/yourproject` directory, you'll find all SQLite command-line tools. Use them to export SQLite schemas or work directly on `objects/yourdb.db`—but only after asking me twice if it involves anything beyond reading the schema.  
…  
  
## Using External APIs Instructions  
1. In the `external_api` folder, you'll find plenty of information about the structure of XML and JSON files. PDF, DOC, XLS file can be here.  
2. In the `external_api/examples` folder, you'll find some examples.  
  
## File Handling  
- When adding modules, classes, or handlers, also add them to the project file `yourproject.b4j` in the way B4X (specifically B4J) expects. This allows them to appear in the project with just a refresh, without needing manual imports.  
- Note: When we say "main," we mean `yourproject.b4j`.  
  
## Syntax Error Checking  
- Compile the project after every change using this command:  
"C:\Program Files\Anywhere Software\B4J\B4JBuilder.exe" -Task=Build -BaseFolder="D:\B4J\yourproject\" -Project="yourproject.b4j"  
- If it returns an errorlevel different from 0, review your changes. Ultimately, consult the B4X documentation for correct syntax: [B4X Documentation](https://www.b4x.com/android/documentation.html).
```

  
  
**2nd Step - very semantic - if you are using sqlite database…**  
[Download SQLite CMD Line tools from here](https://sqlite.org/cli.html), unzip them in root folder of project and the gemini-cli will now have the hands to use them !  
  
Also the Syntax Error Checking, give extra hands to your gemini-cli…  
  
For those believe need to pay something… I am gonna say… that gemini cli.. no need a penny (until today) and using it with /auth (Login with Google account) - no need API key !!!  
  
So I hope [USER=1]@Erel[/USER] think next step for an extra window frame in b4j - as i have it as vision here:  
<https://www.b4x.com/android/forum/threads/wish-or-idea-what-do-you-want-to-build-today.169798/>  
  
\* ;-) With 10% from sales, I can be a great consultant!