### An SSH library courtesy of MS Copilot - B4JSSH - now the Ferrari version by JackKirk
### 04/14/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170667/)

**PREAMBLE**  
  
For some time now I have had a B4J app that manages a number of Netonix (any) and Ubiquiti (USW-FLEX) WISP switches that turn on/off a fleet of high end Hikvision cameras in a remote location.  
  
This app has used the SSHJ library which has worked flawlessly.  
  
I have decided to replace the Netonix switches with Planet (WGS-5225-8UP2SV) switches.  
  
Unfortunately I discovered that SSHJ can't communicate with Planet switches, Copilot's explanation follows:  
  
===========================================  
**Planet Switch SSH Compatibility — Technical Limitation Summary  
Overview**  
Planet‑brand Ethernet switches require an **interactive, PTY‑allocated SSH shell** for authentication and CLI access. Their SSH server does **not** support non‑interactive exec channels for login or command execution.  
**Root Cause**  
The **stock B4J SSHJ library** (as distributed for B4J) only exposes **non‑interactive exec‑style channels** and does **not** provide a mechanism to open a **PTY‑based interactive shell**.  
Planet switches rely on PTY allocation to present their username/password prompts and to maintain an authenticated session.  
**Failure Mode**  
When connecting without a PTY:  

- Planet still emits a Username: prompt
- The switch rejects all submitted credentials
- The login state machine resets
- The session loops indefinitely with repeated Username: prompts
- No CLI prompt (> or #) is ever reached

This behaviour is consistent across all Planet models that use the same SSH daemon.  
**Conclusion  
Planet switches cannot be automated using the stock B4J SSHJ library because the library lacks PTY‑shell support, which Planet requires for interactive authentication and command execution.**  
===========================================  
  
After a fruitless search for an existing solution I decided to have a crack at developing an SSH library with the assistance of Copilot.  
  
This was a two-fold exercise - see what I could really do with Copilot and (if lucky) find a solution.  
  
**[SIZE=5]I FOUND IT!!!!!  
  
EDIT - Check out the [/SIZE]**[**[SIZE=5]Ferrari **Version 1.1**[/SIZE]**](https://www.b4x.com/android/forum/threads/an-ssh-library-courtesy-of-ms-copilot-b4jssh-now-the-ferrari-version.170667/post-1044877)  
  
**[SIZE=5]**EDIT 2 - Check out the** [/SIZE]**[**[SIZE=5]**enhanced error trapping Version 1.2**[/SIZE]**](https://www.b4x.com/android/forum/threads/an-ssh-library-courtesy-of-ms-copilot-b4jssh-now-the-ferrari-version.170667/post-1045109)  
  
**[SIZE=5]**EDIT 3 - Check out the** [/SIZE]**[**[SIZE=5]**m**assively improved Version 3.0****[/SIZE]**](https://www.b4x.com/android/forum/threads/an-ssh-library-courtesy-of-ms-copilot-b4jssh-now-the-ferrari-version.170667/post-1045428)**[SIZE=5] ****by pitting Copilot against Claude****[/SIZE]**