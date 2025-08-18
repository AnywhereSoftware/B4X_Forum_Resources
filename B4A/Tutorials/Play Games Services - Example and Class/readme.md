### Play Games Services - Example and Class by Jack Cole
### 04/02/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/139583/)

Last year, I commissioned [Biswajit](https://www.b4x.com/android/forum/members/biswajit.100215/) to write a library for the new [Google Play Games Services](https://www.b4x.com/android/forum/threads/new-google-play-games-services.128464/) library. To manage the complexity of the code, I wrote a class called GamePlayLeaderboardsAndAchievements. I put together an example app that demonstrates the functionality of the library and class. There is an additional class and code module that is included that might have some things you will find useful (Map\_B4X and ListHelper). Map\_B4X is like an extended version of Erel's [B4XOrderedMap](https://www.b4x.com/android/forum/threads/b4x-b4xcollections-more-collections.101071/#content) class. ListHelper is a code module that has a variety of list functions including mathematical (from calculating the mean or sum of list values to linear regression). It also does things like ListSubtract, which removes the items in the second list from the first list.  
  
**Features of the attached example app:**  

- Sign in and Sign out
- Show normal achievements
- Show incremental type achievements
- Unlock/Reveal normal achievements
- Increment incremental type
- Submit score to a leaderboard
- Show all leaderboards
- Show specific leaderboard

I didn't comprehensively implement every feature that is available–only the features I needed for my apps. Hopefully, others will find this example and class helpful. If you make useful modifications or fix things, please share it back with the community.  
  
**To get the example app working for you, at a minimum, you will need to replace the manifest code that creates the games-ids.xml resource file. You will also need to change the package name in build configurations.**  
  
[MEDIA=youtube]nQ9S\_3eC3kE[/MEDIA]