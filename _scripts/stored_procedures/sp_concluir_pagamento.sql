DELIMITER #
	DROP PROCEDURE IF EXISTS sp_concluir_pagamento #
    CREATE PROCEDURE sp_concluir_pagamento(
		cpf_cliente VARCHAR(11),
		numero_compra INT,
        senha TEXT,
        opcao TINYINT
	)
    -- opcao 2 para concluir ou 3 para cancelar
    BEGIN
		IF (SELECT IF(c.senha = sha1(senha), 1, 0) FROM tb_cliente AS c WHERE cpf = cpf_cliente) THEN
			INSERT INTO	rl_status_compra
				(fk_status, fk_compra, atualizacao)
			VALUES
				(opcao, numero_compra, now());
		ELSE
			SELECT 'Senha incorreta' AS MENSAGEM;
		END IF ;
	END #
DELIMITER ;