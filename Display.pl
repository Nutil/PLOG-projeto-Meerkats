/**
 * Initialization Methods
 *
 */

createBoard(
	[
	['e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e']
	]
	).

createPecas(2,
	[ 
	['B','B','B','B','B','B','B','B','B','B','B','B','B','B','B'],
	['Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y']
	]).

createPecas(3,
	[
	['B','B','B','B','B','B','B','B','B','B','B','B','B','B','B'],
	['Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'],
	['G','G','G','G','G','G','G','G','G','G','G','G','G','G','G']
	]).
createPecas(4,
	[
	['B','B','B','B','B','B','B','B','B','B','B','B','B','B','B'],
	['Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'],
	['G','G','G','G','G','G','G','G','G','G','G','G','G','G','G'],
	['R','R','R','R','R','R','R','R','R','R','R','R','R','R','R']
	]). 

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

printStartMenu :-
	nl,
	printHorizontalLine,
	write('Choose your option: '), nl,
	printHorizontalLine,
	write('1: Start Game'), nl,
	write('2: Exit').

printGameSelectMenu :-
	nl,
	printHorizontalLine,
	write('Choose your Game Mode: '), nl,
	printHorizontalLine,
	write('1: Player versus Player'),nl,
	write('2: Player versus AI'),nl,
	write('3: AI versus AI').





/**
 * Display board functions
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

printBoard :-
	createBoard(Board),
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
