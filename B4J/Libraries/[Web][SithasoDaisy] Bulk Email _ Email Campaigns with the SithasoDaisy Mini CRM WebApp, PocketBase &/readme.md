### [Web][SithasoDaisy] Bulk Email / Email Campaigns with the SithasoDaisy Mini CRM WebApp, PocketBase & GMail by Mashiane
### 02/17/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/159322/)

Hi Fam..  
  
With the possibility to add web hooks in PocketBase, one is able without any use of third party email sending applications use STMP configuration. We are currently using GMail and a pocketbase custom hook via HTTP, to send our emails.  
  
In the SithasoDaisy Mini CRM application, one is able to define Email Templates, and then use those email templates to send emails to a variety of configured contacts.  
  
![](https://www.b4x.com/android/forum/attachments/150935)  
  
![](https://www.b4x.com/android/forum/attachments/150936)  
  
When creating an email template, one is able to define "fields" where the information will be merged into, for example, {clientname} etc. Off course this is just specific to this use case, nothing is limited.  
  
![](https://www.b4x.com/android/forum/attachments/150937)  
  
Here we have defined the subject of the email, and using the curly brackets, we are able to indicate what information should be fed where. We can specify the email template as specific to one category of clients or make it an "default" template to send to all contacts in our address book or just the clients who procured that product.  
  
This way, we are able to send bulk email all relevant clients at once in a click of a button.  
  
To get pocketbase working with GMail, one can set it up easily by following [these steps..](https://github.com/pocketbase/pocketbase/discussions/458#discussioncomment-3651995) This is not only limited to GMail and can be used with any SMTP details in your pocketbase setup.  
  
As we are using PocketBase in most of our back-ends, it makes sense for us to have email sending functionality directly in PocketBase. For this we have added a sub in the next release of SithasoDaisy and our other products to do so. You just pass it the **to**, **subject** and **message** prompts and all is taken care of.  
  
So far, we have been able to send..  
  
![](https://www.b4x.com/android/forum/attachments/150938)