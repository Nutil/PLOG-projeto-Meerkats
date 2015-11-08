
/* Clean Console */
cleanConsole(0).
cleanConsole(X) :-
	nl,
	N is X-1,
	cleanConsole(N).

/**
 * Display Menu functions
 *
 */
printSlidingInstructions :-
	write('How the directions work:'), nl,
	write('When choosing a direction, you choose a number from 0 to 5, as described in the picture'), nl,
	write('In the example, choose direction 1 will move the piece in the lower-left direction of the board'), nl,

	write('  +-------+'), nl,
	write('  | 3 | 4 |'), nl,
	write('+-----------+'), nl,
	write('| 2 | P | 5 |'), nl,
	write('+-----------+'), nl,
	write('  | 1 | 0 |'), nl,
	write('  +-------+'), nl, nl,

	write('Press [ENTER] to return to the main menu'), !,
	get_code(_).


printStartMenu :-
	nl,
	printHorizontalLine,
	write('Choose your option: '), nl,
	printHorizontalLine,
	write('1: Start Game'), nl,
	write('2: Read Instructions'), nl,
	write('3: Exit').

printGameSelectMenu :-
	nl,
	printHorizontalLine,
	write('Choose your Game Mode: '), nl,
	printHorizontalLine,
	write('1: Player versus Player'),nl,
	write('2: Player versus AI'),nl,
	write('3: Player versus smart AI'), nl,
	write('4: AI versus AI'), nl.



/**
 * Display Board functions
 *
 */

 printHorizontalLine :- write('+-------------------------------------+'), nl.

printBoardLine([]) :- 
	write('|').
printBoardLine([H | Line]) :-
	write('| '),
	write(H),
	write(' '),
	printBoardLine(Line).

printBoard(Board) :-
	printRow1(Board).

printRow1([H | Rest]) :-
	nl, nl,
	printHorizontalLine,
	write('|        '),
	printBoardLine(H),
	write('        |'), nl,
	printHorizontalLine,
	printRow2(Rest).
printRow2([H | Rest]) :-
	write('|      '),
	printBoardLine(H),
	write('      |'), nl,
	printHorizontalLine,
	printRow3(Rest).
printRow3([H | Rest]) :-
	write('|    '),
	printBoardLine(H),
	write('    |'), nl,
	printHorizontalLine,
	printRow4(Rest).
printRow4([H | Rest]) :-
	write('|  '),
	printBoardLine(H),
	write('  |'), nl,
	printHorizontalLine,
	printRow5(Rest).
printRow5([H | Rest]) :-
	write('|'),
	printBoardLine(H), 
	write('|'), nl,
	printHorizontalLine,
	printRow6(Rest).
printRow6([H | Rest]) :-
	write('|  '),
	printBoardLine(H),
	write('  |'), nl,
	printHorizontalLine,
	printRow7(Rest).
printRow7([H | Rest]) :-
	write('|    '),
	printBoardLine(H),
	write('    |'), nl,
	printHorizontalLine,
	printRow8(Rest).
printRow8([H | Rest]) :-
	write('|      '),
	printBoardLine(H),
	write('      |'), nl,
	printHorizontalLine,
	printRow9(Rest).
printRow9([H | LastLine]) :-
	write('|        '),
	printBoardLine(H),
	write('        |'), nl,
	printHorizontalLine,
	printRow10(LastLine).

printRow10([]).