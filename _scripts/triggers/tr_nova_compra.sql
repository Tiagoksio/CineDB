-- 01 Trigger gera o status inicial da compra na rl_status_compra, o definindo como "Aguardando Pagamento"
DELIMITER #
	DROP TRIGGER IF EXISTS tr_nova_compra #
    CREATE TRIGGER tr_nova_compra AFTER INSERT ON rl_compra_assento_sessao
    FOR EACH ROW
    BEGIN
		INSERT INTO rl_status_compra
			(fk_status, fk_compra, atualizacao)
		VALUES
			(1, new.fk_compra, now());
    END #
DELIMITER ;