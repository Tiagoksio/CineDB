-- 01 Transaction para cadastrar cliente
DELIMITER #
	DROP PROCEDURE IF EXISTS sp_cadastrar_cliente #
    CREATE PROCEDURE sp_cadastrar_cliente(
		cpf VARCHAR(11),
        nome VARCHAR(40),
        sobrenome VARCHAR(50),
        dt_nascimento DATE,
        sexo ENUM('M', 'F'),
        email VARCHAR(100),
        senha TEXT,
        ddd_cel VARCHAR(2),
        num_cel VARCHAR(9),
        ddd_res VARCHAR(2),
        num_res VARCHAR(9),
        sg_estado VARCHAR(2),
        cidade VARCHAR(100),
        cep VARCHAR(8),
        bairro VARCHAR(50),
        logradouro VARCHAR(50),
        numero VARCHAR(6),
        complemento TEXT
    )
    BEGIN
    
    DECLARE chave_endereco INT;
    
    DECLARE EXIT HANDLER FOR 1452
		BEGIN
			SELECT 'CPF/Endereço não cadastrado' AS mensagem;
			ROLLBACK;
		END ;
	DECLARE EXIT HANDLER FOR 1062
		BEGIN
			SELECT 'CPF/Endereço/Telefone Já esta cadastrado' AS mensagem;
			ROLLBACK;
		END ;
	DECLARE EXIT HANDLER FOR 1364
		BEGIN
			SELECT 'Dados insuficientes para efetuar o cadastro' AS mensagem;
			ROLLBACK;
		END ;

	
	START TRANSACTION ;
		SELECT fn_cadastro_endereco(
			sg_estado,
			cidade, 
			cep, 
			bairro,
			logradouro,
			numero,
			complemento
        ) INTO chave_endereco;
        
        INSERT INTO tb_cliente
			(cpf,fk_endereco,nome,sobrenome,dt_nascimento,sexo,email,senha)
		VALUES
			(cpf,chave_endereco,nome,sobrenome,dt_nascimento,sexo,email, sha1(senha));
        
        IF length(ddd_cel) = 2 AND length(num_cel) IN (8, 9) OR length(ddd_res) = 2 AND length(num_res) IN (8, 9) THEN
            CALL sp_cadastro_telefone(
				cpf,
				ddd_cel,
				num_cel
			);
			CALL sp_cadastro_telefone(
				cpf,
				ddd_res,
				num_res
			);
            COMMIT;
			SELECT 
				*, 
                'Cliente Cadastrado Com Sucesso' AS mensagem 
				FROM tb_cliente AS c WHERE c.cpf = cpf;
		ELSE
			SELECT 'É necessário cadastrar pelo menos um telefone para contato' AS mensagem;
            ROLLBACK;
		END IF;
        
    END #
DELIMITER ;