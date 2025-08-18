### CovidPass - the reader by drgottjr
### 11/10/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/135795/)

see bottom of this post for "important" update.  
LOOK FURTHER DOWN FOR UPDATED VERSION. MAYBE POST #12  
LOOK EVEN FURTHER DOWN FOR A LITTLE JSON PARSING ROUTINE AND EXPLANATION  
LOOK EVEN FURTHER FURTHER FOR A PARSING CLASS. IN ADDITION TO THE EU GREEN PASS, I'VE ADDED THE FRENCH SANIPASS)  
here's a fun project that cost me several nights' sleep. it reads what i hear is called a covid pass.  
  
my government and many of my fellow citizens don't believe covid is real, so we're not allowed to have any covid-themed artifacts, such as proof one has been vaccinated (against what, right?). but they say other countries have such proofs.  
  
i've tested it with some known, valid covid passes. there are none here, so i'm limited. try it and report back if you like.  
  
a couple notes:  
the library merely decodes the pass. it doesn't verify its validity. you need the public keys for that. and it doesn't generate a fake pass, since you'll only blame me if you're caught counterfeiting them.  
  
i didn't attach a qr code scanner. we have a ton thanks to member schoeman's tireless work. once you have read the qr code, you feed the decoded string to my reader. unzip the attached to your additional libraries folder and add the library to your project. initialize it and call the decodePass() method. it should fit in with any scanner app you've written. just add the decodePass() with what the qr code says you scanned. display the result in a label or - why not - a webview!:)  
  
images of covid qr codes that i found online were mostly bogus. the current version of the decoded string must begin with "HC1:". if you don't see that when you scan the qr code, don't bother with anything else. and even if "HC1:" is there, the code has to have been decoded correctly. i've tried with both google's version of zxing and zxing's own qr code reader. google always came back with something. zxing had some trouble occasionally, but i was scanning images from a browser. so, to be clear, if the decoded qr code returns a string beginning with "HC1:", then you call the decoder, passing the string. that "header" may change or other headers may exists for different types of covid-related digital forms. who knows what condition we'll all be in by that time.  
  
the resultant string comes back to you as a json string (or json-like). i didn't feed it to a json parser, but it certainly looked like json.  
see further down regarding json. it's dealt with in version 0.02, found below. the eu uses json, but the decoder returns the result in a slightly different format.  
  
my interest at this point is hearing if valid passes are successfully decoded. as i said, i have virtually no access to such documents. validation seems pointless unless you're a volunteer covid policeman looking for fake passes. basically, if i see some kind of scannable code, i like to scan it. it's annoying when i can't decode it, like they're trying to keep something from me. if you find a covid pass on the ground, you can decode it with your app and claim your reward. maybe you should wear gloves before picking it up.  
  
the library is govidpass - with a "g". i don't want to be sued by somebody who has copyrighted the word "covid"  
  
update: the library itself is quite small. unfortunately the required dependencies put me over the limit for posting here. if you want a functioning library, download from here: "[MEDIA=googledrive]1K5d6EgEAPY9\_vm7v-mLCUpAS454c8Bp6[/MEDIA]"  
  
(i had to put the url in quotes because something very strange happened, and i couldn't make it go away)  
  
  
there is a readme which basically instructs you to copy the jars to your additional libraries folder and to add some compiler options to your app. (thanks to yiankos1 for the heads up. and apologies for the inconvenience)