DELIMITER #
	DROP PROCEDURE IF EXISTS sp_cadastro_telefone #
    CREATE PROCEDURE sp_cadastro_telefone( 
		cpf_cnpj VARCHAR(20), 
        ddd_num VARCHAR(3), 
        num VARCHAR(9)
	)
    BEGIN
		IF length(num) IN (8, 9) AND  length(ddd_num) = 2 THEN
			IF length(cpf_cnpj) <= 11 THEN
				INSERT INTO tb_telefone
					(fk_tipo_telefone, fk_cpf, ddd, numero)
				VALUES
					(
						CASE 
							WHEN SUBSTRING(num, 1, 1) = '9' THEN 1 
							ELSE 2 
						END, cpf_cnpj, ddd_num, num
					);
			ELSE
				INSERT INTO tb_telefone
					(fk_tipo_telefone, fk_cinema, ddd, numero)
				VALUES
					(3, cpf_cnpj, ddd_num, num);
			END IF ;
		END IF ;
	END #
DELIMITER ;