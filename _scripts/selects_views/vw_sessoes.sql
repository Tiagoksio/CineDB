CREATE VIEW vw_sessoes AS
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
		ON s.fk_cinema = c.cnpj;