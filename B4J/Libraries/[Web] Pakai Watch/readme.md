### [Web] Pakai Watch by aeric
### 07/03/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171438/)

[HEADING=1]Pakai Watch — Rate Limiter Filter for Pakai Server[/HEADING]  
Version 0.60  
  
A sliding-window rate limiter for [Pakai Server v6](https://www.b4x.com/android/forum/threads/web-project-template-pakai-server-v6.169224/) / B4J server apps. Drop it in and protect your endpoints from abuse.  
  
GitHub: <https://github.com/pyhoon/pakai-watch>  
  
**[SIZE=4]Features[/SIZE]**  
  

- **Sliding window** — per-client timestamp tracking (configurable per-endpoint)
- **Per-endpoint limits** — different (maxRequests, windowMs) for different URL prefixes
- **Per-key overrides** — boost limits for specific trusted API keys
- **Bearer token auth** — identifies clients via Authorization header, falls back to GUEST-{IP}
- **Cloudflare aware** — reads CF-Connecting-IP header automatically
- **IP whitelist** — loaded from whitelist.txt, supports wildcards (192.168.\*)
- **Security logging** — blocked requests logged to security\_violations.log
- **Daily summaries** — midnight rollover generates daily\_report\_YYYY-MM-DD.txt
- **Retry-After header** — 429 responses include seconds until window reset
- **Thread-safe** — uses java.util.concurrent.locks.ReentrantLock srvr.CreateThreadSafeMap
- **No timer thread** — lazy maintenance runs inline every N requests

  
**[SIZE=4]Quick Start[/SIZE]**  
  

1. Copy **PakaiWatch.b4xlib** to your additional libraries folder and add the library in your project.
2. Add a filter class by selecting Add New Module -> Class Module -> Rate Limiter.
3. Name the class "RateLimiter".
4. Register the filter:

```B4X
App.srvr.AddFilter("/*", "RateLimiter", False)
```

\*note: this library also include a Code Snippet to add this line.5. (Optional) Set per-endpoint limits by adding this function to your main module:

```B4X
Public Sub GetRateLimitConfig As Map  
    Dim Cfg As Map  
    Cfg.Initialize  
  
    ' 5 req per 10s for API  
    Cfg.Put("/api/", Array As Int(5, 10000))  
  
    ' 3 req per 30s for auth  
    Cfg.Put("/auth/", Array As Int(3, 30000))  
  
    ' Per-key overrides (highest priority)  
    Dim KeyLimits As Map  
    KeyLimits.Initialize  
    KeyLimits.Put("trusted-partner-key", Array As Int(100, 60000))  
    Cfg.Put("__key_overrides__", KeyLimits)  
  
    Return Cfg  
End Sub
```


**[SIZE=4]Priority Chain[/SIZE]**  
  
For each request, the applied limit is determined by (highest first):  

1. Key override (matches the Bearer token value)
2. URI pattern (prefix match against the request path)
3. Default (10 req / 10 s)

  
**[SIZE=4]Whitelist[/SIZE]**  
  
A whitelist.txt is created automatically in File.DirApp. One entry per line — exact IP, IP wildcard, or API key:  
  

```B4X
127.0.0.1  
192.168.*  
my-trusted-api-key
```

  
  
Lines starting with # are ignored.  
  
**[SIZE=4]Files[/SIZE]**  
  
[TABLE]  
[TR]  
[TH]File name[/TH]  
[TH]Description[/TH]  
[/TR]  
[TR]  
[TD]whitelist.txt[/TD]  
[TD]IP/API key whitelist[/TD]  
[/TR]  
[TR]  
[TD]security\_violations.log[/TD]  
[TD]Timestamped blocked request log[/TD]  
[/TR]  
[TR]  
[TD]daily\_report\_YYYY-MM-DD.txt[/TD]  
[TD]Block count summary at midnight[/TD]  
[/TR]  
[/TABLE]  
  
—  
  
Feedback, issues, and feature requests welcome!  
  
Post written by DeepSeek v4 Flash Free  
  
Simple Test:  

1. The easiest way is to clone the repo which contains a Pakai server project with example configuration.
2. Just run it as it is.
3. Make sure 127.0.0.1 is not whitelisted in whitelist.txt
4. Login with wrong password for admin.
5. You should see status code 429 and message Too Many Request for POST /login but 200 for GET /login in Chrome Developer Tool.
6. You can also try with the build-in Web API documentation (HelpHandler) - required login.