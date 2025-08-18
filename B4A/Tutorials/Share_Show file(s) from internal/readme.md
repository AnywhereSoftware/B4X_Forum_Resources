### Share/Show file(s) from internal by KMatle
### 03/25/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/139378/)

Here's a small example how to show/share file(s) from the internal storage (benefits: no permissions are needed)  
  
What it does:  
  
- creates a folder called "shared" (under File.DirInternal)  
- this foldername has to be defined in the manifest, too  
- after that you handle everything by the filename only (so it must be stored under the given folder. Here it's called "shared")  
- 4 textfiles are created (as an example)  
- almost any other file will do (like pdf's). Here you have to change the mime type of the file and the filename. See the spoiler for the available types.   
  
With the 3 buttons you can  
  
- show the file's contents  
- share a single file (here it's always "1.txt")  
- share multiple files (here I share the complete shared folder)  
  
  
- Android checks if there's an app installed to handle the file(s). To show pdf's you need to have a pdf viewer, for textfiles almost any app will be offered.  
- for multiple files it must be an app which can handle multiple files. E.g. my mail app is offered to share with and the files are attached automatically   
  
  
  
  
 [SPOILER="Mime Types"]  
type=application/octet-stream exts=bin  
type=application/astound exts=asd,asn  
type=application/fastman exts=lcc  
type=application/java-archive exts=jar  
type=application/java-serialized-object exts=ser  
type=application/java-vm exts=class  
type=application/mac-binhex40 exts=hqx  
type=application/x-stuffit exts=sit  
type=application/mbedlet exts=mbd  
type=application/msword exts=doc,dot,wiz,rtf  
type=application/oda exts=oda  
type=application/pdf exts=pdf  
type=application/postscript exts=ai,eps,ps  
type=application/studiom exts=smp  
type=application/timbuktu exts=tbt  
type=application/vnd.ms-excel exts=xls,xlw,xla,xlc,xlm,xlt  
type=application/vnd.ms-powerpoint exts=ppt,pps,pot  
type=application/vnd.ms-project exts=mpp  
type=application/winhlp exts=hlp  
type=application/x-javascript exts=js  
type=application/x-javascript;charset=UTF-8 exts=jsu  
type=application/x-java-jnlp-file exts=jnlp  
type=application/x-aim exts=aim  
type=application/x-asap exts=asp  
type=application/x-csh exts=csh  
type=application/x-dvi exts=dvi  
type=application/x-earthtime exts=etc  
type=application/x-envoy exts=evy  
type=application/x-gtar exts=gtar  
type=application/x-cpio exts=cpio  
type=application/x-hdf exts=hdf  
type=application/x-latex exts=latex  
type=application/x-javascript-config exts=jsc  
type=application/x-maker exts=fm  
type=application/x-mif exts=mif,mi  
type=application/x-mocha exts=mocha,moc  
type=application/x-msaccess exts=mdb  
type=application/x-mscardfile exts=crd  
type=application/x-msclip exts=clp  
type=application/x-msmediaview exts=m13,m14  
type=application/x-msmetafile exts=wmf  
type=application/x-msmoney exts=mny  
type=application/x-mspublisher exts=pub  
type=application/x-msschedule exts=scd  
type=application/x-msterminal exts=trm  
type=application/x-mswrite exts=wri  
type=application/x-NET-Install exts=ins  
type=application/x-netcdf exts=nc,cdf  
type=application/x-ns-proxy-autoconfig exts=proxy  
type=application/x-salsa exts=slc  
type=application/x-sh exts=sh  
type=application/x-shar exts=shar  
type=application/x-sprite exts=spr,sprite  
type=application/x-tar exts=tar  
type=application/x-tcl exts=tcl  
type=application/x-perl exts=pl  
type=application/x-tex exts=tex  
type=application/x-texinfo exts=texinfo,texi  
type=application/x-timbuktu exts=tbp  
type=application/x-tkined exts=tki,tkined  
type=application/x-troff-man exts=man  
type=application/x-troff-me exts=me  
type=application/x-troff-ms exts=ms  
type=application/x-troff exts=t,tr,roff  
type=application/x-wais-source exts=src  
type=application/zip exts=zip  
type=application/pre-encrypted exts=enc  
type=application/x-pkcs7-crl exts=crl  
type=application/x-fortezza-ckl exts=ckl  
type=application/xml-dtd exts=dtd  
  
type=audio/basic exts=au,snd  
type=audio/echospeech exts=es,esl  
type=audio/midi exts=midi,mid  
type=audio/x-aiff exts=aif,aiff,aifc  
type=audio/x-wav exts=wav  
type=audio/x-pn-realaudio exts=ra,ram  
type=audio/x-pac exts=pac  
type=audio/x-epac exts=pae  
type=audio/x-liveaudio exts=lam  
  
type=drawing/x-dwf exts=dwf  
  
type=image/fif exts=fif  
type=image/x-icon exts=ico  
type=image/gif exts=gif  
type=image/ief exts=ief  
type=image/ifs exts=ifs  
type=image/jpeg exts=jpeg,jpg,jpe,jfif,pjpeg,pjp  
type=image/png exts=png  
type=image/tiff exts=tiff,tif  
type=image/vnd exts=dwg,svf  
type=image/wavelet exts=wi  
type=image/bmp exts=bmp  
type=image/x-photo-cd exts=pcd  
type=image/x-cmu-raster exts=ras  
type=image/x-portable-anymap exts=pnm  
type=image/x-portable-bitmap exts=pbm  
type=image/x-portable-graymap exts=pgm  
type=image/x-portable-pixmap exts=ppm  
type=image/x-rgb exts=rgb  
type=image/x-xbitmap exts=xbm  
type=image/x-xpixmap exts=xpm  
type=image/x-xwindowdump exts=xwd  
  
type=text/css exts=css  
  
type=text/html exts=htm,html  
type=text/plain exts=txt  
type=text/richtext exts=rtx  
type=text/tab-separated-values exts=tsv  
type=text/x-setext exts=etx  
type=text/x-speech exts=talk  
type=text/xml exts=xml  
type=text/xul exts=xul  
  
type=video/isivideo exts=fvi  
type=video/mpeg exts=mpeg,mpg,mpe,mpv,vbs,mpegv  
type=video/x-mpeg2 exts=mpv2,mp2v  
type=video/msvideo exts=avi  
type=video/quicktime exts=qt,mov,moov  
type=video/vivo exts=viv,vivo  
type=video/wavelet exts=wv  
type=video/x-sgi-movie exts=movie  
  
type=x-world/x-svr exts=svr  
type=x-world/x-vrml exts=wrl  
type=x-world/x-vrt exts=vrt  
  
type=x-conference/x-cooltalk exts=ice  
  
enc=x-gzip exts=gz  
enc=x-compress exts=z  
enc=x-uuencode exts=uu,uue  
  
type=magnus-internal/imagemap exts=map  
type=magnus-internal/parsed-html exts=shtml  
type=magnus-internal/cgi exts=cgi,exe,bat  
  
type=application/x-x509-ca-cert exts=cacert  
  
type=application/x-x509-server-cert exts=scert  
type=application/x-x509-user-cert exts=ucert  
type=application/x-x509-email-cert exts=ecert  
  
type=application/vnd.sun.xml.writer exts=sxw  
type=application/vnd.sun.xml.writer.template exts=stw  
type=application/vnd.sun.xml.calc exts=sxc  
type=application/vnd.sun.xml.calc.template exts=stc  
type=application/vnd.sun.xml.draw exts=sxd  
type=application/vnd.sun.xml.draw.template exts=std  
type=application/vnd.sun.xml.impress exts=sxi  
type=application/vnd.sun.xml.impress.template exts=sti  
type=application/vnd.sun.xml.writer.global exts=sxg  
type=application/vnd.sun.xml.math exts=sxm  
  
type=application/vnd.stardivision.writer exts=sdw  
type=application/vnd.stardivision.writer-global exts=sgl  
type=application/vnd.stardivision.calc exts=sdc  
type=application/vnd.stardivision.draw exts=sda  
type=application/vnd.stardivision.impress exts=sdd  
type=application/vnd.stardivision.impress-packed exts=sdp  
type=application/vnd.stardivision.math exts=smf,sdf  
type=application/vnd.stardivision.chart exts=sds  
type=application/vnd.stardivision.mail exts=sdm  
[/SPOILER]