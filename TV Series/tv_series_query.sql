#ORGANIZAR TODOS AS COLUNAS FEITAS NA NOVA TABELA (29.01.2023)

#SELECIONANDO TODA A TABELA
SELECT * FROM PL.tv_series;

#MODIFICANDO O NOME DAS COLUNAS DO BANCO DE DADOS
ALTER TABLE `PL`.`tv_series` 
CHANGE COLUMN `Series Title` `Series_Title` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `Realease Year` `Release_Year` TEXT NULL DEFAULT NULL ;

#VERIFICANDO VALORES DUPLICADOS
SELECT 
    Series_Title, COUNT(Series_Title)
FROM
    PL.tv_series
GROUP BY 
    Series_Title
HAVING 
    COUNT(Series_Title) > 1;
    
#VERIFICANDO SE POSSUE LINHAS DUPLICADAS
SELECT 
	Series_Title,
    ROW_NUMBER() OVER ( 
		PARTITION BY Series_Title 
        ORDER BY Series_Title
	) AS row_num 
FROM PL.tv_series;

SELECT 
	Series_Title 
FROM (
	SELECT 
		Series_Title,
		ROW_NUMBER() OVER (
			PARTITION BY Series_Title
			ORDER BY Series_Title) AS row_num
	FROM 
		PL.tv_series
)t
WHERE 
	row_num > 1;

## DELETANDO VALORES DUPLICADOS
DELETE FROM PL.tv_series 
WHERE 
	Series_Title IN (
	SELECT 
		Series_Title 
	FROM (
		SELECT 
			Series_Title,
			ROW_NUMBER() OVER (
				PARTITION BY Series_Title
				ORDER BY Series_Title) AS row_num
		FROM 
			PL.tv_series 
	)t
    WHERE row_num > 1
);

SELECT * FROM PL.tv_series;

#ADICIONANDO MAIS UMA COLUNA
ALTER TABLE PL.tv_series ADD COLUMN Year TEXT(255);

#ADICIONANDO VALORES COM AS MODIFICAÇÕES 
UPDATE PL.tv_series
SET Year = REPLACE(REPLACE(REPLACE
(REPLACE(REPLACE(REPLACE(REPLACE
(REPLACE(REPLACE(Release_Year, '?', ' - '),'(', ''), ')', ''), '|',''),'I', ''),'II', ''), 'III', ''), 'IV',''), 'V','');

#APAGANDO TODOS OS POSSIVEIS ESPAÇOS QUE PODEM TER NOS VALORES
UPDATE PL.tv_series
SET Year = TRIM(Year);

#CRIANDO UMA NOVA TABELA - Release Date
ALTER TABLE PL.tv_series ADD COLUMN Release_Date TEXT(255);
ALTER TABLE PL.tv_series ADD COLUMN Final_date TEXT(255);

#ADICIONANDO OS VALORES NA TABELA - Release_date
SET Release_date = SUBSTRING_INDEX(Year, '-', 1);

SELECT Series_Title, Rating, Release_Date
FROM PL.tv_series 
WHERE Rating > 8.0 and Release_date = '2020';

#ATUALIZANDO OS VALORES DA COLUNA - Final_Date
UPDATE PL.tv_series 
SET Final_date = SUBSTRING(Year,8,11);

#APAGANDO AS COLUNAS QUE NÃO SÃO MAIS NECESSARIAS
ALTER TABLE PL.tv_series 
DROP COLUMN Release_Year,
DROP COLUMN Year;

SELECT * 
FROM PL.tv_series
WHERE LOCATE('Animation', Genre) != 0 AND Rating > 7.5
ORDER BY Rating DESC;

SELECT *
FROM PL.tv_series
WHERE CAST(Release_date AS UNSIGNED) > 2021;

SELECT * 
FROM PL.tv_series
WHERE  CAST(Final_date AS DECIMAL) - CAST(Release_date AS DECIMAL) < 1.0 ;

SELECT DISTINCT Release_date 
FROM PL.tv_series;

SELECT SUBSTRING_INDEX(Final_Date, '- ', -1) 
FROM PL.tv_series;

SELECT * FROM PL.tv_series
WHERE Final_date = '';

#TRANSFORMANDO A COLUNA Release_date EM DATA
ALTER TABLE PL.tv_series MODIFY COLUMN Release_date YEAR(4);

UPDATE PL.tv_series 
SET Release_date = '2004'
WHERE Series_Title = 'Miss Marple';

#TRANSFORMANDO AS COLUNAS EM BRANCO EM VALORES NULOS
UPDATE PL.tv_series SET Final_date = NULL WHERE Final_date = '';

#TRANSFORMANDO A COLUNA Final_date EM ANO
ALTER TABLE PL.tv_series MODIFY COLUMN Final_date YEAR(4);

SELECT Series_Title, Cast, Final_date, Release_Date 
 FROM PL.tv_series
WHERE (Final_date - Release_Date) = 1;

#MEXENDO COM O RUNTIME

SELECT SUBSTRING(Runtime ,1, 2) AS Runtime_1
FROM PL.tv_series; 

#RETIRANDO OS VALORES **** E TRANSFORMANDO EM NULOS
UPDATE PL.tv_series
SET Runtime = NULLIF(Runtime,'****');

UPDATE PL.tv_series
SET Runtime_time = REPLACE(Runtime_time,',','');

#ADICIONANDO UMA COLUNA - Runtime_time
ALTER TABLE PL.tv_series ADD COLUMN Runtime_time INT(3);

UPDATE PL.tv_series
SET Runtime_time = SUBSTRING(Runtime,1,2);

UPDATE PL.tv_series
SET Runtime_time = TRIM(Runtime_time);

ALTER TABLE PL.tv_series MODIFY COLUMN Runtime_time INT(3);

SELECT * FROM PL.tv_Series;

SELECT DISTINCT Runtime_time
FROM PL.tv_series;

ALTER TABLE PL.tv_series 
DROP COLUMN Runtime;
