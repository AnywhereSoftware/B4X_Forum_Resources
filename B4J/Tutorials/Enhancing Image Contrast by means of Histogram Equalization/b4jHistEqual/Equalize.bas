B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private fx As JFX
	Private nativeMe As JavaObject
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	nativeMe = Me

End Sub

public Sub applyEqualize(img As Image) As Image
	
	Return nativeMe.RunMethod("equalize", Array(img))
	
End Sub

#If Java

import java.awt.image.BufferedImage;
import javafx.scene.image.Image;
import javafx.embed.swing.SwingFXUtils;
import java.awt.image.WritableRaster;


public Image equalize (Image src) {

    BufferedImage bmp = SwingFXUtils.fromFXImage(src, null);	
    

    BufferedImage nImg = new BufferedImage(bmp.getWidth(), bmp.getHeight(),
                         BufferedImage.TYPE_BYTE_GRAY);
    WritableRaster wr = bmp.getRaster();
    WritableRaster er = nImg.getRaster();
    int totpix= wr.getWidth()*wr.getHeight();
    int[] histogram = new int[256];

    for (int x = 0; x < wr.getWidth(); x++) {
        for (int y = 0; y < wr.getHeight(); y++) {
            histogram[wr.getSample(x, y, 0)]++;
        }
    }

    int[] chistogram = new int[256];
    chistogram[0] = histogram[0];
    for(int i=1;i<256;i++){
        chistogram[i] = chistogram[i-1] + histogram[i];
    }

    float[] arr = new float[256];
    for(int i=0;i<256;i++){
        arr[i] =  (float)((chistogram[i]*255.0)/(float)totpix);
    }

    for (int x = 0; x < wr.getWidth(); x++) {
        for (int y = 0; y < wr.getHeight(); y++) {
            int nVal = (int) arr[wr.getSample(x, y, 0)];
            er.setSample(x, y, 0, nVal);
        }
    }
    nImg.setData(er);
 
    Image img = SwingFXUtils.toFXImage(nImg, null);
    return img;


}


#end if