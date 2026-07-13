B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
'======================================================
' Standard multi-position Bottom Sheet for B4XPages.
' Works identically on B4A, B4i and B4J.
' Drag works from anywhere on the sheet (mSheet), not
' only from the handle.
'
' Public API:
'   Initialize(Root As B4XView, Owner As Object, EventName As String)
'   Build(SheetHeight, VisibleFractions())
'   OpenAt(Index)
'   Close
'   CurrentIndex
'	getContentPanel
'	getTop
'	ProcessSharedTouch
'
' Owner callback:
'   Sub <EventName>_StateChanged(Index As Int)
'   Sub <EventName>_HidingKeyboard
'======================================================

Sub Class_Globals
	Private xui As XUI
	Private classIME As IME	'IME Lib
	
	Private mRoot As B4XView
	Private mOwner As Object        'B4XPage instance that will receive the callback
	Private mEventName As String

	Private mSheet As B4XView		'The main panel of the BottomSheet
	Private mHandle As B4XView
	Private mContent As B4XView

	' --- Movement States and Physics ---
	Private mPositionsY() As Int	' Array containing the anchor coordinates (Expanded, Collapsed...)
	Private mCurrentIndex As Int	' Current position index
	Private mInitialIndex As Int	' 👈 Save the original index before the drag operation
	Private mLastY As Float			' Store the last AbsoluteY To calculate the delta

	Private mAnimDurationMs As Int

	Private mDownY As Float			' Y-coordinate of the first touch
	Private mIsDragging As Boolean	' Flag indicating whether the user is dragging
	Private HiddenKeyboardNow	As Boolean = False	' Indicates whether the keyboard is currently hidden. Avoid redundant calls To the keyboard

'	Private mCloseTimer As Timer
	
	Private Const ACTION_DOWN As Int = 0
	Private Const ACTION_UP As Int = 1
	Private Const ACTION_MOVE As Int = 2
	Private Const ACTION_CANCEL As Int = 3
End Sub


' ------------ PUBLIC METHODS (API) ------------

'Owner: usually "Me" from the B4XPage that creates this class (target of the callback)
Public Sub Initialize(Root As B4XView, Owner As Object, EventName As String)
	mRoot = Root
	mOwner = Owner
	mEventName = EventName
	mAnimDurationMs = 250
	mCurrentIndex = -1

'	mCloseTimer.Initialize("mCloseTimer", mAnimDurationMs)
	
	classIME.Initialize("")
End Sub

Public Sub Build(SheetHeight As Int, VisibleFractions() As Float)
	Dim n As Int = VisibleFractions.Length
	Dim positions(n + 1) As Int
	Dim i As Int
	For i = 0 To n - 1
		positions(i) = mRoot.Height - Round(SheetHeight * VisibleFractions(i))
	Next
	positions(n) = mRoot.Height
	mPositionsY = positions

	mSheet = xui.CreatePanel("mSheet")
	mSheet.Color = xui.Color_White
	mRoot.AddView(mSheet, 0, mPositionsY(mPositionsY.Length - 1), mRoot.Width, SheetHeight)

	' el alto del Handle adaptado para la curva).
	Dim HandleHeight As Int = 32dip
	mHandle = xui.CreatePanel("")
	mSheet.AddView(mHandle, 0, 0, mSheet.Width, HandleHeight)

	' 🌟 ¡MIRA QUÉ LIMPIO!: Llamamos a nuestro nuevo módulo de código
	UIUtils.SetTopCorners(mSheet, 28dip, xui.Color_White)
	UIUtils.SetTopCorners(mHandle, 28dip, xui.Color_RGB(224, 224, 224))

	' El contenedor de contenido ahora empieza justo debajo del nuevo Handle de 32dip
	mContent = xui.CreatePanel("")
	mSheet.AddView(mContent, 0, HandleHeight, mSheet.Width, SheetHeight - HandleHeight)
End Sub

Public Sub OpenAt(Index As Int)
	If Index < 0 Or Index > mPositionsY.Length - 2 Then Return
	MoveTo(Index)
End Sub

Public Sub Close
	MoveTo(mPositionsY.Length - 1)
End Sub

Public Sub CurrentIndex As Int
	Return mCurrentIndex
End Sub

' Para poder asignarle un layout
Public Sub getContentPanel As B4XView
	Return mContent
End Sub

' Para el suavizado del movimiento
Public Sub getTop As Int
	Return mSheet.Top
End Sub

' (The external public walkway)
' El núcleo matemático: procesa el toque unificado, aplica el filtro de atenuación
' y devuelve True si fue un click limpio (Tap).
' En lugar de recibir Y, recibe AbsoluteY
' Triggered when the user drags the BottomSheet by touching complex child views in B4XMainPage
' It does not calculate the Y coordinate. Instead, it receives a preprocessed absolute screen-space Y coordinate from an external source
Public Sub ProcessSharedTouch (TargetView As B4XView, Action As Int, AbsoluteY As Float) As Boolean
'	Dim expandedTop As Int = mPositionsY(0)
'	Dim lowestVisibleTop As Int = mPositionsY(mPositionsY.Length - 2)
	
	' Variable local para controlar el retorno
	Dim cleanClick As Boolean = False

	Select Action
		Case ACTION_DOWN
			mDownY = AbsoluteY
			mLastY = AbsoluteY
			mIsDragging = False ' 🌟 Importante: En DOWN todavía no estamos arrastrando
			
			' 🌟 EL COLOFÓN: Guardamos la posición inicial de la lista
			' Sin esto, 'SnapToNearest' no sabe calcular el destino al soltar el dedo.
			mInitialIndex = mCurrentIndex
			
		Case ACTION_MOVE
			' Control de umbral interno de la clase para activar el arrastre
			If mIsDragging = False And Abs(AbsoluteY - mDownY) > 15dip Then
				mIsDragging = True
			End If
			
			If mIsDragging Then
				ExecuteDragPhysics(AbsoluteY)
				
'				' Delta puro basado en la pantalla fija
'				Dim deltaY As Float = AbsoluteY - mLastY
'				mLastY = AbsoluteY
'				
'				Dim targetTop As Int = mSheet.Top + deltaY
'				
'				' Clamping (Límites superior e inferior)
'				If targetTop < expandedTop Then targetTop = expandedTop
'				If targetTop > lowestVisibleTop Then targetTop = lowestVisibleTop
'				
'				' Filtro de Atenuación impecable (40% Easing)
'				Dim smoothedTop As Int = mSheet.Top + 0.40 * (targetTop - mSheet.Top)
'				mSheet.Top = smoothedTop
			End If
			
		Case ACTION_UP, ACTION_CANCEL
			' 🌟 ¡EL SALVAVIDAS!: Capturamos el estado justo antes de resetearlo
			Dim wasDragging As Boolean = mIsDragging
			
			mIsDragging = False
			SnapToNearest
			
			' Si NO estábamos arrastrando, entonces ha sido un click limpio y real
			cleanClick = Not(wasDragging)
	End Select
	
	Return cleanClick
End Sub



' ------------ PRIVATE METHODS (INTERNAL LOGIC) ------------

' Realiza el deslizamiento final suave hacia la posición objetivo
Private Sub MoveTo(Index As Int)
	mCurrentIndex = Index

	mSheet.SetLayoutAnimated(mAnimDurationMs, mSheet.Left, mPositionsY(Index), mSheet.Width, mSheet.Height)
	CallSubDelayed2(mOwner, mEventName & "_StateChanged", Index)
End Sub

' (The native internal manager)
' Handles touch events for the main panel
' It activates when the user drags the BottomSheet, touching an empty area of ​​the sheet itself (the white background or the top handle)
' Calculates the absolute Y-coordinate in screen space
' Manages the keyboard
Private Sub mSheet_Touch(Action As Int, X As Float, Y As Float)
'	Dim expandedTop As Int = mPositionsY(0)
	
'	Dim hiddenTop As Int = mPositionsY(mPositionsY.Length - 1)
	' CAMBIO: El límite inferior ya no es el fondo total, sino la última posición visible
'	Dim lowestVisibleTop As Int = mPositionsY(mPositionsY.Length - 2)
	
	' 🌟 EL ANTÍDOTO: Convertimos la Y local en una coordenada absoluta de pantalla
	Dim AbsoluteY As Float = mSheet.Top + Y

	Select Action
		Case ACTION_DOWN
			' 👈 Reseteamos el interruptor para el nuevo intento de arrastre
			HiddenKeyboardNow = False
			
			' Guardamos la posición absoluta e inicializamos el rastreador de fotogramas
			mDownY = AbsoluteY
			mLastY = AbsoluteY
			mIsDragging = True
			mInitialIndex = mCurrentIndex
			
		Case ACTION_MOVE
			' 👈 ¡EL TRUCO MAESTRO AQUÍ!
			' classIME.HideKeyboard no necesita saber qué EditText está activo.
			' Cierra de golpe CUALQUIER teclado que esté abierto en la app.
			' 👈 ¡EL CERROJO!: Solo entramos si es la primera vez que se mueve en este toque
			If HiddenKeyboardNow = False Then
				HiddenKeyboardNow = True ' Cerramos el cerrojo inmediatamente
        
				' Log("Clase: Ocultando teclado (Solo 1 vez por arrastre)")
				' Android descarta la orden si el teclado no está abierto
				classIME.HideKeyboard
			
				' 👈 ¡EL PUENTE EXCLUSIVO PARA TU FIRMA!:
				' Comprobamos si en tu B4XMainPage existe la subrutina "BottomSheet1_OcultandoTeclado"
				If SubExists(mOwner, mEventName & "_HidingKeyboard") Then
					' Le pegamos el grito a la página principal
					CallSub(mOwner, mEventName & "_HidingKeyboard")
				End If
			End If
			
			If mIsDragging Then
				ExecuteDragPhysics(AbsoluteY)
				
'				' 1. 🌟 NUEVO CÁLCULO: Medimos el movimiento real entre este fotograma y el anterior
'				Dim deltaY As Float = AbsoluteY - mLastY
'				mLastY = AbsoluteY ' Actualizamos la marca para el próximo milisegundo
'				
'				' 2. Calculamos el destino ideal al que quiere ir el panel
'				Dim targetTop As Int = mSheet.Top + deltaY
'				
'				' 3. Aplicamos tus límites de seguridad
'				If targetTop < expandedTop Then targetTop = expandedTop
'				If targetTop > lowestVisibleTop Then targetTop = lowestVisibleTop
'				
'				' 4. 🌟 EL REMEDIO SANTO: Filtro de Atenuación (Easing)
'				' En vez de saltar a 'targetTop' de golpe (lo que causa la vibración),
'				' nos movemos solo un 40% de la distancia que falta en cada fotograma.
'				' Esto actúa como un "amortiguador" que absorbe el 100% del temblor.
'				Dim smoothedTop As Int = mSheet.Top + 0.40 * (targetTop - mSheet.Top)
'				
'				mSheet.Top = smoothedTop
			End If
			
		Case ACTION_UP, ACTION_CANCEL
			mIsDragging = False
			SnapToNearest
	End Select
End Sub

' Subrutina auxiliar de física unificada
' Aplica los límites de pantalla y el filtro de atenuación (easing) al arrastrar.
Private Sub ExecuteDragPhysics(AbsoluteY As Float)
	' 1. Calculamos el desplazamiento (delta) neto entre este fotograma y el anterior
	Dim deltaY As Float = AbsoluteY - mLastY
	mLastY = AbsoluteY
	
	' 2. Calculamos la posición teórica a la que quiere ir el panel
	Dim targetTop As Int = mSheet.Top + deltaY
	
	' 3. Clamping Guard (Límites de Seguridad)
	' mPositionsY(0)                  -> Límite Superior (Totalmente Expandido / Top Mínimo)
	' mPositionsY(mPositionsY.Length-2) -> Límite Inferior (Último estado visible antes de ocultarse)
	If targetTop < mPositionsY(0) Then targetTop = mPositionsY(0)	' Expanded top
	If targetTop > mPositionsY(mPositionsY.Length - 2) Then targetTop = mPositionsY(mPositionsY.Length - 2)	' lowest visible top
	
	' 4. Filtro de Atenuación (40% Easing) Easing Filter (40%)
	' Reduce drásticamente el temblor (jitter) al suavizar la transición física
	Dim smoothedTop As Int = mSheet.Top + 0.40 * (targetTop - mSheet.Top)
	mSheet.Top = smoothedTop
End Sub

' Calcula cuál es la posición del array mPositionsY más cercana al Top actual y la selecciona
Private Sub SnapToNearest
	' Seguridad por si acaso arrastran antes de que se defina un índice
	If mInitialIndex < 0 Then mInitialIndex = 0
	
	' 1. Calculamos el movimiento neto total en la pantalla (Delta Y)
	' Si es negativo: El usuario movió el panel hacia ARRIBA
	' Si es positivo: El usuario movió el panel hacia ABAJO
	Dim totalDeltaY As Int = mSheet.Top - mPositionsY(mInitialIndex)
	Dim threshold As Int = 12dip ' Umbral mínimo de píxeles para notar "intención"		'40dip
	
	' 2. Buscamos primero la posición más cercana por matemática pura (Física por defecto)
	Dim bestIndex As Int = 0
	Dim bestDist As Int = 999999999
	Dim i As Int
	For i = 0 To mPositionsY.Length - 2
		Dim d As Int = Abs(mSheet.Top - mPositionsY(i))
		If d < bestDist Then
			bestDist = d
			bestIndex = i
		End If
	Next
	
	' 3. ¡EL TRUCO MAESTRO!: Si la matemática dice que debes "rebotar" al mismo sitio...
	If bestIndex = mInitialIndex Then
		' ...pero tu dedo se movió con fuerza superando el umbral de intención:
		If Abs(totalDeltaY) > threshold Then
			If totalDeltaY < 0 Then
				' Sube el panel -> Pasamos al índice anterior (en Android, menor Y es más arriba)
				bestIndex = mInitialIndex - 1
			Else
				' Baja el panel -> Pasamos al índice siguiente
				bestIndex = mInitialIndex + 1
			End If
			
			' Blindamos los extremos para no salirnos del Array de posiciones
			bestIndex = Max(0, Min(mPositionsY.Length - 2, bestIndex))
		End If
	End If
	
	' 4. Movemos de forma fluida a la posición final calculada
	MoveTo(bestIndex)
End Sub

