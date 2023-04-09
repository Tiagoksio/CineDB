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

## Configuração

O projeto foi desenvolvido utilizando o SGBD **MySQL** e o **MySQL Workbench**, basta fazer a instalação das ferramentas e fazer o dumping executando o script na pasta referente.

## Utilizando o banco

Na pasta "_scripts" estão alguns exemplos de consulta e funcionalidades do banco:

* **Através dos selects e views:** Visualizar os detalhes de cadastro dos clientes, cinemas, compras, faturamento, ingressos e sessões;
* **Através das functions:** Cadastrar compras, endereços, contatenar alguns nomes, localizar uf;
* **Através das procedures:** Cadastrar telefone, concluir pagamento, visualização de ingressos por sessão, visualização dos assentos e das sessões;
* **Através das transactions:** Garantir o cadastro de clientes e reserva de ingressos conforme estrutura ACID;
* **Através das triggers:** Garantir a coesão dos dados ao efetuar uma reserva ou compra e registro de alteração de estado das mesmas.

## Teste

**Segue uma sugestão de teste:**

* Cadastrar telefone para o cliente que possui o cpf **"4831468118"**;

    ```sql
    CALL sp_cadastro_telefone('4831468118', '61', '995883232');
    -- Select para visualizar se o cadastro funcionou:
    SELECT * FROM vw_cliente_detalhes;
    ```

* Cadastrar um novo cliente:

    ```sql
    CALL sp_cadastrar_cliente('99999999999', 'Valter', 'Blanco', '1964/01/01', 'M', 'ValterBlanco@TESTE.com', '123456', '61', '999999199', '', '', 'DF', 'Brasília', '73360100', 'Setor Tradicional', 'Independência', '53', NULL);
    -- Select para visualizar se o cadastro funcionou:
    SELECT * FROM vw_cliente_detalhes WHERE cpf = '99999999999';
    ```

* Efetuar uma compra:

    ```sql
        -- Utilizando o cpf como parâmetro, a primeira procedure vai mostrar as sessões disponíveis para o CPF;
        CALL sp_mostrar_sessoes('99999999999');
        -- Escolhida a sessão '5', no exemplo, agora listamos os assentos disponíveis para a sessão;
        CALL sp_mostrar_assentos('5');
        -- Escolhido o assento, no caso 'a10', e a sessão '5', agora verificamos o ingressso utilizando a sessão como parâmetro;
        CALL sp_ingressos_por_sessao('5'); -- 10
        -- Escolhido o ingresso de código '10', agora basta passar os argumentos abaixo com os 2 últimos parâmetros para especificar se o ingresso é meia entrada e a forma de pagamento:
        CALL sp_reservar_ingresso('99999999999', 'a10', 5, 10, 1, 1);
        -- Consultar as formas de pagamento:
        SELECT * FROM tb_forma_pagamento;
        -- Consultar o status do pedido:
        SELECT * FROM vw_dados_compra where cpf='99999999999';
    ```

* Concluir a compra:

    ```sql
        --- CPF, NUM_COMPRA, SENHA, STATUS(2 para concluir OU 3 para cancelar):
        CALL sp_concluir_pagamento('99999999999', 306, 123456, 2);
    ```

## Links e Fontes

* [Instalador MySQL](https://dev.mysql.com/downloads/installer/);
* [4Devs - Para gerar os dados](https://www.4devs.com.br/);
* [Adoro Cinema - Para gerar os dados](https://www.adorocinema.com/filmes/numero-cinemas/);
* [BRmodelo - Para modelagem conceitual MER](http://www.sis4.com/brModelo/download.html);
* [Video da apresentação do projeto](https://www.youtube.com/watch?v=eMAIFIyt_ao);
* Demais dados gerados utilizando algoritimos.
