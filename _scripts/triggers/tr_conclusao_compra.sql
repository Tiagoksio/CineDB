-- 02 Trigger muda o status da tabela 'rl_assento_sessao' conforme o status da compra é atualizado na rl_status_compra
DELIMITER #
	DROP TRIGGER IF EXISTS tr_conclusao_compra #
    CREATE TRIGGER tr_conclusao_compra AFTER INSERT ON rl_status_compra
    FOR EACH ROW
    BEGIN
		DECLARE novo_status VARCHAR(20);
		IF new.fk_status = 1 THEN
			SET novo_status = 'Selecionado';
		ELSE
			IF new.fk_status = 2 THEN
				SET novo_status = 'Ocupado';
			ELSE 
				SET novo_status = 'Disponível';
			END IF ;
		END IF;
        
        UPDATE rl_assento_sessao
			SET status = novo_status
			WHERE fk_assento = ANY (SELECT fk_assento FROM rl_compra_assento_sessao WHERE fk_compra = new.fk_compra)
			AND fk_sessao = ANY (SELECT fk_sessao FROM rl_compra_assento_sessao WHERE fk_compra = new.fk_compra);
    END #
DELIMITER ;