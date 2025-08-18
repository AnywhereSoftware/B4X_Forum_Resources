### [SithasoFaker] Generate massive amounts of fake data for your BANano projects by Mashiane
### 11/15/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/136031/)

Hi there  
  
[Download](https://github.com/Mashiane/SithasoFaker)  
  
As per subject matter, here we have wrapped [faker.js.](https://github.com/marak/Faker.js/)  
  
Supported Locales  

- az
- ar
- cz
- de
- de\_AT
- de\_CH
- en
- en\_AU
- en\_AU\_ocker
- en\_BORK
- en\_CA
- en\_GB
- en\_IE
- en\_IND
- en\_US
- en\_ZA
- es
- es\_MX
- fa
- fi
- fr
- fr\_CA
- fr\_CH
- ge
- hy
- hr
- id\_ID
- it
- ja
- ko
- nb\_NO
- ne
- nl
- nl\_BE
- pl
- pt\_BR
- pt\_PT
- ro
- ru
- sk
- sv
- tr
- uk
- vi
- zh\_CN
- zh\_TW

  
Example usage  
  

```B4X
  Sub BANano_Ready  
    Dim f As SithasoFaker  
    f.Initialize  
    f.locale_Chinese  
    Dim fName As String = f.name.firstName  
    Dim lName As String = f.name.lastName  
    Dim pName As String = f.name.findName(fName, lName)  
    Dim gender As String = f.name.gender  
    Dim street As String = f.address.streetAddress  
    Dim city As String = f.address.city  
    Dim state As String = f.address.stateAbbr  
    Dim zip As String = f.address.zipCode  
    Dim country As String = f.address.country  
    Dim userName As String = f.internet.userName1(fName, lName)  
    Dim phone As String = f.phone.phoneNumber  
    Dim pwd As String = f.internet.password  
    Dim email As String = f.internet.email1(fName, lName)  
    Dim avatar As String = f.internet.avatar  
    Dim price As String = f.commerce.price1(5, 10, 2,"R")  
    Dim past As String = f.date.past(10)  
    Dim future As String = f.date.future(5)  
    Dim btwn As String = f.date.between("2015-01-01", "2015-12-31")  
    Dim msk As String = f.finance.mask  
    Dim msk1 As String = f.finance.mask1(8, True, True)  
    '  
    Log(fName)  
    Log(lName)  
    Log(pName)  
    Log(gender)  
    Log(street)  
    Log(city)  
    Log(state)  
    Log(zip)  
    Log(country)  
    Log(userName)  
    Log(phone)  
    Log(pwd)  
    Log(email)  
    Log(avatar)  
    Log(price)  
    Log(past)  
    Log(future)  
    Log(btwn)  
    Log(msk)  
    Log(msk1)  
    Log(f.finance.mask1(4,False,True))  
    Log(f.finance.mask1(4,True,True))  
    Log(f.finance.mask1(4,True,False))  
    Log(f.finance.amount1(0.10, 5.00, 2,"$"))  
    Log(f.helpers.replaceSymbolWithNumber("###-###-####"))  
    Log(f.helpers.shuffle(Array("apple", "bat", "cat")))  
    Log(f.image.imageUrl1(400, 400, "people"))  
    Log(f.internet.email3("joe", "smith", "gmail.com"))  
    Log(f.internet.password1(10))  
    Log(f.random.arrayElement(Array("one","two","three","four")))  
    Log(f.random.objectElement(CreateMap("one": 1, "two": 2, "three": 3)))  
    Log(f.random.alpha(5))  
    Log(f.random.alphaNumeric(10))  
    End Sub
```

  
  
Output  
  

```B4X
鹏  
叶  
鹏 叶  
Trans Male  
伟诚 街  
锦程汉市  
黔  
476588  
Azerbaijan  
鹏.叶85  
014-12965647  
ZC7bMz_gM46huro  
鹏96@gmail.com  
https://cdn.fakercloud.com/avatars/davidbaldie_128.jpg  
R8.00  
Wed Jan 18 2017 00:11:20 GMT+0200 (South Africa Standard Time)  
Thu Oct 02 2025 00:51:40 GMT+0200 (South Africa Standard Time)  
Mon Nov 09 2015 12:22:26 GMT+0200 (South Africa Standard Time)  
5825  
(…40786276)  
…1617  
(…7854)  
(2963)  
$4.01  
832-713-5396  
Array(3)  
http://placeimg.com/400/400/people  
joe.smith13@gmail.com  
5pDNqdHc7a  
three  
2  
iifum  
lr1tocvdwhcode
```

  
  
Find more details and usage examples from the fakerjs website.