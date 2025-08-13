###  Supabase - Sign In Anonymously by Alexander Stolte
### 04/17/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/160566/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
Supabase now supports anonymous user login, the B4X library now too.  
<https://supabase.com/blog/anonymous-sign-ins>  
  
**Create and use anonymous users to authenticate with Supabase**  
[Enable Anonymous Sign-Ins](https://supabase.com/dashboard/project/_/settings/auth) to build apps which provide users an authenticated experience without requiring users to enter an email address, password, use an OAuth provider or provide any other PII (Personally Identifiable Information). Later, when ready, the user can link an authentication method to their account.  
  
Anonymous sign-ins can be used to build:  

- E-commerce applications, such as shopping carts before check-out
- Full-feature demos without collecting personal information
- Temporary or throw-away accounts

**Review your existing RLS policies before enabling anonymous sign-ins**  
Anonymous users use the authenticated role. To distinguish between anonymous users and permanent users, your policies need to check the is\_anonymous field of the user's JWT.  
See the [Access control section](https://supabase.com/docs/guides/auth/auth-anonymous#access-control) for more details.  
  
**Abuse prevention and rate limits**  
Since anonymous users are stored in your database, bad actors can abuse the endpoint to increase your database size drastically. It is strongly recommended to [enable invisible Captcha or Cloudflare Turnstile](https://supabase.com/docs/guides/auth/auth-captcha) to prevent abuse for anonymous sign-ins. An IP-based rate limit is enforced at 30 requests per hour which can be modified in your [dashboard](https://supabase.com/dashboard/project/_/auth/rate-limits). You can refer to the full list of rate limits [here](https://supabase.com/docs/guides/platform/going-into-prod#rate-limiting-resource-allocation--abuse-prevention).  
  
More you can read in the official blog post:  
<https://supabase.com/docs/guides/auth/auth-anonymous>  
  

```B4X
    Wait For (xSupabase.Auth.LogIn_Anonymously) Complete (AnonymousUser As SupabaseUser)  
    If AnonymousUser.Error.Success Then  
        Log("Successfully created an anonymous user")  
    Else  
        Log("Error: " & AnonymousUser.Error.ErrorMessage)  
    End If
```