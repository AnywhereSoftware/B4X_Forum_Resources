B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.01
@EndOfDesignText@
Sub Class_Globals

#if 0
    // Lower and Upper bounds for range checking in HSV color space
    private Scalar mLowerBound = new Scalar(0);
    private Scalar mUpperBound = new Scalar(0);
    // Minimum contour area in percent for contours filtering
    private static double mMinContourArea = 0.1;
    // Color radius for range checking in HSV color space
    private Scalar mColorRadius = new Scalar(25,50,50,0);
    private Mat mSpectrum = new Mat();
    private List<MatOfPoint> mContours = new ArrayList<MatOfPoint>();

    // Cache
    Mat mPyrDownMat = new Mat();
    Mat mHsvMat = new Mat();
    Mat mMask = new Mat();
    Mat mDilatedMask = new Mat();
    Mat mHierarchy = new Mat();
#End If
	Private mLowerBound As OCVScalar
	Private mUpperBound As OCVScalar
	Private mMinContourArea As Double = 0.1
	
	Private mColorRadius As OCVScalar
	Private mSpectrum As OCVMat
	Private mContours As List

	'Cache
	Private mPyrDownMat As OCVMat
	Private mHsvMat As OCVMat
	Private mMask As OCVMat
	Private mDilatedMask As OCVMat
	Private mHierarchy As OCVMat
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	mLowerBound.Set(Array As Double(0))
	mUpperBound.Set(Array As Double(0))
	mMinContourArea=0.1
	mColorRadius.Set(Array As Double(25,50,70,0))
	
	mSpectrum.Initialize
	mPyrDownMat.Initialize
	mHsvMat.Initialize
	mMask.Initialize
	mDilatedMask.Initialize
	mHierarchy.Initialize
End Sub

Public Sub setColorRadius(radius As OCVScalar)
	
	mColorRadius=radius
End Sub

public Sub setHsvColor(hsvColor As OCVScalar)
#if 0
        double minH = (hsvColor.val[0] >= mColorRadius.val[0]) ? hsvColor.val[0]-mColorRadius.val[0] : 0;
        double maxH = (hsvColor.val[0]+mColorRadius.val[0] <= 255) ? hsvColor.val[0]+mColorRadius.val[0] : 255;

        mLowerBound.val[0] = minH;
        mUpperBound.val[0] = maxH;

        mLowerBound.val[1] = hsvColor.val[1] - mColorRadius.val[1];
        mUpperBound.val[1] = hsvColor.val[1] + mColorRadius.val[1];

        mLowerBound.val[2] = hsvColor.val[2] - mColorRadius.val[2];
        mUpperBound.val[2] = hsvColor.val[2] + mColorRadius.val[2];

        mLowerBound.val[3] = 0;
        mUpperBound.val[3] = 255;

        Mat spectrumHsv = new Mat(1, (int)(maxH-minH), CvType.CV_8UC3);

        for (int j = 0; j < maxH-minH; j++) {
            byte[] tmp = {(byte)(minH+j), (byte)255, (byte)255};
            spectrumHsv.put(0, j, tmp);
        }

        Imgproc.cvtColor(spectrumHsv, mSpectrum, Imgproc.COLOR_HSV2RGB_FULL, 4);
#End If

	Dim minH As Double = Max(hsvColor.val(0)-mColorRadius.val(0),0)
	Dim maxH As Double = Min(hsvColor.val(0)+mColorRadius.val(0),255)	

	mLowerBound.val(0)=minH
	mUpperBound.val(0)=maxH
	mLowerBound.val(1)=hsvColor.val(1)-mColorRadius.val(1)
	mUpperBound.val(1)=hsvColor.val(1)+mColorRadius.val(1)
	mLowerBound.val(2)=hsvColor.val(2)-mColorRadius.val(2)
	mUpperBound.val(2)=hsvColor.val(2)+mColorRadius.val(2)
	mLowerBound.val(3)=0
	mUpperBound.val(3)=255
	
	Dim spectrumHsv As OCVMat
	Dim cvt As OCVCvType
	spectrumHsv=spectrumHsv.zeros(1,maxH-minH,cvt.CV_8UC3)
	
	For j=0 To (maxH-minH)
		Dim tmp() As Byte = Array As Byte(minH+j,255,255)
		spectrumHsv.put4(0,j,tmp)
	Next
	
	Dim mImgProc As OCVImgproc
	mImgProc.cvtColor(spectrumHsv,mSpectrum,mImgProc.COLOR_HSV2RGB_FULL,4)

End Sub

public Sub getSpectrum() As OCVMat
	
	Return mSpectrum
End Sub

public Sub setMinContourArea(area As Double)
	
	mMinContourArea = area
End Sub

Sub process(rgbaImage As OCVMat)
#if 0
        Imgproc.pyrDown(rgbaImage, mPyrDownMat);
        Imgproc.pyrDown(mPyrDownMat, mPyrDownMat);

        Imgproc.cvtColor(mPyrDownMat, mHsvMat, Imgproc.COLOR_RGB2HSV_FULL);

        Core.inRange(mHsvMat, mLowerBound, mUpperBound, mMask);
        Imgproc.dilate(mMask, mDilatedMask, new Mat());

        List<MatOfPoint> contours = new ArrayList<MatOfPoint>();

        Imgproc.findContours(mDilatedMask, contours, mHierarchy, Imgproc.RETR_EXTERNAL, Imgproc.CHAIN_APPROX_SIMPLE);

        // Find max contour area
        double maxArea = 0;
        Iterator<MatOfPoint> each = contours.iterator();
        while (each.hasNext()) {
            MatOfPoint wrapper = each.next();
            double area = Imgproc.contourArea(wrapper);
            if (area > maxArea)
                maxArea = area;
        }

        // Filter contours by area and resize to fit the original image size
        mContours.clear();
        each = contours.iterator();
        while (each.hasNext()) {
            MatOfPoint contour = each.next();
            if (Imgproc.contourArea(contour) > mMinContourArea*maxArea) {
                Core.multiply(contour, new Scalar(4,4), contour);
                mContours.add(contour);
            }
        }
#End If

	Dim mImgProc As OCVImgproc
	Dim mCore As OCVCore
	
	mImgProc.pyrDown2(rgbaImage,mPyrDownMat)
	mImgProc.pyrDown2(mPyrDownMat,mPyrDownMat)	

	mImgProc.cvtColor(mPyrDownMat,mHsvMat,mImgProc.COLOR_RGB2HSV_FULL,3)
	
	mCore.inRange(mHsvMat,mLowerBound,mUpperBound,mMask)
	Dim mTmpMat As OCVMat
	mTmpMat.Initialize
	mImgProc.dilate2(mMask,mDilatedMask,mTmpMat)
	
	Dim contours As List
	contours.Initialize
	
	'mImgProc.findContours1(mDilatedMask,contours,mHierarchy,mImgProc.RETR_EXTERNAL,mImgProc.CHAIN_APPROX_SIMPLE)
	mImgProc.findContours1(mDilatedMask,contours,mHierarchy,mImgProc.RETR_LIST,mImgProc.CHAIN_APPROX_SIMPLE)
	'Find max contour area
	Dim maxArea As Double=0
	For Each mEach As OCVMatOfPoint In contours	'OCVMatOfPoint2f in 3.20 version
		Dim area As Double = mImgProc.contourArea1(mEach)
		If area>maxArea Then maxArea=area
	Next
	'Log("maxArea is:"&maxArea)
	
	'Filter contours by area and resize to fit the original image size
	mContours.Initialize
	For Each contour As OCVMatOfPoint In contours	'OCVMatOfPoint2f
		If mImgProc.contourArea1(contour)> mMinContourArea*maxArea Then
			Dim mScalarTmp As OCVScalar
			mScalarTmp.Set(Array As Double(4,4))
			mCore.multiply5(contour,mScalarTmp,contour)	
			mContours.Add(contour)			
		End If
	Next	
	
End Sub

Sub getContours() As List
	
	Return mContours
End Sub








