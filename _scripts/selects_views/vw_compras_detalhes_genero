CREATE VIEW vw_compras_detalhes_genero AS
SELECT 
	'Homem' AS 'Sexo',
	max(valor) AS 'maior compra',
    min(valor) AS 'menor compra',
    format(avg(valor), 2) AS 'valor médio das compras',
    count(*) AS 'qtd_compras'
	FROM vw_dados_compra 
    GROUP BY sexo
    HAVING sexo = 'M'
UNION
SELECT 
	'Mulher' AS 'Sexo',
	max(valor) AS 'maior compra',
    min(valor) AS 'menor compra',
    format(avg(valor), 2) AS 'valor médio das compras',
    count(*) AS 'qtd_compras'
	FROM vw_dados_compra 
    GROUP BY sexo
    HAVING sexo = 'F';