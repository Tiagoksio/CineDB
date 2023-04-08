CREATE VIEW vw_montante_pagamentos AS
SELECT 
	'Pagamento Confirmado'AS 'Status do pagamento',
    concat('R$ ', format(sum(preco_pago), 2)) AS 'Montante dos Ingressos',
    count(fk_assento) AS 'qtd_assentos'
	FROM rl_compra_assento_sessao AS cas 
    INNER JOIN tb_sessao AS ss
    ON cas.fk_sessao = ss.id_sessao
    INNER JOIN rl_status_compra AS sc
    ON sc.fk_compra = cas.fk_compra
    WHERE fk_status = 2
UNION
SELECT 
	'Aguardando Pagamento',
    concat('R$ 'format(sum(preco_pago), 2)),
    count(fk_assento) AS 'qtd_assentos'
	FROM rl_compra_assento_sessao AS cas 
    INNER JOIN tb_sessao AS ss
    ON cas.fk_sessao = ss.id_sessao
    INNER JOIN rl_status_compra AS sc
    ON sc.fk_compra = cas.fk_compra
    WHERE fk_status = 1
UNION
SELECT 
    'Pagamento Cancelado',
    concat('R$ ', format(sum(preco_pago), 2)),
    count(fk_assento) AS 'qtd_assentos'
	FROM rl_compra_assento_sessao AS cas 
    INNER JOIN tb_sessao AS ss
    ON cas.fk_sessao = ss.id_sessao
    INNER JOIN rl_status_compra AS sc
    ON sc.fk_compra = cas.fk_compra
    WHERE fk_status = 3
    ORDER BY 2;