// B4R Library rTM1637Ex
// 20210525 rwbl
#pragma once
#include "B4RDefines.h"
#include "TM1637Display.h"
//~version: 1.51
namespace B4R {
	//~shortname: TM1637Display
	class B4RTM1637Display {
		private:
			uint8_t beTM1637Display[sizeof(TM1637Display)];
			TM1637Display* display;

			/**
			*Char Tables
			*   AAA
			*  F   B
			*  F   B
			*   GGG
			*  E   C
			*  E   C
			*   DDD
			*
			* SPECIAL CASES
			* AscII 94 = ^ Character used for Degree °
			*/

			// Converted & enhanced from the SevSeg library https://github.com/sparkfun/SevSeg (many thanks for providing)
			const Byte AscIICharTable[128] = {
			// const Byte AscIICharTable[128] PROGMEM = {
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F,	 		// 0   0
				SEG_B | SEG_C,	 										// 1   1
				SEG_A | SEG_B | SEG_D | SEG_E | SEG_G,	 				// 2   2
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_G,	 				// 3   3
				SEG_B | SEG_C | SEG_F | SEG_G,	 						// 4   4
				SEG_A | SEG_C | SEG_D | SEG_F | SEG_G,	 				// 5   5
				SEG_A | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 		// 6   6
				SEG_A | SEG_B | SEG_C,	 								// 7   7
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	// 8   8
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_F | SEG_G,	 		// 9   9
				SEG_A | SEG_B | SEG_C | SEG_E | SEG_F | SEG_G,	 		// 10  A
				SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 11  b
				SEG_A | SEG_D | SEG_E | SEG_F,	 						// 12  C
				SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,	 				// 13  d
				SEG_A | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 14  E
				SEG_A | SEG_E | SEG_F | SEG_G,	 						// 15  F
				0,	 													// 16  NO DISPLAY
				0,	 													// 17  NO DISPLAY
				0,	 													// 18  NO DISPLAY
				0,	 													// 19  NO DISPLAY
				0,	 													// 20  NO DISPLAY
				0,	 													// 21  NO DISPLAY
				0,	 													// 22  NO DISPLAY
				0,	 													// 23  NO DISPLAY
				0,	 													// 24  NO DISPLAY
				0,	 													// 25  NO DISPLAY
				0,	 													// 26  NO DISPLAY
				0,	 													// 27  NO DISPLAY
				0,	 													// 28  NO DISPLAY
				0,	 													// 29  NO DISPLAY
				0,	 													// 30  NO DISPLAY
				0,	 													// 31  NO DISPLAY
				0,	 													// 32  SPACE
				0,	 													// 33  !  NO DISPLAY
				SEG_B | SEG_F,	 										// 34  "
				0,	 													// 35  #  NO DISPLAY
				0,	 													// 36  $  NO DISPLAY
				0,	 													// 37  %  NO DISPLAY
				0,	 													// 38  &  NO DISPLAY
				SEG_B,	 												// 39  |  RIGHT
				SEG_A | SEG_D | SEG_E | SEG_F,	 						// 40  (
				SEG_A | SEG_B | SEG_C | SEG_D,	 						// 41  )
				0,	 													// 42  *  NO DISPLAY
				0,	 													// 43  +  NO DISPLAY
				SEG_E,	 												// 44  |  LEFT
				SEG_G,	 												// 45  -
				0,	 													// 46  .  NO DISPLAY
				0,	 													// 47  /  NO DISPLAY
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F,	 		// 48  0
				SEG_B | SEG_C,	 										// 49  1
				SEG_A | SEG_B | SEG_D | SEG_E | SEG_G,	 				// 50  2
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_G,	 				// 51  3
				SEG_B | SEG_C | SEG_F | SEG_G,	 						// 52  4
				SEG_A | SEG_C | SEG_D | SEG_F | SEG_G,	 				// 53  5
				SEG_A | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 		// 54  6
				SEG_A | SEG_B | SEG_C,	 								// 55  7
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	// 56  8
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_F | SEG_G,	 		// 57  9
				0,	 													// 58  :  NO DISPLAY
				0,	 													// 59  ;  NO DISPLAY
				0,	 													// 60  <  NO DISPLAY
				0,	 													// 61  =  NO DISPLAY
				0,	 													// 62  >  NO DISPLAY
				0,	 													// 63  ?  NO DISPLAY
				0,	 													// 64  @  NO DISPLAY
				SEG_A | SEG_B | SEG_C | SEG_E | SEG_F | SEG_G,	 		// 65  A
				SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 66  b
				SEG_A | SEG_D | SEG_E | SEG_F,	 						// 67  C
				SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,	 				// 68  d
				SEG_A | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 69  E
				SEG_A | SEG_E | SEG_F | SEG_G,	 						// 70  F
				SEG_A | SEG_C | SEG_D | SEG_E | SEG_F,	 				// 71  G
				SEG_B | SEG_C | SEG_E | SEG_F | SEG_G,	 				// 72  H
				SEG_B | SEG_C,	 										// 73  I
				SEG_B | SEG_C | SEG_D,	 								// 74  J
				0,	 													// 75  K  NO DISPLAY
				SEG_D | SEG_E | SEG_F,	 								// 76  L
				0,	 													// 77  M  NO DISPLAY
				SEG_C | SEG_E | SEG_G,	 								// 78  n
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F,	 		// 79  O
				SEG_A | SEG_B | SEG_E | SEG_F | SEG_G,	 				// 80  P
				SEG_A | SEG_B | SEG_C | SEG_F | SEG_G,	 				// 81  q
				SEG_E | SEG_G,	 										// 82  r
				SEG_A | SEG_C | SEG_D | SEG_F | SEG_G,	 				// 83  S
				SEG_D | SEG_E | SEG_F | SEG_G,	 						// 84  t
				SEG_B | SEG_C | SEG_D | SEG_E | SEG_F,	 				// 85  U
				0,	 													// 86  V  NO DISPLAY
				0,	 													// 87  W  NO DISPLAY
				0,	 													// 88  X  NO DISPLAY
				SEG_B | SEG_C | SEG_D | SEG_F | SEG_G,	 				// 89  y
				0,	 													// 90  Z  NO DISPLAY
				SEG_A | SEG_D | SEG_E | SEG_F,	 						// 91  [
				0,	 													// 92  \  NO DISPLAY
				SEG_A | SEG_B | SEG_C | SEG_D,	 						// 93  ]
				SEG_A | SEG_B | SEG_F | SEG_G,	 						// 94  ^  DEGREE
				SEG_D,	 												// 95  _
				SEG_F,	 												// 96  `
				SEG_A | SEG_B | SEG_C | SEG_E | SEG_F | SEG_G,	 		// 97  a SAME AS CAP
				SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,				 	// 98  b SAME AS CAP
				SEG_D | SEG_E | SEG_G,	 								// 99  c
				SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,	 				// 100 d SAME AS CAP
				SEG_A | SEG_B | SEG_D | SEG_E | SEG_F | SEG_G,	 		// 101 e
				SEG_A | SEG_E | SEG_F | SEG_G,	 						// 102 F SAME AS CAP
				SEG_A | SEG_C | SEG_D | SEG_E | SEG_F,	 				// 103 G SAME AS CAP
				SEG_C | SEG_E | SEG_F | SEG_G,	 						// 104 h
				SEG_C,	 												// 105 i
				SEG_B | SEG_C | SEG_D,	 								// 106 j SAME AS CAP
				0,	 													// 107 k  NO DISPLAY
				SEG_B | SEG_C,	 										// 108 l
				0,	 													// 109 m  NO DISPLAY
				SEG_C | SEG_E | SEG_G,	 								// 110 n SAME AS CAP
				SEG_C | SEG_D | SEG_E | SEG_G,	 						// 111 o
				SEG_A | SEG_B | SEG_E | SEG_F | SEG_G,	 				// 112 p SAME AS CAP
				SEG_A | SEG_B | SEG_C | SEG_F | SEG_G,	 				// 113 q SAME AS CAP
				SEG_E | SEG_G,	 										// 114 r SAME AS CAP
				SEG_A | SEG_C | SEG_D | SEG_F | SEG_G,	 				// 115 S SAME AS CAP
				SEG_D | SEG_E | SEG_F | SEG_G,	 						// 116 t SAME AS CAP
				SEG_C | SEG_D | SEG_E,	 								// 117 u
				0,	 													// 118 b  NO DISPLAY
				0,	 													// 119 w  NO DISPLAY
				0,	 													// 120 x  NO DISPLAY
				0,	 													// 121 y  NO DISPLAY
				0,	 													// 122 z  NO DISPLAY
				0,	 													// 123    NO DISPLAY
				0,	 													// 124 |  NO DISPLAY
				0,	 													// 125 
				0,	 													// 126 ~  NO DISPLAY
				0}; 													// 127 DEL  NO DISPLAY 

			// Siekoo font converted from http://en.fakoo.de/siekoo.html (many thanks for poviding)
			const Byte SiekooCharTable[128] = {
			// const Byte SiekooCharTable[128] PROGMEM = {
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F,	 		// 0  	0
				SEG_B | SEG_C,	 										// 1  	1
				SEG_A | SEG_B | SEG_D | SEG_E | SEG_G,	 				// 2  	2
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_G,	 				// 3  	3
				SEG_B | SEG_C | SEG_F | SEG_G,	 						// 4  	4
				SEG_A | SEG_C | SEG_D | SEG_F | SEG_G,	 				// 5  	5
				SEG_A | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 		// 6  	6
				SEG_A | SEG_B | SEG_C,	 								// 7  	7
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	// 8  	8
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_F | SEG_G,	 		// 9  	9
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,			// 10 	A
				SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 11 	B
				SEG_D | SEG_E | SEG_G,	 								// 12 	C
				SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,	 				// 13 	D
				SEG_A | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 14 	E
				SEG_A | SEG_E | SEG_F | SEG_G,							// 15 	F
				0,	 													// 16 	NO DISPLAY
				0,	 													// 17 	NO DISPLAY
				0,	 													// 18 	NO DISPLAY
				0,	 													// 19 	NO DISPLAY
				0,	 													// 20 	NO DISPLAY
				0,	 													// 21 	NO DISPLAY
				0,	 													// 22 	NO DISPLAY
				0,	 													// 23 	NO DISPLAY
				0,	 													// 24 	NO DISPLAY
				0,	 													// 25 	NO DISPLAY
				0,	 													// 26 	NO DISPLAY
				0,	 													// 27 	NO DISPLAY
				0,	 													// 28 	NO DISPLAY
				0,	 													// 29 	NO DISPLAY
				0,	 													// 30 	NO DISPLAY
				0,	 													// 31 	NO DISPLAY
				0,	 													// 32 	SPACE
				SEG_A | SEG_F | SEG_G | SEG_B | SEG_D,					// 33 	!  EXPERIMENTAL
				SEG_B | SEG_F,	 										// 34 	"
				SEG_F | SEG_E | SEG_B | SEG_C,							// 35 	#  EXPERIMENTAL
				0,	 													// 36 	$  NO DISPLAY
				SEG_F | SEG_C,											// 37 	%  EXPERIMENTAL
				0,	 													// 38 	&  NO DISPLAY
				SEG_F,	 												// 39 	'  
				SEG_A | SEG_D | SEG_E | SEG_F,	 						// 40 	(
				SEG_A | SEG_B | SEG_C | SEG_D,	 						// 41 	)
				SEG_A | SEG_G | SEG_D,									// 42 	*  EXPERIMENTAL
				SEG_G | SEG_B | SEG_C,									// 43 	+  EXPERIMENTAL
				SEG_D | SEG_C,											// 44  	,  COMMA
				SEG_G,	 												// 45 	-
				SEG_E, 													// 46 	.  EXPERIMENTAL
				SEG_B | SEG_G | SEG_E,									// 47 	/  EXPERIMENTAL
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F,			// 48 	0
				SEG_B | SEG_C,	 										// 49 	1
				SEG_A | SEG_B | SEG_D | SEG_E | SEG_G,	 				// 50 	2
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_G,	 				// 51 	3
				SEG_B | SEG_C | SEG_F | SEG_G,	 						// 52 	4
				SEG_A | SEG_C | SEG_D | SEG_F | SEG_G,					// 53 	5
				SEG_A | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 		// 54 	6
				SEG_A | SEG_B | SEG_C,	 								// 55 	7
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	// 56 	8
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_F | SEG_G,	 		// 57 	9
				SEG_A | SEG_D,											// 58 	:  EXPERIMENTAL
				SEG_B | SEG_D,	 										// 59 	;  EXPERIMENTAL
				SEG_A | SEG_F,	 										// 60 	<  EXPERIMENTAL
				SEG_D | SEG_G,	 										// 61 	=  EXPERIMENTAL
				SEG_A | SEG_B,	 										// 62 	>  EXPERIMENTAL
				SEG_A | SEG_B | SEG_D | SEG_G,	 						// 63 	?  EXPERIMENTAL
				SEG_A | SEG_B | SEG_C | SEG_E,	 						// 64 	@  EXPERIMENTAL
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,			// 65 	A
				SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 66 	B
				SEG_D | SEG_E | SEG_G,	 								// 67 	C
				SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,	 				// 68 	D
				SEG_A | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 69 	E
				SEG_A | SEG_E | SEG_F | SEG_G,							// 70 	F
				SEG_A | SEG_C | SEG_D | SEG_E | SEG_F,					// 71 	G
				SEG_C | SEG_E | SEG_F | SEG_G,	 						// 72 	H
				SEG_A | SEG_E,	 										// 73 	I
				SEG_A | SEG_C | SEG_D,	 								// 74 	J
				SEG_A | SEG_C | SEG_E | SEG_F | SEG_G,	 				// 75 	K
				SEG_D | SEG_E | SEG_F,									// 76 	L
				SEG_A | SEG_C | SEG_E | SEG_G,	 						// 77 	M
				SEG_C | SEG_E | SEG_G,	 								// 78 	N
				SEG_C | SEG_D | SEG_E | SEG_G,	 						// 79 	O
				SEG_A | SEG_B | SEG_E | SEG_F | SEG_G,	 				// 80 	P
				SEG_A | SEG_B | SEG_C | SEG_F | SEG_G,	 				// 81 	Q
				SEG_E | SEG_G,											// 82 	R
				SEG_A | SEG_C | SEG_D | SEG_F,	 						// 83 	S
				SEG_D | SEG_E | SEG_F | SEG_G,	 						// 84 	T
				SEG_C | SEG_D | SEG_E,	 								// 85 	U
				SEG_B | SEG_D | SEG_F,	 								// 86 	V
				SEG_B | SEG_D | SEG_F | SEG_G,	 						// 87 	W
				SEG_C | SEG_E,											// 88 	X
				SEG_B | SEG_C | SEG_D | SEG_F | SEG_G,	 				// 89 	Y
				SEG_A | SEG_B | SEG_D | SEG_E,							// 90 	Z
				SEG_A | SEG_D | SEG_E | SEG_F,	 						// 91  	[
				SEG_F | SEG_G | SEG_C,									// 92  	\	EXPERIMENTAL
				SEG_A | SEG_B | SEG_C | SEG_D,	 						// 93  	]
				SEG_A | SEG_B | SEG_F | SEG_G,	 						// 94  	^	DEGREE
				SEG_D,	 												// 95  	_
				SEG_F,	 												// 96  	`
				SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,			// 97 	a
				SEG_C | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 98 	b
				SEG_D | SEG_E | SEG_G,	 								// 99 	c
				SEG_B | SEG_C | SEG_D | SEG_E | SEG_G,	 				// 100	d
				SEG_A | SEG_D | SEG_E | SEG_F | SEG_G,	 				// 101	e
				SEG_A | SEG_E | SEG_F | SEG_G,							// 102	f
				SEG_A | SEG_C | SEG_D | SEG_E | SEG_F,					// 103	g
				SEG_C | SEG_E | SEG_F | SEG_G,	 						// 104	h
				SEG_A | SEG_E,	 										// 105	i
				SEG_A | SEG_C | SEG_D,	 								// 106	j
				SEG_A | SEG_C | SEG_E | SEG_F | SEG_G,	 				// 107	k
				SEG_D | SEG_E | SEG_F,									// 108	l
				SEG_A | SEG_C | SEG_E | SEG_G,	 						// 109	m
				SEG_C | SEG_E | SEG_G,	 								// 110	n
				SEG_C | SEG_D | SEG_E | SEG_G,	 						// 111	o
				SEG_A | SEG_B | SEG_E | SEG_F | SEG_G,	 				// 112	p
				SEG_A | SEG_B | SEG_C | SEG_F | SEG_G,	 				// 113	q
				SEG_E | SEG_G,											// 114	r
				SEG_A | SEG_C | SEG_D | SEG_F,	 						// 115	s
				SEG_D | SEG_E | SEG_F | SEG_G,	 						// 116	t
				SEG_C | SEG_D | SEG_E,	 								// 117	u
				SEG_B | SEG_D | SEG_F,	 								// 118	v
				SEG_B | SEG_D | SEG_F | SEG_G,	 						// 119	w
				SEG_C | SEG_E,											// 120	x
				SEG_B | SEG_C | SEG_D | SEG_F | SEG_G,	 				// 121	y
				SEG_A | SEG_B | SEG_D | SEG_E,							// 122	z
				SEG_F | SEG_E,											// 123  |	EXPERIMENTAL
				SEG_B | SEG_C,											// 124 	 |	EXPERIMENTAL
				0,	 													// 125 		NO DISPLAY
				SEG_A | SEG_D,											// 126 	~ 	EXPERIMENTAL
				0}; 													// 127 	DEL	NO DISPLAY 
			
		public:
			/**
			*Initializes the object.
			*PinClk - Pin connected to the Clock pin.
			*PinDIO - Pin connected to the Data Input/output pin pin.
			*/
			void Initialize(Byte PinClk, Byte PinDIO);

			/**
			*Sets the brightness of the display.
			*The setting takes effect when a command is given to change the data being displayed.
			*brightness - Number from 0 (lowes brightness) to 7 (highest brightness)
			*on - Turn the display on or off
			*/
			void SetBrightness(Byte brightness, bool on); 

			/**
			*Displays arbitrary data.
			*Each byte represents a single digit.
			*Each bit represents a segment.
			*Position - Position from which to start the modification (0 - leftmost, 3 - rightmost).
			*The 7 LED segments:
			* A
			*F B
			* G
			*E C
			* D
			*  DP
			*DP is the dot (8th LED) if supported by the display.
			*/
			void SetSegments(ArrayByte* Segments, Byte Position);

			// Define the 7 segments for function SetSegments
			#define /*Byte SEG_A;*/ B4RTM1637Display_SEG_A 1	//B000000001
			#define /*Byte SEG_B;*/ B4RTM1637Display_SEG_B 2	//B000000010
			#define /*Byte SEG_C;*/ B4RTM1637Display_SEG_C 4	//B000000100
			#define /*Byte SEG_D;*/ B4RTM1637Display_SEG_D 8	//B000001000
			#define /*Byte SEG_E;*/ B4RTM1637Display_SEG_E 16	//B000010000
			#define /*Byte SEG_F;*/ B4RTM1637Display_SEG_F 32	//B000100000
			#define /*Byte SEG_G;*/ B4RTM1637Display_SEG_G 64	//B001000000

			#define /*Byte FONT_ASCII;*/ B4RTM1637Display_FONT_ASCII 1
			#define /*Byte FONT_SIEKOO;*/ B4RTM1637Display_FONT_SIEKOO 2

			#define /*Byte SPECIAL_DEGREE;*/ B4RTM1637Display_SPECIAL_DEGREE SEG_A | SEG_B | SEG_F | SEG_G
			
			/**
			*Displays the decimal number.
			*/
			void ShowNumberDec(Int Number);

			/**
			*Displays the decimal number.
			*Number - Number to be shown.
			*LeadingZero - Whether to add leading zeroes.
			*Length - Number of digits to set.
			*Position - Position of the least significant digit (0 - leftmost, 3 - rightmost).
			*/
			void ShowNumberDec2(Int Number, bool LeadingZero, Byte Length, Byte Position);

			/**
			*Similar to ShowNumberDec2. Controls the decimal dots or colon based on the DotsMask. Pass 0xFF to enable all dots / colons.
			*The argument is a bitmask, with each bit corresponding to a dot
			*between the digits (or colon mark, as implemented by each module). The MSB is the 
			*leftmost dot of the digit being update. For example, if Position is 1, the MSB of DotsMask
			*will correspond the dot near digit no. 2 from the left. Dots are updated only on
			*those digits actually being update (that is, no more than Length digits)
			*/
			void ShowNumberDec3(Int Number, bool LeadingZero, Byte Length, Byte Position, Byte DotsMask);
			
			/**
			*Clear the display (uses SetSegments with 0 data)
			*/
			void Clear();
						
			/**
			*Get Char from the font char table.
			*Index - AscII character index 0 - 127)
			*Font - 1=AscII, 2=Siekoo
			*/
			Byte GetChar(Int Index, Byte Font);
			
			/**
			*Display a text with max 4 characters in ascii range 0-127. Not all characters are supported.
			*Position - Starting position of the text: 0=leftmost .. 3=rightmost
			*Font - 1=AscII, 2=Siekoo
			*Examples:
			*Display text HaLo startig at pos 0 (leftmost): tmDisplay.ShowText("HaLo",0)
			*Display text 9C starting at position 1: tmDisplay.ShowText("9C",1)
			*/
			void ShowText(B4RString* Text, Byte Position, Byte Font);
		
	};
}