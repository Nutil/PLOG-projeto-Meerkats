
:- use_module(library(lists)).
:- use_module(library(random)).
:- include('Display.pl').
:- include('Movements.pl').

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



createPecas([
	['B','B','B','B','B','B','B','B','B','B','B','B','B','B','B'],
	['Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'],
	['G','G','G','G','G','G','G','G','G','G','G','G','G','G','G'],
	['R','R','R','R','R','R','R','R','R','R','R','R','R','R','R']
	]). 


/**
 * User Interaction
 *
 */


playGame :-
	readNumberPlayers(NrPlayers),
	createBoard(Board),
	createPecas(Pecas),
	printBoard(Board),
	playGame(Board, Pecas, NrPlayers, NrPlayers).


playGame(Board, Pecas, MaxPlayers, PreviousPlayer) :-
	nextPlayer(MaxPlayers, PreviousPlayer, CurrentPlayer), !,

	( gameCannotContinue(0, 0, Board) -> write('Player 1 wins'), fail ; true),

	makeOnePlay(Board, Pecas, BoardAlterada, PecasAlterada),
	printBoard(BoardAlterada),

	playGame(BoardAlterada, PecasAlterada, MaxPlayers, CurrentPlayer).


%Board Alterada e a board apos todas as jogadas
makeOnePlay(Board, Pecas, BoardAlterada, PecasAlterada) :-
	write('Escolha a linha do tabuleiro em que quer jogar <0-8>: '),
	readInt(BoardLineIndex), nl, 
	write('Escolha a posicao na linha em que quer jogar: '),
	readInt(LineElementIndex), nl,
	
	calculatePeca(Pecas, Peca, IndexPeca), %Peca = carater, IndexPeca = 0-3, elemento da lista pecas
	colocarPeca(Peca, BoardLineIndex, LineElementIndex, Board, BoardAlterada1),

	%remover a peca colocada da lista Pecas
	getLine(PecaLine, IndexPeca, Pecas),
	write('PecaLine IS this: '),
	write(PecaLine), nl,  %PecaLine = linha de pecas da qual e para remover uma peca
	removeListHead(PecaLine, NewPecasLine),
	write('NewPecasLine is this: '),
	write(NewPecasLine), nl, 
	replaceListElement(Pecas, IndexPeca, NewPecasLine, PecasAlterada), nl,
	write(PecasAlterada), nl,% PecasAlterada = Pecas ja editada



	printBoard(BoardAlterada1),

	write('Escolha a linha da peca que quer mover <0-8>: '),
	readInt(LineIndex2), nl, 
	write('Escolha a posicao na linha da peca que quer mover: '),
	readInt(Index2), nl,
	write('Escolha a direcao em que quer mover a peca <0-5>: '),
	readInt(Direction), nl,

	slidePeca(LineIndex2, Index2, Direction, BoardAlterada1, BoardAlterada), nl.



readNumberPlayers(N) :-
	write('How many players will partake in this round? : '),
	readInt(N).

readInt(Value) :-
	get_code(Temp),
	get_code(_),
	Value is Temp - 48.

nextPlayer(MaxPlayers, CurrentPlayer, NextPlayer) :-
	NextPlayer1 is CurrentPlayer +1,
	( NextPlayer1 > MaxPlayers -> NextPlayer = 1 ; NextPlayer = NextPlayer1).



%Calcula a peca a ser jogada, retornando o carater e o indice
calculatePeca(Pecas, Peca, IndexPeca) :-
	random(0, 4, Value),
	calculatePecaValue(Pecas, Value, FinalValue),
	calculatePecaChar(FinalValue, Peca),
	IndexPeca = FinalValue.


calculatePecaValue(Pecas, InitialValue, FinalValue) :-
	getLine(LineToCheck, InitialValue, Pecas), %get line in Pecas at index initialvalue

	TempValue is InitialValue + 1, %Assume it's empty

	( TempValue >= 4 -> NextValue = 0 ; NextValue = TempValue), %If the next value to check was >= 4, it means we needa check the first line, if not, all good.

	( listIsEmpty(LineToCheck) -> calculatePecaValue(Pecas, NextValue, FinalValue), write('Skipping...') %if the list is indeed empty, try again with next value,
		;
		FinalValue = InitialValue).  %otherwise the init value was correct

calculatePecaChar(Value, Peca) :-

	(Value == 0 -> Peca = 'R'
	 ;
	Value == 1 -> Peca = 'G'
	;
	Value == 2 -> Peca = 'B'
	;
	Value == 3 -> Peca = 'Y'
	; fail).

listIsEmpty(List) :-
	List == [].

gameCannotContinue(L, I, Board) :-
	!, ( colocarPecaValido(L, I, Board) -> fail ; true),

	determineNextIndexInDirection(NextIndex, L, I, 5), % direction 5 means go to the right
	( getCell(UselessVariable, L, NextIndex, Board) -> !, gameCannotContinue(L, NextIndex, Board) %If there's a cell in the next index, that means we can go there :)
		; %if not, we check if there is a line below us, at the start of the line
		NextLine is L + 1, getCell(UselessVariable, NextLine, 0, Board) -> !, gameCannotContinue(NextLine, 0, Board)
		; true).%if there is no line below us and no index to our right, that means we're at the end of the board AND never found a playable position: the game cannot continue.
		