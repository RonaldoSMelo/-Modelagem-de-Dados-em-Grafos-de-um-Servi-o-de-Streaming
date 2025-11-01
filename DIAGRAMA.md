# Diagrama de Modelagem - Grafo de Streaming

## Estrutura do Grafo

```
                    ┌─────────────┐
                    │   GENRE     │
                    │  (Gêneros)  │
                    └──────┬──────┘
                           │
                           │ IN_GENRE
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
┌───────▼───────┐                  ┌─────────▼────────┐
│    MOVIE      │                  │      SERIES      │
│   (Filmes)    │                  │    (Séries)      │
└───────┬───────┘                  └─────────┬────────┘
        │                                     │
        │                                     │
        │ ACTED_IN                      ACTED_IN
        │                                     │
        │                                     │
┌───────▼───────────┐                   ┌────┘
│      ACTOR        │                   │
│     (Atores)      │                   │
└───────────────────┘                   │
                                        │
                                ┌───────▼───────┐
                                │   DIRECTOR    │
                                │  (Diretores)  │
                                └───────┬───────┘
                                        │
                                        │ DIRECTED
                                        │
┌───────────────────────────────────────▼─────────────┐
│                    USER                             │
│              (Usuários)                             │
│                                                      │
│  ┌────────────────────────────────────────────────┐ │
│  │ WATCHED {rating, watchedDate}                  │ │
│  │                                                 │ │
│  │  • Ana, Bruno, Carolina, Daniel, Eduarda       │ │
│  │  • Felipe, Gabriela, Henrique, Isabela, João   │ │
│  └────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────┘
```

## Detalhamento das Relações

### User → Content (WATCHED)
```
User ──[WATCHED {rating: 1-5, watchedDate: date}]──> Movie
User ──[WATCHED {rating: 1-5, watchedDate: date}]──> Series
```

### Actor → Content (ACTED_IN)
```
Actor ──[ACTED_IN]──> Movie
Actor ──[ACTED_IN]──> Series
```

### Director → Content (DIRECTED)
```
Director ──[DIRECTED]──> Movie
Director ──[DIRECTED]──> Series
```

### Content → Genre (IN_GENRE)
```
Movie ──[IN_GENRE]──> Genre
Series ──[IN_GENRE]──> Genre
```

## Exemplo Real: Inception

```
┌──────────────────────────────────────────────────────────────────┐
│                         Christopher Nolan                        │
│                           (Director)                             │
└────────────────────────────┬─────────────────────────────────────┘
                             │ DIRECTED
                             ▼
                    ┌────────────────┐
                    │   Inception    │
                    │   (Movie)      │
                    │ 2010, 148min   │
                    └────────┬───────┘
                             │
              ┌──────────────┼──────────────┐
              │ ACTED_IN     │              │
              ▼              ▼              │
     ┌────────────────┐      │              │
     │ Leonardo       │      │              │
     │ DiCaprio       │      │              │
     │ (Actor)        │      │              │
     └────────────────┘      │              │
                             │              │
              ┌──────────────▼──────────────┘
              │ IN_GENRE
              ▼
     ┌────────────────┐        ┌────────────────┐
     │    Aventura    │        │  Ficção        │
     │   (Genre)      │        │  Científica    │
     │                │        │  (Genre)       │
     └────────────────┘        └────────────────┘
              │
              │ WATCHED
              │
              ▼
     ┌────────────────┐
     │     Users      │
     │  - Ana (5★)    │
     │  - Daniel (5★) │
     │  - Isabela (5★)│
     └────────────────┘
```

## Fluxo de Recomendação

### Recomendação Baseada em Gêneros
```
User assistiu ──> Movie/Series ──> Genre ──> Other Movies/Series
```

### Recomendação Baseada em Atores
```
User assistiu ──> Movie/Series ←── Actor ──> Other Movies/Series
```

### Recomendação Baseada em Diretores
```
User assistiu ──> Movie/Series ←── Director ──> Other Movies/Series
```

### Recomendação Colaborativa
```
User assistiu ──> Movie/Series ──> Genre ←── Movie/Series ←── Other User
```

## Métricas Possíveis

1. **Popularidade**: Contagem de WATCHED
2. **Rating Médio**: Média de ratings em WATCHED
3. **Sobreposição de Gêneros**: Similaridade entre conteúdos
4. **Caminhos de Conexão**: Ator ↔ Diretor ↔ Ator
5. **Clustering**: Usuários com preferências similares

## Propriedades dos Nós

| Nó | Propriedades Principais |
|----|-------------------------|
| **User** | id, name, email, age |
| **Movie** | id, title, year, duration, rating |
| **Series** | id, title, startYear, endYear, seasons, rating |
| **Genre** | id, name |
| **Actor** | id, name, birthYear |
| **Director** | id, name, birthYear |

## Propriedades dos Relacionamentos

| Relacionamento | Propriedades |
|----------------|--------------|
| **WATCHED** | rating (1-5), watchedDate |
| **ACTED_IN** | - |
| **DIRECTED** | - |
| **IN_GENRE** | - |

## Exemplo de Query de Visualização

Para ver o grafo completo no Neo4j Browser:

```cypher
MATCH (n)
OPTIONAL MATCH (n)-[r]->(m)
RETURN n, r, m
LIMIT 100
```

Ou apenas usuários e o que assistiram:

```cypher
MATCH (u:User)-[w:WATCHED]->(content)
RETURN u, w, content
```

## Complexidade do Grafo

- **Nós**: 45 (10 users + 6 movies + 4 series + 8 genres + 10 actors + 7 directors)
- **Relacionamentos WATCHED**: ~30
- **Relacionamentos ACTED_IN**: ~15
- **Relacionamentos DIRECTED**: ~6
- **Relacionamentos IN_GENRE**: ~20

**Total aproximado**: ~71 relacionamentos

Este grafo permite múltiplos caminhos de recomendação e análise de relacionamentos complexos!

