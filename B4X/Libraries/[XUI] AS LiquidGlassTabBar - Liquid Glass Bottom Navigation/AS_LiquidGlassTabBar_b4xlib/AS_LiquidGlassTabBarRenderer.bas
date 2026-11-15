B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'Private, reusable pixel pipeline for the replicated tab bar.
Sub Class_Globals
End Sub

Public Sub Initialize
End Sub

Public Sub Dispose
    #If B4A Or B4J
    Dim native As JavaObject = Me
    native.RunMethod("clearBackdropCaches", Null)
    #End If
End Sub

Public Sub RenderWithLighting(Backdrop As B4XBitmap, Width As Int, Height As Int, Radius As Float, Blur As Int, Refraction As Float, Bevel As Float, Dispersion As Float, Saturation As Float, Tint As Int, Highlight As Float, LightX As Float, LightY As Float, Rim As Float) As B4XBitmap
    #If B4A Or B4J
    Dim native As JavaObject = Me
    Return native.RunMethod("renderBackdrop", Array(Backdrop, Width, Height, Radius, Blur, Refraction, Bevel, Dispersion, Saturation, Tint, Highlight, LightX, LightY, Rim))
    #Else
    Return Backdrop
    #End If
End Sub

#If B4A Or B4J
#If Java
private final BackdropPixels pixels = new BackdropPixels();
public static final class BackdropPixels {
    public void clear(){buffers.clear();shapes.clear();}
    // Three bounded entries cover the bar and the expanded/compact accessory.
    private final java.util.LinkedHashMap<Integer, Buffers> buffers = new java.util.LinkedHashMap<Integer, Buffers>(4,.75f,true){
        @Override protected boolean removeEldestEntry(java.util.Map.Entry<Integer,Buffers> entry){return size()>3;}
    };
    private final java.util.LinkedHashMap<String, Geometry> shapes = new java.util.LinkedHashMap<String, Geometry>(4,.75f,true){
        @Override protected boolean removeEldestEntry(java.util.Map.Entry<String,Geometry> entry){return size()>3;}
    };
    private static final class Buffers {
        final int[] input, horizontal, blurred, output;
        Buffers(int count){input=new int[count];horizontal=new int[count];blurred=new int[count];output=new int[count];}
    }
    private static final class Geometry {
        final int[] center, red, blue;
        final float[] coverage, shine;
        Geometry(int count){center=new int[count];red=new int[count];blue=new int[count];coverage=new float[count];shine=new float[count];}
    }
    private Buffers frame(int count){Buffers value=buffers.get(count);if(value==null){value=new Buffers(count);buffers.put(count,value);}return value;}
    public int[] input(int width,int height){return frame(width*height).input;}
    private static int sample(float x,float y,int width,int height){return Math.max(0,Math.min(height-1,Math.round(y)))*width+Math.max(0,Math.min(width-1,Math.round(x)));}
    private Geometry geometry(int width,int height,float radius,float refraction,float bevel,float dispersion,float highlight,float lightX,float lightY,float rim){
        radius=Math.max(0,Math.min(radius,Math.min(width,height)/2f));bevel=Math.max(1,bevel);
        String key=width+":"+height+":"+radius+":"+refraction+":"+bevel+":"+dispersion+":"+highlight+":"+lightX+":"+lightY+":"+rim;
        Geometry g=shapes.get(key);if(g!=null)return g;
        g=new Geometry(width*height);float hw=width/2f,hh=height/2f,lightLength=Math.max(.001f,(float)Math.sqrt(lightX*lightX+lightY*lightY));
        for(int y=0;y<height;y++)for(int x=0;x<width;x++){
            int index=y*width+x;float px=x+.5f-hw,py=y+.5f-hh,qx=Math.abs(px)-hw+radius,qy=Math.abs(py)-hh+radius;
            float ox=Math.max(qx,0),oy=Math.max(qy,0),length=(float)Math.sqrt(ox*ox+oy*oy),distance=length+Math.min(Math.max(qx,qy),0)-radius;
            float coverage=Math.max(0,Math.min(1,.5f-distance));g.coverage[index]=coverage;if(coverage<=0)continue;
            float nx=0,ny=0;if(length>0){nx=ox/length*(px<0?-1:1);ny=oy/length*(py<0?-1:1);}else if(qx>qy)nx=px<0?-1:1;else ny=py<0?-1:1;
            float depth=Math.max(0,-distance),edge=Math.max(0,1-depth/bevel),displacement=refraction*edge*edge;
            float sx=x-nx*displacement,sy=y-ny*displacement;
            g.center[index]=sample(sx,sy,width,height);
            g.red[index]=dispersion>0&&edge>0?sample(sx-nx*displacement*dispersion,sy-ny*displacement*dispersion,width,height):g.center[index];
            g.blue[index]=dispersion>0&&edge>0?sample(sx+nx*displacement*dispersion,sy+ny*displacement*dispersion,width,height):g.center[index];
            float light=Math.max(0,(nx*lightX+ny*lightY)/lightLength),litEdge=Math.max(0,1-depth/2f),rimEdge=Math.max(0,1-depth/1.5f);
            g.shine[index]=Math.min(1,highlight*light*light*light*litEdge*litEdge+Math.max(0,rim)*rimEdge*rimEdge);
        }
        shapes.put(key,g);return g;
    }
    // Premultiplied sliding-window box pass. Repeated three times for a soft
    // Gaussian approximation instead of the old flat box-shaped text trails.
    private static void box(int[] source,int width,int height,int radius,int[] horizontal,int[] result){
        int count=radius*2+1;
        for(int pass=0;pass<2;pass++){
            int[] input=pass==0?source:horizontal,output=pass==0?horizontal:result;
            int lines=pass==0?height:width,length=pass==0?width:height;
            for(int line=0;line<lines;line++){
                int sa=0,sr=0,sg=0,sb=0;
                for(int k=-radius;k<=radius;k++){int pos=Math.max(0,Math.min(length-1,k)),c=input[pass==0?line*width+pos:pos*width+line],a=c>>>24;sa+=a;sr+=((c>>16)&255)*a;sg+=((c>>8)&255)*a;sb+=(c&255)*a;}
                for(int pos=0;pos<length;pos++){
                    int color=Math.round((float)sa/count)<<24;if(sa>0)color|=Math.round((float)sr/sa)<<16|Math.round((float)sg/sa)<<8|Math.round((float)sb/sa);
                    output[pass==0?line*width+pos:pos*width+line]=color;
                    int oldPos=Math.max(0,Math.min(length-1,pos-radius)),nextPos=Math.max(0,Math.min(length-1,pos+radius+1));
                    int old=input[pass==0?line*width+oldPos:oldPos*width+line],next=input[pass==0?line*width+nextPos:nextPos*width+line],oa=old>>>24,na=next>>>24;
                    sa+=na-oa;sr+=((next>>16)&255)*na-((old>>16)&255)*oa;sg+=((next>>8)&255)*na-((old>>8)&255)*oa;sb+=(next&255)*na-(old&255)*oa;
                }
            }
        }
    }
    private static int channel(float value,float shine){return Math.max(0,Math.min(255,Math.round(value+(255-value)*shine)));}
    private static void boxOpaque(int[] source,int width,int height,int radius,int[] horizontal,int[] result){
        int count=radius*2+1;float inverse=1f/count;
        for(int pass=0;pass<2;pass++){
            int[] input=pass==0?source:horizontal,output=pass==0?horizontal:result;
            int lines=pass==0?height:width,length=pass==0?width:height;
            for(int line=0;line<lines;line++){
                int sr=0,sg=0,sb=0;
                for(int k=-radius;k<=radius;k++){int pos=Math.max(0,Math.min(length-1,k)),c=input[pass==0?line*width+pos:pos*width+line];sr+=(c>>16)&255;sg+=(c>>8)&255;sb+=c&255;}
                for(int pos=0;pos<length;pos++){
                    output[pass==0?line*width+pos:pos*width+line]=0xFF000000|Math.round(sr*inverse)<<16|Math.round(sg*inverse)<<8|Math.round(sb*inverse);
                    int oldPos=Math.max(0,Math.min(length-1,pos-radius)),nextPos=Math.max(0,Math.min(length-1,pos+radius+1));
                    int old=input[pass==0?line*width+oldPos:oldPos*width+line],next=input[pass==0?line*width+nextPos:nextPos*width+line];
                    sr+=((next>>16)&255)-((old>>16)&255);sg+=((next>>8)&255)-((old>>8)&255);sb+=(next&255)-(old&255);
                }
            }
        }
    }
    public int[] render(int[] source,int width,int height,float radius,int blur,float refraction,float bevel,float dispersion,float saturation,int tint,float highlight,float lightX,float lightY,float rim){
        Buffers f=frame(width*height);if(source!=f.input)System.arraycopy(source,0,f.input,0,f.input.length);
        int[] input=f.input;blur=Math.max(0,Math.min(128,blur));float alpha=(tint>>>24)/255f,inverse=1-alpha;
        if(blur>0&&alpha<1){
            boolean opaque=true;for(int c:input)if((c>>>24)!=255){opaque=false;break;}
            if(opaque){boxOpaque(f.input,width,height,blur,f.horizontal,f.blurred);boxOpaque(f.blurred,width,height,blur,f.horizontal,f.input);boxOpaque(f.input,width,height,blur,f.horizontal,f.blurred);}
            else{box(f.input,width,height,blur,f.horizontal,f.blurred);box(f.blurred,width,height,blur,f.horizontal,f.input);box(f.input,width,height,blur,f.horizontal,f.blurred);}
            input=f.blurred;
        }
        Geometry g=geometry(width,height,radius,refraction,bevel,dispersion,highlight,lightX,lightY,rim);
        float tr=((tint>>16)&255)*alpha,tg=((tint>>8)&255)*alpha,tb=(tint&255)*alpha;
        for(int i=0;i<f.output.length;i++){
            float coverage=g.coverage[i];if(coverage<=0){f.output[i]=0;continue;}
            int c=input[g.center[i]];float r=(input[g.red[i]]>>16)&255,green=(c>>8)&255,b=input[g.blue[i]]&255;
            float luminance=r*.2126f+green*.7152f+b*.0722f,shine=g.shine[i];
            int rr=channel((luminance+(r-luminance)*saturation)*inverse+tr,shine);
            int gg=channel((luminance+(green-luminance)*saturation)*inverse+tg,shine);
            int bb=channel((luminance+(b-luminance)*saturation)*inverse+tb,shine);
            f.output[i]=Math.round((c>>>24)*coverage)<<24|rr<<16|gg<<8|bb;
        }
        return f.output;
    }
    public static void resize(int[] source,int sw,int sh,int[] destination,int width,int height){
        if(sw==width&&sh==height){System.arraycopy(source,0,destination,0,destination.length);return;}
        for(int y=0;y<height;y++){
            float sy=Math.max(0,Math.min(sh-1,(y+.5f)*sh/height-.5f));int y0=(int)sy,y1=Math.min(sh-1,y0+1);float fy=sy-y0;
            for(int x=0;x<width;x++){
                float sx=Math.max(0,Math.min(sw-1,(x+.5f)*sw/width-.5f));int x0=(int)sx,x1=Math.min(sw-1,x0+1);float fx=sx-x0;
                int c0=source[y0*sw+x0],c1=source[y0*sw+x1],c2=source[y1*sw+x0],c3=source[y1*sw+x1];
                float w0=(1-fx)*(1-fy),w1=fx*(1-fy),w2=(1-fx)*fy,w3=fx*fy;
                float a0=(c0>>>24)*w0,a1=(c1>>>24)*w1,a2=(c2>>>24)*w2,a3=(c3>>>24)*w3,a=a0+a1+a2+a3;
                if(a<.001f){destination[y*width+x]=0;continue;}
                int r=Math.round((((c0>>16)&255)*a0+((c1>>16)&255)*a1+((c2>>16)&255)*a2+((c3>>16)&255)*a3)/a);
                int g=Math.round((((c0>>8)&255)*a0+((c1>>8)&255)*a1+((c2>>8)&255)*a2+((c3>>8)&255)*a3)/a);
                int b=Math.round(((c0&255)*a0+(c1&255)*a1+(c2&255)*a2+(c3&255)*a3)/a);
                destination[y*width+x]=Math.round(a)<<24|r<<16|g<<8|b;
            }
        }
    }
}
#End If
#End If

#If B4A
#If Java
public synchronized void clearBackdropCaches(){pixels.clear();}
public synchronized android.graphics.Bitmap renderBackdrop(android.graphics.Bitmap source,int width,int height,float radius,int blur,float refraction,float bevel,float dispersion,float saturation,int tint,float highlight,float lightX,float lightY,float rim){
    android.graphics.Bitmap scaled=android.graphics.Bitmap.createScaledBitmap(source,width,height,true);
    int[] input=pixels.input(width,height);scaled.getPixels(input,0,width,0,0,width,height);
    int[] output=pixels.render(input,width,height,radius,blur,refraction,bevel,dispersion,saturation,tint,highlight,lightX,lightY,rim);
    return android.graphics.Bitmap.createBitmap(output,width,height,android.graphics.Bitmap.Config.ARGB_8888);
}
#End If
#End If

#If B4J
#If Java
private int[] original;
public synchronized void clearBackdropCaches(){pixels.clear();original=null;}
public synchronized javafx.scene.image.Image renderBackdrop(javafx.scene.image.Image source,int width,int height,float radius,int blur,float refraction,float bevel,float dispersion,float saturation,int tint,float highlight,float lightX,float lightY,float rim){
    int sw=(int)source.getWidth(),sh=(int)source.getHeight();int[] input=pixels.input(width,height);
    if(sw==width&&sh==height)source.getPixelReader().getPixels(0,0,sw,sh,javafx.scene.image.PixelFormat.getIntArgbInstance(),input,0,sw);
    else{if(original==null||original.length!=sw*sh)original=new int[sw*sh];source.getPixelReader().getPixels(0,0,sw,sh,javafx.scene.image.PixelFormat.getIntArgbInstance(),original,0,sw);BackdropPixels.resize(original,sw,sh,input,width,height);}
    int[] output=pixels.render(input,width,height,radius,blur,refraction,bevel,dispersion,saturation,tint,highlight,lightX,lightY,rim);
    javafx.scene.image.WritableImage bitmap=new javafx.scene.image.WritableImage(width,height);
    bitmap.getPixelWriter().setPixels(0,0,width,height,javafx.scene.image.PixelFormat.getIntArgbInstance(),output,0,width);return bitmap;
}
#End If
#End If
