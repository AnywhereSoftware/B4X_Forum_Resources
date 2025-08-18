### In App Billing - steps required in Google Console by Andrew (Digitwell)
### 08/10/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/142244/)

This applies to Google Billing V4.  
  
I was following the tutorial to add in app billing to my app and I found that it would not work in test.  
<https://www.b4x.com/android/forum/threads/googleplaybilling-in-app-purchases.109945/>  
  
This guide is fine, but only covers the coding requirements of  
I did finally get it working, after a number of days, here is what I had to do.  
  
There are a number of things that you have to do in the Google Console before the billing will work correctly.  
  

1. At the top level (All apps) go to License Testing and add email addresses as your testers. These CANNOT be the same as your developer email address.
2. Create your App or select it if already created.
3. Follow the instructions in the dashboard to "Setup your app". I found that I needed to complete all sections apart from the Store Listing.
4. Under Monetize->in app products, create your products. Make sure that you Activate them.
5. Create an Internal Test or Closed testing release.
6. Upload (AAB) and release your app to your testing track.
7. Create a testers list for the release. This should be the same as the emails in the License Testers at the top level.
8. Get the link from the bottom of this page "How testers join your test". Email to testers.
9. The testers must follow the link on the phone and accept the test from link.
10. Wait and then wait some more… It took over 12 hours before all of this was propagated on the Google servers and the app purchases would work.

Note: you do not need to download the version that you used in the test track so you can still run the app in debug mode. I also found that you can update the version name and number from the version uploaded and it still seemed to work in debug.  
  
Before I had followed these steps especially step 10, I was getting "The item you requested is not available for purchase".  
  
I also found that I had to have my email address exactly right, for example, I have an @googlemail.com email address, but I normally can login with @gmail.com with no problem. But to get testing to work, I had to add the @googlemail.com email address to the lists.  
But this may also be that I didn't wait long enough… see point 10.  
  
Large parts taken from this stackoverflow question - <https://stackoverflow.com/questions/71516443/testing-google-play-billing-with-the-item-you-requested-is-not-available-for-pu>  
  
Hope this helps.