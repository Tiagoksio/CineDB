DELIMITER #
	DROP PROCEDURE IF EXISTS sp_ingressos_por_sessao #
    CREATE PROCEDURE sp_ingressos_por_sessao(chave_sessao INT)
	BEGIN
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
			ON i.cod_ingresso = ds.fk_ingresso
			WHERE turno = (
				SELECT
					CASE 
						WHEN time(hr_inicio) < '18:00:00' THEN 'matine'
						WHEN time(hr_inicio) > '18:00:00' THEN 'noite'
					END 
					FROM tb_sessao 
					WHERE id_sessao = chave_sessao
			) AND tipo_sessao = ANY (
				SELECT s.tela 
					FROM tb_sala AS s 
					INNER JOIN tb_sessao AS ss 
					ON s.id_sala = ss.fk_sala 
					WHERE id_sessao = chave_sessao 
			) AND substring(dia_semana,1,1) = (
				SELECT weekday(hr_inicio) 
					FROM tb_sessao 
					WHERE id_sessao = chave_sessao
			);
	END #
DELIMITER ;