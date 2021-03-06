/* 
SCHEMA:
        TABLES: 
            person.PERSON       : pessoas;
            person.EmailAddres  : Email;
            person.Addres       : Endereço;
            person.PERSONPHONE  : Numero de telefone;
            person.PHONETYPE    : Tipo do telefone;
            production.PRODUCT  : produtos;
            
*/

-- 1) A EQUIPE DE MARKETING PRECISA DE FAZER UMA PESQUISA SOBRE NOMES MAIS COMUNS DE SEUS CLIENTES
-- E PRECISA DO NOME E SOBRENOME DE TODOS OS CLIENTES QUE ESTÃO CADASTRADOS NO SISTEMA.
-- R: 
    SELECT FIRST_NAME, LAST_NAME
    FROM person.PERSON;

-- 2) QUANTOS SOBRENOMES UNICOS TEMOS EM NOSSA TABELA DE PESSOAS?
-- R:
    SELECT DISTINCT LAST_NAME
    FROM person.PERSON;

-- 3) A EQUIPE DE PRODUÇÃO DE PRODUTOS PRECISA DO NOME DE TODAS AS PEÇAS QUE PESAM MAIS QUE 500KG,
-- MAS NÃO MAIS QUE 700KG PARA INSPEÇÃO. 
-- R:
    SELECT PROD_NAME
    FROM production.PRODUCT
    WHERE PROD_WEIGHT > 500 AND PROD_WEIGHT <= 700;

-- 4) FOI PEDIDO PELO MARKETING UMA RELAÇÃO DE TODOS OS EMPREGADOS QUE SÃO CASADOS E SÃO ASALARIADOS
-- R:
    SELECT EMP_NAME
    FROM person.EMPLOYERS
    WHERE MARITAL_STT = 'm' AND SALARIED_STT = 1; -- TRUE

-- 5) UM USUARIO CHAMADO PETER KREBS ESTA DEVENDO UM PAGAMENTO, CONSIGA O EMAIL DELE PARA QUE POSSAMOS
-- ENVIAR UMA COBRANÇA. (USO DE DUAS TABELAS)
-- R:
    -- PEGANDO O CODIGO PARA OUTRA TABELA (BUSINESS_ID)
    SELECT *
    FROM person.PERSON
    WHERE FIRST_NAME = 'Peter' AND LAST_NAME = 'Krebs';
    -- BUSCANDO O EMAIL 
    SELECT *
    FROM person.EmailAddres
    WHERE BUSINESS_ID = 20;

-- 6) EU QUERO SABER QUANTOS PRODUTOS TEMOS CADASTRADOS EM NOSSA TABELA DE PRODUTOS
-- R:
    SELECT COUNT(PROD_NAME)
    FROM production.PRODUCT;

-- 7) EU QUERO SABER QUANTOS TAMANHOS DE PRODUTOS TEMOS CADASTRADO EM NOSSA TABELA
-- R:
    SELECT COUNT(PROD_SIZE)
    FROM production.PRODUCT;
 
-- 8) EU QUERO SABER QUANTOS TAMANHOS DIFERENTES DE PRODUTOS TEMOS CADASTRADO EM NOSSA TABELA
-- R:
    SELECT COUNT(DISTINCT PROD_SIZE)
    FROM production.PRODUCT;

-- 9) OBTER OS 10 PRODUTOS MAIS CAROS CADASTRADOS NO SISTEMA, LISTANDO DO MAIS CARO AO BARATO
-- R:
--  POR NOME:                               
    SELECT TOP 10 PROD_NAME
    FROM production.PRODUCT
    ORDER BY PROD_PRICE DESC;
--  POR ID:
    SELECT TOP 10 PROD_ID
     FROM production.PRODUCT
    ORDER BY PROD_PRICE DESC;

-- 10) OBTER O NOME E O NUMERO DO PRODUTO DOS PRODUTOS QUE TEM O ID ENTRE 1 E 4
-- R:
    SELECT TOP 4 PROD_NAME, PROD_NUMBER        
    FROM production.PRODUCT          
    ORDER BY PROD_ID ASC;

-- 11) QUANTOS PRODUTOS TEMOS CADASTRADO NO SISTEMA QUE CUSTAM MAIS QUE 1500 DOLARES?
-- R:
    SELECT COUNT(PROD_PRICE)
    FROM production.PRODUCT
    WHERE PROD_PRICE > 1500;
 
-- 12) QUANTAS PESSOAS TEMOS COM O SOBRENOME QUE INICIA COM A LETRA P?
-- R:
    SELECT COUNT(LAST_NAME)
    FROM person.PERSON
    WHERE LAST_NAME LIKE 'P%';

-- 13) EM QUANTAS CIDADES UNICAS ESTÃO CADASTRADOS NOSSOS CLIENTES?
-- R:
    SELECT COUNT(DISTINCT CIDADE)
    FROM person.Addres;

-- 14) QUAIS CIDADES UNICAS ESTÃO CADASTRADOS EM NOSSO SISTEMA?
-- R:
    SELECT DISTINCT CIDADE
    FROM person.Addres;

-- 15) QUANTOS PRODUTOS VERMELHOS TEM PRECO ENTRE 500 A 1000 DOLARES?
-- R:
    SELECT COUNT(*)
    FROM production.PRODUCT
    WHERE PROD_COLOR = 'Red' 
    AND PROD_PRICE BETWEEN 500 AND 100;

-- 16) QUANTOS PRODUTOS CADASTRADOS TEM A PALAVRA 'ROAD' NO NOME DELES?
-- R:
    SELECT COUNT(*)
    FROM production.PRODUCT
    WHERE PROD_NAME LIKE '%road%'

-- 17) QUANTAS PESSOAS TEM O MESMO NOME DO MEIO AGRUPADAS POR NOME DO MEIO;
-- R:
    SELECT MIDDLE_NAME, COUNT(FIRST_NAME) AS "Contagem"
    FROM person.PERSON
    GROUP BY MIDDLE_NAME;

-- 18) QUAL A MEDIA DA QUANTIDADE QUE CADA PRODUTO É VENDIDO NA LOJA
-- R:
    SELECT PROD_ID, AVG(SALE_PROD)
    FROM production.PRODUCT
    GROUP BY PROD_IDID;

-- 19) QUAL FORAM AS 10 VENDAS QUE TIVERAM OS MAIORES VALORES DE VENDA POR
-- PRODUTO DO MAIOR PARA O MENOR. 
-- R:
    SELECT TOP 10 PROD_ID, SUM(LINE_TOTAL)
    FROM production.PRODUCT
    GROUP BY PROD_ID
    ORDER BY SUM(LINE_TOTAL) DESC;

-- 20) ESTAMOS QUERENDO INDENTIFICAR AS PROVINCIAS COM O MAIOR NUMERO DE CADASTROS NO NOSSO SISTEMA
-- ENTÃO É PRECISO ENCONTRAR QUAIS PROVINCIAS ESTÃO REGISTRADAS NO BANCO MAIS QUE 1000 VEZES.
-- R:
    SELECT PROVINCE_ID, COUNT(PROVINCE_ID) AS 'CADASTROS'
    FROM person.Address
    GROUP BY PROVINCE_ID
    HAVING COUNT(PROVINCE_ID) > 1000;

-- 21) OS GERENTES QUEREM SABER QUAIS PRODUTOS NÃO ESTÃO TRAZENDO EM MÉDIA NO MINIMO 1 MILHÃO EM TOTAL
-- DE VENDAS.
-- R:
    SELECT PROD_ID, AVG(SALE_PROD) AS 'CADASTROS'
    FROM production.PRODUCT
    GROUP BY PROD_ID
    HAVING AVG(SALE_PROD) > 1000000;

-- 22) ENCONTRAR O FIRST_NAME E LAST_NAME E TRADUZIR
-- R:
    SELECT FIRST_NAME AS 'Primeiro nome', LAST_NAME AS 'Último nome' 
	FROM person.PERSON;

-- 23) TRAZER O NUMERO DO PRODUTO TRADUZIDO
-- R:
    SELECT PROD_NUMBER AS 'Numero do Produto'
	FROM production.PRODUCT;

-- 24) TRAGA OS DADOS NOME, NUMERO DE TELEFONE
-- R:
    SELECT P.PHONE_NUMBER, P.BUSS_ID, T.PHONE_ID, T.NAME
    FROM person.PERSONPHONE P
    INNER JOIN person.PHONETYPE T ON P.PHONE_ID = T.PHONE_ID ;

-- 25) EU QEURO SABER NA TABELA 'DETALHE DO PEDIDO' QUAIS PRODUTOS TEM O MESMO PERCENTUAL DE DESCONTO.
-- R:
    SELECT A.Id, A.discount, B.Id, B.discount
    FROM orderer.DETAIL A, orderer.DETAIL B
    WHERE A.discount = B.discount;

-- 26) TODOS OS ENDEREÇOS QUE ESTÃO NO ESTADO DE 'ALBERTA', TODAS AS INFORMAÇÕES.
-- R:
    SELECT *
    FROM person.Addres
    WHERE PROVINCE_ID IN (SELECT PROVINCE_ID FROM person.StateProvince  WHERE STATE_NAME = 'ALBERTA');