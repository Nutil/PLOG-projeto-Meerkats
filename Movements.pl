/**
 * Initialization Methods
 *
 */
:- use_module(library(lists)).
createBoard(
	[
	['e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'e', 'e', 'e', 'e', 'e', 'e', 'e'],
	['e', 'e', 'A', 'A', 'A', 'e', 'e', 'e'],
	['e', 'e', 'A', 'e', 'A', 'e', 'e'],
	['e', 'e', 'A', 'A', 'A', 'e'],
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

verificaListaTemEmpty([]) :- fail.
verificaListaTemEmpty([H | T]) :-
	( H == 'e' -> true;
		!, write('skipping...'), verificaListaTemEmpty(T) )
	.

testGetCell(P, L, I) :-
	createBoard(Board),
	getCell(P, L, I, Board).


getLine(Linha, LIndex, Board) :-
	nth0(LIndex, Board, Linha).

getCell(P, L, I, Board) :-
	%Retorna em P a peça na posicao L|I da Board
	\+ I < 0,
	\+ L < 0,
	\+ L > 8,
	getLine(Linha, L, Board),
	length(Linha, NElements),
	NEle is NElements - 1,
	\+ I > NEle,

	nth0(L,Board,Linha),
	nth0(I,Linha, Temp),
	P = Temp
	%write(P), nl.
	.
printCell(L, I, Board) :-
	getCell(P, L, I, Board),
	write(P), nl.


/**
 * Verificaçao de posiçao
 *
 */


testColocarPecaValido(L, I) :-
	createBoard(Board),
	colocarPecaValido(L, I, Board).

colocarPecaValido(L, I, Board) :-
	L > 4, !, colocarPecaValidoBaixo(L, I, Board).

colocarPecaValido(L, I, Board) :-
	L == 4, !, colocarPecaValidoMeio(L, I, Board).

colocarPecaValido(L, I, Board) :-
	L < 4, !, colocarPecaValidoCima(L, I, Board).

colocarPecaValidoBaixo(L, I, Board) :-
	%Check if inicial position is empty
	getCell(P, L, I, Board),
 
	verificaListaTemEmpty([P]),

	%Check adjacent positions for at least 1 empty.
	%Verificar a partir da posicao abaixo à direita, em sentido do ponteiro dos relogios
	L1 is L - 1,
	L2 is L,
	L3 is L + 1,
	I1 is I - 1,
	I2 is I,
	I3 is I + 1,

	UpdatedList1 = [], !,
	( getCell(P1, L3, I2, Board) -> List1 = [P1] ; List1 = []),

	append(UpdatedList1, List1, UpdatedList2), !, %Este corte é VERMELHO, sem ele, loop infinito
	( getCell(P2, L3, I1, Board) -> List2 = [P2]; List2 = []),

	append(UpdatedList2, List2, UpdatedList3), !,
	( getCell(P3, L2, I1, Board) ->	List3 = [P3]; List3 = []),

	append(UpdatedList3, List3, UpdatedList4), !,
	( getCell(P4, L1, I2, Board) -> List4 = [P4]; List4 = []),

	append(UpdatedList4, List4, UpdatedList5), !,
	( getCell(P5, L1, I3, Board) ->	List5 = [P5]; List5 = []),

	append(UpdatedList5, List5, UpdatedList6), !,
	( getCell(P6, L2, I3, Board) ->	List6 = [P6]; List6 = []),

	append(UpdatedList6, List6, UpdatedList7), !,
	verificaListaTemEmpty(UpdatedList7).

colocarPecaValidoMeio(L, I, Board) :-
	%Check if inicial position is empty
	getCell(P, L, I, Board),
 
	verificaListaTemEmpty([P]),

	%Check adjacent positions for at least 1 empty.
	%Verificar a partir da posicao abaixo à direita, em sentido do ponteiro dos relogios
	L1 is L-1,
	L2 is L,
	L3 is L + 1,
	I1 is I - 1,
	I2 is I,
	I3 is I + 1,

	UpdatedList1 = [], !,
	( getCell(P1, L3, I2, Board) ->	List1 = [P1] ; List1 = []),

	append(UpdatedList1, List1, UpdatedList2), !, %Este corte é VERMELHO, sem ele, loop infinito
	( getCell(P2, L3, I1, Board) ->	List2 = [P2]; List2 = []),

	append(UpdatedList2, List2, UpdatedList3), !,
	( getCell(P3, L2, I1, Board) ->	List3 = [P3]; List3 = []),

	append(UpdatedList3, List3, UpdatedList4), !,
	( getCell(P4, L1, I1, Board) -> List4 = [P4]; List4 = []),

	append(UpdatedList4, List4, UpdatedList5), !,
	( getCell(P5, L1, I2, Board) ->	List5 = [P5]; List5 = []),

	append(UpdatedList5, List5, UpdatedList6), !,
	( getCell(P6, L2, I3, Board) -> List6 = [P6]; List6 = []),

	append(UpdatedList6, List6, UpdatedList7), !,
	verificaListaTemEmpty(UpdatedList7).

colocarPecaValidoCima(L, I, Board) :-
	%Check if inicial position is empty
	getCell(P, L, I, Board),
 
	verificaListaTemEmpty([P]),
	%Check adjacent positions for at least 1 empty.
	%Verificar a partir da posicao abaixo à direita, em sentido do ponteiro dos relogios
	L1 is L-1,
	L2 is L,
	L3 is L + 1,
	I1 is I - 1,
	I2 is I,
	I3 is I + 1,

	UpdatedList1 = [], !,
	( getCell(P1, L3, I3, Board) ->	List1 = [P1] ; List1 = []), !,

	append(UpdatedList1, List1, UpdatedList2), !, %Este corte é VERMELHO, sem ele, loop infinito
	( getCell(P2, L3, I2, Board) -> List2 = [P2]; List2 = []), !, 

	append(UpdatedList2, List2, UpdatedList3), !,
	( getCell(P3, L2, I1, Board) ->	List3 = [P3]; List3 = []), !, 

	append(UpdatedList3, List3, UpdatedList4), !,
	( getCell(P4, L1, I1, Board) ->	List4 = [P4] ; List4 = []), !, 

	append(UpdatedList4, List4, UpdatedList5), !,
	( getCell(P5, L1, I2, Board) -> List5 = [P5] ; List5 = []), !, 

	append(UpdatedList5, List5, UpdatedList6), !,
	( getCell(P6, L2, I3, Board) ->	List6 = [P6] ; List6 = []), !, 

	append(UpdatedList6, List6, UpdatedList7), !,
	verificaListaTemEmpty(UpdatedList7).

/**
 * Colocaçao de uma peça
 *
 */

colocarPeca(P, L, N, Board, BoardAlterada) :-
	%tenta colocar a peça P no elemento N da linha L da Board. Retorna a Board, alterada ou não.
	colocarPecaValido(P, L, I, Board).




























































































































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