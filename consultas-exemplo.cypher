// ==========================================
// CONSULTAS CYPHER DE EXEMPLO
// Modelagem de Grafos - Serviço de Streaming
// ==========================================

// ==========================================
// 1. CONSULTAS BÁSICAS
// ==========================================

// Ver todos os nós por tipo
MATCH (u:User)
RETURN count(u) as total_usuarios;

MATCH (m:Movie)
RETURN count(m) as total_filmes;

MATCH (s:Series)
RETURN count(s) as total_series;

MATCH (a:Actor)
RETURN count(a) as total_atores;

MATCH (d:Director)
RETURN count(d) as total_diretores;

MATCH (g:Genre)
RETURN count(g) as total_generos;

// ==========================================
// 2. RELACIONAMENTOS
// ==========================================

// Ver todos os relacionamentos WATCHED
MATCH (u:User)-[w:WATCHED]->(content)
RETURN u.name as Usuario, content.title as Titulo, w.rating as Rating, 
       labels(content) as TipoConteudo
ORDER BY w.rating DESC;

// Ver filmes assistidos por um usuário específico
MATCH (u:User {id: 'user_001'})-[:WATCHED]->(content)
RETURN u.name as Usuario, content.title as Titulo, content.year as Ano, 
       content.rating as RatingIMDB
ORDER BY content.year;

// Ver atores que atuaram em um filme específico
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie {title: 'Inception'})
RETURN a.name as Ator, a.birthYear as AnoNascimento, m.title as Filme;

// Ver diretor e atores de um filme
MATCH (d:Director)-[:DIRECTED]->(m:Movie {title: 'Inception'})<-[:ACTED_IN]-(a:Actor)
RETURN d.name as Diretor, m.title as Filme, collect(a.name) as Atores;

// Ver gêneros de um filme
MATCH (m:Movie {title: 'Inception'})-[:IN_GENRE]->(g:Genre)
RETURN m.title as Filme, collect(g.name) as Generos;

// ==========================================
// 3. ANÁLISES E ESTATÍSTICAS
// ==========================================

// Top 5 filmes/séries mais assistidos
MATCH (u)-[:WATCHED]->(content)
RETURN content.title as Titulo, labels(content)[0] as Tipo, 
       count(u) as Total_Assistido
ORDER BY Total_Assistido DESC
LIMIT 5;

// Média de ratings por gênero
MATCH (u)-[w:WATCHED]->(content)-[:IN_GENRE]->(g)
RETURN g.name as Genero, 
       round(avg(w.rating), 2) as Media_Rating,
       count(*) as Total_Assistencias
ORDER BY Media_Rating DESC;

// Usuários mais ativos (mais assistiram)
MATCH (u:User)-[:WATCHED]->(content)
RETURN u.name as Usuario, count(content) as Total_Assistido
ORDER BY Total_Assistido DESC
LIMIT 5;

// Ator mais popular (participou em mais produções)
MATCH (a:Actor)-[:ACTED_IN]->(content)
RETURN a.name as Ator, count(content) as Total_Participacoes
ORDER BY Total_Participacoes DESC
LIMIT 5;

// Diretor mais produtivo
MATCH (d:Director)-[:DIRECTED]->(content)
RETURN d.name as Diretor, count(content) as Total_Dirigido
ORDER BY Total_Dirigido DESC
LIMIT 5;

// ==========================================
// 4. SISTEMA DE RECOMENDAÇÃO
// ==========================================

// Recomendar filmes baseado em gêneros que o usuário assistiu
MATCH (u:User {id: 'user_001'})-[:WATCHED]->(c)-[:IN_GENRE]->(g)<-[:IN_GENRE]-(recomendado)
WHERE NOT (u)-[:WATCHED]->(recomendado)
RETURN DISTINCT recomendado.title as Recomendacao, 
       labels(recomendado)[0] as Tipo,
       g.name as Genero
LIMIT 10;

// Recomendar baseado em atores/diretores favoritos
MATCH (u:User {id: 'user_001'})-[:WATCHED]->(c)<-[:ACTED_IN]-(a:Actor)-[:ACTED_IN]->(recomendado)
WHERE NOT (u)-[:WATCHED]->(recomendado)
RETURN DISTINCT recomendado.title as Recomendacao,
       labels(recomendado)[0] as Tipo,
       a.name as Baseado_Em_Ator
LIMIT 10;

// Recomendar baseado em usuários similares (mesmos gêneros)
MATCH (u:User {id: 'user_001'})-[:WATCHED]->(c)-[:IN_GENRE]->(g)<-[:IN_GENRE]-(u2)-[:WATCHED]->(recomendado)
WHERE u <> u2 AND NOT (u)-[:WATCHED]->(recomendado)
RETURN DISTINCT recomendado.title as Recomendacao,
       labels(recomendado)[0] as Tipo,
       count(DISTINCT u2) as Numero_Usuario_Similares
ORDER BY Numero_Usuario_Similares DESC
LIMIT 10;

// ==========================================
// 5. ANÁLISES AVANÇADAS
// ==========================================

// Filmes/séries bem avaliados pelos usuários (rating médio > 4)
MATCH (u)-[w:WATCHED]->(content)
WITH content, avg(w.rating) as MediaRating
WHERE MediaRating >= 4
RETURN content.title as Titulo, 
       labels(content)[0] as Tipo,
       round(MediaRating, 2) as Media_Rating_Usuarios
ORDER BY MediaRating DESC;

// Usuários com gosto similar (jaccard similarity em gêneros)
MATCH (u1:User {id: 'user_001'})-[:WATCHED]->(c1)-[:IN_GENRE]->(g),
      (u2:User)-[:WATCHED]->(c2)-[:IN_GENRE]->(g)
WHERE u1 <> u2
WITH u1, u2, count(DISTINCT g) as GenerosComuns,
     collect(DISTINCT g) as Generos
MATCH (u2)-[:WATCHED]->(c2)-[:IN_GENRE]->(g)
WITH u1, u2, GenerosComuns, count(DISTINCT g) as TotalGenerosU2
RETURN u2.name as Usuario_Similar, 
       GenerosComuns as Generos_Comuns,
       round((GenerosComuns * 100.0 / TotalGenerosU2), 2) as Similaridade
ORDER BY Similaridade DESC
LIMIT 5;

// Trilhas de carreira: atores que trabalharam com mesmo diretor
MATCH (a1:Actor)-[:ACTED_IN]->(content)<-[:DIRECTED]-(d:Director)<-[:DIRECTED]-(content2)<-[:ACTED_IN]-(a2:Actor)
WHERE a1 <> a2
RETURN DISTINCT a1.name as Ator1, 
       a2.name as Ator2, 
       d.name as Diretor_Comum,
       collect(DISTINCT d.name) as Diretores
LIMIT 10;

// ==========================================
// 6. VISUALIZAÇÕES ESPECÍFICAS
// ==========================================

// Ver grafo completo de um filme específico
MATCH path = (u:User)-[:WATCHED]->(m:Movie {title: 'Inception'})<-[:DIRECTED]-(d:Director),
      path2 = (m)<-[:ACTED_IN]-(a:Actor),
      path3 = (m)-[:IN_GENRE]->(g:Genre)
RETURN path, path2, path3;

// Ver caminho entre dois atores (caminhos de conexão)
MATCH path = shortestPath(
  (a1:Actor {name: 'Leonardo DiCaprio'})-[*..4]-(a2:Actor {name: 'Ryan Gosling'})
)
RETURN path;

// Ver caminho de recomendação para um usuário
MATCH path = (u:User {id: 'user_001'})-[:WATCHED]->(c1)-[:IN_GENRE]->(g)<-[:IN_GENRE]-(c2)
WHERE NOT (u)-[:WATCHED]->(c2)
RETURN path
LIMIT 10;

// ==========================================
// FIM DAS CONSULTAS
// ==========================================
