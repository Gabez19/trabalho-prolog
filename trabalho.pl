% Bibliotecas
:- use_module(library(lists)).

resolver(Alunos) :-
    % 1. lista de alunos (as variáveis a serem descobertas)
    Alunos = [
        aluno(Nome1, Mochila1, Mes1, Jogo1, Materia1, Suco1),
        aluno(Nome2, Mochila2, Mes2, Jogo2, Materia2, Suco2),
        aluno(Nome3, Mochila3, Mes3, Jogo3, Materia3, Suco3),
        aluno(Nome4, Mochila4, Mes4, Jogo4, Materia4, Suco4),
        aluno(Nome5, Mochila5, Mes5, Jogo5, Materia5, Suco5)
    ],


    % 3. Aplicando as regras
    % Regras com posição definidas
    Suco3 = morango,
    Suco1 = limao,
    Nome5 = lenin,
    (Jogo1 = 'Cubo Vermelho' ; Jogo5 = 'Cubo Vermelho'),
    (Nome1 = otavio ; Nome5 = otavio),
    Jogo3 = 'Jogo da Forca',
    


    % Regras de Relação (dentro da lista)
    member(aluno(joao, _, _, _, historia, _), Alunos),
    member(aluno(_, _, _, _, biologia, morango), Alunos),
    member(aluno(_, _, dezembro, _, matematica, _), Alunos),
    member(aluno(_, _, _, _, matematica, maracuja), Alunos),
    member(aluno(_, _, _, 'Prob. de Lógica', _, uva), Alunos),
    member(aluno(_, azul, janeiro, _, _, _), Alunos),

     % 2. Definir os domínios (todas as características devem ser únicas)
    Dominios_Nome = [Nome1, Nome2, Nome3, Nome4, Nome5],
    permutation(Dominios_Nome, [denis, joao, lenin, otavio, will]),

    Dominios_Mochila = [Mochila1, Mochila2, Mochila3, Mochila4, Mochila5],
    permutation(Dominios_Mochila, [amarela, azul, branca, verde, vermelha]),

    Dominios_Mes = [Mes1, Mes2, Mes3, Mes4, Mes5],
    permutation(Dominios_Mes, [agosto, dezembro, janeiro, maio, setembro]),

    Dominios_Jogos = [Jogo1, Jogo2, Jogo3, Jogo4, Jogo5],
    permutation(Dominios_Jogos, ['3 ou Mais', 'Caça Palavras', 'Cubo Vermelho', 'Jogo da Forca', 'Prob. de Lógica']),

    Dominios_Materia = [Materia1, Materia2, Materia3, Materia4, Materia5],
    permutation(Dominios_Materia, [biologia, geografia, historia, matematica, portugues]),

    Dominios_Suco = [Suco1,Suco2,Suco3,Suco4,Suco5],
    permutation(Dominios_Suco, [laranja, limao, maracuja, morango, uva]),
    
    % Regras de Localização
    aolado(aluno(_, _, setembro, _, _, _), aluno(_, _, _, _, _, laranja), Alunos),
    aEsquerda(aluno(_, azul, _, _, _, _), aluno(_, _, maio, _, _, _), Alunos),
    aolado(aluno(will, _, _, _, _, _), aluno(_, _, _, 'Prob. de Lógica', _, _), Alunos),
    exatamenteEsquerda(aluno(_, branca, _, _, _, _), aluno(will, _, _, _, _, _), Alunos),
    aolado(aluno(_, _, _, 'Jogo da Forca', _, _), aluno(_, _, _, '3 ou Mais', _, _), Alunos),
    aDireita(aluno(_, _, _, _, _, uva), aluno(_, azul, _, _, _, _), Alunos),
    aolado(aluno(_, _, janeiro, _, _, _), aluno(_, _, setembro, _, _, _), Alunos),
    exatamenteEsquerda(aluno(_, _, _, _, _, uva), aluno(_, _, _, _, portugues, _), Alunos),
    aolado(aluno(_, _, _, 'Prob. de Lógica', _, _), aluno(_, amarela, _, _, _, _), Alunos),
    aolado(aluno(_, _, setembro, _, _, _), aluno(_, _, _, 'Cubo Vermelho', _, _), Alunos),
    aolado(aluno(_, _, _, 'Jogo da Forca', _, _), aluno(_, vermelha, _, _, _, _), Alunos).

% Predicados Auxiliares
aolado(X, Y, Lista) :- 
    nextto(X, Y, Lista).
aolado(X, Y, Lista) :- 
    nextto(Y, X, Lista).

aEsquerda(X, Y, Lista) :-
    nth0(IdX, Lista, X), nth0(IdY, Lista, Y),
    IdX > IdY.

aDireita(X, Y, Lista) :-
	nth0(IdX, Lista, X), nth0(IdY, Lista, Y),
    IdX < IdY.

exatamenteEsquerda(X, Y, Lista) :-
    nextto(X, Y, Lista).