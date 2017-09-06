%% Exercises and examples from here: http://www.learnprolognow.org/lpnpage.php?pageid=online

%% Written by Joe Bloggs [2017-09-06 Wed]

%% example in part 2.1
horizontal(line(point(X,Y),point(Z,Y))).

%% Exercise 2.1: Which of the following pairs of terms unify? Where relevant,
%%               give the variable instantiations that lead to successful unification.
%% bread  =  bread         true
%% ’Bread’  =  bread       false
%% ’bread’  =  bread       true
%% Bread  =  bread         false
%% bread  =  sausage       false
%% food(bread)  =  bread   false
%% food(bread)  =  X       true
%% food(X)  =  food(bread)  true (X = bread)
%% food(bread,X)  =  food(Y,sausage)  true (X = sausage, Y = bread)
%% food(bread,X,beer)  =  food(Y,sausage,X) false
%% food(bread,X,beer)  =  food(Y,kahuna_burger) false
%% food(X)  =  X          true (swi-prolog unification)
%% meal(food(bread),drink(beer))  =  meal(X,Y) true (X = food(bread), Y = drink(beer))
%% meal(food(bread),X)  =  meal(X,drink(beer))   false

%% Exercise 2.2: We are working with the following knowledge base:
%% house_elf(dobby). 
%% witch(hermione). 
%% witch(’McGonagall’). 
%% witch(rita_skeeter). 
%% magic(X):-  house_elf(X). 
%% magic(X):-  wizard(X). 
%% magic(X):-  witch(X).
%% Which of the following queries are satisfied? Where relevant, give all the variable instantiations that lead to success.
%% ?-  magic(house_elf).   false
%% ?-  wizard(harry).      false
%% ?-  magic(wizard).      false
%% ?-  magic(’McGonagall’). true
%% ?-  magic(Hermione).     true

%% Exercise 2.3: Here is a tiny lexicon (that is, information about individual words) and a mini grammar consisting of one
%%               syntactic rule (which defines a sentence to be an entity consisting of five words in the following order:
%%                                a determiner, a noun, a verb, a determiner, a noun).

word(determiner,a). 
word(determiner,every). 
word(noun,criminal). 
word(noun,'big  kahuna  burger'). 
word(verb,eats). 
word(verb,likes). 
    
sentence(Word1,Word2,Word3,Word4,Word5):- 
  word(determiner,Word1), 
  word(noun,Word2), 
  word(verb,Word3), 
  word(determiner,Word4), 
  word(noun,Word5).
%% What query do you have to pose in order to find out which sentences the grammar can generate?
%% List all sentences that this grammar can generate in the order that Prolog will generate them in.
%% sentence(W1,W2,W3,W4,W5).


%% example in part 4.3
a2b([],[]).
a2b([a|Ta],[b|Tb]) :- a2b(Ta,Tb).

%% Exercise 4.1 : How does Prolog respond to the following queries?
%% [a,b,c,d]  =  [a,[b,c,d]].  false
%% [a,b,c,d]  =  [a|[b,c,d]].  true
%% [a,b,c,d]  =  [a,b,[c,d]].  false
%% [a,b,c,d]  =  [a,b|[c,d]].  true
%% [a,b,c,d]  =  [a,b,c,[d]].  false
%% [a,b,c,d]  =  [a,b,c|[d]].  true
%% [a,b,c,d]  =  [a,b,c,d,[]]. false
%% [a,b,c,d]  =  [a,b,c,d|[]]. false
%% []  =  _.                   true
%% []  =  [_].                 false
%% []  =  [_|[]].              false

%% Exercise 4.2 : Which of the following are syntactically correct lists?
%%                If the representation is correct, how many elements does the list have?
%% [1|[2,3,4]]            correct, 4 elements
%% [1,2,3|[]]             correct, 3 elements
%% [1|2,3,4]              incorrect (tail should be a list)
%% [1|[2|[3|[4]]]]        correct, 4 elements
%% [1,2,3,4|[]]           correct, 4 elements
%% [[]|[]]                correct, 1 element (which is an empty list)
%% [[1,2]|4]              incorrect, (tail should be a list, not a single element)
%% [[1,2],[3,4]|[5,6,7]]  correct, 5 elements


%% Exercise 4.3: Write a predicate second(X,List) which checks whether X is the second element of List.
second(X,[_,X|_]).

%% Exercise 4.4: Write a predicate swap12(List1,List2) which checks whether List1 is identical to List2,
%%               except that the first two elements are exchanged.
swap12([X,Y|_],[Y,X|_]).

%% Exercise 4.5: Suppose we are given a knowledge base with the following facts:
tran(eins,one). 
tran(zwei,two). 
tran(drei,three). 
tran(vier,four). 
tran(fuenf,five). 
tran(sechs,six). 
tran(sieben,seven). 
tran(acht,eight). 
tran(neun,nine).

%% Write a predicate listtran(G,E) which translates a list of German number words to the corresponding list of English number words.
%% For example: listtran([eins,neun,zwei],X).
%% should give: X  =  [one,nine,two].
%% Your program should also work in the other direction. For example, if you give it the query: listtran(X,[one,seven,six,two]).
%% it should return: X  =  [eins,sieben,sechs,zwei].
%% (Hint: to answer this question, first ask yourself "How do I translate the empty list of number words?". That's the base case.
%% For non-empty lists, first translate the head of the list, then use recursion to translate the tail.)

listtran([],[]).
listtran([H1|T1],[H2|T2]) :- tran(H1,H2), listtran(T1,T2).


%% Exercise 4.6: Write a predicate twice(In,Out) whose left argument is a list, and whose right argument is a list consisting of
%% every element in the left list written twice. For example, the query: twice([a,4,buggle],X).
%% should return: X  =  [a,a,4,4,buggle,buggle]).
%% And the query: twice([1,2,1,1],X).
%% should return: X  =  [1,1,2,2,1,1,1,1].
%% (Hint: to answer this question, first ask yourself "What should happen when the first argument is the empty list?".
%% That's the base case. For non-empty lists, think about what you should do with the head, and use recursion to handle the tail.)

twice([],[]).
twice([H|T1],[H,H|T2]) :- twice(T1,T2).

%% Exercise 11.3:  a) Write a predicate sigma/2 that takes an integer n > 0 and calculates the sum of all integers from 1 to n.
%%                 b) Write the predicate so that results are stored in the database (there should never be more than one entry
%%                    in the database for each value) and are reused whenever possible.

%% stored values
:- dynamic(sigmares/2). %% this must go before any definitions of sigmares (value will be stored dynamically later)
:- assert(sigmares(0,0)).
%% initial value
sigma(N,X) :- sigmares(N,X).
%% recursion (need to make sure N > 0 to avoid infinite loop - if sigma(0,X) fails then sigma(N,X) will be tried).
sigma(N,X) :- \+ sigmares(N,_), N > 0, M is N-1, sigma(M,Y), X is N+Y, assert(sigmares(N,X)).

