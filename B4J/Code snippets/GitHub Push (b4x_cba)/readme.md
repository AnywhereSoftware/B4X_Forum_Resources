### GitHub Push (b4x_cba) by tchart
### 01/22/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165199/)

Read this if you dont know what b4x\_cba is;  
  
<https://www.b4x.com/android/forum/threads/b4x_cba-b4x-custom-build-action.164556/>  
  
The latest version of b4x\_cba introduces an action to push your project code to GitHub.  
  
To get started you will need to  
  
1. Get b4x\_cba installed.  
2. Create a repository on GitHub  
3. Generate an API key (personal access token) on GitHub - I use a classic token  
  
For more on GitHub access tokens see;  
<https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens>  
<https://docs.github.com/en/rest/authentication/authenticating-to-the-rest-api?apiVersion=2022-11-28#authenticating-with-a-personal-access-token)>  
  
In your B4X project add your github config to your project attributes section. The below is from a B4J project. You only need to add; github\_repository\_owner, github\_repository\_name and github\_branch (see example below)  
  

```B4X
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
   
    '###################################################################################  
    ' GitHub Config for b4x_cba.exe  
    ' You will be prompted for API key on first run  
    ' API key is stored in same location as b4x_cba.exe  
    ' .gitignore & .gitattribute files will automatically be created in project folder  
    '###################################################################################  
    'github_repository_owner=githubusername  
    'github_repository_name=RepoName  
    'github_branch=main
```

  
  
To call the action you can use an IDE link such as this;  
  

```B4X
' Ctrl + click to push to GitHub: ide://run?File=b4x_cba.exe&Args=-action&Args=githubpush
```

  
  
Or if you wish to push everytime you make a Release build  
  

```B4X
#CustomBuildAction: 2, b4x_cba.exe, -action githubpush
```

  
  
When the action is called for the first time you will be prompted for your API key. The API key is saved in same location as b4x\_cba.exe in a file named "github\_api\_key.txt"  
  
Notes on behaviour;  
  
1. A .gitignore file will be created in the project folder. This will exclude folders like the Objects folder and the .meta file.  
2. A .gitattributes file will be created in the project folder. This tells GitHub that your project is a B4X project (this uses [USER=74499]@aeric[/USER] format - [see here](https://www.b4x.com/android/forum/threads/b4x-project-template-b4xpages-for-github-upload.162990/#content))  
3. The repo must exist - you can do this on the GitHub website  
4. The branch must exist - you can do this on the GitHub website  
5. Only new or updated files will be uploaded  
6. If there is a file on GitHub that is not in your project it will be deleted from GitHub (these are assumed to be orphans that have been removed from your project)  
7. Local files are never deleted