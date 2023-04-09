CREATE VIEW vw_cinema_detalhes AS
SELECT
	c.nome AS 'Nome',
    c.cnpj AS 'CNPJ',
    c.email AS 'E-Mail',
    uf.nome AS 'Estado',
    m.nome AS 'Cidade',
    e.bairro AS 'Bairro',
    e.logradouro AS 'Logradouro',
    e.numero AS 'Número',
    e.cep AS 'CEP',
    ifnull(e.complemento, 'Não cadastrado') AS 'Complemento',
    concat('(', t.ddd, ') ', t.numero) AS 'Telefone',
	tt.tipo AS 'Tipo de Telefone' 
	FROM tb_cinema AS c
    INNER JOIN tb_endereco AS e
    ON c.fk_endereco = e.id_endereco
    INNER JOIN tb_telefone AS t
    ON t.fk_cinema = c.cnpj
    INNER JOIN tb_tipo_telefone AS tt
    ON tt.id_tipo_telefone = t.fk_tipo_telefone
    INNER JOIN tb_municipio AS m
    ON m.id_municipio = e.fk_municipio
    INNER JOIN tb_estado AS uf
    ON uf.id_estado = m.fk_estado;