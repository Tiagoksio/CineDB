-- 04 Função cadastra endereço e retorna a primary key do endereço cadastrado
DELIMITER #
	DROP FUNCTION IF EXISTS fn_cadastro_endereco #
    CREATE FUNCTION fn_cadastro_endereco(
		sigla_uf VARCHAR(2),
		cidade VARCHAR(100), 
        cep VARCHAR(8), 
        bairro VARCHAR(50),
        logradouro VARCHAR(50), 
        numero VARCHAR(6),
        complemento VARCHAR(100)
	) RETURNS INT
	DETERMINISTIC 
    BEGIN
		DECLARE chave_municipio INT;
        DECLARE chave_estado INT;
        
        SELECT id_estado INTO chave_estado 
			FROM tb_estado
		WHERE sigla = sigla_uf;
        
        SELECT id_municipio INTO chave_municipio 
			FROM tb_municipio
		WHERE nome = cidade
        AND fk_estado = chave_estado;
        
        INSERT INTO tb_endereco 
			(fk_municipio, cep, bairro, logradouro, numero, complemento)
		VALUES
			(chave_municipio, cep, bairro, logradouro, numero, complemento);
		
        RETURN (
			SELECT 
				id_endereco
				FROM tb_endereco
                ORDER BY 1 DESC LIMIT 1
		);     
        END #
DELIMITER ;