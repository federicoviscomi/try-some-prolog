
regexToAutomaton(Regex, Automaton) :-
	r2a(0, Regex, Automaton).
/* casi base */
r2a(N, epsilon, X) :-
	X = automaton(
		state(N+i), 
		state(N+f), 
		[(state(N+i), epsilon, state(N+f)), (state(N+f), epsilon, state(N+f))]).
r2a(N, A, X) :- 
	member(A, [a, b, c, d, e, f, g, h, i, l, m]),
	X = automaton(
		state(N+i), 
		state(N+f), 
		[(state(N+i), A, state(N+f))]).

/* casi induttivi */
r2a(N, cat(A, B), X) :- 
	r2a(N+0, A, automaton(state(Ni), state(Nf), At)),
	r2a(N+1, B, automaton(state(Mi), state(Mf), Bt)),
	append(At, Bt, Xt),
	X = automaton(
		state(N+i),
		state(N+f),
		[(state(N+i), epsilon, state(Ni)), (state(Nf), epsilon, state(Mi)), 
		 (state(Mf), epsilon, state(N+f)) | Xt]).

r2a(N, union(A, B), X) :- 
	r2a(N+0, A, automaton(state(Ni), state(Nf), At)),
	r2a(N+1, B, automaton(state(Mi), state(Mf), Bt)),
	append(At, Bt, Xt),
	X = automaton(
		state(N+i),
		state(N+f),
		[(state(N+i), epsilon, state(Ni)), (state(N+i), epsilon, state(Mi)), 
		 (state(Nf), epsilon, state(N+f)), (state(Mf), epsilon, state(N+f)) | Xt]).

r2a(N, star(A), X) :- 
	r2a(N+0, A, automaton(state(Ni), state(Nf), At)),
	X = automaton(
		state(N+i),
		state(N+f),
		[(state(N+i), epsilon, state(N+f)), (state(N+i), epsilon, state(Ni)), 
		 (state(Nf), epsilon, state(Ni)),  (state(Nf), epsilon, state(N+f)) | At ]).

