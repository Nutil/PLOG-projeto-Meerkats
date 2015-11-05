
:- use_module(library(lists)).

:- include('Display.pl').
:- include('Movements.pl').



/**
 * User Interaction
 *
 */
testMakeOnePlay :-
	createBoard(Board),
	makeOnePlay(Board).

makeOnePlay(Board) :-
	nl,
	write('Escolha a peca que quer colocar: '),
	read(Peca), nl,
	write('Peca: '),
	write(Peca),
	write('Escolha a linha em que quer jogar <0-8>: '),
	read(LineIndex), nl, 
	write('LineIndex: '),
	write(LineIndex),
	nl, write('Escolha a posicao na linha em que quer jogar: '),
	read(Index), nl,
	write('Index: '),
	write(Index), nl,
	colocarPeca(Peca, LineIndex, Index, Board, BoardAlterada),
	printBoard(BoardAlterada).


