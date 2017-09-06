% Example of a basic expert system written in prolog.
% To use this program just load/consult the file into prolog, and you should get a "> " prompt
% asking you to enter a command. If you don't see this prompt you may need to evaluate the 
% "go" predicate (see below), or you can just evaluate "solve." to perform a query directly.

% The main program logic is contained in the first half of the file (MAIN CODE SECTION),
% and the data is contained in the 2nd section. 
% You can store different datasets in different files and load them with the load command
% at the user command prompt (started with the "go" predicate). See the data section to
% see how to create your own dataset.

%% Written by Joe Bloggs [2017-09-06 Wed]

% MAIN CODE SECTION

% this predicate is used to start the consultation
solve :- abolish(known, 3), % remove any existing known attribute values
	 dynamic(known/3), % let prolog know about the "known" predicate
	 top_goal(X), % evaluate the goal
	 write('The answer is '), write(X), nl. % write the answer
solve :- write('No answer found.'), nl. % otherwise inform the user that there is no valid answer

% menuask procedure: prompts the user for a value for attribute A chosen from MenuList, and store it in V
menuask(A, V, MenuList) :- known(yes, A, V), !. % succeed if true (if known as "yes"), and then stop (so only 1 answer is returned).
menuask(A, V, MenuList) :- known(_, A, V), fail. % if known as something other than "yes", then fail & stop checking.
menuask(A, V, MenuList) :- known(yes, A, W), V \== W, fail. % if known as yes for some other value different from V then fail.
menuask(A, V, MenuList) :- nl,write('What is the value for '), write(A), write('?'), nl, % otherwise, ask the user for a value
			   write_menu(MenuList,1), nl, % print the possible values
			   read(X), % read user input into X
			   check_val(X, A, V, MenuList, W), % make sure X is valid, and set W to appropriate value
			   asserta(known(yes, A, W)), % store the user chosen value for A in the database
			   X == V. % only proceed with this value V if it is the same as the value X chosen by the user

% proceedures for writing the menu
write_menu([],N) :- nl.
write_menu([X|Y],N) :- nl,format("~d: ~a",[N,X]),write_menu(Y,N+1).

% procedure to check if selected value is legal.
check_val(X, A, V, MenuList, W) :- member(X, MenuList), W is X, !. % if it's a member of "MenuList" set W to that member, and stop.
% it it's a number < length(MenuList), set W to the corresponding element of MenuList, and stop.
check_val(X, A, V, MenuList, W) :- integer(X), length(MenuList,L), X =< L, nth1(X,MenuList,W), !.
% otherwise print an error message, and prompt the user for another value
check_val(X, A, V, MenuList, W) :- write(X), write(' is not a legal value, try again.'), nl, menuask(A, V, MenuList). 

% prompt user for commands
go :- greeting, % greet the user (see below)
      repeat, % loop 
      nl, write('> '), % prompt string
      read(X), % read user input
      do(X), % execute command
      X == quit. % exit loop if "quit" command entered
% greeting message
greeting :- write('This is the Native Prolog shell.'), nl, 
	    write('Enter "help." to show available commands, or "quit." to exit.'), nl.
% user command processing
do(load) :- load_kb, !.
do(consult) :- solve, !.
do(help) :- nl, write('Available commands:'), nl, nl,
	    write('help.      show this help.'), nl,
	    write('load.      load a data file (prompted for).'), nl,
	    write('consult.   query the database.'), nl,
	    write('list.      list the currently known attributes and their values.'), nl,
	    write('quit.      exit.'), nl, !.
do(list) :- dynamic(known/3),
	    known(yes,A,V),
	    nl, write(A), write(' = '), write(V).
do(list) :- nl, !.
do(quit).
do(X) :- nl, write(X),
	 write(' is not a legal command.'), nl, 
	 fail.
% command to load file
load_kb :- write('Enter file name: '), 
	   read(F), 
	   reconsult(F).

% DATA SECTION
% This can be put in a separate file, or you can create another file with different data, based on this one.

% main goal that will be called by "solve"
top_goal(X) :- bird(X).
% data for the different birds
bird(laysan_albatross):- family(albatross), 
			 colour(white).
bird(black_footed_albatross):- family(albatross), 
			       colour(dark).
bird(whistling_swan) :- family(swan), 
			voice(muffled_musical_whistle).
bird(trumpeter_swan) :- family(swan), 
			voice(loud_trumpeting).
bird(canada_goose):- family(goose), 
		     season(winter), 
		     country(united_states), 
		     head(black), 
		     cheek(white).
bird(canada_goose):- family(goose), 
		     season(summer), 
		     country(canada), 
		     head(black), 
		     cheek(white).
bird(mallard):- family(duck), 
		voice(quack), 
		head(green).
bird(mallard):- family(duck), 
		voice(quack), 
		colour(mottled_brown).
% data about different families and orders of birds
order(tubenose) :- nostrils(external_tubular), 
		   live(at_sea), 
		   bill(hooked).
order(waterfowl) :- feet(webbed), 
		    bill(flat).
family(albatross) :- order(tubenose), 
		     size(large), 
		     wings(long_narrow).
family(swan) :- order(waterfowl), 
		neck(long), 
		colour(white), 
		flight(ponderous).
% following attributes will be queried from the user
feet(X):- menuask(feet, X, [webbed, pointy]).
wings(X):- menuask(wings, X, [long_narrow, short]).
neck(X):- menuask(neck, X, [long, short]).
colour(X):- menuask(color, X, [white, dark, mottled_brown]).
nostrils(X):- menuask(nostrils, X, [external_tubular, wide]).
live(X):- menuask(live,X,[at_sea, on_land]).
bill(X):- menuask(bill,X,[hooked, flat]).
size(X):- menuask(size, X, [large, plump, medium, small]).
flight(X):- menuask(flight, X, [ponderous, agile, flap_glide]).
voice(X):- menuask(voice, X, [quack, loud_trumpeting, muffled_musical_whistle]).

% start the user command prompt.
:- go.

