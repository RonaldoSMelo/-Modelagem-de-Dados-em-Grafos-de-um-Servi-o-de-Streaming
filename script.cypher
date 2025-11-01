// ==========================================
// SCRIPT CYPHER - SERVIÇO DE STREAMING
// Modelagem de Grafos - Neo4j
// ==========================================

// LIMPAR BANCO DE DADOS (ATENÇÃO: Remove todos os dados!)
MATCH (n)
DETACH DELETE n;

// ==========================================
// 1. CRIAR CONSTRAINTS E ÍNDICES
// ==========================================

// Constraints para garantir unicidade de IDs
CREATE CONSTRAINT user_id_unique IF NOT EXISTS
FOR (u:User) REQUIRE u.id IS UNIQUE;

CREATE CONSTRAINT movie_id_unique IF NOT EXISTS
FOR (m:Movie) REQUIRE m.id IS UNIQUE;

CREATE CONSTRAINT series_id_unique IF NOT EXISTS
FOR (s:Series) REQUIRE s.id IS UNIQUE;

CREATE CONSTRAINT genre_id_unique IF NOT EXISTS
FOR (g:Genre) REQUIRE g.id IS UNIQUE;

CREATE CONSTRAINT actor_id_unique IF NOT EXISTS
FOR (a:Actor) REQUIRE a.id IS UNIQUE;

CREATE CONSTRAINT director_id_unique IF NOT EXISTS
FOR (d:Director) REQUIRE d.id IS UNIQUE;

// Índices para melhorar performance
CREATE INDEX user_name IF NOT EXISTS
FOR (u:User) ON (u.name);

CREATE INDEX movie_title IF NOT EXISTS
FOR (m:Movie) ON (m.title);

CREATE INDEX series_title IF NOT EXISTS
FOR (s:Series) ON (s.title);

CREATE INDEX genre_name IF NOT EXISTS
FOR (g:Genre) ON (g.name);

CREATE INDEX actor_name IF NOT EXISTS
FOR (a:Actor) ON (a.name);

CREATE INDEX director_name IF NOT EXISTS
FOR (d:Director) ON (d.name);

// ==========================================
// 2. CRIAR GÊNEROS (GENRES)
// ==========================================

CREATE (g1:Genre {id: 'genre_001', name: 'Ação'});
CREATE (g2:Genre {id: 'genre_002', name: 'Comédia'});
CREATE (g3:Genre {id: 'genre_003', name: 'Drama'});
CREATE (g4:Genre {id: 'genre_004', name: 'Ficção Científica'});
CREATE (g5:Genre {id: 'genre_005', name: 'Terror'});
CREATE (g6:Genre {id: 'genre_006', name: 'Romance'});
CREATE (g7:Genre {id: 'genre_007', name: 'Aventura'});
CREATE (g8:Genre {id: 'genre_008', name: 'Suspense'});

// ==========================================
// 3. CRIAR DIRETORES (DIRECTORS)
// ==========================================

CREATE (d1:Director {id: 'director_001', name: 'Christopher Nolan', birthYear: 1970});
CREATE (d2:Director {id: 'director_002', name: 'Steven Spielberg', birthYear: 1946});
CREATE (d3:Director {id: 'director_003', name: 'Quentin Tarantino', birthYear: 1963});
CREATE (d4:Director {id: 'director_004', name: 'Greta Gerwig', birthYear: 1983});
CREATE (d5:Director {id: 'director_005', name: 'Ava DuVernay', birthYear: 1972});
CREATE (d6:Director {id: 'director_006', name: 'Denis Villeneuve', birthYear: 1967});
CREATE (d7:Director {id: 'director_007', name: 'David Fincher', birthYear: 1962});

// ==========================================
// 4. CRIAR ATORES (ACTORS)
// ==========================================

CREATE (a1:Actor {id: 'actor_001', name: 'Leonardo DiCaprio', birthYear: 1974});
CREATE (a2:Actor {id: 'actor_002', name: 'Meryl Streep', birthYear: 1949});
CREATE (a3:Actor {id: 'actor_003', name: 'Tom Hanks', birthYear: 1956});
CREATE (a4:Actor {id: 'actor_004', name: 'Jennifer Lawrence', birthYear: 1990});
CREATE (a5:Actor {id: 'actor_005', name: 'Michael B. Jordan', birthYear: 1987});
CREATE (a6:Actor {id: 'actor_006', name: 'Viola Davis', birthYear: 1965});
CREATE (a7:Actor {id: 'actor_007', name: 'Ryan Gosling', birthYear: 1980});
CREATE (a8:Actor {id: 'actor_008', name: 'Emma Stone', birthYear: 1988});
CREATE (a9:Actor {id: 'actor_009', name: 'Timothée Chalamet', birthYear: 1995});
CREATE (a10:Actor {id: 'actor_010', name: 'Zendaya', birthYear: 1996});

// ==========================================
// 5. CRIAR FILMES (MOVIES)
// ==========================================

CREATE (m1:Movie {
  id: 'movie_001',
  title: 'Inception',
  year: 2010,
  duration: 148,
  description: 'Um ladrão especializado em roubar segredos do subconsciente humano',
  rating: 8.8
});

CREATE (m2:Movie {
  id: 'movie_002',
  title: 'Jurassic Park',
  year: 1993,
  duration: 127,
  description: 'Parque temático com dinossauros clonados',
  rating: 8.2
});

CREATE (m3:Movie {
  id: 'movie_003',
  title: 'Django Unchained',
  year: 2012,
  duration: 165,
  description: 'Um escravo e um caçador de recompensas alemão no Velho Oeste',
  rating: 8.4
});

CREATE (m4:Movie {
  id: 'movie_004',
  title: 'Little Women',
  year: 2019,
  duration: 135,
  description: 'Quatro irmãs crescem na América do século XIX',
  rating: 7.8
});

CREATE (m5:Movie {
  id: 'movie_005',
  title: 'Gone Girl',
  year: 2014,
  duration: 149,
  description: 'Desaparecimento misterioso de uma mulher',
  rating: 8.1
});

CREATE (m6:Movie {
  id: 'movie_006',
  title: 'Blade Runner 2049',
  year: 2017,
  duration: 164,
  description: 'Um jovem replicante descobre um segredo que pode mergulhar a sociedade no caos',
  rating: 8.0
});

// ==========================================
// 6. CRIAR SÉRIES (SERIES)
// ==========================================

CREATE (s1:Series {
  id: 'series_001',
  title: 'Stranger Things',
  startYear: 2016,
  endYear: 2022,
  seasons: 4,
  description: 'Um grupo de amigos enfrenta forças sobrenaturais',
  rating: 8.7
});

CREATE (s2:Series {
  id: 'series_002',
  title: 'The Crown',
  startYear: 2016,
  endYear: 2023,
  seasons: 6,
  description: 'A vida da Rainha Elizabeth II e a história da monarquia britânica',
  rating: 8.6
});

CREATE (s3:Series {
  id: 'series_003',
  title: 'Black Mirror',
  startYear: 2011,
  endYear: 2019,
  seasons: 5,
  description: 'Antologia de ficção científica explorando a tecnologia moderna',
  rating: 8.8
});

CREATE (s4:Series {
  id: 'series_004',
  title: 'Bridgerton',
  startYear: 2020,
  endYear: null,
  seasons: 3,
  description: 'Drama de época na alta sociedade da Inglaterra regencial',
  rating: 7.4
});

// ==========================================
// 7. CRIAR USUÁRIOS (USERS)
// ==========================================

CREATE (u1:User {id: 'user_001', name: 'Ana Silva', email: 'ana.silva@email.com', age: 28});
CREATE (u2:User {id: 'user_002', name: 'Bruno Santos', email: 'bruno.santos@email.com', age: 35});
CREATE (u3:User {id: 'user_003', name: 'Carolina Costa', email: 'carolina.costa@email.com', age: 42});
CREATE (u4:User {id: 'user_004', name: 'Daniel Oliveira', email: 'daniel.oliveira@email.com', age: 31});
CREATE (u5:User {id: 'user_005', name: 'Eduarda Lima', email: 'eduarda.lima@email.com', age: 24});
CREATE (u6:User {id: 'user_006', name: 'Felipe Martins', email: 'felipe.martins@email.com', age: 45});
CREATE (u7:User {id: 'user_007', name: 'Gabriela Alves', email: 'gabriela.alves@email.com', age: 29});
CREATE (u8:User {id: 'user_008', name: 'Henrique Pereira', email: 'henrique.pereira@email.com', age: 52});
CREATE (u9:User {id: 'user_009', name: 'Isabela Rocha', email: 'isabela.rocha@email.com', age: 36});
CREATE (u10:User {id: 'user_010', name: 'João Cavalcanti', email: 'joao.cavalcanti@email.com', age: 27});

// ==========================================
// 8. RELACIONAMENTOS: FILMES -> GÊNEROS
// ==========================================

MATCH (m:Movie {id: 'movie_001'}), (g1:Genre {id: 'genre_007'}), (g2:Genre {id: 'genre_004'})
CREATE (m)-[:IN_GENRE]->(g1), (m)-[:IN_GENRE]->(g2);

MATCH (m:Movie {id: 'movie_002'}), (g1:Genre {id: 'genre_001'}), (g2:Genre {id: 'genre_007'})
CREATE (m)-[:IN_GENRE]->(g1), (m)-[:IN_GENRE]->(g2);

MATCH (m:Movie {id: 'movie_003'}), (g1:Genre {id: 'genre_001'}), (g2:Genre {id: 'genre_006'})
CREATE (m)-[:IN_GENRE]->(g1), (m)-[:IN_GENRE]->(g2);

MATCH (m:Movie {id: 'movie_004'}), (g1:Genre {id: 'genre_003'}), (g2:Genre {id: 'genre_006'})
CREATE (m)-[:IN_GENRE]->(g1), (m)-[:IN_GENRE]->(g2);

MATCH (m:Movie {id: 'movie_005'}), (g1:Genre {id: 'genre_003'}), (g2:Genre {id: 'genre_008'})
CREATE (m)-[:IN_GENRE]->(g1), (m)-[:IN_GENRE]->(g2);

MATCH (m:Movie {id: 'movie_006'}), (g1:Genre {id: 'genre_004'}), (g2:Genre {id: 'genre_003'})
CREATE (m)-[:IN_GENRE]->(g1), (m)-[:IN_GENRE]->(g2);

// ==========================================
// 9. RELACIONAMENTOS: SÉRIES -> GÊNEROS
// ==========================================

MATCH (s:Series {id: 'series_001'}), (g1:Genre {id: 'genre_005'}), (g2:Genre {id: 'genre_004'})
CREATE (s)-[:IN_GENRE]->(g1), (s)-[:IN_GENRE]->(g2);

MATCH (s:Series {id: 'series_002'}), (g1:Genre {id: 'genre_003'}), (g2:Genre {id: 'genre_006'})
CREATE (s)-[:IN_GENRE]->(g1), (s)-[:IN_GENRE]->(g2);

MATCH (s:Series {id: 'series_003'}), (g1:Genre {id: 'genre_004'}), (g2:Genre {id: 'genre_008'})
CREATE (s)-[:IN_GENRE]->(g1), (s)-[:IN_GENRE]->(g2);

MATCH (s:Series {id: 'series_004'}), (g1:Genre {id: 'genre_003'}), (g2:Genre {id: 'genre_006'})
CREATE (s)-[:IN_GENRE]->(g1), (s)-[:IN_GENRE]->(g2);

// ==========================================
// 10. RELACIONAMENTOS: DIRETORES -> FILMES/SÉRIES
// ==========================================

MATCH (d:Director {id: 'director_001'}), (m:Movie {id: 'movie_001'})
CREATE (d)-[:DIRECTED]->(m);

MATCH (d:Director {id: 'director_002'}), (m:Movie {id: 'movie_002'})
CREATE (d)-[:DIRECTED]->(m);

MATCH (d:Director {id: 'director_003'}), (m:Movie {id: 'movie_003'})
CREATE (d)-[:DIRECTED]->(m);

MATCH (d:Director {id: 'director_004'}), (m:Movie {id: 'movie_004'})
CREATE (d)-[:DIRECTED]->(m);

MATCH (d:Director {id: 'director_007'}), (m:Movie {id: 'movie_005'})
CREATE (d)-[:DIRECTED]->(m);

MATCH (d:Director {id: 'director_006'}), (m:Movie {id: 'movie_006'})
CREATE (d)-[:DIRECTED]->(m);

// ==========================================
// 11. RELACIONAMENTOS: ATORES -> FILMES/SÉRIES
// ==========================================

// Inception
MATCH (a:Actor {id: 'actor_001'}), (m:Movie {id: 'movie_001'})
CREATE (a)-[:ACTED_IN]->(m);

MATCH (a:Actor {id: 'actor_009'}), (m:Movie {id: 'movie_001'})
CREATE (a)-[:ACTED_IN]->(m);

// Jurassic Park
MATCH (a:Actor {id: 'actor_003'}), (m:Movie {id: 'movie_002'})
CREATE (a)-[:ACTED_IN]->(m);

// Django Unchained
MATCH (a:Actor {id: 'actor_001'}), (m:Movie {id: 'movie_003'})
CREATE (a)-[:ACTED_IN]->(m);

// Little Women
MATCH (a:Actor {id: 'actor_008'}), (m:Movie {id: 'movie_004'})
CREATE (a)-[:ACTED_IN]->(m);

MATCH (a:Actor {id: 'actor_009'}), (m:Movie {id: 'movie_004'})
CREATE (a)-[:ACTED_IN]->(m);

// Gone Girl
MATCH (a:Actor {id: 'actor_004'}), (m:Movie {id: 'movie_005'})
CREATE (a)-[:ACTED_IN]->(m);

// Blade Runner 2049
MATCH (a:Actor {id: 'actor_007'}), (m:Movie {id: 'movie_006'})
CREATE (a)-[:ACTED_IN]->(m);

// Stranger Things - Series
MATCH (a:Actor {id: 'actor_010'}), (s:Series {id: 'series_001'})
CREATE (a)-[:ACTED_IN]->(s);

// The Crown - Series
MATCH (a:Actor {id: 'actor_002'}), (s:Series {id: 'series_002'})
CREATE (a)-[:ACTED_IN]->(s);

// ==========================================
// 12. RELACIONAMENTOS: USUÁRIOS -> FILMES/SÉRIES (WATCHED com rating)
// ==========================================

// Ana assistiu 3 filmes e 1 série
MATCH (u:User {id: 'user_001'}), (m:Movie {id: 'movie_001'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-01-15'}]->(m);

MATCH (u:User {id: 'user_001'}), (m:Movie {id: 'movie_004'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-02-10'}]->(m);

MATCH (u:User {id: 'user_001'}), (m:Movie {id: 'movie_005'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-03-05'}]->(m);

MATCH (u:User {id: 'user_001'}), (s:Series {id: 'series_001'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-04-20'}]->(s);

// Bruno assistiu 2 filmes
MATCH (u:User {id: 'user_002'}), (m:Movie {id: 'movie_002'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-01-20'}]->(m);

MATCH (u:User {id: 'user_002'}), (m:Movie {id: 'movie_003'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-02-15'}]->(m);

// Carolina assistiu 1 filme e 2 séries
MATCH (u:User {id: 'user_003'}), (m:Movie {id: 'movie_006'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-01-30'}]->(m);

MATCH (u:User {id: 'user_003'}), (s:Series {id: 'series_002'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-03-10'}]->(s);

MATCH (u:User {id: 'user_003'}), (s:Series {id: 'series_003'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-04-15'}]->(s);

// Daniel assistiu 2 filmes
MATCH (u:User {id: 'user_004'}), (m:Movie {id: 'movie_001'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-02-01'}]->(m);

MATCH (u:User {id: 'user_004'}), (m:Movie {id: 'movie_003'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-02-28'}]->(m);

// Eduarda assistiu 1 filme e 1 série
MATCH (u:User {id: 'user_005'}), (m:Movie {id: 'movie_004'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-03-12'}]->(m);

MATCH (u:User {id: 'user_005'}), (s:Series {id: 'series_004'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-04-01'}]->(s);

// Felipe assistiu 3 filmes
MATCH (u:User {id: 'user_006'}), (m:Movie {id: 'movie_002'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-01-10'}]->(m);

MATCH (u:User {id: 'user_006'}), (m:Movie {id: 'movie_005'})
CREATE (u)-[:WATCHED {rating: 3, watchedDate: '2024-02-20'}]->(m);

MATCH (u:User {id: 'user_006'}), (m:Movie {id: 'movie_006'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-03-08'}]->(m);

// Gabriela assistiu 1 série
MATCH (u:User {id: 'user_007'}), (s:Series {id: 'series_003'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-04-10'}]->(s);

// Henrique assistiu 2 séries
MATCH (u:User {id: 'user_008'}), (s:Series {id: 'series_002'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-03-05'}]->(s);

MATCH (u:User {id: 'user_008'}), (s:Series {id: 'series_001'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-04-12'}]->(s);

// Isabela assistiu 2 filmes
MATCH (u:User {id: 'user_009'}), (m:Movie {id: 'movie_001'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-01-25'}]->(m);

MATCH (u:User {id: 'user_009'}), (m:Movie {id: 'movie_004'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-02-18'}]->(m);

// João assistiu 1 filme e 1 série
MATCH (u:User {id: 'user_010'}), (m:Movie {id: 'movie_003'})
CREATE (u)-[:WATCHED {rating: 4, watchedDate: '2024-03-01'}]->(m);

MATCH (u:User {id: 'user_010'}), (s:Series {id: 'series_001'})
CREATE (u)-[:WATCHED {rating: 5, watchedDate: '2024-04-05'}]->(s);

// ==========================================
// FIM DO SCRIPT
// ==========================================

