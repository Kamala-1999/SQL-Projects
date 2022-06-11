--1.Write a SQL query to find those reviewers who have rated nothing for some movies.Return reviewer name.

select distinct rev_name 
from reviewer r 
join rating mr on r.rev_id = mr.rev_id 
where rev_stars = 0;

--2.Write a SQL query to find the movies, which have been reviewed by any reviewer body except by 'Paul Monks'.Return movie title.

select mov_title as Movies
FROM movie m 
join rating r on m.mov_id = r.mov_id
join reviewer rr on r.rev_id = rr.rev_id
where rr.rev_name != 'Paul Monks';

--3.Write a SQL query to find the lowest rated movies.Return reviewer name, movie title, and number of stars for those movies.

SELECT rev_name, mov_title, num_o_ratings
FROM reviewer r
join rating rr on r.rev_id = rr.rev_id
join movie m on rr.mov_id = m.mov_id
where rev_stars = (SELECT min(rev_stars) FROM rating where rev_stars != 0);

--4.Write a SQL query to find the movies directed by 'James Cameron'.Return movie title.

SELECT mov_title as movies
FROM movie m
join movie_direction d on m.mov_id = d.mov_id
JOIN director d1 on d.dir_id = d1.dir_id
WHERE d1.dir_fname like '%James%' 
and d1.dir_lname like '%Cameron%';

--5.Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies. 

SELECT mov_title as Movies
FROM movie m
join movie_cast mc on m.mov_id = mc.mov_id
WHERE mc.act_id IN (
    SELECT act_id
    FROM movie_cast
    GROUP BY act_id
    HAVING COUNT(*) > 1);

--6.Given a relation R( A, B, C, D) and Functional Dependency set FD = { AB → CD, B → C },determine whether the given R is in 2NF? If not, convert it into 2 NF.

Answer: It is not in 2NF because there is partial dependency in B with PRIMARY KEY AB.

So we can make R1(A,B,D) and R2(B,C).

--7.Given a relation R( P, Q, R, S, T) and Functional Dependency set FD = { PQ → R, S → T },determine whether the given R is in 2NF? If not, convert it into 2 NF.

Answer: It is not in 2NF because there is partial dependency in PQ and S with PRIMARY KEY PQS.

So we can make R1(P,Q,R) , R2(S,T) and R3(P,Q,S).

--8.Given a relation R( P, Q, R, S, T, U, V, W, X, Y) and Functional Dependency set FD = { PQ → R, PS → VW, QS → TU, P → X, W → Y }, determine whether the given R is in 2NF? If not, convert it into 2 NF.

Answer: It is not in 2NF because there is partial dependency in P with PRIMARY KEY PQS.

So we can make R1(P,Q,R) , R2(P,S,V,W,Y) , R3(Q,S,T,U) and R4(P,X).

--9.given a relation R( X, Y, Z, W, P) and Functional Dependency set FD = { X → Y, Y → P, and Z → W}, determine whether the given R is in 3NF? If not, convert it into 3 NF.

Answer: It is not in 3NF because there is partial dependency in X and Z & transitive dependecy in Y with PRIMARY KEY XZ .

So we can make R1(X,Y) , R2(X,P) , R3(Z,W) and R4(X,Z).

--10.Given a relation R( P, Q, R, S, T, U, V, W, X, Y) and Functional Dependency set FD = { PQ → R, P → ST, Q → U, U → VW, and S → XY}, determine whether the given R is in 3NF? If not, convert it into 3 NF.

Answer: It is not in 3NF because there is partial dependency in P and Q &  transitive dependecy in S and U  with PRIMARY KEY PQ.

So we can make R1(P,Q,R) , R2(P,S,T) , R3(Q,U) , R4(Q,V,W) and R5(P,X,Y) .