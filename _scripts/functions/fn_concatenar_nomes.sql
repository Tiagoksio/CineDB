-- 03 A função retorna os nomes de elenco, direção, roteiro ou gêneros de um filme concatenados em apenas um TEXT, conforme opção argumentada no parâmetro "cod_concat"
DELIMITER #
	DROP FUNCTION IF EXISTS fn_concatenar_nomes #
    CREATE FUNCTION fn_concatenar_nomes(cod_concat INT, chave_filme INT) RETURNS TEXT
    /*----------------------------|
	|	cod_concat -> opção       |
	|			 1 -> Elenco      |
	|			 2 -> Direção     |
	|			 3 -> Roteiro     |
	|			 4 -> Genero      |
	|----------------------------*/
	DETERMINISTIC
    BEGIN
		DECLARE nomes_concatenados TEXT DEFAULT '';
        DECLARE nome VARCHAR(50);
        DECLARE qtd_nomes INT;
        DECLARE limite_select INT;
        DECLARE ctrl_loop INT DEFAULT 1;
        
        IF cod_concat = 4 THEN
			SELECT count(fk_genero) 
				FROM rl_filme_genero
                WHERE fk_filme = chave_filme
                INTO qtd_nomes;
                
			WHILE ctrl_loop <= qtd_nomes DO
				SET limite_select = qtd_nomes - ctrl_loop + 1;
				SELECT * INTO nome
					FROM (
						SELECT g.ds_genero
							FROM tb_genero AS g
							INNER JOIN rl_filme_genero AS fg
							ON fg.fk_genero = g.cod_genero
							WHERE fk_filme = chave_filme
							ORDER BY 1 ASC LIMIT limite_select
					) AS tb_tot_generos
                    ORDER BY 1 DESC LIMIT 1;
					SET nomes_concatenados = concat(nomes_concatenados, ' / ', nome);
				SET ctrl_loop = ctrl_loop + 1;
            END WHILE;
		ELSE
			SELECT count(fk_funcao) 
				FROM rl_ficha_tecnica
				WHERE fk_filme = chave_filme
				AND fk_funcao = cod_concat
                INTO qtd_nomes;
                
                WHILE ctrl_loop <= qtd_nomes DO
				SET limite_select = qtd_nomes - ctrl_loop + 1;
				SELECT * INTO nome
					FROM (
						SELECT c.nome
							FROM tb_colaborador AS c
							INNER JOIN rl_ficha_tecnica AS ft
							ON ft.fk_colaborador = c.id_colaborador
							WHERE fk_filme = chave_filme
                            AND fk_funcao = cod_concat
							ORDER BY 1 ASC LIMIT limite_select
					) AS tb_tot_colab
                    ORDER BY 1 DESC LIMIT 1;
					SET nomes_concatenados = concat(nomes_concatenados, ' / ', nome);
				SET ctrl_loop = ctrl_loop + 1;
            END WHILE;
        END IF;
        RETURN substring(nomes_concatenados, 3);
    END #
DELIMITER ;