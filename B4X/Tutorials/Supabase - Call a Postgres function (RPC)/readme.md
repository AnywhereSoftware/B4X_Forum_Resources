###  Supabase - Call a Postgres function (RPC) by Alexander Stolte
### 06/26/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/161815/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
Perform a function call.   
You can call Postgres functions as Remote Procedure Calls, logic in your database that you can execute from anywhere.   
Functions are useful when the logic rarely changes, like for password resets and updates.  
  
Full example with parameters:  

```B4X
create or replace function echo(say text) returns text as $$  
  begin  
    return say;  
  end;  
$$ language plpgsql;
```

  

```B4X
    Dim CallFunction As Supabase_DatabaseRpc = xSupabase.Database.CallFunction  
    CallFunction.Rpc("echo")  
    CallFunction.Parameters(CreateMap("say":"Hello B4X"))  
    Wait For (CallFunction.Execute) Complete (RpcResult As SupabaseRpcResult)  
    If RpcResult.Error.Success Then  
        Log(RpcResult.Data)  
    End If
```

  
  
The return data comes back unformatted as it comes back from the api.  
  
<https://www.restack.io/docs/supabase-knowledge-supabase-rpc-guide>