# CineDB

Um sistema de banco de dados que gerencia uma bilheteria digital de uma rede de cinemas.

## Introdução

O projeto integrador é o projeto final que engloba todo o conteúdo abordado no curso de administrador de banco de dados do SENAC. O projeto visa, através de um sistema de bilheteria digital de cinema, exemplificar a modelagem dos dados e uso da linguagem SQL. Algumas funcionalidades apresentadas, em um projeto real, não estariam no SGBD, mas foram integradas para melhor exemplificação da linguagem.

## Modelagem Conceitual e Regras de Negócio

### Cliente

* Um cliente deverá cadastrar sua conta com o cpf, nome, sobrenome, data de nascimento, email, senha, telefone e endereço; 
* Um cliente poderá ter um endereço e vários telefones; 
* Um cliente poderá efetuar a compra de nenhum ou vários assentos, com apenas uma forma de pagamento;
* Quando um pagamento for aprovado, o acento será reservado, não podendo ser comprado por outro cliente;
* Cada assento de sessão deverá ter um valor de acordo com o tipo de ingresso;

### Cinema

* O cinema deve ter um identificados, um nome, um endereço e vários telefones;
* O cinema possui de uma a várias salas e cada sala pertence a um cinema;
* Cada sala possui uma tela, que pode ser 2D, 3D ou IMAX;
* Cada sala possui um ou vários assentos, e cada assento pertence a uma sala;
* Os assentos podem ser de tipo simples, para cadeirantes e obesos, podendo estar disponível, selecionado, ocupado ou bloqueado, conforme processo e status da compra ou outra indisponibilidade;

### Filme

* Filme deverá possuir um identificador, título, poster, classificação indicativa, duração, ano de lançamento, sinopse, trailer, ficha técnica e gênero;
* Cada filme é apresentado em nenhuma ou várias sessões, porém cada sessão deverá ter um filme;
* A sessão deverá ter o idioma que o filme será exibido e se ele é legendado ou não;
* Deverá ter o horário e data de inicio;
![Modelo Conceitual](/_modelagem/modelo_conceitual.png)

## Modelo Lógico

![Modelo Lógico](/_modelagem/img_modelo_logico.png)
