B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub


'DESCRIPTION

'This program allows manual entry of a Sudoku grid and then a "lazy" way to solve

'The "SHOW" button shows all cell positions where the Selected Number cannot be entered (GRAY)
'and the cell positions where the Selected Number can be entered (Black)

'At each "SHOW" the totals for all number are calculated and displayed as well as the total 
'number count. If this is 81 then the program automatically checks each square, row and column to
'ensure that each only has the numbers 1 to 9 with no repeats or ommissions

'DATA ENTRY
'Use the round Buttons 1 to 9. Only one can be selected at a time. Place on grid with touch
'The "X" button removes entries

'COMMANDS
'SHOW = Displays the locations on the grid of the positions where the selected number cannot be entered (GRAY) and can
'be entered (BACK). A number must be selected for this

'BACK CLEAR = Removes all background colour on the grid if you want to solve the hard way

'SOLVE ON = Starts the autosolve routines (see later)

'CLEAR ALL = Clears the grid and the answers so allowing a fresh start . Does not clear the stored grid

'SAVE = Saves the present grid

'RESTORE = Restores the last saved grid

'Note: Save and restore are great if you guess a number and then want to go back to where your were

'AUTOSOLVE
 
 'Initiated by SOLVEON. This sets up a recursive subroutine for each number that continuously looks for changes, 
 'as implementing one change can provide other solutions for that number
 'At the end of each iteration of numbers 1 to 9 the TotalCount is calculated and if there has been a change then the
 'autosolve is repeated until there are no changes in TotalCount
 
 'If, at this stage, TotalCount is 81 then the program verifies the answers
 
 'Experimenting I have found that the AutoSolve will solve most 'medium' grids by this brute force technigue
 
 'VERIFICATION
 'This is actioned when the TotalCount = 81 whether under manual entry or AutoSolve. 
 'The verification routines checks each Row, Col and Square to ensure only the numbers 1 to 9 are entered
 'with no duplicates and no ommissions.