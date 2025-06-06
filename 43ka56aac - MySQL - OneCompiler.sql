CREATE TABLE candidates (
    candidate_id INT PRIMARY KEY,
    candidate_name VARCHAR(100),
    party VARCHAR(50)
);

CREATE TABLE votes (
    vote_id INT PRIMARY KEY,
    candidate_id INT,
    region_id INT,
    vote_count INT
);

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100)
);

insert into candidates values
(1, 'Davi', 'Partido A'),
(2, 'Hugo', 'Partido B'),
(3, 'Lula', 'Partido C');

insert into votes values
(1, 1, 101, 500),
(2, 1, 102, 300),
(3, 1, 103, 80),
(4, 2, 101, 200),
(5, 2, 102, 150),
(6, 2, 103, 30),
(7, 3, 101, 100),
(8, 3, 102, 300),
(9, 3, 103, 350);

insert into regions values
(101, 'Região Norte'),
(102, 'Região Nordeste'),
(103, 'Região Sul');

 select * from candidates;
 select * from votes;
  
-- Total de votos por candidato
 select candidate_id, sum(vote_count) as Votos_por_candidato from votes group by candidate_id;
 
-- Média de votos por região
select region_id, avg(vote_count) as Media_regiao from votes group by region_id; 

-- Candidatos com o maior número de votos em uma única região.
  -- Norte 101
  select candidate_id as Mais_votado_norte, vote_count as Total_votos from votes where region_id = 101 group by vote_count, candidate_id order by Total_votos desc;
  -- Nordeste 102
  select candidate_id as Mais_votado_nordeste, vote_count as Total_votos from votes where region_id = 102 group by vote_count, candidate_id order by Total_votos desc;
  -- Sul 103
  select candidate_id as Mais_votado_sul, vote_count as Total_votos from votes where region_id = 103 group by vote_count, candidate_id order by Total_votos desc;
  
-- Região com o maior número de votos:
select region_id as Regiao_mais_votada, sum(vote_count) as Votos from votes group by region_id order by Votos desc;

-- Candidato com o maior número de votos
select candidate_id as Candidato_vencedor, sum(vote_count) as Votos from votes group by candidate_id order by Votos desc;

-- Candidatos com mais de 500 votos 
select candidate_id, sum(vote_count) as Candidatos_com_mais_de_500_votos from votes group by candidate_id having sum(vote_count) > 500;

-- Número de votos por região e por candidato
select candidate_id, region_id, sum(vote_count) as Votos_candidato_na_regiao from votes group by candidate_id, region_id;




-- Crie mais duas consultas que façam uso das funções(min, max, AVG, etc) e do group by usando having.

  -- Consultar, entre os candidatos com menos de 800 votos, o que tenha menos votos
  select candidate_id as Candidato_menos_votos_com_menos_de_800 , sum(vote_count) as Total_votos from votes group by candidate_id having Total_votos < 800 order by Total_votos;
  
  -- Candidatos que tiveram média de votos acima de 200 por região
  select candidate_id as Candidato_media_maior_200_por_regiao, avg(vote_count) as Media_votos from votes group by candidate_id having avg(vote_count) > 200;


 
