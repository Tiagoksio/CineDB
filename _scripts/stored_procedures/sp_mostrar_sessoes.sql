/* 
	01 Procedure mostrar as sessões disponíveis para a localidade do cliente conforme 'CPF' informado.
	OBS: O CPF deve ser informado com 11 dígitos, preenchendo com os zeros à esquerda do número, se necessário.
*/
DELIMITER #
	DROP PROCEDURE IF EXISTS sp_mostrar_sessoes #
    CREATE PROCEDURE sp_mostrar_sessoes (cpf_cliente VARCHAR(11))
    BEGIN
		SELECT DISTINCT
			s.id_sessao AS `Sessão`,
			s.fk_sala AS `Nº Sala`,
			sa.tela AS `Tela`,
			CASE
				WHEN weekday(s.hr_inicio) = 6 THEN concat(date_format(s.hr_inicio, '%d/%m' ),' - Domingo')
				WHEN weekday(s.hr_inicio) = 0 THEN concat(date_format(s.hr_inicio, '%d/%m'),' - Segunda-Feira')
				WHEN weekday(s.hr_inicio) = 1 THEN concat(date_format(s.hr_inicio, '%d/%m'),' - Terça-Feira')
				WHEN weekday(s.hr_inicio) = 2 THEN concat(date_format(s.hr_inicio, '%d/%m'),' - Quarta-Feira')
				WHEN weekday(s.hr_inicio) = 3 THEN concat(date_format(s.hr_inicio, '%d/%m'),' - Quinta-Feira')
				WHEN weekday(s.hr_inicio) = 4 THEN concat(date_format(s.hr_inicio, '%d/%m'),' - Sexta-Feira')
				WHEN weekday(s.hr_inicio) = 5 THEN concat(date_format(s.hr_inicio, '%d/%m'),' - Sábado')
			END AS `Dia da Semana`,
            time_format(s.hr_inicio, '%H:%i') AS `Horário`,
            f.titulo AS `Filme`,
            i.ds_idioma AS `Idioma`,
            CASE 
				WHEN i.ds_idioma <> 'Português' THEN 'Legendado'
                WHEN i.ds_idioma = 'Português' THEN 'Dublado'
			END AS `Leg/Dub`,
            c.nome AS `Cinema`
            FROM tb_sessao AS s
            INNER JOIN tb_sala AS sa
            ON s.fk_sala = sa.id_sala
            INNER JOIN tb_filme AS f
            ON s.fk_filme = f.id_filme
            INNER JOIN tb_idioma AS i
            ON s.fk_idioma = i.id_idioma
            INNER JOIN tb_cinema AS c
            ON s.fk_cinema = c.cnpj
            INNER JOIN tb_endereco AS e
            ON c.fk_endereco = e.id_endereco
            INNER JOIN tb_municipio AS m
            ON m.id_municipio = e.fk_municipio
            WHERE fk_estado = fn_localizar_uf(cpf_cliente);
	END #	
DELIMITER ;