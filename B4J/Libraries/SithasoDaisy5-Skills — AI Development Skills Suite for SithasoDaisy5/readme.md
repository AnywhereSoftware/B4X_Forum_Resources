### SithasoDaisy5-Skills — AI Development Skills Suite for SithasoDaisy5 by Mashiane
### 10/23/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172352/)

Hi Coders! 👋  
  
I am excited to officially launch **SithasoDaisy5-Skills**, a comprehensive AI agent skill suite designed to supercharge AI coding assistants when building web applications in B4J using **SithasoDaisy5**.  
  
**SithasoDaisy5-Skills** equips AI developer agents with source-grounded knowledge, verified component specs, and strict guardrails so they can generate 100% browser-renderable B4J/BANano code using **DaisyUI v5 + Tailwind CSS v4** design semantics.  
  

---

  
💡 Why Use This Skill Suite?  
  
Without specialized skills, generic LLMs make basic assumptions about web development that break in B4J/BANano. This suite enforces strict guardrails:  

- **100% API Accuracy:** Restricted to verified APIs across **159 component and support module specifications** extracted directly from the framework.
- **Semantic Color Governance:** Prevents hardcoded hex colors (e.g., #1e293b) and enforces semantic tokens like primary, secondary, accent, neutral, info, success, warning, and error where necessary.
- **Strict Lifecycle Rules:** Guarantees proper Sub Show lifecycles starting with BANano.Await(app.ClearPageView) and ending with pgIndex.UpdateTitle.
- **UX & Ergonomics:** Enforces **Fitts's Law**, **Hick's Law**, **WCAG 2.2 AA** contrast, and 4-state UI view coverage (Loading, Populated, Empty, Error).
- **Gated Verification:** Governed by an 8-gate pipeline (**G0 Contract → G8 Delivery**) with automated static, build, runtime, and visual checks.

---

  
🧰 What's Inside the Suite?  
  
The suite consists of **8 specialized skills**:  

1. **sithasodaisy5**: Core domain component composition skill containing 159 reference guides for SDUI5\* UI components and support modules.
2. **sd5-application-planner**: Turns plain-language requests into grounded application plans, page contracts, navigation maps, and acceptance checks before coding.
3. **sd5-project-bootstrap**: Scaffolds greenfield B4J/BANano web projects, setting up pgIndex, page module wiring, and project settings.
4. **sd5-feature-engineer**: Implements traceable B4J/BANano vertical slices based on verified component specs.
5. **sd5-visual-analysis**: Design-to-code forensics that turns screenshots, wireframes, or mockups directly into verified B4J/SDUI5 code.
6. **sd5-web-orchestrator**: Sequencer that runs full greenfield apps through planning, implementation, and quality gates (G0–G8).
7. **sd5-web-verify**: Quality inspection gate that checks for banned raw HTML, missing setters, and missing lifecycle calls before compilation.
8. **sd5-web-regression**: Assesses impact, runs regression checks, and protects existing behavior when refactoring or fixing bugs in existing apps.

---

  
📝 Code Example: Clean B4J Output  
  
We have created our first AI assisted up using these skills, see it here.  
  
<https://www.b4x.com/android/forum/threads/sithasodaisy5-skills-cloud-auth-screen.172350/>  
  
The app created with this code builds this page.  
  
![](https://www.b4x.com/android/forum/attachments/174413)  
  
🚀 Quick Start & Installation  
  
Option 1: Claude Code Plugin Marketplace (Recommended)  
Register the source and install directly in Claude Code:  
  

```B4X
/plugin marketplace add Mashiane/SithasoDaisy5-Skills  
/plugin install sithasodaisy5-skills@sithasodaisy5-skills
```

  
  
Option 2: Git Clone for AI Coding Agents  
Clone directly into your AI agent's skills path:  

- **Claude Code (Project):**

git clone <https://github.com/Mashiane/SithasoDaisy5-Skills.git> .claude/plugins/sithasodaisy5-skills  
  

- **Antigravity / Gemini CLI:**

git clone <https://github.com/Mashiane/SithasoDaisy5-Skills.git> .agents/plugins/sithasodaisy5-skills  
  

- **OpenCode / Codex / Cursor / Windsurf:**

git clone <https://github.com/Mashiane/SithasoDaisy5-Skills.git> .agents/skills/sithasodaisy5  
  

---

  
📦 Source Code & License  

- **Author:** Mashiane
- **Repository:** [GitHub - Mashiane/SithasoDaisy5-Skills](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2FMashiane%2FSithasoDaisy5-Skills)
- **License:** MIT License

Please give it a spin with your favorite AI coding agent and let me know your feedback or suggestions right here in the thread! Happy coding! 🚀  
  
🚀 Would you like me to draft a quick step-by-step tutorial or sample prompt guide that you can attach as a follow-up reply in your forum thread?