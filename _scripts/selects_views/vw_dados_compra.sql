CREATE VIEW vw_dados_compra AS
SELECT 
	cli.cpf,
    cli.sexo,
    concat(cli.nome,cli.sobrenome) AS 'cliente',
    com.cod_compra,
    fp.ds_pagamento AS 'forma_pagamento',
    sum(preco_pago) AS 'valor',
    count(cas.fk_assento) AS 'qtd_assentos',
    s.ds_status
	FROM tb_cliente AS cli
    INNER JOIN tb_compra AS com
    ON cli.cpf = com.fk_cpf
    INNER JOIN tb_forma_pagamento AS fp
    ON fp.cod_pagamento = com.fk_forma_pagamento
    INNER JOIN rl_status_compra AS sc
    ON sc.fk_compra = com.cod_compra
    INNER JOIN tb_status AS s
    ON sc.fk_status = s.cod_status
    INNER JOIN rl_compra_assento_sessao AS cas
    ON cas.fk_compra = com.cod_compra
	WHERE fk_status = (
		SELECT max(fk_status) 
			FROM rl_status_compra 
            WHERE fk_compra = cod_compra
	)
    GROUP BY com.cod_compra
    ORDER BY cod_compra;