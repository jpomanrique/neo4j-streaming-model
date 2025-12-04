//////////////////////////////////////////
// 1. ENTIDADES (NÓS)
//////////////////////////////////////////

// USERS
CREATE (:User {id: 1, name: "Alice"});
CREATE (:User {id: 2, name: "Bob"});
CREATE (:User {id: 3, name: "Carol"});
CREATE (:User {id: 4, name: "Daniel"});
CREATE (:User {id: 5, name: "Eva"});
CREATE (:User {id: 6, name: "Frank"});
CREATE (:User {id: 7, name: "Grace"});
CREATE (:User {id: 8, name: "Henry"});
CREATE (:User {id: 9, name: "Ivy"});
CREATE (:User {id: 10, name: "John"});

// GENRES
CREATE (:Genre {id: 1, name: "Action"});
CREATE (:Genre {id: 2, name: "Adventure"});
CREATE (:Genre {id: 3, name: "Drama"});
CREATE (:Genre {id: 4, name: "Comedy"});
CREATE (:Genre {id: 5, name: "Sci-Fi"});
CREATE (:Genre {id: 6, name: "Horror"});
CREATE (:Genre {id: 7, name: "Thriller"});
CREATE (:Genre {id: 8, name: "Fantasy"});
CREATE (:Genre {id: 9, name: "Romance"});
CREATE (:Genre {id: 10, name: "Animation"});

// MOVIES
CREATE (:Movie {id: 1, title: "The Last Frontier", released: 2018});
CREATE (:Movie {id: 2, title: "Eternal Sparks", released: 2020});
CREATE (:Movie {id: 3, title: "Quantum Chase", released: 2019});
CREATE (:Movie {id: 4, title: "Silent Echoes", released: 2016});
CREATE (:Movie {id: 5, title: "Steel Shadows", released: 2021});
CREATE (:Movie {id: 6, title: "Urban Inferno", released: 2017});
CREATE (:Movie {id: 7, title: "Moonlight Dawn", released: 2022});
CREATE (:Movie {id: 8, title: "Broken Empire", released: 2015});
CREATE (:Movie {id: 9, title: "Digital Ghost", released: 2023});
CREATE (:Movie {id: 10, title: "Frozen Horizon", released: 2014});

// SERIES
CREATE (:Series {id: 1, title: "Starlight Protocol", seasons: 3});
CREATE (:Series {id: 2, title: "Iron Wolves", seasons: 2});
CREATE (:Series {id: 3, title: "Hidden Truths", seasons: 4});
CREATE (:Series {id: 4, title: "Lost Signal", seasons: 1});
CREATE (:Series {id: 5, title: "Windbreakers", seasons: 5});
CREATE (:Series {id: 6, title: "Neon Shadows", seasons: 2});
CREATE (:Series {id: 7, title: "Valley of Titans", seasons: 3});
CREATE (:Series {id: 8, title: "Crimson Planet", seasons: 1});
CREATE (:Series {id: 9, title: "Parallel Lines", seasons: 6});
CREATE (:Series {id: 10, title: "Soul Archive", seasons: 3});

// ACTORS
CREATE (:Actor {id: 1, name: "Emma Stone"});
CREATE (:Actor {id: 2, name: "Tom Hardy"});
CREATE (:Actor {id: 3, name: "Scarlett Johansson"});
CREATE (:Actor {id: 4, name: "Michael B. Jordan"});
CREATE (:Actor {id: 5, name: "Natalie Portman"});
CREATE (:Actor {id: 6, name: "Chris Evans"});
CREATE (:Actor {id: 7, name: "Zendaya"});
CREATE (:Actor {id: 8, name: "Pedro Pascal"});
CREATE (:Actor {id: 9, name: "Ana de Armas"});
CREATE (:Actor {id: 10, name: "Robert Pattinson"});

// DIRECTORS
CREATE (:Director {id: 1, name: "Denis Villeneuve"});
CREATE (:Director {id: 2, name: "Christopher Nolan"});
CREATE (:Director {id: 3, name: "Greta Gerwig"});
CREATE (:Director {id: 4, name: "Patty Jenkins"});
CREATE (:Director {id: 5, name: "Taika Waititi"});
CREATE (:Director {id: 6, name: "Steven Spielberg"});
CREATE (:Director {id: 7, name: "James Cameron"});
CREATE (:Director {id: 8, name: "Jordan Peele"});
CREATE (:Director {id: 9, name: "Matt Reeves"});
CREATE (:Director {id: 10, name: "Ridley Scott"});


//////////////////////////////////////////
// 2. RELACIONAMENTOS
//////////////////////////////////////////

// WATCHED (Users → Movies/Series) with rating
MATCH (u:User), (m:Movie)
WHERE m.id IN [1,2,3,4,5,6,7,8,9,10]
AND u.id <= 10
CREATE (u)-[:WATCHED {rating: toInteger(rand()*5)+1}]->(m);

MATCH (u:User), (s:Series)
WHERE s.id IN [1,2,3,4,5,6,7,8,9,10]
AND u.id <= 10
CREATE (u)-[:WATCHED {rating: toInteger(rand()*5)+1}]->(s);

// IN_GENRE
MATCH (m:Movie), (g:Genre)
WHERE g.id = toInteger(rand()*10)+1
CREATE (m)-[:IN_GENRE]->(g);

MATCH (s:Series), (g:Genre)
WHERE g.id = toInteger(rand()*10)+1
CREATE (s)-[:IN_GENRE]->(g);

// ACTED_IN for Movies
MATCH (a:Actor), (m:Movie)
WHERE rand() < 0.3
CREATE (a)-[:ACTED_IN]->(m);

// ACTED_IN for Series
MATCH (a:Actor), (s:Series)
WHERE rand() < 0.3
CREATE (a)-[:ACTED_IN]->(s);

// DIRECTED (1 per Movie)
MATCH (d:Director), (m:Movie)
WHERE d.id = toInteger(rand()*10)+1
CREATE (d)-[:DIRECTED]->(m);

// DIRECTED for Series
MATCH (d:Director), (s:Series)
WHERE rand() < 0.15
CREATE (d)-[:DIRECTED]->(s);


//////////////////////////////////////////
// 3. CONSTRAINTS
//////////////////////////////////////////

CREATE CONSTRAINT user_id_unique IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT movie_id_unique IF NOT EXISTS FOR (m:Movie) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT series_id_unique IF NOT EXISTS FOR (s:Series) REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT genre_id_unique IF NOT EXISTS FOR (g:Genre) REQUIRE g.id IS UNIQUE;
CREATE CONSTRAINT actor_id_unique IF NOT EXISTS FOR (a:Actor) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT director_id_unique IF NOT EXISTS FOR (d:Director) REQUIRE d.id IS UNIQUE;
