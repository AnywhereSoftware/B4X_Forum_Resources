### A Hierarchical Class Generator by William Lancee
### 09/21/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/134469/)

If you have a class structure described as follows:  
  

```B4X
    Dim tree As String = _  
        $"  
            PersonHood  
                PersonalInfo  
                    VitalStats  
                        FullName.String  
                        PreferredGender.String  
                        Birthdate.Long  
                    Contact  
                        Address.String  
                        Phones.List  
                        Emails.List  
                    Financial  
                        Incomes.List  
                        Banks.List  
                        CreditCards.List  
                        Assets.List  
                    Employment  
                        Employers.List  
                    History  
                        EducationStages.List  
                        HealthConditions.List  
                        PastEmployements.List  
                        LegalSituations.List  
                LifeRoles  
                    ParentOf.List  
                    SpousePartnerOf.List  
                    SiblingOf.List  
                    ChildOf.List  
        "$
```

  
And you want to be able to do this on all B4X Platforms:  

```B4X
    Dim WiL As clsPersonHood = PersonHood.New(PersonalInfo.New( _  
            VitalStats.New("William Lancee", "Male", DateTime.DateParse("1946-11-19")), _  
            Contact.New("205 XXXXXX St., Toronto, ON, Canada"), _  
            Financial.New, Employment.New, History.New), LifeRoles.New)  
    WiL.Phones.Add("1-(xxx) xxx-xxx1")  
    WiL.Phones.Add("1-(xxx) xxx-xxx2")  
    WiL.Phones.Add("1-(xxx) xxx-xxx3")     
              
    Log(WiL.FullName)                                '    William Lancee  
    Log(WiL.PersonalInfo.FullName)                    '    William Lancee  
    Log(WiL.PersonalInfo.VitalStats.FullName)        '    William Lancee  
      
    WiL.FullName = "WiL"  
    Log(WiL.FullName)                                '    WiL  
    Log(WiL.PersonalInfo.FullName)                    '    WiL  
    Log(WiL.PersonalInfo.VitalStats.FullName)        '    WiL  
      
    WiL.Phones.Add("1-(xxx) xxx-xxx4")  
    Log(WiL.Phones.Get(WiL.Phones.Size - 1))        '    1-(xxx) xxx-xxx4  
    WiL.Phones.RemoveAt(WiL.Phones.Size - 1)  
    Log(WiL.Phones.Get(WiL.Phones.Size - 1))        '    1-(xxx) xxx-xxx3  
  
    Log(DateTime.Date(WiL.Birthdate))                '    1946-11-19                'fake
```

  
You can achieve this manually, but the process has many repetitive parts, and it can be frustrating.  
So here is a 'classGenerator' class that displays the class tree as a graph and generates the necessary classes.  
They are saved in the parent directory of a B4XPages project, so that they can be easily added as Existing Modules.  
The Log will have the two sections that are needed for the B4XMainPage (one in Class\_Global and one in Initialize)  
  
Notes:  
1. You can look at each class and add Class-specific Methods and Delegates to other Methods  
2. You can remove "setters" to make properties read-only (i.e. equivalent to Constants)  
3. You can remove "getters" to limit access to properties  
4. The 'New' Subs takes advantage of the fact that classes can spawn instances of themselves - this avoids endless initializations  
5. The generator class displays class trees in B4J and B4A, but since it accesses the project folder, classes should be generated in B4J  
6. The demo shows a relatively 'Simple' tree, but it generates 8 classes with a total of 582 lines of code  
7. Please use (or not) any or all of these techniques in any way you like.  
  
Comments are welcome.