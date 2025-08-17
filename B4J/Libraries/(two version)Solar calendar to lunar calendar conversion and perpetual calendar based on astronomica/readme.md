### (two version)Solar calendar to lunar calendar conversion and perpetual calendar based on astronomical algorithms. by icefairy333
### 09/13/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/163061/)

基于天文算法的阳历转阴历，万年历、干支历  
  
This is a packaging based on the open source project tyme4j for convenient use. It uses astronomical algorithms internally and mainly supports the conversion from Gregorian calendar to lunar calendar, Gregorian calendar to Ganzhi calendar, backtracking from Ganzhi calendar to Gregorian calendar, solar term calculation, and Na Yin calculation.  
  
  
这是一款基于开源项目tyme4j的一个封装，方便使用，内部使用天文算法，主要支持公历转农历、公历转干支历、干支历倒查公历、节气计算、纳音计算  
first version：  

```B4X
Dim tyme As tyme4j  
    Log("阳历:"&tyme.TickToDateTime(DateTime.Now))  
    Log("农历:"&tyme.LunarFromYMDH(2024,9,12,15,54,1))  
    Log("干支:"&tyme.GanzhiFromYMDH(2024,9,12,15,54,1))  
    Log("旬空:"&tyme.XunkongFromYMDH(2024,9,12,15,54,1))  
    Log("当前节气:"&tyme.JieqiFromYMDH(2024,9,12,15,54,1).toString)  
    Log("下个节气:"&tyme.JieqiFromYMDH(2024,9,12,15,54,1).NextJieqi.toString)  
    Dim ny(4) As String=Regex.Split(" ",tyme.GanzhiFromYMDH(2024,9,12,15,54,1))  
    For i=0 To 3  
        ny(i)=tyme.GanzhiToNayin2(ny(i))  
    Next  
    
    Log("纳音:"&tyme.ArrayToString(ny," "))  
    Dim tl As Long=DateTime.Now  
    DateTime.DateFormat="yyyy-MM-dd"  
    Log(DateTime.Date(tl)&" "&DateTime.Time(tl))
```

  
  
  

```B4X
阳历:2024-09-12 10:23:58  
农历:农历甲辰年八月初十壬申时  
干支:甲辰 癸酉 己卯 壬申  
旬空:寅卯 戌亥 申酉 戌亥  
当前节气:白露 2024-10-07 03:11:18  
下个节气:秋分 2024-10-22 12:43:39  
纳音:覆灯火 剑锋金 城头土 剑锋金  
2024-09-12 18:23:58
```

  
  
this version(tyme4j) based on ([github.com/6tail/tyme4j](http://github.com/6tail/tyme4j))  
  
second version:  

```B4X
Dim tyme As lunar4j  
    Log("阳历:"&tyme.TickToDateTime(DateTime.Now))  
    Dim lo As Lunar=tyme.LunarFromYMDH(2024,9,12,15,54,1)  
    Log("农历:"&lo.toString)  
    Log("干支:"&tyme.GanzhiFromYMDH(2024,9,12,15,54,1))  
    Log("旬空:"&tyme.XunkongFromYMDH(2024,9,12,15,54,1))  
    Log("当前节气:"&lo.JieQi)  
    Log("下个节气:"&lo.NextJieQi)  
    Dim ny(4) As String=Regex.Split(" ",tyme.GanzhiFromYMDH(2024,9,12,15,54,1))  
    For i=0 To 3  
        ny(i)=tyme.GanzhiToNayin2(ny(i))  
    Next  
    Log("纳音:"&tyme.ArrayToString(ny," "))  
    Dim tl As Long=DateTime.Now  
    DateTime.DateFormat="yyyy-MM-dd"  
    Log(DateTime.Date(tl)&" "&DateTime.Time(tl))
```

  
  

```B4X
阳历:2024-09-13 09:06:46  
农历:二〇二四年八月初十  
干支:甲辰 癸酉 己卯 壬申  
旬空:寅卯 戌亥 申酉 戌亥  
当前节气:白露 2024-09-07 11:11:18  
下个节气:秋分 2024-09-22 20:43:39  
纳音:覆灯火 剑锋金 城头土 剑锋金  
2024-09-13 17:06:46
```

  
this version(lunar4j) is based on [github.com/6tail/lunar-java](http://github.com/6tail/lunar-java)  
  
  
all of them support year:-9999 to 9999