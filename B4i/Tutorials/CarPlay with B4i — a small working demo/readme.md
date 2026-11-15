### CarPlay with B4i — a small working demo by marcick
### 11/11/2026
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/172535/)

I have been experimenting with CarPlay in B4i and wanted to share a simple working example.  
  
This follows my earlier post about [**integrating Android Auto with B4A**](https://www.b4x.com/android/forum/threads/b4a-and-android-auto-a-small-first-experiment.172437/). I wanted to share the CarPlay experience as well, so anyone interested in supporting both platforms has a starting point for each.  
  
**Please note:** this guide and the demo were prepared with ChatGPT’s help. I followed its instructions, tested the results and requested changes based on what I wanted to achieve. I would struggle to provide technical support for the integration, so if something is unclear or does not work, I suggest asking ChatGPT directly with the relevant code and error messages.  
  
**How CarPlay works**  
  
CarPlay does not mirror the existing iPhone interface. It provides a separate interface on the car display, using Apple’s templates and interaction rules. Depending on the app category, these can include lists, buttons, information panels and navigation interfaces.  
  
Before starting, check whether your intended functionality fits a supported category. You can request the required entitlement using [Apple’s CarPlay application form](https://developer.apple.com/contact/carplay/). Receiving the entitlement does not itself mean your finished app has passed App Review.  
  
**What the demo contains**  
  
The attached **demo.zip** is a minimal B4i project containing the CarPlay configuration, inline Objective-C code to manage the CarPlay scene, and a simple list with a tappable counter.  
  
Select the app on the CarPlay screen and tap the item to update the counter. This demonstrates the basic integration without maps, external SDKs or library patches.  
  
Configure your own Bundle ID, certificate and provisioning profile. The attached version uses:  
  
#Entitlement: <key>com.apple.developer.carplay-maps</key><true/>  
  
This is Apple’s **Navigation entitlement**, matching the profile I used for testing. The demo itself does not implement navigation, and the provisioning profile must include the entitlement declared in the project.  
  
**Testing on a Mac**  
  
Download **CarPlay Simulator** from Apple’s [Additional Tools for Xcode](https://developer.apple.com/download/all/?q=additional+tools+for+xcode). Install the demo on your physical iPhone, connect it to the Mac by USB, then open CarPlay Simulator and connect to the iPhone to display the app.  
  
**Testing in a real car**  
  
The demo can also be tested in a CarPlay-compatible vehicle. Build it in Release mode and install it on an iPhone using a valid development or Ad Hoc provisioning profile that includes the required CarPlay entitlement and the device.  
  
Connect the iPhone to the vehicle through USB or wireless CarPlay, then select the app on the car display. **Uploading it to TestFlight or publishing it on the App Store is not required for this local test.  
  
The Google Navigation / iCore conflict**  
  
In my larger project, I encountered a specific compatibility issue between **Google Navigation SDK for iOS 11.2.0 and B4i’s iCore**.  
  
Both libraries add layout methods to UIView through Objective-C categories. The conflicting selectors are:  
  

```B4X
setLeft:  
setTop:  
setWidth:  
setHeight:
```

  
  
iCore declares these setters with **float parameters**, whereas the Google implementations use **double parameters** in the arm64 library I examined.  
  
Objective-C does not distinguish these methods by their parameter types or category names: they share the same selectors on the same class. Consequently, a call can reach an implementation expecting a different numeric representation. In my tests, this resulted in incorrect view dimensions, including zero-sized controls and an almost blank iPhone interface.  
  
Removing declarations from a header does not remove the implementations already compiled into the library. The experimental workaround was to rename the four conflicting Google setters **and their internal references** in a copy of the SDK, leaving iCore unchanged.  
  
This is a version-specific binary patch, not a general compatibility fix. Future SDK updates would require checking the conflict again and potentially rebuilding the patch. Erel also explained that changing the iCore category is not straightforward because many B4i libraries depend on it.  
  
Hopefully Erel can work one of his miracles in a future B4i update and make this integration possible without patching Google’s SDK! 🙂  
  
**None of this is required for the attached demo:** it uses the native CarPlay framework without Google Navigation or patched libraries.  
  
I hope it saves some time for anyone curious about getting started with CarPlay in B4i.