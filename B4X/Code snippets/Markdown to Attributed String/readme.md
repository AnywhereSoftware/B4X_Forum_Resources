###  Markdown to Attributed String by nwhitfield
### 09/11/2019
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/109393/)

As promised, here is the small code module and snippets that I use to turn markdown text stored on my server to attributed strings. This method splits the load between server and client app and is by no means a full Markdown / CommonMark implementation. But for basic headings, unnumbered lists, and emphasis, it does the job. Server side, this is how I prepare an item ( $newsitem['storyText'] is a news item, with markdown formatting; Parsedown is the PHP library I use on the site. Link detection is set up only to work will fully marked up links, ie the [title here](url here) sort)  
  

```B4X
$parser = new Parsedown() ;  
$newsitem['richtext'] = strip_tags($parser->text($newsitem['storyText']),'<b><i><em><strong><li><h1><h2><h3><h4><h5><h6>') ;  
           
// get an array of links and descriptions from the markdown  
$buttons = array() ;  
if ( preg_match_all('/\[([^]]*)\] *\(([^)]*)\)/i',$newsitem['storyText'],$matches,PREG_SET_ORDER) > 0 ) {  
    foreach ( $matches as $match ) {  
        $buttons[] = array( 'title' => $match[1], 'destination' => $match[2]) ;  
    }  
}  
           
if ( count($buttons) > 0 ) {  
    $newsitem['buttons'] = $buttons ;  
}
```

  
  
The data is passed to my app as JSON; so, the news item will be a map, and the 'richtext' key contains stripped down HTML. The buttons key is a list of links found in the text, and their names, which can be added to a menu.  
  
The attached html2cs does the work using CSBuilder; it could probably be tided up a bit and turned into a class. It would also be easy-ish to support other tags, but note that it's quick and dirty and depends on each one having a distinct first character. Using it is very simple; newsBody is a label:  
  

```B4X
html2cs.fontbase = 16  
newsBody.AttributedText = html2cs.formatString(n.Get("richtext"))
```

  
  
As I say, it's a bit quick and dirty, but if you have Markdown/CommonMark formatting on a server and want to use the same data in app, this gives you some basic compatibility, should work on B4A as well, and doesn't require implementing a whole Markdown library within your app.