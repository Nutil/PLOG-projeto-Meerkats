
:- use_module(library(lists)).

:- include('Display.pl').
:- include('Movements.pl').



/**
 * User Interaction
 *
 */

playGame :-
	getNumberPlayers(NrPlayers),
	createBoard(Board),
	printBoard(Board),
	playGame(Board, NrPlayers, NrPlayers).


playGame(Board, MaxPlayers, PreviousPlayer) :-
	nextPlayer(MaxPlayers, PreviousPlayer, CurrentPlayer),
	calculatePeca(CurrentPlayer, Peca),
	write('E a vez do jogador '),
	write(CurrentPlayer), nl,
	makeOnePlay(Board, Peca, BoardAlterada),
	printBoard(BoardAlterada),
	playGame(BoardAlterada, MaxPlayers, CurrentPlayer).

testMakeOnePlay :-
	createBoard(Board),
	makeOnePlay(Board).

%Board Alterada e a board apos todas as jogadas
makeOnePlay(Board, Peca, BoardAlterada) :-
	write('Escolha a linha em que quer jogar <0-8>: '),
	readInt(LineIndex1), nl, 
	write('Escolha a posicao na linha em que quer jogar: '),
	readInt(Index1), nl,
	colocarPeca(Peca, LineIndex1, Index1, Board, BoardAlterada1),
	printBoard(BoardAlterada1),

	write('Escolha a linha da peca que quer mover <0-8>: '),
	readInt(LineIndex2), nl, 
	write('Escolha a posicao na linha da peca que quer mover: '),
	readInt(Index2), nl,
	write('Escolha a direcao em que quer mover a peca <0-5>: '),
	readInt(Direction), nl,

	slidePeca(LineIndex2, Index2, Direction, BoardAlterada1, BoardAlterada), nl.



getNumberPlayers(N) :-
	write('How many players will partake in this round? : '),
	readInt(N).

readInt(Value) :-
	get_code(Temp),
	get_code(_),
	Value is Temp - 48.

nextPlayer(MaxPlayers, CurrentPlayer, NextPlayer) :-
	NextPlayer1 is CurrentPlayer +1,
	( NextPlayer1 > MaxPlayers -> NextPlayer = 1 ; NextPlayer = NextPlayer1).

calculatePeca(CurrentPlayer, Peca) :-
	(CurrentPlayer == 1 -> Peca = 'R'
		;
		CurrentPlayer == 2 -> Peca = 'G'
		;
		CurrentPlayer == 3 -> Peca = 'B'
		;
		CurrentPlayer == 4 -> Peca = 'Y'
		; fail
	).