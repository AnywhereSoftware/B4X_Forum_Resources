### Cache for WebApp was keeping previous version of .js file - How to fix by hatzisn
### 03/04/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165944/)

This was the first time I faced something like this and it was Chrome's fault. Here is what happened:  
  
I added in a .js file a new javascript function. When I tried to call it, Chrome was saying that the function was not found. Wondering completely what is going on I right clicked on the page and clicked on "inspect". Then I went to look the sources of the page there. To my surprise I noticed that the .js file was in the previous version. I started a new incognito session in chrome and the file was in the current correct version. I was sure it was cache so searching I found this: In order to get the page to start fresh in Chrome, you have to right click the page and select "inspect". With the tools showing you go the the refresh button and right click and select "Empty cache and hard reload". Then everything starts fresh and brand new to the latest versions of the files.