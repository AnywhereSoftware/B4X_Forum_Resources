Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'AS_LiquidGlassTabBar - Alexander Stolte
#If Documentation
V1.00
	-Release
#End If

#If B4J
#If Java
private javafx.scene.layout.Pane backdropRoot;
private javafx.animation.AnimationTimer backdropFrames;
private boolean backdropFramesRunning;
public void watchBackdrop(javafx.scene.layout.Pane root){
    unwatchBackdrop();backdropDisposed=false;backdropRoot=root;
    backdropFrames=new javafx.animation.AnimationTimer(){@Override public void handle(long now){runBackdropFrame(root,now);if(now>backdropUntil||!backdropLive||backdropDisposed)stopBackdropFrames();}};
}
private void startBackdropFrames(){if(backdropFrames!=null&&backdropLive&&!backdropDisposed&&!backdropFramesRunning){backdropFramesRunning=true;backdropFrames.start();}}
private void stopBackdropFrames(){if(backdropFrames!=null)backdropFrames.stop();backdropFramesRunning=false;}
public void unwatchBackdrop(){backdropDisposed=true;stopBackdropFrames();backdropFrames=null;backdropRoot=null;}
private static boolean containsBackdropView(javafx.scene.Node root,javafx.scene.Node child){for(javafx.scene.Node p=child;p!=null;p=p.getParent())if(p==root)return true;return false;}

private javafx.scene.control.ScrollPane boundScroll;
private javafx.beans.value.ChangeListener<Number> scrollListener;
public void bindScroll(javafx.scene.Node node){
    unbindScroll();if(!(node instanceof javafx.scene.control.ScrollPane))throw new IllegalArgumentException("BindScrollView expects a ScrollPane");
    boundScroll=(javafx.scene.control.ScrollPane)node;
    scrollListener=(value,oldValue,newValue)->emitScroll();
    boundScroll.vvalueProperty().addListener(scrollListener);emitScroll();
}
private void emitScroll(){if(boundScroll==null)return;noteBackdropMotion();javafx.scene.Node content=boundScroll.getContent();double range=content==null?0:Math.max(0,content.getLayoutBounds().getHeight()-boundScroll.getViewportBounds().getHeight());double span=boundScroll.getVmax()-boundScroll.getVmin();double offset=span==0?0:(boundScroll.getVvalue()-boundScroll.getVmin())/span*range;ba.raiseEventFromUI(boundScroll,"native_scroll",offset);}
public void unbindScroll(){if(boundScroll!=null&&scrollListener!=null)boundScroll.vvalueProperty().removeListener(scrollListener);boundScroll=null;scrollListener=null;}
private javafx.scene.layout.Pane watchedParent;
private javafx.beans.value.ChangeListener<Number> parentListener;
public void watchParent(javafx.scene.layout.Pane pane) {
    unwatchParent(); watchedParent = pane;
    parentListener = new javafx.beans.value.ChangeListener<Number>() {
        @Override public void changed(javafx.beans.value.ObservableValue<? extends Number> value, Number oldValue, Number newValue) {
            ba.raiseEventFromUI(pane,"native_parentresize",pane.getWidth(),pane.getHeight());
        }
    };
    pane.widthProperty().addListener(parentListener);pane.heightProperty().addListener(parentListener);
}
public void unwatchParent() {
    if(watchedParent!=null&&parentListener!=null){watchedParent.widthProperty().removeListener(parentListener);watchedParent.heightProperty().removeListener(parentListener);}
    watchedParent=null;parentListener=null;
}
public boolean actuallyVisible(javafx.scene.Node node){if(node.getScene()==null)return false;for(javafx.scene.Node p=node;p!=null;p=p.getParent())if(!p.isVisible())return false;return true;}
public javafx.scene.image.Image captureRegion(javafx.scene.Node node,float left,float top,float width,float height,int targetWidth,int targetHeight,javafx.scene.Node bar,Object accessory,int background){javafx.scene.Node extra=(javafx.scene.Node)unwrap(accessory);boolean hide=containsBackdropView(node,bar),hideExtra=extra!=null&&containsBackdropView(node,extra);double alpha=bar.getOpacity(),extraAlpha=extra==null?1:extra.getOpacity();try{if(hide)bar.setOpacity(0);if(hideExtra)extra.setOpacity(0);javafx.scene.SnapshotParameters parameters=new javafx.scene.SnapshotParameters();parameters.setFill(javafx.scene.paint.Color.rgb((background>>16)&255,(background>>8)&255,background&255));parameters.setViewport(new javafx.geometry.Rectangle2D(left,top,width,height));return node.snapshot(parameters,null);}finally{if(hide)bar.setOpacity(alpha);if(hideExtra)extra.setOpacity(extraAlpha);}}
public boolean systemDark(javafx.scene.Node node) { return false; }
public Object parentOrNull(javafx.scene.Node node) { return node.getParent(); }
public FxBar createBar(javafx.scene.layout.Pane parent) { FxBar bar=new FxBar();parent.getChildren().add(bar);return bar; }
public class FxBar extends javafx.scene.layout.Pane {
    private final TabEngine engine=new TabEngine(){
        @Override public void selected(int index){layerIndex=-2;render();ba.raiseEventFromUI(FxBar.this,"native_selected",index);}
        @Override public void longPress(int index){ba.raiseEventFromUI(FxBar.this,"native_hold",index);}
    };
    private final javafx.scene.effect.DropShadow shadow=new javafx.scene.effect.DropShadow(6,0,2,javafx.scene.paint.Color.color(0,0,0,.12));
    private final javafx.scene.canvas.Canvas canvas=new javafx.scene.canvas.Canvas();
    private final javafx.scene.canvas.Canvas layer=new javafx.scene.canvas.Canvas();
    private final javafx.scene.SnapshotParameters layerSnapshot=new javafx.scene.SnapshotParameters();
    private int[] materialPixels;
    private int materialHash;
    private final javafx.scene.image.ImageView lens=new javafx.scene.image.ImageView();
    private final javafx.scene.shape.Rectangle lensClip=new javafx.scene.shape.Rectangle();
    private final javafx.scene.effect.FloatMap field=new javafx.scene.effect.FloatMap(64,32);
    private final javafx.scene.effect.DisplacementMap refraction=new javafx.scene.effect.DisplacementMap(field);
    private final javafx.animation.AnimationTimer clock;
    private String[] titles=new String[0]; private Object[] badges=new Object[0];private javafx.scene.image.Image[] icons=new javafx.scene.image.Image[0];
    private javafx.scene.image.Image material,texture;private boolean dark,disposed,running;private int tint,layerIndex=-2;private float lastCollapse=-1;private long previous;
    FxBar(){
        getChildren().addAll(canvas,lens);canvas.setMouseTransparent(true);lens.setMouseTransparent(true);lens.setClip(lensClip);lens.setPreserveRatio(false);lens.setEffect(refraction);
        setFocusTraversable(true);setAccessibleRole(javafx.scene.AccessibleRole.TAB_PANE);
        for(int y=0;y<32;y++)for(int x=0;x<64;x++){float px=(x+.5f)/64-.5f,py=(y+.5f)/32-.5f;float length=(float)Math.sqrt(px*px+py*py);float edge=Math.max(0,(length-.25f)/.25f);field.setSamples(x,y,length==0?0:px/length*edge*edge,length==0?0:py/length*edge*edge);}
        clock=new javafx.animation.AnimationTimer(){@Override public void handle(long now){if(disposed){stop();return;}float dt=previous==0?.016f:(now-previous)/1000000000f;previous=now;boolean active=engine.tick(dt,now/1000000);render();if(!active){stop();running=false;previous=0;}}};
        setOnMousePressed(e->{boolean was=engine.minimized;if(engine.press((float)e.getX(),(float)e.getY(),System.nanoTime()/1000000)){if(was&&!engine.minimized)ba.raiseEventFromUI(this,"native_expanded");requestFocus();startFrames();e.consume();}});
        setOnMouseDragged(e->{if(engine.down){engine.move((float)e.getX(),(float)e.getY(),System.nanoTime()/1000000);startFrames();e.consume();}});
        setOnMouseReleased(e->{if(engine.down){engine.release((float)e.getX(),(float)e.getY());startFrames();e.consume();}});
        focusedProperty().addListener((value,oldValue,newValue)->{if(!newValue&&engine.down){engine.cancel();startFrames();}});
        sceneProperty().addListener((value,oldValue,newValue)->{if(newValue==null){engine.cancel();clock.stop();running=false;}else startFrames();});
        setOnKeyPressed(e->{int step=e.getCode()==javafx.scene.input.KeyCode.LEFT?-1:e.getCode()==javafx.scene.input.KeyCode.RIGHT?1:0;if(e.getCode()==javafx.scene.input.KeyCode.ESCAPE){cancelGesture();e.consume();return;}if(step==0)return;int i=engine.selected+step;while(i>=0&&i<engine.enabled.length){if(engine.enabled[i]){selectTab(i);ba.raiseEventFromUI(this,"native_selected",i);break;}i+=step;}e.consume();});
    }
    private final java.util.List<AccessibleTab> accessibleTabs=new java.util.ArrayList<>();
    private class AccessibleTab extends javafx.scene.layout.Region {
        private final int index;
        AccessibleTab(int i,String title,boolean enabled){index=i;setManaged(false);setMouseTransparent(true);setFocusTraversable(enabled);setDisable(!enabled);setAccessibleRole(javafx.scene.AccessibleRole.TAB_ITEM);setAccessibleText(title);setOpacity(.001);setOnKeyPressed(event->{if(event.getCode()==javafx.scene.input.KeyCode.ENTER||event.getCode()==javafx.scene.input.KeyCode.SPACE){activate();event.consume();}});}
        private void activate(){if(index<engine.enabled.length&&engine.enabled[index]){if(engine.minimized&&index!=engine.searchIndex){engine.setMinimized(false);ba.raiseEventFromUI(FxBar.this,"native_expanded");}selectTab(index);ba.raiseEventFromUI(FxBar.this,"native_selected",index);}}
        @Override public Object queryAccessibleAttribute(javafx.scene.AccessibleAttribute attribute,Object... parameters){if(attribute==javafx.scene.AccessibleAttribute.SELECTED)return engine.selected==index;return super.queryAccessibleAttribute(attribute,parameters);}
        @Override public void executeAccessibleAction(javafx.scene.AccessibleAction action,Object... parameters){if(action==javafx.scene.AccessibleAction.FIRE){activate();return;}super.executeAccessibleAction(action,parameters);}
    }
    private void rebuildAccessibleTabs(String[] labels,boolean[] enabled){getChildren().removeAll(accessibleTabs);accessibleTabs.clear();for(int i=0;i<labels.length;i++){AccessibleTab tab=new AccessibleTab(i,labels[i],enabled[i]);accessibleTabs.add(tab);getChildren().add(tab);}}
    private void layoutAccessibleTabs(){for(int i=0;i<accessibleTabs.size();i++){AccessibleTab tab=accessibleTabs.get(i);tab.setVisible(engine.visibleTab(i));double w=engine.minimized&&i!=engine.searchIndex?64*engine.density:engine.tabWidth(i);tab.resizeRelocate(engine.displayCenter(i)-w/2,engine.top(),w,engine.barHeight());tab.setAccessibleText(titles[i]+(badges[i] instanceof String&&!((String)badges[i]).isEmpty()?", "+badges[i]:""));tab.notifyAccessibleAttributeChanged(javafx.scene.AccessibleAttribute.SELECTED);}}

    private javafx.scene.paint.Color color(int c){return javafx.scene.paint.Color.rgb((c>>16)&255,(c>>8)&255,c&255,(c>>>24)/255.0);}
    private javafx.scene.image.Image tinted(javafx.scene.image.Image image,int color){
        if(image==null)return null;int w=(int)image.getWidth(),h=(int)image.getHeight();javafx.scene.image.WritableImage result=new javafx.scene.image.WritableImage(w,h);
        javafx.scene.image.PixelReader reader=image.getPixelReader();for(int y=0;y<h;y++)for(int x=0;x<w;x++){int a=reader.getArgb(x,y)>>>24;result.getPixelWriter().setArgb(x,y,(color&0xffffff)|((a*(color>>>24)/255)<<24));}return result;
    }
    public void configure(String[] labels,Object[] images,Object[] badgeValues,boolean[] enabled,int selected,boolean darkMode,int color,Object bitmap,float density){
        titles=labels.clone();badges=badgeValues.clone();rebuildAccessibleTabs(labels,enabled);icons=new javafx.scene.image.Image[images.length];for(int i=0;i<images.length;i++)icons[i]=(javafx.scene.image.Image)unwrap(images[i]);
        material=(javafx.scene.image.Image)unwrap(bitmap);dark=darkMode;tint=color;engine.density=density;engine.width=(float)getWidth();engine.height=(float)getHeight();engine.configure(enabled,selected);layerIndex=-2;render();
    }
    public void updateMaterial(Object bitmap){javafx.scene.image.Image next=(javafx.scene.image.Image)unwrap(bitmap);int hash=0;if(next!=null){int w=(int)next.getWidth(),h=(int)next.getHeight();if(materialPixels==null||materialPixels.length!=w*h)materialPixels=new int[w*h];next.getPixelReader().getPixels(0,0,w,h,javafx.scene.image.PixelFormat.getIntArgbInstance(),materialPixels,0,w);hash=31*java.util.Arrays.hashCode(materialPixels)+w*17+h;}if(material!=null&&next!=null&&hash==materialHash)return;material=next;materialHash=hash;layerIndex=-2;noteBackdropMotion();render();}
    public void resizeBar(float w,float h){setPrefSize(w,h);resize(w,h);canvas.setWidth(w);canvas.setHeight(h);engine.width=w;engine.height=h;engine.target=engine.center(engine.selected);if(!engine.down)engine.x=engine.target;layerIndex=-2;render();}
    public void selectTab(int index){if(index<0||index>=engine.enabled.length||!engine.enabled[index])return;engine.cancel();engine.selected=index;engine.hover=index;engine.target=engine.center(index);layerIndex=-2;startFrames();}
    private boolean platformReduceMotion(){return false;}
    public void setCustomWidth(float width){engine.customWidth=Math.max(0,width);engine.target=engine.center(engine.selected);layerIndex=-2;startFrames();}
    public void setOptions(int search,boolean minimized,boolean reduceMotion){engine.searchIndex=search;engine.reduceMotion=reduceMotion||platformReduceMotion();engine.setMinimized(minimized);layerIndex=-2;startFrames();}
    public void setMinimized(boolean value){engine.setMinimized(value);layerIndex=-2;startFrames();}
    public void cancelGesture(){engine.cancel();startFrames();}
    public void disposeBar(){disposed=true;clock.stop();running=false;getChildren().clear();lens.setImage(null);canvas.setWidth(0);canvas.setHeight(0);layer.setWidth(0);layer.setHeight(0);texture=material=null;materialPixels=null;accessibleTabs.clear();}
    private void startFrames(){if(!running&&!disposed){running=true;previous=0;clock.start();}}
    private void rebuild(){
        int index=engine.down?engine.hover:engine.selected;int w=(int)Math.ceil(getWidth()),h=(int)Math.ceil(getHeight());if(w<1||h<1)return;
        if(texture!=null&&texture.getWidth()==w&&texture.getHeight()==h&&layerIndex==index&&lastCollapse==engine.collapse)return;
        if(layer.getWidth()!=w)layer.setWidth(w);if(layer.getHeight()!=h)layer.setHeight(h);javafx.scene.canvas.GraphicsContext g=layer.getGraphicsContext2D();g.clearRect(0,0,w,h);float d=engine.density;
        double left=engine.left(),top=engine.top(),bw=engine.barWidth(),bh=engine.barHeight();
        g.save();g.beginPath();g.moveTo(left+bh/2,top);g.arcTo(left+bw,top,left+bw,top+bh,bh/2);g.arcTo(left+bw,top+bh,left,top+bh,bh/2);g.arcTo(left,top+bh,left,top,bh/2);g.arcTo(left,top,left+bw,top,bh/2);g.closePath();g.clip();
        if(material!=null)g.drawImage(material,left,top,engine.width-32*d,bh);else{g.setFill(color(dark?0xE628282C:0xE6F5F5F7));g.fillRoundRect(left,top,bw,bh,bh,bh);}
        g.restore();
        if(engine.searchIndex>=0){g.save();g.beginPath();g.arc(engine.searchLeft()+32*d,top+32*d,32*d,32*d,0,360);g.closePath();g.clip();if(material!=null)g.drawImage(material,left,top,engine.width-32*d,bh);else{g.setFill(color(dark?0xE628282C:0xE6F5F5F7));g.fillOval(engine.searchLeft(),top,64*d,64*d);}g.restore();}
        g.setFont(javafx.scene.text.Font.font("System",javafx.scene.text.FontWeight.MEDIUM,10*d));g.setTextAlign(javafx.scene.text.TextAlignment.CENTER);
        for(int i=0;i<titles.length;i++){
            if(!engine.visibleTab(i))continue;float center=engine.displayCenter(i);int c=i==index?tint:(dark?0xFFD1D1D6:0xFF636366);if(!engine.enabled[i])c=(c&0xffffff)|0x55000000;
            javafx.scene.image.Image image=tinted(icons[i],c);if(image!=null)g.drawImage(image,center-12*d,top+10*d,24*d,24*d);
            g.setFill(color(c));g.fillText(titles[i],center,top+49*d,Math.max(1,engine.tabWidth(i)-8*d));
            if(badges[i]!=null){String badge=String.valueOf(badges[i]);double bx=center+12*d,by=top+9*d,badgeWidth=badge.isEmpty()?7*d:Math.max(16*d,(badge.length()*6+8)*d);g.setFill(color(0xFFFF3B30));g.fillRoundRect(bx-badgeWidth/2,by-7*d,badgeWidth,(badge.isEmpty()?7:14)*d,16*d,16*d);if(!badge.isEmpty()){g.setFill(javafx.scene.paint.Color.WHITE);g.fillText(badge,bx,by+3*d);}}
        }
        layerSnapshot.setFill(javafx.scene.paint.Color.TRANSPARENT);javafx.scene.image.WritableImage reuse=texture instanceof javafx.scene.image.WritableImage&&texture.getWidth()==w&&texture.getHeight()==h?(javafx.scene.image.WritableImage)texture:null;texture=layer.snapshot(layerSnapshot,reuse);layerIndex=index;lastCollapse=engine.collapse;
    }
    private void render(){
        if(disposed||getWidth()<1||getHeight()<1)return;rebuild();if(texture==null)return;javafx.scene.canvas.GraphicsContext g=canvas.getGraphicsContext2D();g.clearRect(0,0,canvas.getWidth(),canvas.getHeight());
        float d=engine.density;double cy=engine.top()+engine.barHeight()/2;
        shadow.setRadius(6*d);shadow.setOffsetY(2*d);g.setEffect(shadow);g.drawImage(texture,0,0);g.setEffect(null);
        if(engine.selected<0){lens.setVisible(false);return;}
        double lensX=engine.selected==engine.searchIndex&&!engine.down?engine.center(engine.selected):engine.x+(engine.displayCenter(engine.selected)-engine.center(engine.selected));
        double w=engine.lensWidth(),h=engine.lensHeight(),left=lensX-w/2,top=cy-h/2;
        g.setFill(color(dark?0x26FFFFFF:0x14000000));g.fillRoundRect(left,top,w,h,h,h);
        lens.setVisible(engine.pressure>.005f);
        if(lens.isVisible()){
            double zoom=1+.14*Math.max(0,engine.pressure),vw=Math.min(texture.getWidth(),w/zoom),vh=Math.min(texture.getHeight(),h/zoom);
            double vx=Math.max(0,Math.min(texture.getWidth()-vw,engine.x-vw/2)),vy=Math.max(0,Math.min(texture.getHeight()-vh,cy-vh/2));
            lens.setImage(texture);lens.setViewport(new javafx.geometry.Rectangle2D(vx,vy,vw,vh));lens.setFitWidth(w);lens.setFitHeight(h);lens.relocate(left,top);
            lensClip.setWidth(w);lensClip.setHeight(h);lensClip.setArcWidth(h);lensClip.setArcHeight(h);refraction.setScaleX(.035*Math.max(0,engine.pressure));refraction.setScaleY(.035*Math.max(0,engine.pressure));
        }
        layoutAccessibleTabs();
    }
}
#End If
#End If

#If B4A OR B4J
#If Java
private static Object unwrap(Object value) {
    return value instanceof anywheresoftware.b4a.AbsObjectWrapper ? ((anywheresoftware.b4a.AbsObjectWrapper)value).getObject() : value;
}
private boolean backdropLive,backdropInFrame,backdropDisposed;
private long backdropUntil,backdropLastFrame,backdropFrameCount,backdropTotalNanos,backdropMaxNanos;
private int backdropInterval=16;
public void setBackdropOptions(boolean live,int interval){backdropLive=live;backdropInterval=Math.max(16,interval);if(live)noteBackdropMotion();else stopBackdropFrames();}
public void noteBackdropMotion(){backdropUntil=System.nanoTime()+200000000L;startBackdropFrames();}
public boolean isBackdropMotionActive(){return backdropLive&&System.nanoTime()<backdropUntil;}
public long[] backdropStats(){return new long[]{backdropFrameCount,backdropTotalNanos,backdropMaxNanos};}
private void runBackdropFrame(Object sender,long now){
    if(!backdropLive||backdropDisposed||backdropInFrame||now>backdropUntil||now-backdropLastFrame<backdropInterval*1000000L)return;
    backdropLastFrame=now;backdropInFrame=true;long started=System.nanoTime();
    // This callback already runs on the UI frame. Posting it would sample the
    // scene one frame late and make moving text slip underneath the glass.
    try{ba.raiseEvent(sender,"native_backdropframe");}
    finally{long duration=System.nanoTime()-started;backdropTotalNanos+=duration;backdropMaxNanos=Math.max(backdropMaxNanos,duration);backdropFrameCount++;backdropInFrame=false;}
}

// Shared state machine: speculative drag never commits a page until release.
public static abstract class TabEngine {
    public int selected = -1, hover = -1, origin = -1;
    public boolean[] enabled = new boolean[0];
    public boolean down, dragging, held, reduceMotion, minimized;
    public int searchIndex = -1;
    public float collapse, collapseVelocity, customWidth;
    private boolean expanding;
    public int regularCount() { return enabled.length - (searchIndex >= 0 && searchIndex < enabled.length ? 1 : 0); }
    public float searchLeft() { return width - 80f * density; }
    public float regularWidth() { return Math.max(1f, width - 32f*density - (searchIndex >= 0 ? 76f*density : customWidth)); }
    public float tabLeft(int index) { return index == searchIndex ? searchLeft() : left() + rank(index) * cell(); }
    public float tabWidth(int index) { return index == searchIndex ? 64f*density : cell(); }
    private int rank(int index) { return index - (searchIndex >= 0 && index > searchIndex ? 1 : 0); }
    public int hit(float px, float py) {
        if (py < top() || py > top()+barHeight()) return -1;
        if (searchIndex >= 0 && px >= searchLeft() && px <= searchLeft()+64*density) return searchIndex;
        if (px < left() || px > left()+barWidth()) return -1;
        if (minimized) return selected == searchIndex ? firstRegular() : selected;
        for(int i=0;i<enabled.length;i++) if(i!=searchIndex && px>=tabLeft(i) && px<=tabLeft(i)+cell()) return i;
        return -1;
    }
    public int firstRegular() { for(int i=0;i<enabled.length;i++)if(i!=searchIndex&&enabled[i])return i;return -1; }
    public void setMinimized(boolean value) { cancel(); minimized=value; target=center(selected); }
    public boolean visibleTab(int index) { return !minimized || index==searchIndex || index==(selected==searchIndex?firstRegular():selected); }
    public float displayCenter(int index) {
        if(index==searchIndex)return searchLeft()+32*density;
        return left()+barWidth()*.5f+(center(index)-(left()+regularWidth()*.5f))*(1-collapse);
    }
    public float width, height, density = 1f, x, velocity, target, pressure, pressureVelocity;
    public float downX, downY, pointerX, pointerY;
    private long downTime;
    private boolean holdSent;
    public abstract void selected(int index);
    public abstract void longPress(int index);
    public void configure(boolean[] flags, int index) {
        cancel(); enabled = flags.clone();if(searchIndex>=enabled.length)searchIndex=-1; selected = index;
        if (selected < 0 || selected >= enabled.length || !enabled[selected]) selected = firstRegular();
        if(selected<0&&searchIndex>=0&&enabled[searchIndex])selected=searchIndex;
        hover = selected; target = center(selected); x = target; velocity = 0;
    }
    public float left() { return 16f * density; }
    public float top() { return Math.max(0f, height - 72f * density); }
    public float barWidth() { return regularWidth()*(1-collapse)+64*density*collapse; }
    public float barHeight() { return Math.min(64f * density, height); }
    public float cell() { return regularWidth() / Math.max(1, regularCount()); }
    public float center(int index) { return index==searchIndex ? searchLeft()+32*density : left()+(Math.max(0,rank(index))+.5f)*cell(); }
    public int nearest(float px) {
        int result = -1; float distance = Float.MAX_VALUE;
        for (int i = 0; i < enabled.length; i++) if (enabled[i] && i != searchIndex) {
            float d = Math.abs(center(i) - px);
            if (d < distance) { result = i; distance = d; }
        }
        return result;
    }
    public boolean press(float px, float py, long now) {
        int hit = hit(px,py);
        if (hit < 0 || !enabled[hit]) return false;
        expanding = minimized && hit != searchIndex;
        if(expanding) minimized=false;
        down = true; dragging = held = holdSent = false; origin = selected;
        downX = pointerX = px; downY = pointerY = py; downTime = now;
        hover = hit; target = center(hover);
        return hover >= 0;
    }
    public void move(float px, float py, long now) {
        if (!down) return;
        pointerX = px; pointerY = py;
        if (Math.abs(px - downX) > 5 * density || Math.abs(py - downY) > 5 * density) dragging = true;
        if (dragging || held) {
            if(originSearch()) { hover=searchIndex; target=center(searchIndex); return; }
            float min = Float.MAX_VALUE, max = -Float.MAX_VALUE;
            for(int i=0;i<enabled.length;i++)if(i!=searchIndex){min=Math.min(min,center(i));max=Math.max(max,center(i));}
            target = px < min ? min - rubber(min - px) : px > max ? max + rubber(px - max) : px;
            hover = nearest(px);
        }
    }
    private boolean originSearch() { return downX>=searchLeft() && searchIndex>=0; }
    private float rubber(float distance) { return 22f * density * distance / (distance + 60f * density); }
    public void release(float px, float py) {
        if (!down) return;
        boolean valid = py >= top() - 28 * density && py <= top() + barHeight() + 28 * density
            && px >= left() - 28 * density && px <= width - 16*density + 28*density;
        int commit = -1;
        if(valid) {
            if(originSearch()) { if(px>=searchLeft()-12*density&&px<=searchLeft()+76*density)commit=searchIndex; }
            else if(px<=left()+regularWidth()+12*density)commit=nearest(px);
        }
        if(expanding&&!dragging){commit=-1;expanding=false;}
        down = dragging = held = false;
        if (commit >= 0) { selected = commit; hover = commit; selected(commit); }
        else { selected = origin; hover = selected; }
        target = center(selected);
    }
    public void cancel() {
        if (down) selected = origin;
        down = dragging = held = holdSent = false; hover = selected; target = center(selected);
    }
    public boolean tick(float seconds, long now) {
        if (down && now - downTime >= 120) held = true;
        if (down && held) move(pointerX, pointerY, now);
        if (down && !holdSent && now - downTime >= 450) {
            holdSent = true;
            if (hover >= 0) longPress(hover);
        }
        float desired = down && (held || dragging) ? 1f : 0f;
        float collapsed = minimized ? 1f : 0f;
        float dt = Math.max(.001f, Math.min(.032f, seconds));
        if (reduceMotion) { x = target; velocity = 0; pressure = desired; pressureVelocity = 0; collapse=collapsed;collapseVelocity=0; }
        else {
            int steps = 4; float step = dt / steps;
            for (int i = 0; i < steps; i++) {
                collapseVelocity += ((collapsed-collapse)*430f-collapseVelocity*32f)*step;
                collapse += collapseVelocity*step;
                velocity += ((target - x) * 430f - velocity * 32f) * step; x += velocity * step;
                pressureVelocity += ((desired - pressure) * 380f - pressureVelocity * 28f) * step; pressure += pressureVelocity * step;
            }
        }
        if (!down && Math.abs(collapse-collapsed)<.001f && Math.abs(collapseVelocity)<.01f && Math.abs(x - target) < .04f && Math.abs(velocity) < .1f && Math.abs(pressure) < .001f && Math.abs(pressureVelocity) < .01f) {
            x = target; collapse=collapsed; collapseVelocity=velocity=pressure=pressureVelocity=0; return false;
        }
        return true;
    }
    public float lensWidth() { return Math.max(1f, (hover==searchIndex || selected==searchIndex && !down ? 64f*density : cell()*(1-collapse)+64*density*collapse) - 8f * density + Math.max(0, pressure) * 12f * density + Math.min(12f * density, Math.abs(velocity) * .012f)); }
    public float lensHeight() { return Math.max(1f, barHeight() - 8f * density + Math.max(0, pressure) * 6f * density); }
}
#End If
#End If

#If B4A
#If Java
private android.view.View backdropRoot;
private android.view.ViewTreeObserver backdropObserver;
private android.view.ViewTreeObserver.OnPreDrawListener backdropListener;
private android.view.View.OnAttachStateChangeListener backdropAttach;
private android.view.Choreographer.FrameCallback backdropClock;
private boolean backdropClockPending;
private long backdropFrameTime;
public void watchBackdrop(android.view.View root){
    unwatchBackdrop();backdropDisposed=false;backdropRoot=root;
    backdropFrameTime=0;
    backdropClock=new android.view.Choreographer.FrameCallback(){@Override public void doFrame(long now){backdropClockPending=false;backdropFrameTime=now;if(backdropLive&&!backdropDisposed&&System.nanoTime()<backdropUntil){backdropClockPending=true;android.view.Choreographer.getInstance().postFrameCallback(this);}}};
    backdropListener=new android.view.ViewTreeObserver.OnPreDrawListener(){@Override public boolean onPreDraw(){runBackdropFrame(root,backdropFrameTime>0?backdropFrameTime:System.nanoTime());return true;}};
    backdropAttach=new android.view.View.OnAttachStateChangeListener(){
        @Override public void onViewAttachedToWindow(android.view.View view){attachBackdropObserver();}
        @Override public void onViewDetachedFromWindow(android.view.View view){detachBackdropObserver();}
    };
    root.addOnAttachStateChangeListener(backdropAttach);attachBackdropObserver();
}
private void attachBackdropObserver(){detachBackdropObserver();if(backdropRoot!=null&&backdropListener!=null){backdropObserver=backdropRoot.getViewTreeObserver();backdropObserver.addOnPreDrawListener(backdropListener);}}
private void detachBackdropObserver(){if(backdropObserver!=null&&backdropObserver.isAlive()&&backdropListener!=null)backdropObserver.removeOnPreDrawListener(backdropListener);backdropObserver=null;}
public void unwatchBackdrop(){backdropDisposed=true;stopBackdropFrames();detachBackdropObserver();if(backdropRoot!=null&&backdropAttach!=null)backdropRoot.removeOnAttachStateChangeListener(backdropAttach);backdropRoot=null;backdropAttach=null;backdropListener=null;backdropClock=null;}
private void startBackdropFrames(){if(backdropRoot!=null&&backdropLive&&!backdropDisposed){backdropRoot.postInvalidateOnAnimation();if(!backdropClockPending&&backdropClock!=null){backdropClockPending=true;android.view.Choreographer.getInstance().postFrameCallback(backdropClock);}}}
private void stopBackdropFrames(){if(backdropClockPending&&backdropClock!=null)android.view.Choreographer.getInstance().removeFrameCallback(backdropClock);backdropClockPending=false;}
private static boolean containsBackdropView(android.view.View root,android.view.View child){for(android.view.View p=child;p!=null;){if(p==root)return true;android.view.ViewParent parent=p.getParent();p=parent instanceof android.view.View?(android.view.View)parent:null;}return false;}

private android.view.View boundScroll;
private android.view.ViewTreeObserver.OnScrollChangedListener scrollListener;
public void bindScroll(android.view.View view){
    unbindScroll();boundScroll=view;
    scrollListener=new android.view.ViewTreeObserver.OnScrollChangedListener(){@Override public void onScrollChanged(){if(boundScroll!=null){noteBackdropMotion();ba.raiseEventFromUI(boundScroll,"native_scroll",(double)boundScroll.getScrollY());}}};
    view.getViewTreeObserver().addOnScrollChangedListener(scrollListener);
    ba.raiseEventFromUI(view,"native_scroll",(double)view.getScrollY());
}
public void unbindScroll(){if(boundScroll!=null&&scrollListener!=null&&boundScroll.getViewTreeObserver().isAlive())boundScroll.getViewTreeObserver().removeOnScrollChangedListener(scrollListener);boundScroll=null;scrollListener=null;}
private android.view.View watchedParent;
private android.view.View.OnLayoutChangeListener parentListener;
public void watchParent(android.view.View view) {
    unwatchParent(); watchedParent = view;
    parentListener = new android.view.View.OnLayoutChangeListener() {
        @Override public void onLayoutChange(android.view.View v,int l,int t,int r,int b,int ol,int ot,int or,int ob) {
            if (r-l != or-ol || b-t != ob-ot) ba.raiseEventFromUI(v,"native_parentresize",(double)(r-l),(double)(b-t));
        }
    };
    view.addOnLayoutChangeListener(parentListener);
}
public void unwatchParent() {
    if (watchedParent != null && parentListener != null) watchedParent.removeOnLayoutChangeListener(parentListener);
    watchedParent = null; parentListener = null;
}
public boolean actuallyVisible(android.view.View view){return view.isShown();}
public android.graphics.Bitmap captureRegion(android.view.View view,float left,float top,float width,float height,int targetWidth,int targetHeight,android.view.View bar,Object accessory,int background){android.view.View extra=(android.view.View)unwrap(accessory);boolean hide=containsBackdropView(view,bar),hideExtra=extra!=null&&containsBackdropView(view,extra);float alpha=bar.getAlpha(),extraAlpha=extra==null?1:extra.getAlpha();try{if(hide)bar.setAlpha(0);if(hideExtra)extra.setAlpha(0);android.graphics.Bitmap result=android.graphics.Bitmap.createBitmap(targetWidth,targetHeight,android.graphics.Bitmap.Config.ARGB_8888);android.graphics.Canvas canvas=new android.graphics.Canvas(result);canvas.drawColor(background);canvas.scale(targetWidth/width,targetHeight/height);canvas.translate(-left,-top);view.draw(canvas);return result;}finally{if(hide)bar.setAlpha(alpha);if(hideExtra)extra.setAlpha(extraAlpha);}}
public boolean systemDark(android.view.View view) { return (view.getResources().getConfiguration().uiMode & 0x30) == 0x20; }
public Object parentOrNull(android.view.View view) { Object parent=view.getParent();return parent instanceof android.view.View?parent:null; }
public AndroidBar createBar(android.view.ViewGroup parent) {
    AndroidBar bar = new AndroidBar(parent.getContext());
    parent.addView(bar, new android.view.ViewGroup.LayoutParams(parent.getWidth(),parent.getHeight()));
    return bar;
}
public class AndroidBar extends android.view.View implements android.view.Choreographer.FrameCallback {
    private final TabEngine engine = new TabEngine() {
        @Override public void selected(int index) { layerIndex = -2; invalidate(); announceSelection(); ba.raiseEventFromUI(AndroidBar.this,"native_selected",index); }
        @Override public void longPress(int index) { performHapticFeedback(android.view.HapticFeedbackConstants.LONG_PRESS); ba.raiseEventFromUI(AndroidBar.this,"native_hold",index); }
    };
    private String[] titles = new String[0]; private Object[] badges = new Object[0];
    private android.graphics.Bitmap[] icons = new android.graphics.Bitmap[0];
    private android.graphics.Bitmap material, texture;
    private final android.graphics.Paint paint = new android.graphics.Paint(3);
    private final android.graphics.Paint text = new android.graphics.Paint(3);
    private boolean dark, framePending, disposed;
    private int tint, layerIndex = -2; private float lastCollapse=-1; private long lastFrame;
    private Object shader;private android.graphics.Bitmap shaderTexture;private boolean compositeDirty=true;private android.graphics.Shader compositeShader;
    AndroidBar(android.content.Context context) { super(context); setFocusable(true); setImportantForAccessibility(IMPORTANT_FOR_ACCESSIBILITY_YES); }
    public void configure(String[] labels, Object[] images, Object[] badgeValues, boolean[] enabled, int selected, boolean darkMode, int color, Object bitmap, float density) {
        titles = labels.clone(); badges = badgeValues.clone(); icons = new android.graphics.Bitmap[images.length];
        for(int i=0;i<images.length;i++) icons[i]=(android.graphics.Bitmap)unwrap(images[i]);
        material = (android.graphics.Bitmap)unwrap(bitmap); dark=darkMode; tint=color; engine.density=density;
        engine.width=getWidth(); engine.height=getHeight(); engine.reduceMotion=android.provider.Settings.Global.getFloat(getContext().getContentResolver(),android.provider.Settings.Global.ANIMATOR_DURATION_SCALE,1f)==0f;
        engine.configure(enabled,selected); layerIndex=-2; invalidate();sendAccessibilityEvent(android.view.accessibility.AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED);
    }
    public void updateMaterial(Object bitmap){android.graphics.Bitmap next=(android.graphics.Bitmap)unwrap(bitmap);if(material!=null&&next!=null&&material.sameAs(next))return;material=next;compositeDirty=true;noteBackdropMotion();invalidate();}
    public void resizeBar(float w,float h) {
        android.view.ViewGroup.LayoutParams lp=getLayoutParams(); lp.width=Math.round(w);lp.height=Math.round(h);setLayoutParams(lp);
        engine.width=w;engine.height=h;engine.target=engine.center(engine.selected);if(!engine.down)engine.x=engine.target;layerIndex=-2;invalidate();
    }
    public void selectTab(int index) { if(index<0||index>=engine.enabled.length||!engine.enabled[index])return;engine.cancel();engine.selected=index;engine.hover=index;engine.target=engine.center(index);layerIndex=-2;startFrames(); }
    private boolean platformReduceMotion(){return android.provider.Settings.Global.getFloat(getContext().getContentResolver(),android.provider.Settings.Global.ANIMATOR_DURATION_SCALE,1f)==0f;}
    public void setCustomWidth(float width){engine.customWidth=Math.max(0,width);engine.target=engine.center(engine.selected);layerIndex=-2;startFrames();}
    public void setOptions(int search,boolean minimized,boolean reduceMotion){engine.searchIndex=search;engine.reduceMotion=reduceMotion||platformReduceMotion();engine.setMinimized(minimized);layerIndex=-2;startFrames();}
    public void setMinimized(boolean value){engine.setMinimized(value);layerIndex=-2;startFrames();}
    public void cancelGesture(){engine.cancel();startFrames();}
    public void disposeBar(){disposed=true;android.view.Choreographer.getInstance().removeFrameCallback(this);framePending=false;texture=material=shaderTexture=null;shader=null;compositeShader=null;icons=new android.graphics.Bitmap[0];titles=new String[0];badges=new Object[0];}
    private void startFrames(){if(!framePending&&!disposed){framePending=true;lastFrame=System.nanoTime();android.view.Choreographer.getInstance().postFrameCallback(this);}}
    @Override public void doFrame(long now){framePending=false;if(disposed)return;boolean active=engine.tick((now-lastFrame)/1000000000f,now/1000000);lastFrame=now;invalidate();if(active){framePending=true;android.view.Choreographer.getInstance().postFrameCallback(this);}}
    @Override protected void onSizeChanged(int w,int h,int oldw,int oldh){engine.width=w;engine.height=h;engine.target=engine.center(engine.selected);if(!engine.down)engine.x=engine.target;layerIndex=-2;}
    @Override public boolean onTouchEvent(android.view.MotionEvent event){
        if(disposed)return false;
        long now=System.nanoTime()/1000000;float x=event.getX(),y=event.getY();
        switch(event.getActionMasked()){
            case android.view.MotionEvent.ACTION_DOWN: boolean was=engine.minimized;if(!engine.press(x,y,now))return false;if(was&&!engine.minimized)ba.raiseEventFromUI(this,"native_expanded");getParent().requestDisallowInterceptTouchEvent(true);startFrames();return true;
            case android.view.MotionEvent.ACTION_MOVE:engine.move(x,y,now);startFrames();return true;
            case android.view.MotionEvent.ACTION_UP:engine.release(x,y);getParent().requestDisallowInterceptTouchEvent(false);startFrames();return true;
            case android.view.MotionEvent.ACTION_CANCEL:engine.cancel();getParent().requestDisallowInterceptTouchEvent(false);startFrames();return true;
            case android.view.MotionEvent.ACTION_POINTER_DOWN:engine.cancel();startFrames();return true;
        }return true;
    }
    private void rebuild(){
        if(getWidth()<1||getHeight()<1)return;
        int index=engine.down?engine.hover:engine.selected;
        if(texture!=null&&texture.getWidth()==getWidth()&&texture.getHeight()==getHeight()&&layerIndex==index&&lastCollapse==engine.collapse)return;
        if(texture==null||texture.getWidth()!=getWidth()||texture.getHeight()!=getHeight())texture=android.graphics.Bitmap.createBitmap(getWidth(),getHeight(),android.graphics.Bitmap.Config.ARGB_8888);texture.eraseColor(android.graphics.Color.TRANSPARENT);
        android.graphics.Canvas c=new android.graphics.Canvas(texture);float d=engine.density;
        android.graphics.RectF bar=new android.graphics.RectF(engine.left(),engine.top(),engine.left()+engine.barWidth(),engine.top()+engine.barHeight());
        paint.setShader(null);paint.setColorFilter(null);paint.setAlpha(255);paint.setStyle(android.graphics.Paint.Style.FILL);
        text.setTypeface(android.graphics.Typeface.create("sans-serif-medium",android.graphics.Typeface.NORMAL));text.setTextAlign(android.graphics.Paint.Align.CENTER);text.setTextSize(10*d);
        for(int i=0;i<titles.length;i++){
            if(!engine.visibleTab(i))continue;float center=engine.displayCenter(i);int color=i==index?tint:(dark?0xFFD1D1D6:0xFF636366);if(!engine.enabled[i])color=(color&0xffffff)|0x55000000;
            if(icons[i]!=null){paint.setColorFilter(new android.graphics.PorterDuffColorFilter(color,android.graphics.PorterDuff.Mode.SRC_IN));c.drawBitmap(icons[i],null,new android.graphics.RectF(center-12*d,bar.top+10*d,center+12*d,bar.top+34*d),paint);paint.setColorFilter(null);}
            text.setColor(color);c.drawText(titles[i],center,bar.top+49*d,text);
            if(badges[i]!=null){String badge=String.valueOf(badges[i]);float bx=center+12*d,by=bar.top+9*d;paint.setColor(0xFFFF3B30);float bw=badge.isEmpty()?7*d:Math.max(16*d,(badge.length()*6+8)*d);android.graphics.RectF badgeRect=new android.graphics.RectF(bx-bw/2,by-7*d,bx+bw/2,by+(badge.isEmpty()?0:7)*d);c.drawRoundRect(badgeRect,8*d,8*d,paint);if(!badge.isEmpty()){text.setColor(0xFFFFFFFF);text.setTextSize(10*d);c.drawText(badge,bx,by+3*d,text);}}
        }layerIndex=index;lastCollapse=engine.collapse;compositeDirty=true;shaderTexture=null;
    }
    private void drawBackdrop(android.graphics.Canvas c){
        float d=engine.density;android.graphics.RectF sourceRect=new android.graphics.RectF(engine.left(),engine.top(),engine.width-16*d,engine.top()+engine.barHeight());
        android.graphics.RectF bar=new android.graphics.RectF(engine.left(),engine.top(),engine.left()+engine.barWidth(),engine.top()+engine.barHeight());
        android.graphics.Path clip=new android.graphics.Path();clip.addRoundRect(bar,bar.height()/2,bar.height()/2,android.graphics.Path.Direction.CW);
        if(engine.searchIndex>=0)clip.addCircle(engine.searchLeft()+32*d,bar.top+32*d,32*d,android.graphics.Path.Direction.CW);
        c.save();c.clipPath(clip);paint.setStyle(android.graphics.Paint.Style.FILL);paint.setShader(null);paint.setColorFilter(null);paint.setAlpha(255);
        if(material!=null){paint.setColor(0xFFFFFFFF);c.drawBitmap(material,null,sourceRect,paint);}else{paint.setColor(dark?0xE628282C:0xE6F5F5F7);c.drawRect(sourceRect,paint);}c.restore();
    }
    private android.graphics.Shader imageShader(){
        if(!compositeDirty&&compositeShader!=null)return compositeShader;
        android.graphics.Shader background;
        if(material!=null){android.graphics.BitmapShader bitmap=new android.graphics.BitmapShader(material,android.graphics.Shader.TileMode.CLAMP,android.graphics.Shader.TileMode.CLAMP);android.graphics.Matrix matrix=new android.graphics.Matrix();matrix.setScale((engine.width-32*engine.density)/material.getWidth(),engine.barHeight()/material.getHeight());matrix.postTranslate(engine.left(),engine.top());bitmap.setLocalMatrix(matrix);background=bitmap;}
        else background=new android.graphics.LinearGradient(0,0,1,0,dark?0xE628282C:0xE6F5F5F7,dark?0xE628282C:0xE6F5F5F7,android.graphics.Shader.TileMode.CLAMP);
        android.graphics.BitmapShader foreground=new android.graphics.BitmapShader(texture,android.graphics.Shader.TileMode.CLAMP,android.graphics.Shader.TileMode.CLAMP);
        compositeShader=new android.graphics.ComposeShader(background,foreground,android.graphics.PorterDuff.Mode.SRC_OVER);compositeDirty=false;return compositeShader;
    }
    @Override protected void onDraw(android.graphics.Canvas c){
        super.onDraw(c);if(titles.length==0)return;rebuild();if(texture==null)return;
        float d=engine.density,cy=engine.top()+engine.barHeight()/2;
        c.save();float scale=1f+.015f*Math.max(0,engine.pressure);c.scale(scale,scale,getWidth()/2f,cy);
        android.graphics.RectF bar=new android.graphics.RectF(engine.left(),engine.top(),engine.left()+engine.barWidth(),engine.top()+engine.barHeight());
        paint.setStyle(android.graphics.Paint.Style.FILL);paint.setColor(dark?0x18000000:0x10000000);paint.setShadowLayer(6*d,0,2*d,0x22000000);c.drawRoundRect(bar,bar.height()/2,bar.height()/2,paint);paint.clearShadowLayer();
        drawBackdrop(c);paint.setColor(0xFFFFFFFF);paint.setColorFilter(null);paint.setShader(null);c.drawBitmap(texture,0,0,paint);
        if(engine.selected>=0){
            float lensX=engine.selected==engine.searchIndex&&!engine.down?engine.center(engine.selected):engine.x+(engine.displayCenter(engine.selected)-engine.center(engine.selected));
            float w=engine.lensWidth(),h=engine.lensHeight();android.graphics.RectF lens=new android.graphics.RectF(lensX-w/2,cy-h/2,lensX+w/2,cy+h/2);
            paint.setColor(dark?0x26FFFFFF:0x14000000);c.drawRoundRect(lens,h/2,h/2,paint);
            if(engine.pressure>.005f){
                boolean drew=false;
                if(android.os.Build.VERSION.SDK_INT>=33&&c.isHardwareAccelerated()){try{drawShader(c,lens);drew=true;}catch(RuntimeException ignored){shader=null;shaderTexture=null;paint.setShader(null);}}
                if(!drew){android.graphics.Path clip=new android.graphics.Path();clip.addRoundRect(lens,h/2,h/2,android.graphics.Path.Direction.CW);c.save();c.clipPath(clip);float zoom=1f+.14f*engine.pressure;c.scale(zoom,zoom,engine.x,cy);drawBackdrop(c);paint.setColor(0xFFFFFFFF);c.drawBitmap(texture,0,0,paint);c.restore();}
                paint.setColor(dark?0x66FFFFFF:0xAAFFFFFF);paint.setStyle(android.graphics.Paint.Style.STROKE);paint.setStrokeWidth(.8f*d);paint.setShader(null);c.drawRoundRect(lens,h/2,h/2,paint);paint.setStyle(android.graphics.Paint.Style.FILL);
            }
        }c.restore();
    }
    @android.annotation.TargetApi(33) private void drawShader(android.graphics.Canvas c,android.graphics.RectF lens){
        android.graphics.RuntimeShader s;
        if(shader==null){s=new android.graphics.RuntimeShader("uniform shader image; uniform float4 box; uniform float held; uniform float density; half4 main(float2 p){ float2 center=(box.xy+box.zw)*0.5; float2 halfSize=(box.zw-box.xy)*0.5; float r=halfSize.y; float2 q=abs(p-center)-halfSize+r; float2 v=max(q,0.0); float sd=length(v)+min(max(q.x,q.y),0.0)-r; float2 n=length(v)>0.001?normalize(v)*sign(p-center):(q.x>q.y?float2(sign(p.x-center.x),0):float2(0,sign(p.y-center.y))); float edge=clamp(1.0+sd/(12.0*density),0.0,1.0); float2 sample=center+(p-center)/(1.0+0.14*held)-n*edge*edge*4.0*density*held; half4 col=image.eval(sample); float rim=pow(edge,8.0)*0.22*held; col.rgb=mix(col.rgb,half3(1.0),rim); return col*(1.0-smoothstep(-0.7,0.7,sd)); }");shader=s;}else s=(android.graphics.RuntimeShader)shader;
        if(shaderTexture!=texture||compositeDirty){s.setInputShader("image",imageShader());shaderTexture=texture;}
        s.setFloatUniform("box",lens.left,lens.top,lens.right,lens.bottom);s.setFloatUniform("held",Math.max(0,engine.pressure));s.setFloatUniform("density",engine.density);paint.setShader(s);paint.setColor(0xFFFFFFFF);c.drawRect(lens,paint);paint.setShader(null);
    }
    private int accessibilityFocus=-1,hoveredTab=-1;
    private final android.view.accessibility.AccessibilityNodeProvider accessibilityProvider=new android.view.accessibility.AccessibilityNodeProvider(){
        @Override public android.view.accessibility.AccessibilityNodeInfo createAccessibilityNodeInfo(int id){
            if(id==android.view.View.NO_ID){android.view.accessibility.AccessibilityNodeInfo root=android.view.accessibility.AccessibilityNodeInfo.obtain(AndroidBar.this);onInitializeAccessibilityNodeInfo(root);root.setClassName("android.widget.TabWidget");for(int i=0;i<titles.length;i++)if(engine.visibleTab(i))root.addChild(AndroidBar.this,i);return root;}
            if(id<0||id>=titles.length||!engine.visibleTab(id))return null;
            android.view.accessibility.AccessibilityNodeInfo node=android.view.accessibility.AccessibilityNodeInfo.obtain();node.setSource(AndroidBar.this,id);node.setParent(AndroidBar.this);node.setPackageName(getContext().getPackageName());node.setClassName("android.widget.RadioButton");node.setContentDescription(titles[id]+(badges[id] instanceof String&&!((String)badges[id]).isEmpty()?", "+badges[id]:""));node.setEnabled(engine.enabled[id]);node.setCheckable(true);node.setChecked(id==engine.selected);node.setSelected(id==engine.selected);node.setFocusable(true);node.setClickable(engine.enabled[id]);node.setVisibleToUser(isShown());
            float w=engine.minimized&&id!=engine.searchIndex?64*engine.density:engine.tabWidth(id),left=engine.displayCenter(id)-w/2;android.graphics.Rect bounds=new android.graphics.Rect(Math.round(left),Math.round(engine.top()),Math.round(left+w),Math.round(engine.top()+engine.barHeight()));node.setBoundsInParent(bounds);int[] location=new int[2];getLocationOnScreen(location);bounds.offset(location[0],location[1]);node.setBoundsInScreen(bounds);
            node.setAccessibilityFocused(accessibilityFocus==id);node.addAction(accessibilityFocus==id?android.view.accessibility.AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS:android.view.accessibility.AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS);if(engine.enabled[id])node.addAction(android.view.accessibility.AccessibilityNodeInfo.ACTION_CLICK);return node;
        }
        @Override public boolean performAction(int id,int action,android.os.Bundle args){
            if(id<0||id>=titles.length)return false;
            if(action==android.view.accessibility.AccessibilityNodeInfo.ACTION_CLICK&&engine.enabled[id]){if(engine.minimized&&id!=engine.searchIndex){engine.setMinimized(false);ba.raiseEventFromUI(AndroidBar.this,"native_expanded");}selectTab(id);announceSelection();ba.raiseEventFromUI(AndroidBar.this,"native_selected",id);return true;}
            if(action==android.view.accessibility.AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS){if(accessibilityFocus==id)return false;if(accessibilityFocus>=0)sendTabAccessibilityEvent(accessibilityFocus,android.view.accessibility.AccessibilityEvent.TYPE_VIEW_ACCESSIBILITY_FOCUS_CLEARED);accessibilityFocus=id;sendTabAccessibilityEvent(id,android.view.accessibility.AccessibilityEvent.TYPE_VIEW_ACCESSIBILITY_FOCUSED);invalidate();return true;}
            if(action==android.view.accessibility.AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS&&accessibilityFocus==id){accessibilityFocus=-1;sendTabAccessibilityEvent(id,android.view.accessibility.AccessibilityEvent.TYPE_VIEW_ACCESSIBILITY_FOCUS_CLEARED);invalidate();return true;}return false;
        }
        @Override public android.view.accessibility.AccessibilityNodeInfo findFocus(int focus){return accessibilityFocus>=0?createAccessibilityNodeInfo(accessibilityFocus):null;}
    };
    @Override public android.view.accessibility.AccessibilityNodeProvider getAccessibilityNodeProvider(){return accessibilityProvider;}
    private void sendTabAccessibilityEvent(int id,int type){if(id<0||id>=titles.length)return;android.view.accessibility.AccessibilityEvent event=android.view.accessibility.AccessibilityEvent.obtain(type);event.setPackageName(getContext().getPackageName());event.setClassName("android.widget.RadioButton");event.setSource(this,id);event.setEnabled(engine.enabled[id]);event.getText().add(titles[id]);if(getParent()!=null)getParent().requestSendAccessibilityEvent(this,event);}
    @Override public boolean dispatchHoverEvent(android.view.MotionEvent event){android.view.accessibility.AccessibilityManager manager=(android.view.accessibility.AccessibilityManager)getContext().getSystemService(android.content.Context.ACCESSIBILITY_SERVICE);if(manager!=null&&manager.isTouchExplorationEnabled()){int hit=event.getActionMasked()==android.view.MotionEvent.ACTION_HOVER_EXIT?-1:engine.hit(event.getX(),event.getY());if(hit!=hoveredTab){if(hoveredTab>=0)sendTabAccessibilityEvent(hoveredTab,android.view.accessibility.AccessibilityEvent.TYPE_VIEW_HOVER_EXIT);hoveredTab=hit;if(hit>=0)sendTabAccessibilityEvent(hit,android.view.accessibility.AccessibilityEvent.TYPE_VIEW_HOVER_ENTER);}return hit>=0;}return super.dispatchHoverEvent(event);}

    @Override public boolean onKeyDown(int code,android.view.KeyEvent event){int step=code==android.view.KeyEvent.KEYCODE_DPAD_LEFT?-1:code==android.view.KeyEvent.KEYCODE_DPAD_RIGHT?1:0;if(step==0)return super.onKeyDown(code,event);int i=engine.selected+step;while(i>=0&&i<engine.enabled.length){if(engine.enabled[i]){selectTab(i);ba.raiseEventFromUI(this,"native_selected",i);return true;}i+=step;}return true;}
    private void announceSelection(){sendAccessibilityEvent(android.view.accessibility.AccessibilityEvent.TYPE_VIEW_SELECTED);}
    @Override protected void onDetachedFromWindow(){engine.cancel();android.view.Choreographer.getInstance().removeFrameCallback(this);framePending=false;super.onDetachedFromWindow();}
    @Override protected void onAttachedToWindow(){super.onAttachedToWindow();startFrames();}
}
#End If
#End If
#DesignerProperty: Key: Theme, DisplayName: Theme, FieldType: String, DefaultValue: Auto, List: Auto|Light|Dark
#DesignerProperty: Key: SelectedColor, DisplayName: Selected Color, FieldType: Color, DefaultValue: 0xFF007AFF
#DesignerProperty: Key: BlurStrength, DisplayName: Blur Strength (%), FieldType: Float, DefaultValue: 13, MinRange: 0, MaxRange: 100
#Event: CustomButtonClick
#Event: TabClick (Index As Int)
#Event: TabChanged (Index As Int)
#Event: TabLongClick (Index As Int)
#Event: MinimizedChanged (Minimized As Boolean)

Sub Class_Globals
	Type AS_LiquidGlassTabBar_Tab(Text As String, SymbolName As String, Icon As B4XBitmap, BadgeValue As String, BadgeVisible As Boolean, Enabled As Boolean, Tag As Object)
	Private xui As XUI
	Private m_Callback As Object
	Private m_EventName As String
	Public mBase As B4XView
	Public Tag As Object
	Private m_Parent As B4XView
	Private m_Tabs As List
	Private m_Index As Int = -1
	Private m_Theme As String = "Auto"
	Private m_SelectedColor As Int = 0xFF007AFF
	Private m_BlurRadius As Float = 2dip
	Private m_GlassTint As Int
	Private m_CustomGlassTint As Boolean
	Private m_BlurStrength As Float = -1
	Private m_Scheduled, m_Disposed, m_Attached As Boolean
	Private m_AutoHeight As Float = 88dip
	Private m_Backdrop As B4XView
	Private m_Pages As List
	Private m_Navigation As Boolean
	Private m_SearchIndex As Int = -1
	Private m_CustomButton, m_CustomHost, m_CustomHit As B4XView
	Private m_CustomButtonWidth As Float = 64dip
	Private m_MinimizeBehavior As String = "Never"
	Private m_DisplayMode As String = "Automatic"
	Private m_Minimized, m_ReduceMotion As Boolean
	Private m_Accessory As B4XView
	Private m_AccessoryHeight As Float = 52dip
	Private m_LiveBackdrop As Boolean = True
	Private m_AccessoryHost, m_AccessoryImage As B4XView
	Private m_BackdropClock As Timer
	Private m_BackdropInterval As Int = 16
	Private m_LastOffset, m_ScrollTravel As Double
	Private m_ScrollKnown As Boolean
	#If B4i
	Private m_Native As NativeObject
	#Else
	Private m_Native As JavaObject
	Private m_Renderer As AS_LiquidGlassTabBarRenderer
	#End If
End Sub

Public Sub Initialize(Callback As Object, EventName As String)
	m_Callback = Callback
	m_EventName = EventName
	m_Tabs.Initialize
	m_Pages.Initialize
	m_BackdropClock.Initialize("BackdropClock", 100)
	#If Not(B4i)
	m_Renderer.Initialize
	#End If
End Sub

'Full navigation host. Use GetContentPanel(Index) for each tab's layout.
'B4i embeds a real UITabBarController. CreateBottomBar remains an overlay.
Public Sub CreateNavigation(Parent As B4XView)
	m_Navigation = True
	CreateBottomBar(Parent)
End Sub

'Attach once. Parent size changes are handled by the view.
Public Sub CreateBottomBar(Parent As B4XView)
	m_Attached = True
	#If B4i
	If m_Navigation Then
		CreateViewPerCode(Parent, 0, 0, Parent.Width, Parent.Height)
	Else
		CreateViewPerCode(Parent, 0, Parent.Height - m_AutoHeight, Parent.Width, m_AutoHeight)
	End If
	#Else
	CreateViewPerCode(Parent, 0, Parent.Height - m_AutoHeight, Parent.Width, m_AutoHeight)
	#End If
	#If B4i
	Dim native As NativeObject = Me
	native.RunMethod("anchorHost:navigation:", Array(mBase, m_Navigation))
	#Else
	Dim native As JavaObject = Me
	native.RunMethod("watchParent", Array(Parent))
	#End If
End Sub

Public Sub CreateViewPerCode(Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float)
	Dim base As B4XView = xui.CreatePanel("")
	Parent.AddView(base, Left, Top, Width, Height)
	Dim lbl As Label
	lbl.Initialize("")
	DesignerCreateView(base, lbl, CreateMap())
End Sub

Public Sub DesignerCreateView(Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	m_Parent = mBase.Parent
	mBase.Color = xui.Color_Transparent
	m_Theme = Props.GetDefault("Theme", "Auto")
	m_SelectedColor = xui.PaintOrColorToColor(Props.GetDefault("SelectedColor", 0xFF007AFF))
	If Props.ContainsKey("BlurStrength") Then setBlurStrength(Props.Get("BlurStrength"))
	#If B4i
	Dim native As NativeObject = Me
	m_Native = native.RunMethod("createNativeBar:navigation:", Array(mBase, m_Navigation))
	#Else
	Dim native As JavaObject = Me
	m_Native = native.RunMethod("createBar", Array(mBase))
	#End If
	#If Not(B4i)
	m_BackdropClock.Enabled = m_LiveBackdrop
	native.RunMethod("watchBackdrop", Array(m_Parent))
	ApplyBackdropOptions
	#End If
	ScheduleRefresh
End Sub

'Built-in names match SF Symbols on iOS. Other platforms use bundled fallback artwork.
'Use SetIcon for the same custom bitmap on every platform.
Public Sub AddTab(Text As String, SymbolName As String) As Int
	If m_Disposed Or m_Tabs.Size >= 5 Then Return -1
	Dim item As AS_LiquidGlassTabBar_Tab
	item.Initialize
	item.Text = Text
	item.SymbolName = SymbolName
	item.Enabled = True
	m_Tabs.Add(item)
	Dim page As B4XView = xui.CreatePanel("")
	page.SetLayoutAnimated(0, 0, 0, m_Parent.Width, m_Parent.Height)
	m_Pages.Add(page)
	If m_Navigation Then
		#If Not(B4i)
		m_Parent.AddView(page, 0, 0, m_Parent.Width, Max(0, m_Parent.Height - m_AutoHeight))
		page.SendToBack
		#End If
	End If
	If m_Index < 0 Then m_Index = 0
	ScheduleRefresh
	Return m_Tabs.Size - 1
End Sub

'Adds a system search tab on iOS; detached search button on B4A/B4J.
Public Sub AddSearchTab(Text As String) As Int
	ClearCustomButton
	If m_SearchIndex >= 0 Then Return m_SearchIndex
	Dim result As Int = AddTab(Text, "magnifyingglass")
	If result >= 0 Then m_SearchIndex = result
	ScheduleRefresh
	Return result
End Sub

 'Custom decorative view with a separate action, never a selected tab.
'B4A/B4J place it beside the bar. B4i uses UIKit's accessory slot in navigation mode.
Public Sub SetCustomButton(Content As B4XView, Width As Float)
	If m_Disposed Or mBase.IsInitialized = False Then Return
	#If B4i
	If m_Navigation = False Then
		Log("AS_LiquidGlassTabBar: native custom buttons require CreateNavigation.")
		Return
	End If
	#End If
	ClearCustomButton
	If m_SearchIndex >= 0 Then RemoveTab(m_SearchIndex)
	m_CustomButton = Content
	m_CustomButtonWidth = Max(44dip, Width)
	m_CustomHost = xui.CreatePanel("")
	m_CustomHit = xui.CreatePanel("CustomButton")
	m_CustomHost.SetLayoutAnimated(0, 0, 0, m_CustomButtonWidth, 64dip)
	m_CustomHost.AddView(m_CustomHit, 0, 0, m_CustomButtonWidth, 64dip)
	Content.RemoveViewFromParent
	m_CustomHit.AddView(Content, 0, 0, m_CustomButtonWidth, 64dip)
	#If B4i
	m_CustomHost.SetLayoutAnimated(0, 0, 0, Max(m_CustomButtonWidth, m_Parent.Width - 32dip), 64dip)
	m_CustomHit.SetLayoutAnimated(0, m_CustomHost.Width - m_CustomButtonWidth, 0, m_CustomButtonWidth, 64dip)
	Dim native As NativeObject = Me
	native.RunMethod("anchorCustomButton:", Array(m_CustomHit))
	SetAccessory(m_CustomHost, 64dip)
	#Else
	m_Parent.AddView(m_CustomHost, 0, 0, m_CustomButtonWidth, 64dip)
	#End If
	LayoutContent
	ScheduleRefresh
End Sub

Public Sub ClearCustomButton
	If m_CustomButton.IsInitialized = False Then Return
	#If B4i
	If m_Accessory.IsInitialized Then
		If m_Accessory = m_CustomHost Then ClearAccessory
	End If
	#End If
	m_CustomButton.RemoveViewFromParent
	m_CustomHost.RemoveViewFromParent
	Dim empty As B4XView
	m_CustomButton = empty
	m_CustomHost = empty
	m_CustomHit = empty
	ScheduleRefresh
End Sub

#If B4J
Private Sub CustomButton_MouseClicked(EventData As MouseEvent)
	RaiseCustomButtonClick
End Sub
#Else
Private Sub CustomButton_Click
	RaiseCustomButtonClick
End Sub
#End If

Private Sub RaiseCustomButtonClick
	If m_Disposed Or m_CustomButton.IsInitialized = False Then Return
	If xui.SubExists(m_Callback, m_EventName & "_CustomButtonClick", 0) Then CallSub(m_Callback, m_EventName & "_CustomButtonClick")
End Sub

Public Sub GetContentPanel(Index As Int) As B4XView
	Return m_Pages.Get(Index)
End Sub

Public Sub GetTab(Index As Int) As AS_LiquidGlassTabBar_Tab
	Return m_Tabs.Get(Index)
End Sub

Public Sub SetIcon(Index As Int, Bitmap As B4XBitmap)
	Dim item As AS_LiquidGlassTabBar_Tab = GetTab(Index)
	item.Icon = Bitmap
	ScheduleRefresh
End Sub

'Empty Value shows a dot. ClearBadge removes it.
Public Sub SetBadge(Index As Int, Value As String)
	Dim item As AS_LiquidGlassTabBar_Tab = GetTab(Index)
	item.BadgeValue = Value
	item.BadgeVisible = True
	ScheduleRefresh
End Sub

Public Sub ClearBadge(Index As Int)
	Dim item As AS_LiquidGlassTabBar_Tab = GetTab(Index)
	item.BadgeVisible = False
	ScheduleRefresh
End Sub

Public Sub SetEnabled(Index As Int, Value As Boolean)
	Dim item As AS_LiquidGlassTabBar_Tab = GetTab(Index)
	item.Enabled = Value
	If Value = False And m_Index = Index Then m_Index = FirstEnabled
	ScheduleRefresh
End Sub

Public Sub RemoveTab(Index As Int)
	If m_Disposed Then Return
	Dim page As B4XView = m_Pages.Get(Index)
	page.RemoveViewFromParent
	m_Pages.RemoveAt(Index)
	If m_SearchIndex = Index Then
		m_SearchIndex = -1
	Else If m_SearchIndex > Index Then
		m_SearchIndex = m_SearchIndex - 1
	End If
	m_Tabs.RemoveAt(Index)
	If m_Index > Index Then m_Index = m_Index - 1
	If m_Index >= m_Tabs.Size Then m_Index = m_Tabs.Size - 1
	If m_Index >= 0 Then
		If GetTab(m_Index).Enabled = False Then m_Index = FirstEnabled
	End If
	ScheduleRefresh
End Sub

Public Sub Clear
	For Each page As B4XView In m_Pages
		page.RemoveViewFromParent
	Next
	m_Pages.Clear
	m_SearchIndex = -1
	m_Tabs.Clear
	m_Index = -1
	ScheduleRefresh
End Sub

Private Sub FirstEnabled As Int
	For i = 0 To m_Tabs.Size - 1
		If GetTab(i).Enabled Then Return i
	Next
	Return -1
End Sub

Private Sub ScheduleRefresh
	If m_Scheduled Or m_Disposed Then Return
	m_Scheduled = True
	CallSubDelayed(Me, "Refresh")
End Sub

'Only needed after directly editing fields returned by GetTab or changing backdrop pixels.
Public Sub Refresh
	m_Scheduled = False
	If m_Disposed Or mBase.IsInitialized = False Then Return
	If mBase.Width < 1 Or mBase.Height < 1 Then
		#If B4i
		Sleep(50)
		ScheduleRefresh
		#End If
		Return
	End If
	If m_Index < 0 Then m_Index = FirstEnabled
	LayoutContent
	#If B4i
	Dim native As NativeObject = Me
	native.RunMethod("resetNativeItems:", Array(m_Native))
	For Each item As AS_LiquidGlassTabBar_Tab In m_Tabs
		Dim image As Object = Null
		If item.Icon.IsInitialized Then image = item.Icon
		native.RunMethod("appendNativeItem:title:symbol:image:badge:visible:enabled:content:search:", Array(m_Native, item.Text, item.SymbolName, image, item.BadgeValue, item.BadgeVisible, item.Enabled, m_Pages.Get(m_Tabs.IndexOf(item)), m_Tabs.IndexOf(item) = m_SearchIndex))
	Next
	native.RunMethod("finishNativeBar:index:theme:color:", Array(m_Native, m_Index, m_Theme, native.ColorToUIColor(m_SelectedColor)))
	native.RunMethod("nativeOptions:behavior:mode:reduceMotion:", Array(m_Native, m_MinimizeBehavior, m_DisplayMode, m_ReduceMotion))
	native.RunMethod("resizeNative:width:height:", Array(m_Native, mBase.Width, mBase.Height))
	#Else
	Dim titles(m_Tabs.Size) As String
	Dim icons(m_Tabs.Size), badges(m_Tabs.Size) As Object
	Dim enabled(m_Tabs.Size) As Boolean
	For i = 0 To m_Tabs.Size - 1
		Dim item As AS_LiquidGlassTabBar_Tab = m_Tabs.Get(i)
		titles(i) = item.Text
		enabled(i) = item.Enabled
		If item.Icon.IsInitialized Then
			icons(i) = item.Icon
		Else
			icons(i) = SymbolBitmap(item.SymbolName)
		End If
		badges(i) = Null
		If item.BadgeVisible Then badges(i) = item.BadgeValue
	Next
	Dim native As JavaObject = Me
	Dim dark As Boolean = m_Theme.ToLowerCase = "dark"
	If m_Theme.ToLowerCase = "auto" Then dark = native.RunMethod("systemDark", Array(mBase))
	Dim material As B4XBitmap = CaptureMaterial(dark)
	Dim nativeMaterial As Object = Null
	If material.IsInitialized Then nativeMaterial = material
	Dim pixelScale As Float = xui.Scale
	Dim nativeWidth As Float = mBase.Width, nativeHeight As Float = mBase.Height
	m_Native.RunMethod("configure", Array(titles, icons, badges, enabled, m_Index, dark, m_SelectedColor, nativeMaterial, pixelScale))
	m_Native.RunMethod("resizeBar", Array(nativeWidth, nativeHeight))
	Dim customGap As Float = 0
	If m_CustomButton.IsInitialized Then customGap = m_CustomButtonWidth + 12dip
	m_Native.RunMethod("setCustomWidth", Array(customGap))
	m_Native.RunMethod("setOptions", Array(m_SearchIndex, m_Minimized, m_ReduceMotion))
	#End If
	LayoutContent
	#If Not(B4i)
	RefreshAccessoryMaterial(dark)
	#End If
End Sub

Private Sub Base_Resize(Width As Double, Height As Double)
	If m_Disposed Then Return
	#If B4i
	If m_Native.IsInitialized Then
		Dim native As NativeObject = Me
		native.RunMethod("resizeNative:width:height:", Array(m_Native, Width, Height))
	End If
	#Else
	ScheduleRefresh
	#End If
End Sub

Private Sub Native_ParentResize(Width As Double, Height As Double)
	If m_Disposed Or m_Attached = False Then Return
	mBase.SetLayoutAnimated(0, 0, Max(0, Height - m_AutoHeight), Width, m_AutoHeight)
	Base_Resize(Width, m_AutoHeight)
	LayoutContent
End Sub

Public Sub Resize(Width As Float, Height As Float)
	mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, Width, Height)
	Base_Resize(Width, Height)
End Sub

Private Sub Native_Selected(Index As Int)
	If m_Disposed Or Index < 0 Or Index >= m_Tabs.Size Then Return
	If GetTab(Index).Enabled = False Then Return
	Dim changed As Boolean = m_Index <> Index
	m_Index = Index
	LayoutContent
	If changed And xui.SubExists(m_Callback, m_EventName & "_TabChanged", 1) Then CallSub2(m_Callback, m_EventName & "_TabChanged", Index)
	If xui.SubExists(m_Callback, m_EventName & "_TabClick", 1) Then CallSub2(m_Callback, m_EventName & "_TabClick", Index)
End Sub

Private Sub Native_Hold(Index As Int)
	If m_Disposed Then Return
	If xui.SubExists(m_Callback, m_EventName & "_TabLongClick", 1) Then CallSub2(m_Callback, m_EventName & "_TabLongClick", Index)
End Sub

Public Sub CancelGesture
	If mBase.IsInitialized = False Or m_Disposed Then Return
	#If Not(B4i)
	m_Native.RunMethod("cancelGesture", Null)
	#End If
End Sub

Public Sub Dispose
	If m_Disposed Then Return
	ClearCustomButton
	m_Disposed = True
	m_BackdropClock.Enabled = False
	UnbindScrollView
	For Each page As B4XView In m_Pages
		page.RemoveViewFromParent
	Next
	If m_Accessory.IsInitialized Then m_Accessory.RemoveViewFromParent
	#If Not(B4i)
	If m_AccessoryHost.IsInitialized Then m_AccessoryHost.RemoveViewFromParent
	#End If
	#If B4i
	If m_Native.IsInitialized Then
		Dim native As NativeObject = Me
		native.RunMethod("disposeNative:", Array(m_Native))
	End If
	#Else
	If m_Native.IsInitialized Then m_Native.RunMethod("disposeBar", Null)
	m_Renderer.Dispose
	Dim native As JavaObject = Me
	native.RunMethod("unwatchBackdrop", Null)
	native.RunMethod("unwatchParent", Null)
	#End If
	If mBase.IsInitialized Then
		mBase.Tag = Tag
		mBase.RemoveViewFromParent
	End If
End Sub

Public Sub getIndex As Int
	Return m_Index
End Sub
Public Sub setIndex(Value As Int)
	If Value < 0 Or Value >= m_Tabs.Size Or m_Disposed Then Return
	If GetTab(Value).Enabled = False Then Return
	m_Index = Value
	LayoutContent
	#If B4i
	If m_Native.IsInitialized Then
		Dim native As NativeObject = Me
		native.RunMethod("selectNative:index:", Array(m_Native, Value))
	End If
	#Else
	If m_Native.IsInitialized Then m_Native.RunMethod("selectTab", Array(Value))
	#End If
End Sub
Public Sub getSelectedIndex As Int
	Return m_Index
End Sub
Public Sub setSelectedIndex(Value As Int)
	setIndex(Value)
End Sub
Public Sub getTabCount As Int
	Return m_Tabs.Size
End Sub
Public Sub getTheme As String
	Return m_Theme
End Sub
Public Sub setTheme(Value As String)
	m_Theme = Value
	ScheduleRefresh
End Sub
Public Sub getSelectedColor As Int
	Return m_SelectedColor
End Sub

'Replica material settings. UIKit controls its native material on B4i.
'One control for blur and coverage: 0 = clear, 100 = completely opaque.
'BlurRadius and GlassTint can still be changed separately afterwards.
Public Sub setBlurStrength(Value As Float)
	m_BlurStrength = Max(0, Min(100, Value))
	m_BlurRadius = 16dip * m_BlurStrength / 100
	ScheduleRefresh
End Sub
Public Sub getBlurStrength As Float
	If m_BlurStrength >= 0 Then Return m_BlurStrength
	Return Bit.UnsignedShiftRight(getGlassTint, 24) * 100 / 255
End Sub

Public Sub setBlurRadius(Value As Float)
	m_BlurRadius = Max(0, Value)
	ScheduleRefresh
End Sub
Public Sub getBlurRadius As Float
	Return m_BlurRadius
End Sub
Public Sub setGlassTint(Value As Int)
	m_GlassTint = Value
	m_CustomGlassTint = True
	m_BlurStrength = -1
	ScheduleRefresh
End Sub
Public Sub getGlassTint As Int
	Dim dark As Boolean = m_Theme.ToLowerCase = "dark"
	#If Not(B4i)
	If m_Theme.ToLowerCase = "auto" And mBase.IsInitialized Then
		Dim native As JavaObject = Me
		dark = native.RunMethod("systemDark", Array(mBase))
	End If
	#End If
	Return ResolveGlassTint(dark)
End Sub

Private Sub ResolveGlassTint(Dark As Boolean) As Int
	Dim tint As Int = IIf(Dark, 0x441C1C1E, 0x22FFFFFF)
	If m_CustomGlassTint Then tint = m_GlassTint
	If m_BlurStrength >= 0 Then
		Dim alpha As Int = Round(m_BlurStrength * 255 / 100)
		tint = Bit.Or(Bit.And(tint, 0x00FFFFFF), Bit.ShiftLeft(alpha, 24))
	End If
	Return tint
End Sub

Public Sub setSelectedColor(Value As Int)
	m_SelectedColor = Value
	ScheduleRefresh
End Sub

'Never, OnScrollDown or OnScrollUp. UIKit performs native minimizing in navigation mode.
Public Sub setMinimizeBehavior(Value As String)
	Select Value.ToLowerCase
		Case "never", "onscrolldown", "onscrollup", "automatic"
			m_MinimizeBehavior = Value
		Case Else
			Return
	End Select
	m_ScrollKnown = False
	If Value.ToLowerCase = "never" Then setMinimized(False)
	ScheduleRefresh
End Sub
Public Sub getContentBottomInset As Float
	Dim inset As Float = m_AutoHeight
	If m_Accessory.IsInitialized And m_Minimized = False Then inset = inset + m_AccessoryHeight + 4dip
	Return inset
End Sub
Public Sub getMinimizeBehavior As String
	Return m_MinimizeBehavior
End Sub

'Automatic, TabBar or TabSidebar. UIKit adapts to iPad size classes in navigation mode.
Public Sub setDisplayMode(Value As String)
	Select Value.ToLowerCase
		Case "automatic", "tabbar", "tabsidebar"
			m_DisplayMode = Value
		Case Else
			Return
	End Select
	ScheduleRefresh
End Sub
Public Sub getDisplayMode As String
	Return m_DisplayMode
End Sub

'Explicit replica collapse state. On iOS, UIKit minimizes from native scroll gestures.
Public Sub setMinimized(Value As Boolean)
	#If Not(B4i)
	If m_Minimized = Value Or m_Disposed Then Return
	m_Minimized = Value
	If m_Native.IsInitialized Then m_Native.RunMethod("setMinimized", Array(Value))
	LayoutContent
	If xui.SubExists(m_Callback, m_EventName & "_MinimizedChanged", 1) Then CallSub2(m_Callback, m_EventName & "_MinimizedChanged", Value)
	#End If
End Sub
Public Sub getMinimized As Boolean
	Return m_Minimized
End Sub

Public Sub setReduceMotion(Value As Boolean)
	m_ReduceMotion = Value
	ScheduleRefresh
End Sub
Public Sub getReduceMotion As Boolean
	Return m_ReduceMotion
End Sub

'Optional custom scroll controls can forward their offset here instead of BindScrollView.
'Increasing Offset means scrolling down. Direction changes use a 16dip threshold.
Public Sub NotifyScroll(Offset As Double)
	If m_Disposed Then Return
	#If Not(B4i)
	If m_ScrollKnown = False Then
		m_LastOffset = Offset
		m_ScrollKnown = True
		Return
	End If
	Dim delta As Double = Offset - m_LastOffset
	m_LastOffset = Offset
	If delta = 0 Then Return
	If delta * m_ScrollTravel < 0 Then m_ScrollTravel = 0
	m_ScrollTravel = m_ScrollTravel + delta
	Dim native As JavaObject = Me
	native.RunMethod("noteBackdropMotion", Null)
	If Abs(m_ScrollTravel) < 16dip Then Return
	Dim down As Boolean = m_ScrollTravel > 0
	m_ScrollTravel = 0
	Select m_MinimizeBehavior.ToLowerCase
		Case "onscrolldown", "automatic": setMinimized(down And Offset > 0)
		Case "onscrollup": setMinimized(Not(down))
	End Select
	#End If
End Sub

'Bind a native ScrollView (B4A) or ScrollPane (B4J). Native iOS scroll views must be inside GetContentPanel.
'Does not replace the scroll control's existing event handlers.
Public Sub BindScrollView(Scroll As B4XView)
	m_ScrollKnown = False
	m_ScrollTravel = 0
	#If Not(B4i)
	Dim native As JavaObject = Me
	native.RunMethod("bindScroll", Array(Scroll))
	#End If
End Sub
Public Sub UnbindScrollView
	m_ScrollKnown = False
	#If Not(B4i)
	Dim native As JavaObject = Me
	native.RunMethod("unbindScroll", Null)
	#End If
End Sub
Private Sub Native_Scroll(Offset As Double)
	NotifyScroll(Offset)
End Sub
Private Sub Native_Expanded
	m_Minimized = False
	LayoutContent
	If xui.SubExists(m_Callback, m_EventName & "_MinimizedChanged", 1) Then CallSub2(m_Callback, m_EventName & "_MinimizedChanged", False)
End Sub

'Use any custom view as a mini-player/accessory. Call ClearAccessory to remove it.
Public Sub SetAccessory(Content As B4XView, Height As Float)
	If m_Disposed Then Return
	ClearAccessory
	m_Accessory = Content
	m_AccessoryHeight = Max(32dip, Height)
	#If B4i
	Dim native As NativeObject = Me
	native.RunMethod("setNativeAccessory:content:height:", Array(m_Native, Content, m_AccessoryHeight))
	#Else
	Content.RemoveViewFromParent
	m_AccessoryHost = xui.CreatePanel("")
	m_Parent.AddView(m_AccessoryHost, 16dip, 0, Max(1dip, m_Parent.Width - 32dip), m_AccessoryHeight)
	Dim image As ImageView
	image.Initialize("")
	m_AccessoryImage = image
	m_AccessoryHost.AddView(m_AccessoryImage, 0, 0, m_AccessoryHost.Width, m_AccessoryHeight)
	m_AccessoryHost.AddView(Content, 0, 0, m_AccessoryHost.Width, m_AccessoryHeight)
	m_AccessoryHost.SetColorAndBorder(IIf(m_Theme.ToLowerCase = "dark", 0xEC28282C, 0xECF5F5F7), 0, 0, m_AccessoryHeight / 2)
	#End If
	LayoutContent
	ScheduleRefresh
End Sub
Public Sub ClearAccessory
	If m_Accessory.IsInitialized = False Then Return
	#If B4i
	Dim native As NativeObject = Me
	native.RunMethod("setNativeAccessory:content:height:", Array(m_Native, Null, 0))
	#End If
	m_Accessory.RemoveViewFromParent
	#If Not(B4i)
	If m_AccessoryHost.IsInitialized Then m_AccessoryHost.RemoveViewFromParent
	#End If
	Dim empty As B4XView
	m_Accessory = empty
	LayoutContent
End Sub

Private Sub LayoutContent
	If mBase.IsInitialized = False Then Return
	#If Not(B4i)
	If m_Accessory.IsInitialized Then
		Dim left As Float = 16dip, width As Float = Max(1dip, m_Parent.Width - 32dip)
		Dim top As Float = mBase.Top - m_AccessoryHeight - 4dip
		If m_Minimized Then
			left = 88dip
			width = Max(1dip, m_Parent.Width - left - 16dip - IIf(m_SearchIndex >= 0, 76dip, IIf(m_CustomButton.IsInitialized, m_CustomButtonWidth + 12dip, 0)))
			top = mBase.Top + 16dip + (64dip - m_AccessoryHeight) / 2
		End If
		m_AccessoryHost.SetLayoutAnimated(IIf(m_ReduceMotion, 0, 220), left, top, width, m_AccessoryHeight)
		m_AccessoryImage.SetLayoutAnimated(0, 0, 0, width, m_AccessoryHeight)
		m_Accessory.SetLayoutAnimated(0, 0, 0, width, m_AccessoryHeight)
		m_AccessoryHost.BringToFront
	End If
	If m_Navigation Then
		For i = 0 To m_Pages.Size - 1
			Dim page As B4XView = m_Pages.Get(i)
			page.Visible = i = m_Index
			page.SetLayoutAnimated(0, 0, 0, m_Parent.Width, Max(0, m_Parent.Height))
		Next
	End If
	mBase.BringToFront
	If m_CustomHost.IsInitialized Then
		m_CustomHost.SetLayoutAnimated(0, m_Parent.Width - 16dip - m_CustomButtonWidth, mBase.Top + Max(0, mBase.Height - 72dip), m_CustomButtonWidth, 64dip)
		m_CustomHost.BringToFront
	End If
	#End If
End Sub

'Frame-synchronized while scrolling; low-rate polling when the scene is idle.
'The animation/gesture engine is not reconfigured by a backdrop update.
Public Sub setLiveBackdrop(Value As Boolean)
	m_LiveBackdrop = Value
	#If Not(B4i)
	m_BackdropClock.Enabled = Value And Not(m_Disposed)
	ApplyBackdropOptions
	#End If
End Sub
Public Sub getLiveBackdrop As Boolean
	Return m_LiveBackdrop
End Sub
Public Sub setBackdropRefreshInterval(Value As Int)
	m_BackdropInterval = Max(16, Value)
	m_BackdropClock.Interval = Max(100, m_BackdropInterval)
	ApplyBackdropOptions
End Sub
Public Sub getBackdropRefreshInterval As Int
	Return m_BackdropInterval
End Sub
Private Sub ApplyBackdropOptions
	#If Not(B4i)
	If mBase.IsInitialized = False Or m_Disposed Then Return
	Dim native As JavaObject = Me
	native.RunMethod("setBackdropOptions", Array(m_LiveBackdrop, m_BackdropInterval))
	#End If
End Sub

Private Sub Native_BackdropFrame
	RenderBackdropFrame
End Sub

Private Sub BackdropClock_Tick
	#If Not(B4i)
	Dim native As JavaObject = Me
	If native.RunMethod("isBackdropMotionActive", Null) Then Return
	#End If
	RenderBackdropFrame
End Sub

Private Sub RenderBackdropFrame
	#If Not(B4i)
	If m_Disposed Or mBase.IsInitialized = False Then Return
	If mBase.Visible = False Or m_Tabs.Size = 0 Then Return
	Dim visibility As JavaObject = Me
	If visibility.RunMethod("actuallyVisible", Array(mBase)) = False Then Return
	Dim dark As Boolean = m_Theme.ToLowerCase = "dark"
	If m_Theme.ToLowerCase = "auto" Then
		Dim native As JavaObject = Me
		dark = native.RunMethod("systemDark", Array(mBase))
	End If
	'An opaque material cannot reveal changes behind it; keep its cached bitmap.
	If Bit.UnsignedShiftRight(ResolveGlassTint(dark), 24) = 255 Then Return
	Dim material As B4XBitmap = CaptureMaterial(dark)
	If material.IsInitialized Then m_Native.RunMethod("updateMaterial", Array(material))
	RefreshAccessoryMaterial(dark)
	#End If
End Sub

#If B4i
Public Sub getNativeController As NativeObject
	Dim native As NativeObject = Me
	Return native.RunMethod("nativeController:", Array(m_Native))
End Sub
#End If

'Optional scene panel, otherwise the parent is captured with this bar temporarily hidden.
Public Sub SetBackdropView(Source As B4XView)
	If Source = mBase Or Source = m_Parent Then Return
	m_Backdrop = Source
	ScheduleRefresh
End Sub

#If Not(B4i)
Private Sub CaptureMaterial(Dark As Boolean) As B4XBitmap
	Return RenderRegion(mBase.Left + 16dip, mBase.Top + Max(0, mBase.Height - 72dip), Max(1dip, mBase.Width - 32dip), Min(64dip, mBase.Height), Dark)
End Sub

Private Sub RefreshAccessoryMaterial(Dark As Boolean)
	If m_Accessory.IsInitialized = False Or m_AccessoryHost.IsInitialized = False Then Return
	If m_AccessoryHost.Width < 1 Or m_AccessoryHost.Height < 1 Then Return
	Dim bitmap As B4XBitmap = RenderRegion(m_AccessoryHost.Left, m_AccessoryHost.Top, m_AccessoryHost.Width, m_AccessoryHost.Height, Dark)
	If bitmap.IsInitialized Then m_AccessoryImage.SetBitmap(bitmap)
End Sub

Private Sub RenderRegion(Left As Float, Top As Float, Width As Float, Height As Float, Dark As Boolean) As B4XBitmap
	Dim source As B4XView = m_Backdrop
	If source.IsInitialized = False Then
		If m_Navigation And m_Index >= 0 Then
			source = m_Pages.Get(m_Index)
		Else
			source = m_Parent
		End If
	End If
	Dim empty As B4XBitmap
	If source.Width < 1 Or source.Height < 1 Or Width < 1 Or Height < 1 Then Return empty
	Dim p As B4XView = source
	Dim sx As Float = 0, sy As Float = 0
	Dim native As JavaObject = Me
	Do While p.IsInitialized
		If p = m_Parent Then Exit
		sx = sx + p.Left
		sy = sy + p.Top
		p = native.RunMethod("parentOrNull", Array(p))
	Loop
	If p.IsInitialized = False Then Return empty
	Left = Left - sx
	Top = Top - sy
	If Left < 0 Or Top < 0 Or Left + Width > source.Width + 0.5 Or Top + Height > source.Height + 0.5 Then Return empty
	Dim renderWidth As Int = Max(1, Min(480, Round(Width * 0.75)))
	Dim renderHeight As Int = Max(1, Round(renderWidth * Height / Width))
	Dim accessory As Object = Null
	If m_AccessoryHost.IsInitialized Then accessory = m_AccessoryHost
	Dim background As Int = m_Parent.Color
	If Bit.UnsignedShiftRight(background, 24) < 255 Then background = IIf(Dark, 0xFF1C1C1E, 0xFFF2F2F7)
	Dim crop As B4XBitmap
	Try
		crop = native.RunMethod("captureRegion", Array(source, Left, Top, Width, Height, renderWidth, renderHeight, mBase, accessory, background))
	Catch
		Log("AS_LiquidGlassTabBar: " & LastException.Message)
	End Try
	If crop.IsInitialized = False Then Return empty
	Dim scale As Float = renderHeight / Height
	Dim tint As Int = ResolveGlassTint(Dark)
	Return m_Renderer.RenderWithLighting(crop, renderWidth, renderHeight, renderHeight / 2, Round(m_BlurRadius * scale), 7dip * scale, 14dip * scale, 0.1, 1.05, tint, 0.2, -1, -1, 0.12)
End Sub

Private Sub SymbolBitmap(Symbol As String) As B4XBitmap
	Dim glyph As Int
	Select Symbol.ToLowerCase
		Case "house", "house.fill": glyph = 0xF015
		Case "heart", "heart.fill": glyph = 0xF004
		Case "magnifyingglass": glyph = 0xF002
		Case "gear", "gearshape", "gearshape.fill": glyph = 0xF013
		Case "person", "person.fill", "person.crop.circle": glyph = 0xF007
		Case "star", "star.fill": glyph = 0xF005
		Case "clock", "clock.fill": glyph = 0xF017
		Case "folder", "folder.fill": glyph = 0xF07B
		Case "music.note": glyph = 0xF001
		Case Else: glyph = 0xF111
	End Select
	Dim panel As B4XView = xui.CreatePanel("")
	panel.SetLayoutAnimated(0, 0, 0, 28dip, 28dip)
	Dim canvas As B4XCanvas
	canvas.Initialize(panel)
	Dim font As B4XFont = xui.CreateFontAwesome(23)
	Dim rect As B4XRect = canvas.MeasureText(Chr(glyph), font)
	canvas.DrawText(Chr(glyph), 14dip, 14dip - rect.Height / 2 - rect.Top, font, xui.Color_Black, "CENTER")
	Dim result As B4XBitmap = canvas.CreateBitmap
	canvas.Release
	Return result
End Sub
#End If

#If OBJC
- (void)anchorCustomButton:(UIView *)view { view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin; }
// UIKit owns its controller, view lifecycle, tab gestures, search placement,
// sidebar adaptation, accessibility, accessory and scroll minimization.
- (NSMutableDictionary *)createNativeBar:(UIView *)host navigation:(NSNumber *)navigation {
    NSMutableDictionary *state = [NSMutableDictionary new];
    UITabBar *bar;
    if (navigation.boolValue) {
        UITabBarController *controller = [UITabBarController new];
        controller.delegate = (id<UITabBarControllerDelegate>)self;
        UIResponder *responder = host;
        while (responder && ![responder isKindOfClass:[UIViewController class]]) responder = responder.nextResponder;
        UIViewController *parent = (UIViewController *)responder;
        if (parent) [parent addChildViewController:controller];
        controller.view.frame = host.bounds;
        controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        controller.view.backgroundColor = UIColor.clearColor;
        [host addSubview:controller.view];
        if (parent) [controller didMoveToParentViewController:parent];
        state[@"controller"] = controller;
        bar = controller.tabBar;
    } else {
        bar = [[UITabBar alloc] initWithFrame:host.bounds];
        bar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        bar.delegate = (id<UITabBarDelegate>)self;
        [host addSubview:bar];
    }
    state[@"bar"] = bar;
    [self resetNativeItems:state];
    UILongPressGestureRecognizer *hold = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(nativeHold:)];
    hold.minimumPressDuration = 0.45;
    hold.cancelsTouchesInView = NO;
    hold.delaysTouchesBegan = NO;
    hold.delaysTouchesEnded = NO;
    hold.delegate = (id<UIGestureRecognizerDelegate>)self;
    [bar addGestureRecognizer:hold];
    return state;
}
- (void)anchorHost:(UIView *)host navigation:(NSNumber *)navigation {
    host.autoresizingMask = UIViewAutoresizingFlexibleWidth | (navigation.boolValue ? UIViewAutoresizingFlexibleHeight : UIViewAutoresizingFlexibleTopMargin);
}
- (void)resetNativeItems:(NSMutableDictionary *)state {
    state[@"items"] = [NSMutableArray new];
    state[@"controllers"] = [NSMutableArray new];
    state[@"tabs"] = [NSMutableArray new];
}
- (void)appendNativeItem:(NSMutableDictionary *)state title:(NSString *)title symbol:(NSString *)symbol image:(UIImage *)image badge:(NSString *)badge visible:(NSNumber *)visible enabled:(NSNumber *)enabled content:(UIView *)content search:(NSNumber *)search {
    if (image == nil) { if (@available(iOS 13.0, *)) image = [UIImage systemImageNamed:symbol]; }
    NSMutableArray *items = state[@"items"];
    NSInteger index = items.count;
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image tag:index];
    item.enabled = enabled.boolValue;
    item.badgeValue = visible.boolValue ? badge : nil;
    [items addObject:item];
    if (!state[@"controller"]) return;
    UIViewController *vc = [UIViewController new];
    vc.view = content;
    content.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    vc.view.backgroundColor = content.backgroundColor;
    vc.tabBarItem = item;
    [state[@"controllers"] addObject:vc];
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 180000
    if (@available(iOS 18.0, *)) {
        UITab *tab;
        if (search.boolValue) {
            tab = [[UISearchTab alloc] initWithViewControllerProvider:^UIViewController *(UITab *t) { return vc; }];
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 260000
            if (@available(iOS 26.0, *)) ((UISearchTab *)tab).automaticallyActivatesSearch = YES;
# endif
            tab.title = title;
        } else {
            tab = [[UITab alloc] initWithTitle:title image:image identifier:[NSString stringWithFormat:@"AS.Tab.%ld", (long)index] viewControllerProvider:^UIViewController *(UITab *t) { return vc; }];
        }
        tab.userInfo = @{@"index": @(index), @"enabled": enabled};
        tab.badgeValue = item.badgeValue;
        tab.allowsHiding = NO;
        if ([tab respondsToSelector:NSSelectorFromString(@"setEnabled:")]) [tab setValue:enabled forKey:@"enabled"];
        [state[@"tabs"] addObject:tab];
    }
# endif
}
- (void)finishNativeBar:(NSMutableDictionary *)state index:(NSNumber *)index theme:(NSString *)theme color:(UIColor *)color {
    UITabBar *bar = state[@"bar"];
    UITabBarController *controller = state[@"controller"];
    UIView *appearance = controller ? controller.view : bar;
    if (@available(iOS 13.0, *)) {
        appearance.overrideUserInterfaceStyle = [theme.lowercaseString isEqualToString:@"dark"] ? UIUserInterfaceStyleDark : [theme.lowercaseString isEqualToString:@"light"] ? UIUserInterfaceStyleLight : UIUserInterfaceStyleUnspecified;
    }
    bar.tintColor = color;
    if (controller) {
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 180000
        if (@available(iOS 18.0, *)) controller.tabs = state[@"tabs"];
        else
# endif
        [controller setViewControllers:state[@"controllers"] animated:NO];
        controller.customizableViewControllers = nil;
    } else [bar setItems:state[@"items"] animated:NO];
    [self selectNative:state index:index];
}
- (void)nativeOptions:(NSMutableDictionary *)state behavior:(NSString *)behavior mode:(NSString *)mode reduceMotion:(NSNumber *)reduceMotion {
    UITabBarController *controller = state[@"controller"];
    if (!controller) return;
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 180000
    if (@available(iOS 18.0, *)) {
        controller.mode = [mode.lowercaseString isEqualToString:@"tabsidebar"] ? UITabBarControllerModeTabSidebar : [mode.lowercaseString isEqualToString:@"tabbar"] ? UITabBarControllerModeTabBar : UITabBarControllerModeAutomatic;
    }
# endif
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 260000
    if (@available(iOS 26.0, *)) {
        controller.tabBarMinimizeBehavior = [behavior.lowercaseString isEqualToString:@"onscrolldown"] ? UITabBarMinimizeBehaviorOnScrollDown : [behavior.lowercaseString isEqualToString:@"onscrollup"] ? UITabBarMinimizeBehaviorOnScrollUp : [behavior.lowercaseString isEqualToString:@"automatic"] ? UITabBarMinimizeBehaviorAutomatic : UITabBarMinimizeBehaviorNever;
    }
# endif
}
- (void)selectNative:(NSMutableDictionary *)state index:(NSNumber *)index {
    NSInteger i = index.integerValue;
    UITabBarController *controller = state[@"controller"];
    if (controller) {
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 180000
        if (@available(iOS 18.0, *)) {
            if (i>=0 && i<controller.tabs.count) controller.selectedTab = controller.tabs[i];
            return;
        }
# endif
        if (i>=0 && i<controller.viewControllers.count) controller.selectedIndex = i;
    } else {
        UITabBar *bar = state[@"bar"];
        bar.selectedItem = i>=0 && i<bar.items.count ? bar.items[i] : nil;
    }
}
- (void)resizeNative:(NSMutableDictionary *)state width:(NSNumber *)width height:(NSNumber *)height {
    UITabBarController *controller = state[@"controller"];
    UIView *view = controller ? controller.view : state[@"bar"];
    view.frame = CGRectMake(0, 0, width.doubleValue, height.doubleValue);
    [view setNeedsLayout];
}
- (void)setNativeAccessory:(NSMutableDictionary *)state content:(UIView *)content height:(NSNumber *)height {
    UITabBarController *controller = state[@"controller"];
    if (!controller) { NSLog(@"AS_LiquidGlassTabBar: SetAccessory requires CreateNavigation on iOS."); return; }
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 260000
    if (@available(iOS 26.0, *)) {
        NSLayoutConstraint *old = state[@"accessoryHeight"];
        old.active = NO;
        [state removeObjectForKey:@"accessoryHeight"];
        if (content) {
            [content removeFromSuperview];
            NSLayoutConstraint *constraint = [content.heightAnchor constraintEqualToConstant:height.doubleValue];
            constraint.active = YES;
            state[@"accessoryHeight"] = constraint;
            UITabAccessory *accessory = [[UITabAccessory alloc] initWithContentView:content];
            [controller setBottomAccessory:accessory animated:YES];
        } else [controller setBottomAccessory:nil animated:YES];
        return;
    }
# endif
    NSLog(@"AS_LiquidGlassTabBar: native bottom accessory requires an iOS 26+ SDK and device.");
}
- (void)tabBar:(UITabBar *)bar didSelectItem:(UITabBarItem *)item {
    [self.bi raiseEvent:nil event:@"native_selected:" params:@[@(item.tag)]];
}
- (BOOL)tabBarController:(UITabBarController *)controller shouldSelectViewController:(UIViewController *)vc { return vc.tabBarItem.enabled; }
- (void)tabBarController:(UITabBarController *)controller didSelectViewController:(UIViewController *)vc {
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 180000
    if (@available(iOS 18.0, *)) return;
# endif
    [self.bi raiseEvent:nil event:@"native_selected:" params:@[@(vc.tabBarItem.tag)]];
}
# if __IPHONE_OS_VERSION_MAX_ALLOWED >= 180000
- (BOOL)tabBarController:(UITabBarController *)controller shouldSelectTab:(UITab *)tab API_AVAILABLE(ios(18.0)) { return [tab.userInfo[@"enabled"] boolValue]; }
- (void)tabBarController:(UITabBarController *)controller didSelectTab:(UITab *)tab previousTab:(UITab *)previousTab API_AVAILABLE(ios(18.0)) {
    [self.bi raiseEvent:nil event:@"native_selected:" params:@[tab.userInfo[@"index"]]];
}
# endif
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)a shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)b { return YES; }
- (void)nativeHold:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateBegan) return;
    UITabBar *bar = (UITabBar *)recognizer.view;
    CGPoint point = [recognizer locationInView:bar];
    if (bar.items.count == 0) return;
    // This event observes the touch only. No replacement pan recognizer or selection logic.
    NSInteger index = MIN(bar.items.count-1, MAX(0, (NSInteger)(point.x/MAX(1,bar.bounds.size.width)*bar.items.count)));
    if (bar.items[index].enabled) [self.bi raiseEvent:nil event:@"native_hold:" params:@[@(bar.items[index].tag)]];
}
- (UITabBarController *)nativeController:(NSMutableDictionary *)state { return state[@"controller"]; }
- (void)disposeNative:(NSMutableDictionary *)state {
    NSLayoutConstraint *height = state[@"accessoryHeight"];
    height.active = NO;
    UITabBarController *controller = state[@"controller"];
    if (controller) {
        controller.delegate = nil;
        [controller willMoveToParentViewController:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
    } else { UITabBar *bar=state[@"bar"];bar.delegate=nil;[bar removeFromSuperview]; }
    [state removeAllObjects];
}
#End If
