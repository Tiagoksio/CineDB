SELECT * FROM tb_cliente where timestampdiff(year, dt_nascimento, curdate()) < 18;