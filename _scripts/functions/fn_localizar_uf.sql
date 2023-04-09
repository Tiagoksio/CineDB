-- 02 Função retorna a PK do estado segundo cpf/cnpj informado
DELIMITER #
	DROP FUNCTION IF EXISTS fn_localizar_uf #
    CREATE FUNCTION fn_localizar_uf (cnpj_cpf VARCHAR(20)) RETURNS INT
    DETERMINISTIC
    BEGIN
		IF length(cnpj_cpf) > 11 THEN
			RETURN (
				SELECT uf.id_estado 
					FROM tb_estado AS uf
					INNER JOIN tb_municipio AS m
                    ON uf.id_estado = m.fk_estado
                    INNER JOIN tb_endereco AS e
                    ON e.fk_municipio = m.id_municipio
					INNER JOIN tb_cinema AS c
                    ON c.fk_endereco = e.id_endereco
                    AND c.cnpj = cnpj_cpf);
		ELSE
			RETURN (
				SELECT uf.id_estado 
					FROM tb_estado AS uf
					INNER JOIN tb_municipio AS m
                    ON uf.id_estado = m.fk_estado
                    INNER JOIN tb_endereco AS e
                    ON e.fk_municipio = m.id_municipio
					INNER JOIN tb_cliente AS c
                    ON c.fk_endereco = e.id_endereco
                    AND c.cpf = cnpj_cpf);
        END IF;
    END #
DELIMITER ;