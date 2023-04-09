CREATE VIEW vw_ingressos AS
	SELECT
		i.cod_ingresso,
		i.turno,
		i.preco_ingresso,
		i.tipo_sessao,
		CASE
			WHEN i.e_promocional = 0 THEN 'Não'
			WHEN i.e_promocional = 1 THEN 'Sim'
		END AS 'Promoção',
		ifnull(i.ds_promocao, '') AS 'Descrição promoção',
		CASE 
			WHEN ds.dia_semana = '0' THEN 'Segunda-Feira'
			WHEN ds.dia_semana = '1' THEN 'Terça-Feira'
			WHEN ds.dia_semana = '2' THEN 'Quarta-Feira'
			WHEN ds.dia_semana = '3' THEN 'Quinta-Feira'
			WHEN ds.dia_semana = '4' THEN 'Sexta-Feira'
			WHEN ds.dia_semana = '5' THEN 'Sábado'
			WHEN ds.dia_semana = '6' THEN 'Domingo'
		END AS `dia da semana`
		FROM tb_ingresso AS i
		INNER JOIN tb_dia_semana AS ds
		ON i.cod_ingresso = ds.fk_ingresso;