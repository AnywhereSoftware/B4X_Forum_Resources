### GitHub API Library by tchart
### 10/27/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/111969/)

This is a work in progress library that wraps the GitHub API for Java library;  
  
<http://github-api.kohsuke.org/>  
  
File is too large to upload so you can download it here;  
  
<https://www.dropbox.com/s/zlrbzugcoe8h37r/github-api.zip?dl=0>  
  
The minimum methods are exposed to;  
  
1. Create a repo  
2. Connect to a repo  
3. Create files in a repo  
4. Update files in a repo  
5. Delete files in a repo  
6. List all repos for the current user  
  
Small example to connect to a repo;  
  

```B4X
Dim hub As githubapi  
    
'hub.Initialize("email","password") 'Use email and password (had mixed luck with this)  
hub.Initialize2("XXX") 'Use oauth token (set up in your github)  
Log(hub.isCredentialValid)  
    
Dim repo As GHRepository  
repo.Initialize  
  
'NB important note you have to fully qualify the repo with your org or user name (this is the same as repo.FullName)  
repo = hub.getRepository(user_or_org_name & "/" & ProjectName)  
    
Log(repo.Name)  
Log(repo.Description)  
Log(repo.FullName)
```

  
  
Once you have a repo you can create files like this;  
  

```B4X
repo.createContent(File.ReadString(File.DirApp,"Somefile.txt"),"CommitMessage","SomeFile.txt")
```

  
  
To update a file you need to get it first;  
  

```B4X
Dim c As GHContent  
c = repo.getFileContent("Somefile.txt")  
  
'if c isnt initialised then the file doesnt exist in github  
  
c.update(File.ReadString(File.DirApp,"Somefile.txt"),"Update")
```

  
  
And to delete a file;  
  

```B4X
Dim c As GHContent  
c = repo.getFileContent("Somefile.txt")  
c.delete("Deleted")
```

  
  
To create a new repo do this;  
  

```B4X
Dim repo As GHRepository  
repo.Initialize  
repo = hub.createRepository(ProjectName,"","",False)
```