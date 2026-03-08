### D-PID: Alternative PID algorithm by microfan
### 03/04/2026
[B4X Forum - B4R - Code snippets](https://www.b4x.com/android/forum/threads/170502/)

Maybe someone is interested in this algorithm, which is a kind of PID controller but with better performances.  
  
It is described in great detail in [this document published by Zenodo](https://doi.org/10.5281/zenodo.18241087). It is released under the Creative Commons Attribution Non Commercial Share Alike 4.0 International license, so it can not be used in commercial products.  
  
Another explanation about D-PID is found in my site, <https://linuxfan.altervista.org/pid/4-dpid/>   
  
The algorithm can be tested using a program written just to experiment and study PIDs, described here: <https://linuxfan.altervista.org/pid/the-pidanalyzer-program/>. The program is published on Codeberg, in my repository at <https://codeberg.org/linuxfan/PidAnalyzer>.  
  
  
The thing boils down to this simple code:  
  

```B4X
desslope = (sp - pv) * slope  
realslope = pv - prevpv  
prevpv = pv  
  
out = (desslope - realslope) * hard + out  
if out < -1000 then out = -1000  
if out >  1000 then out = 1000
```

  
  
Where:  
 PV is the process variable  
 SP is the set point  
 slope is a parameter, it controls the slope of the output curve  
 hard is another parameter, it controls the "force" of the PID  
 out is the output of the controller  
  
I've successfully implemented this algorithm using integers (fixed point math) in a real-world application, and it worked well.  
  
I hope this can be useful but I can not make any guarantees about the applicability of this idea, so I decline any responsibility.