CREATE VIEW vw_faturamento_cinema AS
SELECT 
    c.nome AS 'Cinema',
    concat('R$ ', format(sum(preco_pago), 2)) AS 'Faturamento',
    concat('R$ ', format(avg(preco_pago), 2)) AS 'Receita média por ingresso',
    count(fk_assento) AS 'Ingressos Vendidos',
    tb_tot_assentos.tot_assentos AS 'Total de Assentos por Semana',
    concat('%', count(fk_assento) / tb_tot_assentos.tot_assentos * 100) AS 'Percentual Vendido'    
	FROM rl_compra_assento_sessao AS cas 
    INNER JOIN tb_sessao AS ss
    ON cas.fk_sessao = ss.id_sessao
    INNER JOIN tb_cinema AS c
    ON c.cnpj = ss.fk_cinema
    INNER JOIN rl_status_compra AS sc
    ON sc.fk_compra = cas.fk_compra
    INNER JOIN (
		SELECT 
			fk_cinema AS chave_cinema, 
			count(*) AS tot_assentos
			FROM rl_assento_sessao AS rl_as
			INNER JOIN tb_sessao AS ss
			ON rl_as.fk_sessao = ss.id_sessao
			GROUP BY ss.fk_cinema
    ) AS tb_tot_assentos
    ON tb_tot_assentos.chave_cinema = c.cnpj
    WHERE fk_status = 2
    GROUP BY fk_cinema
    ORDER BY 2 DESC;