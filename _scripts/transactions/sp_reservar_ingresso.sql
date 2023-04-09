-- 02 Transaction para efetuar compra de ingresso
DELIMITER #
	DROP PROCEDURE IF EXISTS sp_reservar_ingresso #
    CREATE PROCEDURE sp_reservar_ingresso(
		cpf VARCHAR(11),
        assento VARCHAR(3),
        sessao INT,
        ingresso INT,
        meia TINYINT,
        pagamento INT
    )
    BEGIN
		DECLARE chave_compra INT;
        
		DECLARE EXIT HANDLER FOR 1452
			BEGIN
				SELECT 'Erro: Verifique se as Foreign Keys Informadas' AS mensagem;
				ROLLBACK;
			END ;
		DECLARE EXIT HANDLER FOR 1062
			BEGIN
				SELECT 'Já existe um registro para as chaves informadas' AS mensagem;
				ROLLBACK;
			END ;
		DECLARE EXIT HANDLER FOR 1364
			BEGIN
				SELECT 'Dados insuficientes para concluir transação' AS mensagem;
				ROLLBACK;
			END ;
		
        START TRANSACTION;
			SELECT fn_cadastrar_compra(cpf, pagamento) INTO chave_compra;
            
            IF NOT fn_localizar_uf((
				SELECT fk_cinema
					FROM tb_sessao
                    WHERE id_sessao = sessao
            )) = fn_localizar_uf(cpf) THEN
				SELECT 'Sessão não disponível para sua região';
                ROLLBACK;
            ELSE
				IF (SELECT status 
						FROM rl_assento_sessao 
                        WHERE fk_assento = assento 
                        AND fk_sessao = sessao
				) <> 'Disponível' THEN
					SELECT 'O assento selecionado não está disponível';
					ROLLBACK;
				ELSE
					IF NOT ingresso = ANY (
						SELECT
							i.cod_ingresso
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
									WHERE id_sessao = sessao
							) AND tipo_sessao = ANY (
								SELECT s.tela 
									FROM tb_sala AS s 
									INNER JOIN tb_sessao AS ss 
									ON s.id_sala = ss.fk_sala 
									WHERE id_sessao = sessao 
							) AND substring(dia_semana,1,1) = (
								SELECT weekday(hr_inicio) 
									FROM tb_sessao 
									WHERE id_sessao = sessao
							)
					) THEN
						SELECT 'Ingresso inválido';
						ROLLBACK;
					ELSE
						INSERT INTO rl_compra_assento_sessao
							(fk_compra, fk_assento, fk_sessao, fk_ingresso, meia, preco_pago)
						VALUES
							(chave_compra, assento, sessao, ingresso, meia, (select if(meia = 1, preco_ingresso / 2, preco_ingresso) from tb_ingresso where cod_ingresso = ingresso));
                        COMMIT;
                        SELECT 
							*,
                            'Reserva realizada com sucesso' AS MENSAGEM
							FROM rl_compra_assento_sessao
                            WHERE fk_compra = chave_compra
                            AND fk_assento = assento
                            AND fk_sessao = sessao;
                    END IF;
				END IF;
            END IF; 
    END #    
DELIMITER ;