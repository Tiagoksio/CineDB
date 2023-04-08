CREATE VIEW vw_cliente_detalhes AS
SELECT 
    c.cpf AS 'CPF',
    c.nome AS 'Nome',
    c.sobrenome AS 'Sobrenome',
    DATE_FORMAT(c.dt_nascimento, "%d/%m/%Y") AS 'Data de Nascimento',
    timestampdiff(year, c.dt_nascimento, curdate()) AS 'Idade',
    c.sexo AS 'Sexo',
    c.email AS 'E-Mail',
    e.cep AS 'CEP',
    uf.sigla AS 'Estado',
    m.nome AS 'Cidade',
    e.bairro AS 'Bairro',
    e.logradouro AS 'Logradouro',
    e.numero AS 'Número',
    ifnull(tb_tel_residencial.telefone,'') AS 'Telefone Residêncial',
    ifnull(tb_tel_cel.telefone, '') AS 'Telefone Celular'
	FROM tb_cliente AS c
	INNER JOIN tb_endereco AS e
    ON c.fk_endereco = e.id_endereco
    INNER JOIN tb_municipio AS m
    ON m.id_municipio = e.fk_municipio
    INNER JOIN tb_estado AS uf
    ON uf.id_estado = m.fk_estado
    LEFT JOIN (
		SELECT 
			concat('(', t.ddd, ') ', t.numero) AS 'telefone',
            t.fk_cpf
			FROM tb_telefone AS t
			INNER JOIN tb_cliente AS c
			ON t.fk_cpf = c.cpf
			WHERE t.fk_tipo_telefone = 2
    ) AS tb_tel_residencial
    ON c.cpf = tb_tel_residencial.fk_cpf
   LEFT JOIN (
		SELECT 
			concat('(', t.ddd, ') ', t.numero) AS 'telefone',
            t.fk_cpf
			FROM tb_telefone AS t
			INNER JOIN tb_cliente AS c
			ON t.fk_cpf = c.cpf
			WHERE t.fk_tipo_telefone = 1
    ) AS tb_tel_cel
    ON c.cpf = tb_tel_cel.fk_cpf;