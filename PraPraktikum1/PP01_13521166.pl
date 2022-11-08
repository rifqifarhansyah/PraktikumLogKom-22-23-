/* PP01_13521166.pl */

/* Bagian 1 */
/* Deklarasi Fakta */

/* pria(X) : X adalah pria */
pria(gede).
pria(gojo).
pria(von_neumann).
pria(van_rossum).
pria(bambang).
pria(vito).
pria(ave).
pria(wesly).
pria(elon_musk).
pria(patrick).

/* wanita(X) : X adalah wanita */
wanita(indah).
wanita(lovelace).
wanita(khelli).
wanita(power).
wanita(aqua).
wanita(wulandari).
wanita(anya).

/* usia(X,Y) : X berusia Y */
usia(gede,96).
usia(indah,92).
usia(gojo,90).
usia(lovelace,79).
usia(khelli,89).
usia(von_neumann,92).
usia(van_rossum,65).
usia(bambang,60).
usia(vito,56).
usia(power,50).
usia(ave,54).
usia(aqua,50).
usia(wulandari,24).
usia(wesly,26).
usia(elon_musk,28).
usia(patrick,24).
usia(anya,4).

/* menikah(X,Y) : X menikah dengan Y */
menikah(gede,indah).
menikah(indah,gede).
menikah(gojo,lovelace).
menikah(lovelace,gojo).
menikah(khelli,von_neumann).
menikah(von_neumann,khelli).
menikah(vito,power).
menikah(power,vito).
menikah(ave,aqua).
menikah(aqua,ave).
menikah(wulandari,wesly).
menikah(wesly,wulandari).

/* anak(X,Y) : X adalah anak Y */
anak(van_rossum,gede).
anak(van_rossum,indah).
anak(bambang,gede).
anak(bambang,indah).
anak(vito,gede).
anak(vito,indah).
anak(power,gojo).
anak(power,lovelace).
anak(ave,gojo).
anak(ave,lovelace).
anak(aqua,khelli).
anak(aqua,von_neumann).
anak(wesly,vito).
anak(wesly,power).
anak(elon_musk,ave).
anak(elon_musk,aqua).
anak(patrick,ave).
anak(patrick,aqua).
anak(anya,wulandari).
anak(anya,wesly).

/* saudara(X,Y) : X adalah saudara kandung Y */
saudara(van_rossum,bambang).
saudara(bambang,van_rossum).
saudara(van_rossum,vito).
saudara(vito,van_rossum).
saudara(bambang,vito).
saudara(vito,bambang).
saudara(power,ave).
saudara(ave,power).
saudara(elon_musk,patrick).
saudara(patrick,elon_musk).

/* Deklarasi Rules */

/* kakak(X,Y) : X adalah kakak dari Y (baik perempuan maupun lelaki) */
kakak(X,Y) :-
    saudara(X,Y),
    usia(X,A),
    usia(Y,B),
    A>B.

/* keponakan(X,Y) : X adalah keponakan dari Y */
keponakan(X,Y) :-
    anak(X,A),
    saudara(A,Y).

/* suami(X,Y) : X adalah suami dari Y */
suami(X,Y) :-
    pria(X),
    menikah(X,Y).

/* sepupu(X,Y) : X adalah sepupu dari Y */
sepupu(X,Y) :-
    anak(X,A),
    saudara(A,B),
    anak(Y,B).

/* menantu(X,Y) : X adalah menantu dari Y */
menantu(X,Y) :-
    menikah(X,A),
    anak(A,Y).

/* orangtua(X,Y): X adalah orang tua dari Y */
orangtua(X,Y) :-
    anak(Y,X).

/* bibi(X,Y) : X adalah bibi dari Y */
bibi(X,Y) :-
    anak(Y,A),
    wanita(X),
    saudara(X,A).

/* cucu(X,Y) : X adalah cucu dari Y */
cucu(X,Y) :-
    anak(X,A),
    anak(A,Y).

/* keturunan(X,Y): X adalah keturunan dari Y (berlaku untuk anak, cucu, dan seterusnya) */
keturunan(X,Y) :-
    orangtua(Y,X).

keturunan(X,Y) :-
    orangtua(A,X),
    orangtua(Y,A).

keturunan(X,Y) :-
    orangtua(A,X),
    orangtua(B,A),
    orangtua(Y,B).

/* anaksulung(X) : X adalah anak paling tua */
anaksulung(X) :-
    anak(X,Y),
    pria(Y),
    \+kakak(_,X).

/* anakbungsu(X) : X adalah anak paling muda  */
anakbungsu(X) :-
    anak(X,Y),
    pria(Y),
    \+kakak(X,_).

/* Bagian 2 */
/* combination(N,C,X)  */
combination(N,0,X) :- X is 1, !.
combination(N,1,X) :- X is N, !.
combination(N,N,X) :- X is 1, !.
combination(N,C,X) :-
    C > 1,
    C < N,
    C1 is C - 1,
    N1 is N - 1,
    combination(N1,C1,X1),
    combination(N1,C,X2),
    X is X1 + X2.

/* change(X, Y) */
change(X,1) :- X is 1, !.
change(X,2) :- X is 1, !.
change(X,3) :- X is 2, !.
change(X,4) :- X is 2, !.
change(X,5) :- X is 1, !.
change(X,Y) :-
    Y1 is Y-5,
    change(X1,Y1),
    X is X1+1.

/* fpb(A, B, X)  */
fpb(X,0,X) :- !.
fpb(0,X,X) :- !.
fpb(A,B,X) :- 
    A1 is A mod B,
    fpb(B,A1,X).

/* mod(A,B,X) */
mod(A, B ,X) :-
    A<2*B, X is A-B, !.
mod(A,B,X) :-
    A>=2*B, mod(A-B, B, X).

/* deret(X,Y) */
deret(1,Y) :- Y is 1, !.
deret(X,Y) :-
    X1 is X-1,
    deret(X1,Y1),
    X mod 2 =:= 1,
    Y is Y1*2.
deret(X,Y) :-
    X1 is X-1,
    deret(X1,Y1),
    X mod 2 =:= 0,
    Y is Y1+1.

/* Bagian 3 */
/* min(List, Min) */
min([X],X) :- !.
min([X|Xs],X) :-
    min(Xs,Y),
    X=<Y.
min([X|Xs],Y) :-
    min(Xs,Y),
    X>Y.

/* max(List, Max) */
max([X],X) :- !.
max([X|Xs],X) :-
    max(Xs,Y),
    X>=Y.
max([X|Xs],Y) :-
    max(Xs,Y),
    X<Y.

/* range(List, Range) */
range(List,Range) :-
    min(List,Min),
    max(List,Max),
    Range is Max-Min.

/* count(List, Count) */
count([],0) :- !.
count([_|Xs],Y) :-
    count(Xs,Y1),
    Y is Y1+1.

/* sum(List, Sum) */
sum([],0) :- !.
sum([X|Xs],Y) :-
    sum(Xs,Y1),
    Y is Y1+X.

/* getIndex(List, SearchedElement, Result) */
getIndex([X|_],X,1) :- !.
getIndex([_|Xs],X,Y) :-
    getIndex(Xs,X,Y1),
    Y is Y1+1.

/* swap(List, Index1, Index2, Result) */
change_value([X|List], 0, Y, [Y|List2]) :- 
        copy_rest(List, List2). 
change_value([], P, Y, []).   
change_value([X|List], Pos, Y, [X|List2]) :- 
        Pos > 0, 
        NewPos is Pos - 1, 
        change_value(List, NewPos, Y, List2). 

copy_rest([], []). 
copy_rest([X|List], [X|List2]) :- 
        copy_rest(List, List2).

getElmt([H|_],H,1) :-!.
getElmt([_|T],H,N) :-
    N > 1, 
    N1 is N-1,
    getElmt(T,H,N1).

swap(List,Idx1,Idx2,Res):-
    Idx1r is Idx1-1,
    Idx2r is Idx2-1,
    getElmt(List,Elem1,Idx1),
    getElmt(List,Elem2,Idx2),
    change_value(List,Idx1r,Elem2,List2),
    change_value(List2,Idx2r,Elem1,Res),!.

/* splitList(ListAwal, ListGanjil, ListGenap) */
splitList([],[],[]) :- !.
splitList([X|Xs],[X|Ys],Zs) :-
    X mod 2 =:= 1,
    splitList(Xs,Ys,Zs).
splitList([X|Xs],Ys,[X|Zs]) :-
    X mod 2 =:= 0,
    splitList(Xs,Ys,Zs).

/* BONUS */
:- dynamic(savedvalue/1). 
:- dynamic(cek/1).

savedvalue(0).
cek(0).

/* saveValue(X) : untuk melakukan overwrite pada savedvalue */
saveValue(X) :-
    retract(savedvalue(_)),
    asserta(savedvalue(X)).

/* saveCek(X) : untuk melakukan overwrite pada cek */
saveCek(X) :-
    retract(cek(_)),
    asserta(cek(X)).

startCalculator :-
    saveCek(1),
    write('Selamat Datang di Kalkulator Prolog!'), nl,
    savedvalue(X),
    write('Currently Saved Value is '), write(X), nl.

add(X) :-
    cek(C),
    C =:= 1,
    savedvalue(A),
    write('Old Saved Value is '), write(A),nl,
    Y is A+X,
    saveValue(Y),
    write('New Saved Value is '), write(Y), nl.

subtract(X) :-
    cek(C),
    C =:= 1,
    savedvalue(A),
    write('Old Saved Value is '), write(A),nl,
    Y is A-X,
    saveValue(Y),
    write('New Saved Value is '), write(Y), nl.

multiply(X) :-
    cek(C),
    C =:= 1,
    savedvalue(A),
    write('Old Saved Value is '), write(A),nl,
    Y is A*X,
    saveValue(Y),
    write('New Saved Value is '), write(Y), nl.

divide(X) :-
    cek(C),
    C =:= 1,
    savedvalue(A),
    write('Old Saved Value is '), write(A),nl,
    Y is A/X,
    saveValue(Y),
    write('New Saved Value is '), write(Y), nl.

clearCalculator :-
    cek(C),
    C =:= 1,
    savedvalue(X),
    write('Old Saved Value is '), write(X),nl,
    saveValue(0),
    write('New Saved Value is '), write(0), nl.

getValue :-
    cek(C),
    C =:= 1,
    savedvalue(X),
    write('Currently Saved Value is '),write(X),nl.

exitCalculator :-
    saveCek(0),
    write('Terima Kasih telah Menggunakan Kalkulator Prolog'),nl.


