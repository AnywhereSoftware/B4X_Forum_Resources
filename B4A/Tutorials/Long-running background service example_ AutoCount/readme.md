### Long-running background service example: AutoCount by Andris
### 06/05/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/131365/)

In debugging my current app I needed to reset back to basics to debug some code. I ended up creating this simple app which contains all the basics of a long-running background service (taken from [Erel's MyLocation example](https://www.b4x.com/android/forum/threads/background-location-tracking.99873/)). The main activity and the service share data in a Keystore. I'm sharing it because it might be of help to some in demystifying some of the concepts, which can take lots of time at first. Might not be the most elegant way to do this, but at least it works ;). Comments welcome.