B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private mJavaTrans As JavaObject
	Private mFactoryClass As JavaObject
End Sub

'Initializes this transformation as the identity transformation (no change):
'   | 1 0 0 |
'   | 0 1 0 |
'   | 0 0 1 |
'Build the desired transformation by chaining: Rotate, Scale, Translate,
'Shear, Reflect, Compose, ComposeBefore, SetTransformation,
'CreateFromControlVectors, or CreateFromBaseLines.
Public Sub Initialize
	mFactoryClass.InitializeStatic("org.locationtech.jts.geom.util.AffineTransformationFactory")
	mJavaTrans.InitializeNewInstance("org.locationtech.jts.geom.util.AffineTransformation", Null)
End Sub

'Returns a new JTSAffineTransformation set to the identity transformation.
'Useful for forking a fresh transformation from an existing instance, or as
'a chain starter to keep the original untouched.
'Example: someAt.IdentityInstance.Rotate(0.5).Translate(10, 20).Transform(g)
Public Sub IdentityInstance As JTSAffineTransformation
	Dim t As JTSAffineTransformation
	t.Initialize
	Return t
End Sub

'Internal: returns the underlying Java AffineTransformation. Used by Compose, ComposeBefore.
Public Sub GetJavaTrans As JavaObject
	Return mJavaTrans
End Sub

'-------- AffineTransformationFactory methods (mutate this, return Me) --------

'Replaces this transformation with one built from three control vectors (general affine).
'The source points must not be collinear.
'Returns Me for chaining.
Public Sub CreateFromControlVectors(src0 As JTSCoordinate, src1 As JTSCoordinate, src2 As JTSCoordinate, _
                                    dest0 As JTSCoordinate, dest1 As JTSCoordinate, dest2 As JTSCoordinate) As JTSAffineTransformation
	mJavaTrans = mFactoryClass.RunMethod("createFromControlVectors", _
        Array(src0.GetJavaCoord, src1.GetJavaCoord, src2.GetJavaCoord, _
              dest0.GetJavaCoord, dest1.GetJavaCoord, dest2.GetJavaCoord))
	Return Me
End Sub

'Replaces this transformation with one built from a pair of control vectors.
'The result combines uniform scale, rotation, and translation (no shear/reflection).
'If the vectors do not determine a well-defined transformation (e.g. src0 == src1),
'this transformation is left unchanged.
'Returns Me for chaining.
Public Sub CreateFromControlVectors2(src0 As JTSCoordinate, src1 As JTSCoordinate, _
                                     dest0 As JTSCoordinate, dest1 As JTSCoordinate) As JTSAffineTransformation
	Dim raw As JavaObject = mFactoryClass.RunMethod("createFromControlVectors", _
        Array(src0.GetJavaCoord, src1.GetJavaCoord, dest0.GetJavaCoord, dest1.GetJavaCoord))
	If raw <> Null Then mJavaTrans = raw
	Return Me
End Sub

'Replaces this transformation with one built from a single control vector (pure translation).
'Returns Me for chaining.
Public Sub CreateFromControlVectors3(src0 As JTSCoordinate, dest0 As JTSCoordinate) As JTSAffineTransformation
	mJavaTrans = mFactoryClass.RunMethod("createFromControlVectors", _
        Array(src0.GetJavaCoord, dest0.GetJavaCoord))
	Return Me
End Sub

'Replaces this transformation with one built from 1-3 control vectors supplied as lists.
'srcList and destList must have the same length (1, 2, or 3 elements).
'Throws IllegalArgumentException for invalid lengths.
'Returns Me for chaining.
Public Sub CreateFromControlVectors4(srcList As List, destList As List) As JTSAffineTransformation
	Dim srcArr(srcList.Size) As Object
	Dim i As Int
	For i = 0 To srcList.Size - 1
		srcArr(i) = srcList.Get(i).As(JTSCoordinate).GetJavaCoord
	Next
	Dim destArr(destList.Size) As Object
	For i = 0 To destList.Size - 1
		destArr(i) = destList.Get(i).As(JTSCoordinate).GetJavaCoord
	Next
	Dim srcJava As JavaObject
	srcJava.InitializeArray("org.locationtech.jts.geom.Coordinate", srcArr)
	Dim destJava As JavaObject
	destJava.InitializeArray("org.locationtech.jts.geom.Coordinate", destArr)
	mJavaTrans = mFactoryClass.RunMethod("createFromControlVectors", Array(srcJava, destJava))
	Return Me
End Sub

'Replaces this transformation with one defined by a mapping between two baselines.
'The result is the composition of: translation from src0 to dest0, rotation by the angle
'between the baselines about dest0, and uniform scaling by the ratio of baseline lengths.
'If the source baseline has zero length, this becomes the identity.
'Returns Me for chaining.
Public Sub CreateFromBaseLines(src0 As JTSCoordinate, src1 As JTSCoordinate, _
                               dest0 As JTSCoordinate, dest1 As JTSCoordinate) As JTSAffineTransformation
	mJavaTrans = mFactoryClass.RunMethod("createFromBaseLines", _
        Array(src0.GetJavaCoord, src1.GetJavaCoord, dest0.GetJavaCoord, dest1.GetJavaCoord))
	Return Me
End Sub

'-------- Direct matrix setters (mutate this, return Me) --------

'Resets this transformation to the identity. Useful for recycling an instance.
'Returns Me for chaining.
Public Sub SetToIdentity As JTSAffineTransformation
	mJavaTrans.RunMethod("setToIdentity", Null)
	Return Me
End Sub

'Sets this transformation's matrix entries directly.
'm00, m01, m02: first row of the transformation matrix.
'm10, m11, m12: second row of the transformation matrix.
'Returns Me for chaining.
Public Sub SetTransformation(m00 As Double, m01 As Double, m02 As Double, m10 As Double, m11 As Double, m12 As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("setTransformation", Array(m00, m01, m02, m10, m11, m12))
	Return Me
End Sub

'Sets this transformation to be a copy of another transformation.
'Returns Me for chaining.
Public Sub SetTransformation2(trans As JTSAffineTransformation) As JTSAffineTransformation
	mJavaTrans.RunMethod("setTransformation", Array(trans.GetJavaTrans))
	Return Me
End Sub

'-------- Compose with the current transformation (mutate this, return Me) --------

'Composes a reflection about the line (x0,y0)-(x1,y1) onto this transformation.
'Returns Me for chaining.
Public Sub Reflect(x0 As Double, y0 As Double, x1 As Double, y1 As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("reflect", Array(x0, y0, x1, y1))
	Return Me
End Sub

'Composes a reflection about the line (0,0)-(x,y) onto this transformation.
'Returns Me for chaining.
Public Sub Reflect2(x As Double, y As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("reflect", Array(x, y))
	Return Me
End Sub

'Composes a rotation about the origin onto this transformation.
'theta: rotation angle in radians. Positive = counter-clockwise.
'Returns Me for chaining.
Public Sub Rotate(theta As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("rotate", Array(theta))
	Return Me
End Sub

'Composes a rotation about the origin specified by sin/cos onto this transformation.
'Useful for exact quarter-turn rotations (sin=1, cos=0 for 90°) to avoid floating-point error.
'Returns Me for chaining.
Public Sub Rotate2(sinTheta As Double, cosTheta As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("rotate", Array(sinTheta, cosTheta))
	Return Me
End Sub

'Composes a rotation about (x,y) onto this transformation.
'Returns Me for chaining.
Public Sub Rotate3(theta As Double, x As Double, y As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("rotate", Array(theta, x, y))
	Return Me
End Sub

'Composes a rotation about (x,y) specified by sin/cos onto this transformation.
'Returns Me for chaining.
Public Sub Rotate4(sinTheta As Double, cosTheta As Double, x As Double, y As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("rotate", Array(sinTheta, cosTheta, x, y))
	Return Me
End Sub

'Composes a scaling relative to the origin onto this transformation.
'Returns Me for chaining.
Public Sub Scale(xScale As Double, yScale As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("scale", Array(xScale, yScale))
	Return Me
End Sub

'Composes a shear onto this transformation.
'Note: shear(1, 1) is NOT shear(1, 0) composed with shear(0, 1); it maps to the line x = y.
'Returns Me for chaining.
Public Sub Shear(xShear As Double, yShear As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("shear", Array(xShear, yShear))
	Return Me
End Sub

'Composes a translation by (x,y) onto this transformation.
'Returns Me for chaining.
Public Sub Translate(x As Double, y As Double) As JTSAffineTransformation
	mJavaTrans.RunMethod("translate", Array(x, y))
	Return Me
End Sub

'Composes trans after this transformation: this then trans.
'Mathematically: this := trans_matrix * this_matrix.
'Returns Me for chaining.
Public Sub Compose(trans As JTSAffineTransformation) As JTSAffineTransformation
	mJavaTrans.RunMethod("compose", Array(trans.GetJavaTrans))
	Return Me
End Sub

'Composes trans before this transformation: trans then this.
'Mathematically: this := this_matrix * trans_matrix.
'Returns Me for chaining.
Public Sub ComposeBefore(trans As JTSAffineTransformation) As JTSAffineTransformation
	mJavaTrans.RunMethod("composeBefore", Array(trans.GetJavaTrans))
	Return Me
End Sub

'-------- Apply this transformation --------

'Applies this transformation to g and returns the result as a new JTSGeometry.
'The input geometry is not modified. The output has the same SRID as g.
Public Sub Transform(g As JTSGeometry) As JTSGeometry
	Dim raw As JavaObject = mJavaTrans.RunMethod("transform", Array(g.GetJavaGeom))
	Dim result As JTSGeometry
	result.Initialize(raw)
	Return result
End Sub

'Applies this transformation to src and returns the result as a new JTSCoordinate.
'The input src is not modified. The new coordinate has Z = 0 because
'AffineTransformation operates only on the 2D X/Y plane.
'For in-place: src = at.Transform2(src)
Public Sub Transform2(src As JTSCoordinate) As JTSCoordinate
	Dim newRaw As JavaObject
	newRaw.InitializeNewInstance("org.locationtech.jts.geom.Coordinate", Null)
	mJavaTrans.RunMethod("transform", Array(src.GetJavaCoord, newRaw))
	Dim result As JTSCoordinate
	result.Initialize(newRaw)
	Return result
End Sub

'-------- Query --------

'Returns the 6 non-trivial matrix entries as { m00, m01, m02, m10, m11, m12 }.
Public Sub GetMatrixEntries As Double()
	Return mJavaTrans.RunMethod("getMatrixEntries", Null)
End Sub

'Returns the determinant of the transformation matrix (m00*m11 - m01*m10).
'A determinant of zero means the transformation is singular (not invertible).
Public Sub GetDeterminant As Double
	Return mJavaTrans.RunMethod("getDeterminant", Null)
End Sub

'Returns the inverse of this transformation as a new JTSAffineTransformation.
'Throws NoninvertibleTransformationException if the determinant is zero
'(geometrically, when the transformation collapses the plane onto a line or point).
Public Sub GetInverse As JTSAffineTransformation
	Dim raw As JavaObject = mJavaTrans.RunMethod("getInverse", Null)
	Dim entries() As Double = raw.RunMethod("getMatrixEntries", Null)
	Dim t As JTSAffineTransformation
	t.Initialize
	t.SetTransformation(entries(0), entries(1), entries(2), entries(3), entries(4), entries(5))
	Return t
End Sub

'Returns True if this is the identity transformation.
Public Sub IsIdentity As Boolean
	Return mJavaTrans.RunMethod("isIdentity", Null)
End Sub

'-------- Misc --------

'Returns a deep copy of this transformation.
Public Sub Clone As JTSAffineTransformation
	Dim t As JTSAffineTransformation
	t.Initialize
	t.SetTransformation2(Me)
	Return t
End Sub

'Returns True if trans has exactly the same 6 matrix entries as this transformation.
Public Sub Equals(trans As JTSAffineTransformation) As Boolean
	Return mJavaTrans.RunMethod("equals", Array(trans.GetJavaTrans))
End Sub

'Returns a text representation of the form
'"AffineTransformation[[m00, m01, m02], [m10, m11, m12]]".
Public Sub ToString As String
	Return mJavaTrans.RunMethod("toString", Null)
End Sub
