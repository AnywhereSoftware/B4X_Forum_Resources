### B4X Forum Search Tool - Command Line Search for AI Assistants & Developers by Jack Cole
### 01/04/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/169953/)

I created a simple Node.js tool that searches the B4X forums directly from the command line. It's particularly useful when working with AI coding assistants like Claude Code, Codex CLI, Cursor, or GitHub Copilot - they can search the forums and find solutions without you having to leave your IDE.  
  
**Features:**  
- Direct forum search from terminal  
- Returns thread titles, URLs, authors, dates, and content previews  
- JSON output option for scripting/AI integration  
- Falls back to Google site-search if direct search fails  
  
**Requirements:**  
- Node.js v14+  
  
**Usage:**  

```B4X
# Basic search  
node b4x-search.js "CustomListView example"  
  
# Limit results  
node b4x-search.js "httpjob post json" –limit 5  
  
# JSON output (for AI assistants)  
node b4x-search.js "Firebase Analytics B4A" –json
```

  
  
**Example Output:**  

```B4X
=== B4X Forum Search: 'CustomListView example' ===  
Found 3 results  
  
1. Android Question clv dragging without extra button  
   URL: https://www.b4x.com/android/forum/threads/clv-dragging-without-extra-button.169804/  
   Author: Gfy  
   Preview: I try to implement a function for customlistview to drag items…  
  
2. B4J Library [Class] SelectionListView - drag and drop between 2 clv  
   URL: https://www.b4x.com/android/forum/threads/class-selectionlistview…  
   Author: zed  
   Preview: This class allows you to manage two lists…
```

  
  
**Why I Made This:**  
I use Claude Code (Anthropic's CLI tool) to assist with B4X development. The problem is that AI assistants don't always have built-in knowledge of B4X-specific solutions - things like #AdditionalJar requirements, manifest configurations, or library-specific patterns. With this tool, I can point Claude at the forums and it finds relevant threads automatically.  
  
For example, when I had the "java.time.Duration ClassNotFoundException" crash, Claude used this tool to search the forums and found Erel's responses explaining that B4A doesn't support desugaring and the solution is to raise minSdkVersion to 26.  
  
**GitHub:**  
<https://github.com/jcole75/b4x-search>  
  
The repo includes:  
- b4x-search.js - the search tool  
- README.md - usage documentation  
- CLAUDE.md - instructions for AI assistants  
- agents.md - example AI agent usage patterns  
  
Feel free to use it, fork it, or suggest improvements!  
  
If you use Firebase Crashlytics, you can also use the [MCP server](https://firebase.google.com/docs/crashlytics/ai-assistance-mcp) to automatically pull down crash reports with your agentic coding tool of choice. I recommend giving the tool that link and asking it to set it up for your use case.