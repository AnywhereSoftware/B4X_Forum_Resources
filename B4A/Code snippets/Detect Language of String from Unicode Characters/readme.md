### Detect Language of String from Unicode Characters by epiCode
### 08/21/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/142463/)

Different languages use different Unicode Ranges to display their characters.   
Based on these ranges we can assume the Language/Script of a string.  
  

```B4X
Sub identifyLang(text As String) As String  
      
    Dim lang = "Unknown"  
  
    Dim code As Int = Asc(text)  
  
    Select True  
        Case code >= 0x0000    And code <= 0x007F  
            lang = "English /Basic Latin"  
        Case code >= 0x0080    And code <= 0x00FF  
            lang = "C1 Controls and Latin-1 Supplement"  
        Case code >= 0x0100    And code <= 0x017F  
            lang = "English / Latin Extended-A"  
        Case code >= 0x0180    And code <= 0x024F  
            lang = "English / Latin Extended-B"  
        Case code >= 0x0250    And code <= 0x02AF  
            lang = "IPA Extensions"  
        Case code >= 0x02B0    And code <= 0x02FF  
            lang = "Spacing Modifier Letters"  
        Case code >= 0x0300    And code <= 0x036F  
            lang = "Combining Diacritical Marks"  
        Case code >= 0x0370    And code <= 0x03FF  
            lang = "Greek/Coptic"  
        Case code >= 0x0400    And code <= 0x04FF  
            lang = "Cyrillic"  
        Case code >= 0x0500    And code <= 0x052F  
            lang = "Cyrillic Supplement"  
        Case code >= 0x0530    And code <= 0x058F  
            lang = "Armenian"  
        Case code >= 0x0590    And code <= 0x05FF  
            lang = "Hebrew"  
        Case code >= 0x0600    And code <= 0x06FF  
            lang = "Arabic / Urdu / Persian"  
        Case code >= 0x0700    And code <= 0x074F  
            lang = "Syriac"  
        Case code >= 0x0750    And code <= 0x077F  
            lang = "Undefined"  
        Case code >= 0x0780    And code <= 0x07BF  
            lang = "Thaana"  
        Case code >= 0x07C0    And code <= 0x08FF  
            lang = "Undefined"  
        Case code >= 0x0900    And code <= 0x097F  
            lang = "Hindi / Devanagari"  
        Case code >= 0x0980    And code <= 0x09FF  
            lang = "Bengali/Assamese"  
        Case code >= 0x0A00    And code <= 0x0A7F  
            lang = "Gurmukhi"  
        Case code >= 0x0A80    And code <= 0x0AFF  
            lang = "Gujarati"  
        Case code >= 0x0B00    And code <= 0x0B7F  
            lang = "Oriya"  
        Case code >= 0x0B80    And code <= 0x0BFF  
            lang = "Tamil"  
        Case code >= 0x0C00    And code <= 0x0C7F  
            lang = "Telugu"  
        Case code >= 0x0C80    And code <= 0x0CFF  
            lang = "Kannada"  
        Case code >= 0x0D00    And code <= 0x0DFF  
            lang = "Malayalam"  
        Case code >= 0x0D80    And code <= 0x0DFF  
            lang = "Sinhala"  
        Case code >= 0x0E00    And code <= 0x0E7F  
            lang = "Thai"  
        Case code >= 0x0E80    And code <= 0x0EFF  
            lang = "Lao"  
        Case code >= 0x0F00    And code <= 0x0FFF  
            lang = "Tibetan"  
        Case code >= 0x1000    And code <= 0x109F  
            lang = "Myanmar"  
        Case code >= 0x10A0    And code <= 0x10FF  
            lang = "Georgian"  
        Case code >= 0x1100    And code <= 0x11FF  
            lang = "Hangul Jamo"  
        Case code >= 0x1200    And code <= 0x137F  
            lang = "Ethiopic"  
        Case code >= 0x1380    And code <= 0x139F  
            lang = "Undefined"  
        Case code >= 0x13A0    And code <= 0x13FF  
            lang = "Cherokee"  
        Case code >= 0x1400    And code <= 0x167F  
            lang = "Unified Canadian Aboriginal Syllabics"  
        Case code >= 0x1680    And code <= 0x169F  
            lang = "Ogham"  
        Case code >= 0x16A0    And code <= 0x16FF  
            lang = "Runic"  
        Case code >= 0x1700    And code <= 0x171F  
            lang = "Tagalog"  
        Case code >= 0x1720    And code <= 0x173F  
            lang = "Hanunoo"  
        Case code >= 0x1740    And code <= 0x175F  
            lang = "Buhid"  
        Case code >= 0x1760    And code <= 0x177F  
            lang = "Tagbanwa"  
        Case code >= 0x1780    And code <= 0x17FF  
            lang = "Khmer"  
        Case code >= 0x1800    And code <= 0x18AF  
            lang = "Mongolian"  
        Case code >= 0x18B0    And code <= 0x18FF  
            lang = "Undefined"  
        Case code >= 0x1900    And code <= 0x194F  
            lang = "Limbu"  
        Case code >= 0x1950    And code <= 0x197F  
            lang = "Tai Le"  
        Case code >= 0x1980    And code <= 0x19DF  
            lang = "Undefined"  
        Case code >= 0x19E0    And code <= 0x19FF  
            lang = "Khmer Symbols"  
        Case code >= 0x1A00    And code <= 0x1CFF  
            lang = "Undefined"  
        Case code >= 0x1D00    And code <= 0x1D7F  
            lang = "Phonetic Extensions"  
        Case code >= 0x1D80    And code <= 0x1DFF  
            lang = "Undefined"  
        Case code >= 0x1E00    And code <= 0x1EFF  
            lang = "English / Latin Extended Additional"  
        Case code >= 0x1F00    And code <= 0x1FFF  
            lang = "Greek Extended"  
        Case code >= 0x2000    And code <= 0x206F  
            lang = "General Punctuation"  
        Case code >= 0x2070    And code <= 0x209F  
            lang = "Superscripts and Subscripts"  
        Case code >= 0x20A0    And code <= 0x20CF  
            lang = "Currency Symbols"  
        Case code >= 0x20D0    And code <= 0x20FF  
            lang = "Combining Diacritical Marks for Symbols"  
        Case code >= 0x2100    And code <= 0x214F  
            lang = "Letterlike Symbols"  
        Case code >= 0x2150    And code <= 0x218F  
            lang = "Number Forms"  
        Case code >= 0x2190    And code <= 0x21FF  
            lang = "Arrows"  
        Case code >= 0x2200    And code <= 0x22FF  
            lang = "Mathematical Operators"  
        Case code >= 0x2300    And code <= 0x23FF  
            lang = "Miscellaneous Technical"  
        Case code >= 0x2400    And code <= 0x243F  
            lang = "Control Pictures"  
        Case code >= 0x2440    And code <= 0x245F  
            lang = "Optical Character Recognition"  
        Case code >= 0x2460    And code <= 0x24FF  
            lang = "Enclosed Alphanumerics"  
        Case code >= 0x2500    And code <= 0x257F  
            lang = "Box Drawing"  
        Case code >= 0x2580    And code <= 0x259F  
            lang = "Block Elements"  
        Case code >= 0x25A0    And code <= 0x25FF  
            lang = "Geometric Shapes"  
        Case code >= 0x2600    And code <= 0x26FF  
            lang = "Miscellaneous Symbols"  
        Case code >= 0x2700    And code <= 0x27BF  
            lang = "Dingbats"  
        Case code >= 0x27C0    And code <= 0x27EF  
            lang = "Miscellaneous Mathematical Symbols-A"  
        Case code >= 0x27F0    And code <= 0x27FF  
            lang = "Supplemental Arrows-A"  
        Case code >= 0x2800    And code <= 0x28FF  
            lang = "Braille Patterns"  
        Case code >= 0x2900    And code <= 0x297F  
            lang = "Supplemental Arrows-B"  
        Case code >= 0x2980    And code <= 0x29FF  
            lang = "Miscellaneous Mathematical Symbols-B"  
        Case code >= 0x2A00    And code <= 0x2AFF  
            lang = "Supplemental Mathematical Operators"  
        Case code >= 0x2B00    And code <= 0x2BFF  
            lang = "Miscellaneous Symbols and Arrows"  
        Case code >= 0x2C00    And code <= 0x2E7F  
            lang = "Undefined"  
        Case code >= 0x2E80    And code <= 0x2EFF  
            lang = "CJK Radicals Supplement"  
        Case code >= 0x2F00    And code <= 0x2FDF  
            lang = "Kangxi Radicals"  
        Case code >= 0x2FE0    And code <= 0x2EEF  
            lang = "Undefined"  
        Case code >= 0x2FF0    And code <= 0x2FFF  
            lang = "Ideographic Description Characters"  
        Case code >= 0x3000    And code <= 0x303F  
            lang = "CJK Symbols and Punctuation"  
        Case code >= 0x3040    And code <= 0x309F  
            lang = "Hiragana"  
        Case code >= 0x30A0    And code <= 0x30FF  
            lang = "Katakana"  
        Case code >= 0x3100    And code <= 0x312F  
            lang = "Bopomofo"  
        Case code >= 0x3130    And code <= 0x318F  
            lang = "Hangul Compatibility Jamo"  
        Case code >= 0x3190    And code <= 0x319F  
            lang = "Kanbun (Kunten)"  
        Case code >= 0x31A0    And code <= 0x31BF  
            lang = "Bopomofo Extended"  
        Case code >= 0x31C0    And code <= 0x31EF  
            lang = "Undefined"  
        Case code >= 0x31F0    And code <= 0x31FF  
            lang = "Katakana Phonetic Extensions"  
        Case code >= 0x3200    And code <= 0x32FF  
            lang = "Enclosed CJK Letters and Months"  
        Case code >= 0x3300    And code <= 0x33FF  
            lang = "CJK Compatibility"  
        Case code >= 0x3400    And code <= 0x4DBF  
            lang = "CJK Unified Ideographs Extension A"  
        Case code >= 0x4DC0    And code <= 0x4DFF  
            lang = "Yijing Hexagram Symbols"  
        Case code >= 0x4E00    And code <= 0x9FAF  
            lang = "CJK Unified Ideographs"  
        Case code >= 0x9FB0    And code <= 0x9FFF  
            lang = "Undefined"  
        Case code >= 0xA000    And code <= 0xA48F  
            lang = "Yi Syllables"  
        Case code >= 0xA490    And code <= 0xA4CF  
            lang = "Yi Radicals"  
        Case code >= 0xA4D0    And code <= 0xABFF  
            lang = "Undefined"  
        Case code >= 0xAC00    And code <= 0xD7AF  
            lang = "Hangul Syllables"  
        Case code >= 0xD7B0    And code <= 0xD7FF  
            lang = "Undefined"  
        Case code >= 0xD800    And code <= 0xDBFF  
            lang = "High Surrogate Area"  
        Case code >= 0xDC00    And code <= 0xDFFF  
            lang = "Low Surrogate Area"  
        Case code >= 0xE000    And code <= 0xF8FF  
            lang = "Private Use Area"  
        Case code >= 0xF900    And code <= 0xFAFF  
            lang = "CJK Compatibility Ideographs"  
        Case code >= 0xFB00    And code <= 0xFB4F  
            lang = "Alphabetic Presentation Forms"  
        Case code >= 0xFB50    And code <= 0xFDFF  
            lang = "Arabic Presentation Forms-A"  
        Case code >= 0xFE00    And code <= 0xFE0F  
            lang = "Variation Selectors"  
        Case code >= 0xFE10    And code <= 0xFE1F  
            lang = "Undefined"  
        Case code >= 0xFE20    And code <= 0xFE2F  
            lang = "Combining Half Marks"  
        Case code >= 0xFE30    And code <= 0xFE4F  
            lang = "CJK Compatibility Forms"  
        Case code >= 0xFE50    And code <= 0xFE6F  
            lang = "Small Form Variants"  
        Case code >= 0xFE70    And code <= 0xFEFF  
            lang = "Arabic Presentation Forms-B"  
        Case code >= 0xFF00    And code <= 0xFFEF  
            lang = "Halfwidth and Fullwidth Forms"  
        Case code >= 0xFFF0    And code <= 0xFFFF  
            lang = "Specials"  
        Case code >= 0x10000    And code <= 0x1007F  
            lang = "Linear B Syllabary"  
        Case code >= 0x10080    And code <= 0x100FF  
            lang = "Linear B Ideograms"  
        Case code >= 0x10100    And code <= 0x1013F  
            lang = "Aegean Numbers"  
        Case code >= 0x10140    And code <= 0x102FF  
            lang = "Undefined"  
        Case code >= 0x10300    And code <= 0x1032F  
            lang = "Old Italic"  
        Case code >= 0x10330    And code <= 0x1034F  
            lang = "Gothic"  
        Case code >= 0x10380    And code <= 0x1039F  
            lang = "Ugaritic"  
        Case code >= 0x10400    And code <= 0x1044F  
            lang = "Deseret"  
        Case code >= 0x10450    And code <= 0x1047F  
            lang = "Shavian"  
        Case code >= 0x10480    And code <= 0x104AF  
            lang = "Osmanya"  
        Case code >= 0x104B0    And code <= 0x107FF  
            lang = "Undefined"  
        Case code >= 0x10800    And code <= 0x1083F  
            lang = "Cypriot Syllabary"  
        Case code >= 0x10840    And code <= 0x1CFFF  
            lang = "Undefined"  
        Case code >= 0x1D000    And code <= 0x1D0FF  
            lang = "Byzantine Musical Symbols"  
        Case code >= 0x1D100    And code <= 0x1D1FF  
            lang = "Musical Symbols"  
        Case code >= 0x1D200    And code <= 0x1D2FF  
            lang = "Undefined"  
        Case code >= 0x1D300    And code <= 0x1D35F  
            lang = "Tai Xuan Jing Symbols"  
        Case code >= 0x1D360    And code <= 0x1D3FF  
            lang = "Undefined"  
        Case code >= 0x1D400    And code <= 0x1D7FF  
            lang = "Mathematical Alphanumeric Symbols"  
        Case code >= 0x1D800    And code <= 0x1FFFF  
            lang = "Undefined"  
        Case code >= 0x20000    And code <= 0x2A6DF  
            lang = "CJK Unified Ideographs Extension B"  
        Case code >= 0x2A6E0    And code <= 0x2F7FF  
            lang = "Undefined"  
        Case code >= 0x2F800    And code <= 0x2FA1F  
            lang = "CJK Compatibility Ideographs Supplement"  
        Case code >= 0x2FAB0    And code <= 0xDFFFF  
            lang = "Unused"  
        Case code >= 0xE0000    And code <= 0xE007F  
            lang = "Tags"  
        Case code >= 0xE0080    And code <= 0xE00FF  
            lang = "Unused"  
        Case code >= 0xE0100    And code <= 0xE01EF  
            lang = "Variation Selectors Supplement"  
        Case code >= 0xE01F0    And code <= 0xEFFFF  
            lang = "Unused"  
        Case code >= 0xF0000    And code <= 0xFFFFD  
            lang = "Supplementary Private Use Area-A"  
        Case code >= 0xFFFFE    And code <= 0xFFFFF  
            lang = "Unused"  
        Case code >= 0x100000    And code <= 0x10FFFD  
            lang = "0xSupplementary Private Use Area0x-B"  
    End Select  
  
    Return lang  
End Sub
```

  
  
  
This method will not give correct results when:  
1. Input string is a mix of multiple languages  
2. First character is misleading (Roman Numeral in Arabic Text) (it takes only first character into consideration)