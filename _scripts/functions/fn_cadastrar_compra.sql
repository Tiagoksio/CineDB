-- 01 Função cadastra compra e retorna o cod_compra do ultimo registro efetuadoDELIMITER #
	DROP FUNCTION IF EXISTS fn_cadastrar_compra #
    CREATE FUNCTION fn_cadastrar_compra(
		cpf VARCHAR(11),
        forma_pagamento INT
    ) RETURNS INT
    
    DETERMINISTIC
    BEGIN
		INSERT INTO tb_compra
			(fk_cpf, fk_forma_pagamento)
		VALUES
			(cpf, forma_pagamento);
		
        RETURN(
			SELECT cod_compra
				FROM tb_compra
                ORDER BY 1 DESC LIMIT 1
        );
    END #
DELIMITER ;