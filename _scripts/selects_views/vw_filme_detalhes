CREATE VIEW vw_filme_detalhes AS
SELECT 
	titulo,
    titulo_original,
    img_poster,
    trailer,
    classificacao_indicativa,
    duracao,
    DATE_FORMAT(dt_lancamento, "%d/%m/%Y") AS 'Data de Lançamento',
    sinopse,
    fn_concatenar_nomes(4, id_filme) AS 'Gêneros',
    fn_concatenar_nomes(2, id_filme) AS 'Direção',
    fn_concatenar_nomes(3, id_filme) AS 'Roteiro',
    fn_concatenar_nomes(1, id_filme) AS 'Elenco'    
	FROM tb_filme;