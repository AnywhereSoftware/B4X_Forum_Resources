B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
    Private xui As XUI
    Private mBaseView As B4XView
    Private mParent As B4XView
    Private mLeft, mTop, mWidth, mHeight As Int
    Private mRequestedWidth, mRequestedHeight As Int
    Private mSourceKind As String
    Private mAssetName As String
    Private mNetworkUrl As String
    Private mPlaceholderName As String
    Private mBitmap As B4XBitmap
    Private mPlaceholderBitmap As B4XBitmap
    Private mFitMode As String
    Private mTheme As UITheme
    Private mLoadStarted As Boolean
    Private mLoaded As Boolean
    Private mRequestId As Int
    Private mLoadTarget As Object
    Private mLoadEventName As String
    Private mErrorTarget As Object
    Private mErrorEventName As String
End Sub

' Creates an empty declarative image. Loaded bitmaps survive native remounts.
Public Sub Initialize As UIImage
    mBaseView = Null
    mParent = Null
    mRequestedWidth = -1
    mRequestedHeight = 160dip
    mSourceKind = ""
    mAssetName = ""
    mNetworkUrl = ""
    mPlaceholderName = ""
    mBitmap = Null
    mPlaceholderBitmap = Null
    mFitMode = "contain"
    mLoadStarted = False
    mLoaded = False
    mRequestId = 0
    mLoadTarget = Null
    mLoadEventName = ""
    mErrorTarget = Null
    mErrorEventName = ""
    Dim defaultTheme As UITheme
    defaultTheme.Initialize
    mTheme = defaultTheme
    Return Me
End Sub

' Loads an image bundled in the host application's Files folder.
Public Sub Asset(Name As String) As UIImage
    mSourceKind = "asset"
    mAssetName = Name.Trim
    mNetworkUrl = ""
    mBitmap = Null
    mLoaded = False
    mLoadStarted = False
    mRequestId = mRequestId + 1
    Return Me
End Sub

' Loads an image from a public URL without exposing HttpJob to the caller.
Public Sub Network(Url As String) As UIImage
    mSourceKind = "network"
    mNetworkUrl = Url.Trim
    mAssetName = ""
    mBitmap = Null
    mLoaded = False
    mLoadStarted = False
    mRequestId = mRequestId + 1
    Return Me
End Sub

' Uses a bundled asset while a network image is loading or unavailable.
Public Sub PlaceholderAsset(Name As String) As UIImage
    mPlaceholderName = Name.Trim
    mPlaceholderBitmap = Null
    Return Me
End Sub

' Sets contain, center or fill. Contain is the default and preserves aspect ratio.
Public Sub Fit(Value As String) As UIImage
    Dim normalized As String = Value.Trim.ToLowerCase
    If normalized = "fill" Or normalized = "center" Or normalized = "contain" Then
        mFitMode = normalized
    Else
        mFitMode = "contain"
    End If
    Return Me
End Sub

' Sets an explicit image width. Without it, the parent provides the width.
Public Sub Width(Value As Int) As UIImage
    mRequestedWidth = Max(0, Value)
    Return Me
End Sub

' Sets an explicit image height. The default is 160dip.
Public Sub Height(Value As Int) As UIImage
    mRequestedHeight = Max(0, Value)
    Return Me
End Sub

' Registers a no-argument callback after a network image is loaded.
Public Sub OnLoaded(Target As Object, EventName As String) As UIImage
    mLoadTarget = Target
    mLoadEventName = EventName
    Return Me
End Sub

' Registers a no-argument callback when a network image cannot be loaded.
Public Sub OnError(Target As Object, EventName As String) As UIImage
    mErrorTarget = Target
    mErrorEventName = EventName
    Return Me
End Sub

' Applies theme defaults without replacing source or layout choices.
Public Sub ApplyTheme(Theme As UITheme) As UIImage
    If Theme = Null Then Return Me
    If Theme.IsInitialized = False Then Return Me
    mTheme = Theme
    If mParent <> Null Then
        If mParent.IsInitialized Then ApplyViewStyle
    End If
    Return Me
End Sub

Public Sub SetParent(Parent As B4XView)
    mParent = Parent
End Sub

Public Sub SetPosition(Left As Int, Top As Int)
    mLeft = Left
    mTop = Top
End Sub

Public Sub SetSize(NewWidth As Int, NewHeight As Int)
    mWidth = Max(0, NewWidth)
    mHeight = Max(0, NewHeight)
End Sub

Public Sub Render
    If mParent = Null Then Return
    If mParent.IsInitialized = False Then Return

    EnsureLocalBitmaps
    Dim createBase As Boolean = False
    If mBaseView = Null Then
        createBase = True
    Else If mBaseView.IsInitialized = False Then
        createBase = True
    End If
    If createBase Then
        Dim image As ImageView
        image.Initialize("")
        mBaseView = image
        mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
    End If

    mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)
    ApplyViewStyle
    ApplyCurrentBitmap

    If mSourceKind = "network" And mLoaded = False And mLoadStarted = False Then
        StartNetworkLoad
    End If
End Sub

Private Sub EnsureLocalBitmaps
    If mPlaceholderName.Trim <> "" Then
        Try
            Dim loadedPlaceholder As B4XBitmap = xui.LoadBitmapResize(File.DirAssets, mPlaceholderName, Max(1, mWidth), Max(1, mHeight), True)
            If loadedPlaceholder.IsInitialized Then mPlaceholderBitmap = loadedPlaceholder
        Catch
            mPlaceholderBitmap = Null
        End Try
    End If

    If mSourceKind <> "asset" Then Return
    If mLoaded Then Return
    If mAssetName.Trim = "" Then Return

    Try
        Dim loadedAsset As B4XBitmap = xui.LoadBitmapResize(File.DirAssets, mAssetName, Max(1, mWidth), Max(1, mHeight), True)
        If loadedAsset.IsInitialized Then
            mBitmap = loadedAsset
            mLoaded = True
        End If
    Catch
        mLoaded = False
    End Try
End Sub

Private Sub ApplyViewStyle
    If mBaseView = Null Then Return
    If mBaseView.IsInitialized = False Then Return
    mBaseView.Color = mTheme.SurfaceVariant
    Dim image As ImageView = mBaseView
    If mFitMode = "fill" Then
        image.Gravity = Gravity.FILL
    Else
        image.Gravity = Gravity.CENTER
    End If
End Sub

Private Sub ApplyCurrentBitmap
    If mBaseView = Null Then Return
    If mBaseView.IsInitialized = False Then Return
    If mBitmap <> Null Then
        If mBitmap.IsInitialized Then
            mBaseView.SetBitmap(mBitmap)
            Return
        End If
    End If
    If mPlaceholderBitmap <> Null Then
        If mPlaceholderBitmap.IsInitialized Then mBaseView.SetBitmap(mPlaceholderBitmap)
    End If
End Sub

Private Sub StartNetworkLoad
    If mNetworkUrl = "" Then Return
    mLoadStarted = True
    mRequestId = mRequestId + 1
    Dim requestId As Int = mRequestId
    Dim job As HttpJob
    job.Initialize("", Me)
    job.Download(mNetworkUrl)
    job.GetRequest.SetHeader("User-Agent", "DeclarativeUI/1.0 (B4A image widget)")
    Wait For (job) JobDone(job As HttpJob)
    If requestId <> mRequestId Then
        job.Release
        Return
    End If
    If job.Success Then
        Dim downloaded As B4XBitmap
        Try
            downloaded = job.GetBitmapResize(Max(1, mWidth), Max(1, mHeight), True)
        Catch
            mLoadStarted = False
            Notify(mErrorTarget, mErrorEventName)
            job.Release
            Return
        End Try
        If downloaded.IsInitialized Then
            mBitmap = downloaded
            mLoaded = True
            ApplyCurrentBitmap
            Notify(mLoadTarget, mLoadEventName)
        Else
            mLoadStarted = False
            Notify(mErrorTarget, mErrorEventName)
        End If
    Else
        mLoadStarted = False
        Notify(mErrorTarget, mErrorEventName)
    End If
    job.Release
End Sub

Private Sub Notify(Target As Object, EventName As String)
    If Target = Null Or EventName.Trim = "" Then Return
    If SubExists(Target, EventName) Then CallSub(Target, EventName)
End Sub

' Returns the mounted native ImageView for optional animations.
Public Sub GetView As B4XView
    If mBaseView = Null Then Return Null
    If mBaseView.IsInitialized = False Then Return Null
    Return mBaseView
End Sub

Public Sub IsLoaded As Boolean
    Return mLoaded
End Sub

' Releases only the native view. Source and loaded bitmaps survive navigation.
' Invalidate any pending HTTP callback before releasing the mounted view.
Public Sub Unmount
    mRequestId = mRequestId + 1
    mLoadStarted = False
    mBaseView = Null
    mParent = Null
End Sub

Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
    Dim result As List
    result.Initialize
    Dim safeMaxWidth As Int = MaxWidth
    Dim safeMaxHeight As Int = MaxHeight
    If safeMaxWidth <= 0 Then safeMaxWidth = 10000
    If safeMaxHeight <= 0 Then safeMaxHeight = 10000
    Dim imageWidth As Int = safeMaxWidth
    If mRequestedWidth >= 0 Then imageWidth = Min(mRequestedWidth, safeMaxWidth)
    Dim imageHeight As Int = Min(mRequestedHeight, safeMaxHeight)
    result.Add(imageWidth)
    result.Add(imageHeight)
    Return result
End Sub