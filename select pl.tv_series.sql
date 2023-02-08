#Transformando string em decimal para calucar a idade.(Treinamento)
SELECT * 
FROM PL.tv_series
WHERE  CAST(Final_date AS DECIMAL) - CAST(Realease_date AS DECIMAL) < 1.0 ;

#Selecionando todas as colunas da tabela
SELECT * FROM PL.tv_series;

#Selecionando series que possuem rating maior que 9
SELECT Series_Title, Genre, Rating, Synopsis
FROM PL.tv_series
WHERE Rating > 9
GROUP BY Series_Title, Genre, Synopsis, Rating
ORDER BY Rating, Genre;

#Selecionando series que um dos generos é animação
SELECT *
FROM PL.tv_series
WHERE Genre LIKE '%Animation%' AND Rating > 7.5;


#Verificando a quantidade de vezes que cada genero aparece.
SELECT DISTINCT Genre, COUNT(Genre)
FROM PL.tv_series
GROUP BY Genre
ORDER BY Genre;

# Selecionando Series que tiveram apenas uma temporada.
SELECT Series_Title, Genre, Rating, Release_Date, Final_date
FROM PL.tv_series
WHERE  Final_date - Release_date = 1
ORDER BY Series_Title DESC;

#Selecionando os programas mais antigo
SELECT Series_Title, Genre, Rating, Release_Date, (2023 - Release_Date) AS Duracao
FROM PL.tv_series
WHERE Final_date IS NULL
ORDER BY Duracao DESC;

#Selecionando os series que ainda não acabaram
SELECT Series_Title, Genre, Rating, Release_Date, Final_date
FROM PL.tv_series
WHERE  Final_date IS NULL
ORDER BY Series_Title DESC;

#Selecionando a serie 'The Big Bang Theory'
SELECT Series_Title, Genre, Rating, Release_Date, Final_date 
FROM PL.tv_series
WHERE Series_Title LIKE 'The Big Bang Theory%';

#Avaliando os Rating das Séries
SELECT Series_Title, Genre, Rating, Synopsis,
CASE
WHEN Rating < 7 THEN 'Abaixo da média'
WHEN Rating > 7 AND Rating < 8 THEN 'Na média'
ELSE 'Acima da média'
END AS 'Avaliação'
FROM PL.tv_series;

#CALCULANDO AS AVALIAÇÕES
SELECT 
SUM(CASE WHEN Rating <= 7 THEN 1 ELSE 0 END) AS count_media_baixa, 
SUM(CASE WHEN Rating > 7 AND Rating <= 8 THEN 1 ELSE 0 END) AS count_na_media, 
SUM(CASE WHEN Rating > 8 THEN 1 ELSE 0 END) AS count_media_alta
FROM PL.tv_series;

#Calculando a quantidade dos generos
SELECT DISTINCT Genre FROM PL.tv_series;

SELECT 
SUM(CASE WHEN Genre LIKE '%Animation%' THEN 1 ELSE 0 END) AS count_animation, 
SUM(CASE WHEN Genre LIKE '%Action%' THEN 1 ELSE 0 END) AS count_action, 
SUM(CASE WHEN Genre LIKE '%Comedy%' THEN 1 ELSE 0 END) AS count_comedy,
SUM(CASE WHEN Genre LIKE '%Drama%' THEN 1 ELSE 0 END) AS count_drama,
SUM(CASE WHEN Genre LIKE '%Horror%' THEN 1 ELSE 0 END) AS count_horror,
SUM(CASE WHEN Genre LIKE '%Romance%' THEN 1 ELSE 0 END) AS count_romance,
SUM(CASE WHEN Genre LIKE '%Thriller%' THEN 1 ELSE 0 END) AS count_thriller,
SUM(CASE WHEN Genre LIKE '%Western%' THEN 1 ELSE 0 END) AS count_western,
SUM(CASE WHEN Genre LIKE '%****%' THEN 1 ELSE 0 END) AS count_null
FROM PL.tv_series;
 
#Calculando a quantidade de series entre cada
SELECT DISTINCT Release_Date
FROM PL.tv_series;

#Calculando a quantidade de séries entre anos
SELECT 
SUM(CASE WHEN Release_Date IS NULL THEN 1 ELSE 0 END) AS count_null,
SUM(CASE WHEN Release_Date <= 2000 THEN 1 ELSE 0 END) AS under_2000,
SUM(CASE WHEN Release_Date > 2000 AND Release_Date <= 2008 THEN 1 ELSE 0 END) AS under_2008,
SUM(CASE WHEN Release_Date > 2008 AND Release_Date <= 2016 THEN 1 ELSE 0 END) AS under_2016,
SUM(CASE WHEN Release_Date > 2016 AND Release_Date <= 2023 THEN 1 ELSE 0 END) AS under_2023
FROM PL.tv_series;
