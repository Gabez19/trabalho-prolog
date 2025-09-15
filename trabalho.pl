% -----------------------------------------------
% Trabalho Inteligência Artificial - Cinco Amigos
% Alunos: Gabriel Barbosa Zanolla e Letícia Ximenes Parreiras
% Descrição: Resolução de um quebra-cabeça de lógica usando Prolog.
% -----------------------------------------------

:- use_module(library(lists)).

% -----------------------------------------------
% Main
% -----------------------------------------------
main :-
    statistics(cputime, T1),
    ( resolver(Alunos),
      imprime_lista(Alunos),
      nl,
      fail
    ; statistics(cputime, T2),
      T_exec is T2 - T1,
      format('\nBusca terminada. Tempo de execucao: ~2f segundos.~n', [T_exec])
    ).

% -----------------------------------------------
% Impressão da lista de alunos
% -----------------------------------------------
imprime_lista([]) :- write('\n\n FIM do imprime_lista \n').
imprime_lista([H|T]) :-
    write('\n.............................\n'),
    write(H), write(' : '),
    imprime_lista(T).

% -----------------------------------------------
% Resolver o quebra-cabeça
% -----------------------------------------------
resolver(Alunos) :-
    % 1. lista de alunos (as variáveis a serem descobertas)
    Alunos = [
        aluno(Nome1, Mochila1, Mes1, Jogo1, Materia1, Suco1),
        aluno(Nome2, Mochila2, Mes2, Jogo2, Materia2, Suco2),
        aluno(Nome3, Mochila3, Mes3, Jogo3, Materia3, Suco3),
        aluno(Nome4, Mochila4, Mes4, Jogo4, Materia4, Suco4),
        aluno(Nome5, Mochila5, Mes5, Jogo5, Materia5, Suco5)
    ],

    % 2. Regras fixas de posição
    Suco1 = limao,
    Suco3 = morango,
    Jogo3 = 'Jogo da Forca',
    Nome5 = lenin,
    (Jogo1 = 'Cubo Vermelho' ; Jogo5 = 'Cubo Vermelho'),
    (Nome1 = otavio ; Nome5 = otavio),

    % 3. Regras de associação (dentro da lista)
    member(aluno(joao, _, _, _, historia, _), Alunos),
    member(aluno(_, _, _, _, biologia, morango), Alunos),
    member(aluno(_, _, dezembro, _, matematica, _), Alunos),
    member(aluno(_, _, _, _, matematica, maracuja), Alunos),
    member(aluno(_, _, _, 'Prob. de Lógica', _, uva), Alunos),
    member(aluno(_, azul, janeiro, _, _, _), Alunos),

    % 4. Permutações para unicidade
    permutation([Nome1, Nome2, Nome3, Nome4, Nome5], [denis, joao, lenin, otavio, will]),
    permutation([Mochila1, Mochila2, Mochila3, Mochila4, Mochila5], [amarela, azul, branca, verde, vermelha]),
    permutation([Mes1, Mes2, Mes3, Mes4, Mes5], [agosto, dezembro, janeiro, maio, setembro]),
    permutation([Jogo1, Jogo2, Jogo3, Jogo4, Jogo5], ['3 ou Mais', 'Caça Palavras', 'Cubo Vermelho', 'Jogo da Forca', 'Prob. de Lógica']),
    permutation([Materia1, Materia2, Materia3, Materia4, Materia5], [biologia, geografia, historia, matematica, portugues]),
    permutation([Suco1, Suco2, Suco3, Suco4, Suco5], [laranja, limao, maracuja, morango, uva]),

    % 5. Regras de posição e vizinhança
    aolado(aluno(_, _, setembro, _, _, _), aluno(_, _, _, _, _, laranja), Alunos),
    aEsquerda(aluno(_, azul, _, _, _, _), aluno(_, _, maio, _, _, _), Alunos),
    aolado(aluno(will, _, _, _, _, _), aluno(_, _, _, 'Prob. de Lógica', _, _), Alunos),
    exatamenteEsquerda(aluno(_, branca, _, _, _, _), aluno(will, _, _, _, _, _), Alunos),
    aolado(aluno(_, _, _, 'Jogo da Forca', _, _), aluno(_, _, _, '3 ou Mais', _, _), Alunos),
    aDireita(aluno(_, _, _, _, _, uva), aluno(_, azul, _, _, _, _), Alunos),
    aolado(aluno(_, _, janeiro, _, _, _), aluno(_, _, setembro, _, _, _), Alunos),
    exatamenteEsquerda(aluno(_, _, _, _, _, uva), aluno(_, _, _, _, portugues, _), Alunos),
    aolado(aluno(_, _, _, 'Prob. de Lógica', _, _), aluno(_, amarela, _, _, _, _), Alunos),
    aolado(aluno(_, _, setembro, _, _, _), aluno(_, _, _, 'Cubo Vermelho', _, _), Alunos).

% -----------------------------------------------
% Predicados auxiliares de posição
% -----------------------------------------------
aolado(X, Y, Lista) :- nextto(X, Y, Lista).
aolado(X, Y, Lista) :- nextto(Y, X, Lista).

aEsquerda(X, Y, Lista) :-
    nth0(IdX, Lista, X), nth0(IdY, Lista, Y),
    IdX < IdY.

aDireita(X, Y, Lista) :-
    nth0(IdX, Lista, X), nth0(IdY, Lista, Y),
    IdX > IdY.

exatamenteEsquerda(X, Y, Lista) :-
    nextto(X, Y, Lista).
