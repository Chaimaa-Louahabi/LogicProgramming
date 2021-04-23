/*Question 1: Le prédicat 'poids' */
poids(morceau, 10).
poids(cachous, 1).
poids(ballons, 7).
poids(goodies, 6).
poids(ordi, 20).

/*Question 2: le predicat poids_sac(S, P) 
 * est vrai si P est le poids total de la liste d’objets S
 */
poids_sac([], 0).
poids_sac([H|T], P) :- poids(H, X), poids_sac(T, Y), P is Y+X.

/*Question 3: le predicat sous_liste(L, M) 
 * est vrai si M est une sous-liste de L
 */
sous_liste([],[]).
sous_liste([H | T1], [H | T2]) :- sous_liste(T1,T2).
sous_liste([_ | T], M) :- sous_liste(T, M).

/*Question 4: le predicat acceptable(L, S) est vrai si 
 * S est une liste d’objets choisis dans la liste L, et si 
 *le poids total des objets de S ne dépasse pas 20 kg 
 */

acceptable(L, S) :- sous_liste(L, S), poids_sac(S, P), P =< 20.


/*Question 5: le predicat meilleur_poids(L, S) est vrai si S est une liste 
 *acceptable d’objets, choisis dans la liste L, de poids maximal
 */
autre_meilleur_poids(L,S):-  acceptable(L, S2),S\=S2, 
                            poids_sac(S, P1), poids_sac(S2, P2), (P2>P1;P1>20).
meilleur_poids(L, S):- acceptable(L, S),\+ autre_meilleur_poids(L,S).

/*Question 6: le predicat utilite(O, U) est vrai si U est l'utilité de 
 *l'objet O.
 */
utilite(morceau, 4).
utilite(cachous, 3).
utilite(ballons, 2).
utilite(goodies, 1).
utilite(ordi, 0).

utilite_sac([], 0).
utilite_sac([H|T], U) :- utilite(H, X), utilite_sac(T, Y), U is Y+X.

/*Question 6: le predicat meilleure_utilite(L, S) est vrai si S est une liste 
 *d’objets de poids maximal et d’utilité maximale.
*/
autre_meilleur_utilite(L,S):- acceptable(L, S2),S\=S2, 
                              poids_sac(S, P1), poids_sac(S2, P2), (P2>P1;P1>20), 
                              utilite_sac(S, U1), utilite_sac(S2, U2), U2>U1 .
meilleure_utilite(L, S):- acceptable(L, S),\+ autre_meilleur_utilite(L,S).

/* Question 7: 
 * a) le prédicat p(L, S, X) est vrai si X est la liste des sous liste de L à 
 *partir de la sous liste S .
 */
q([],_,_) :- fail.
q([X|_],[],[X]).
q([X|RR],[X|RC],S) :- q(RR,RC,S). q([X|_],[Y|RC],S) :- X \= Y, S = [X,Y|RC].
p(R,C,[C]) :- \+ (q(R,C,_)).
p(R,C,[C|V]) :- q(R,C,S), p(R,S,V).

/* Le prédicat poids_max(L, P) est vrai si P est le poids maximal de tous les 
 * sacs de L
 */
poids_max([],_).
poids_max([H|T],P) :- poids_sac(H, Ph), (Ph> 20;Ph=<P), poids_max(T,P).

meilleur_poids2([], []).
meilleur_poids2(L, S):- acceptable(L, S), p(L,[],X), poids_sac(S, P), poids_max(X, P).



