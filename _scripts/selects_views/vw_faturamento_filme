CREATE VIEW vw_faturamento_filme AS
SELECT 
    f.titulo AS 'Filme',
	count(cas.fk_assento) AS 'Qtd Ingressos Vendidos',
    format(sum(preco_pago), 2) AS 'Faturamento'
	FROM rl_compra_assento_sessao AS cas 
    INNER JOIN tb_sessao AS ss
    ON cas.fk_sessao = ss.id_sessao
    INNER JOIN tb_filme AS f
    ON f.id_filme = ss.fk_filme
    INNER JOIN rl_status_compra AS sc
    ON sc.fk_compra = cas.fk_compra
    WHERE fk_status = 2
    GROUP BY f.titulo
    ORDER BY 3;