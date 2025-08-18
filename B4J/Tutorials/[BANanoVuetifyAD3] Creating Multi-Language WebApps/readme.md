### [BANanoVuetifyAD3] Creating Multi-Language WebApps by Mashiane
### 04/23/2022
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/140079/)

Hi there…  
  
With this piece of code…  
  

```B4X
vuetify.AddTranslation("en", "de", "hello", "Hello {name}!", "Guten Tag, {name}!")  
    vuetify.AddTranslation("en", "de", "welcome", "Welcome!", "Willkommen!")  
    vuetify.AddTranslation("en", "de", "yes-button", "Yes", "Ja")  
    vuetify.AddTranslation("en", "de", "no-button", "No", "Nein")
```

  
  
One is able to experience this on the webapps.  
  
![](https://www.b4x.com/android/forum/attachments/128358)  
  
So what happened? We have added i18n on BVAD3 and with the language of choice selected, we change the locale.  
  
On the first paragraph caption property VLabel, we wrote..  
  

```B4X
{{ $t('message.hello', { name: 'BANanoVuetifyAD3'}) }}
```

  
  
The welcome message caption is  
  

```B4X
{{ $t('message.welcome') }}
```

  
  
The Yes button label was set to  
  

```B4X
{{ $t('message.yes-button') }}
```

  
  
and the No button label set to  
  

```B4X
{{ $t('message.no-button') }}
```

  
  
We have a combo to select the language of choice.  
  
We just put a VAutoComplete on a form and set these settings..  
  
![](https://www.b4x.com/android/forum/attachments/128359)  
  
Then trapped the change event in the combobox to change the locale when we need to.  
  

```B4X
Private Sub cboLanguage_Change (item As Object)  
    vuetify.SetLocale(item)  
End Sub
```

  
  
This then changes our UI language to what locate we have chosen.  
  
#Happy BANanoVuetifyAD3 coding.  
  
Perhaps soon, you can just load the translations from an external json file.