DELIMITER #
	DROP PROCEDURE IF EXISTS sp_mostrar_assentos #
    CREATE PROCEDURE sp_mostrar_assentos(chave_sessao INT)
    BEGIN
		SELECT 
			rl_as.fk_assento AS 'Assento',
            rl_as.fk_sessao AS 'Sessão',
            rl_as.status AS 'Status',
            a.categoria AS 'Categoria'            
			FROM rl_assento_sessao AS rl_as
            INNER JOIN tb_assento AS a
            ON rl_as.fk_assento = a.cod_assento
            WHERE fk_sessao = chave_sessao;
	END #
DELIMITER ;