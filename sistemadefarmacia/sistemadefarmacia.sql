-- Criando um banco de dados
CREATE DATABASE sistemadefarmacia;
 
--Criando uma tabela no banco de dados
CREATE TABLE farmacia(
    cnpj CHAR (14) PRIMARY KEY,
    nomefarmacia VARCHAR (255) NOT NULL,
    telefone INT,
    rua VARCHAR (255) NOT NULL,
    numero VARCHAR (20) NOT NULL,
    complemento VARCHAR (100),
    bairro VARCHAR (100) NOT NULL,
    cidade VARCHAR (100) NOT NULL,
    estado CHAR (2) NOT NULL,
    cep BIGINT NOT NULL
);
 
--Deletar a tabela do banco de dados
DROP TABLE farmacia;
 
--Deletar o banco de dados
DROP DATABASE sistemadefarmacia;
 
CREATE TABLE farmaceutico(
    rg INT PRIMARY KEY,
    nomefarmaceutico VARCHAR(255) NOT NULL,
    cnpj_farmacia CHAR(14),
    FOREIGN KEY (cnpj_farmacia)
        REFERENCES farmacia(cnpj)
);
 
CREATE TABLE produto (
    codproduto INT PRIMARY KEY,
    quantproduto INT NOT NULL,
    valorproduto DECIMAL (10,2) NOT NULL,
    cnpj_farmacia CHAR(14),
    FOREIGN KEY (cnpj_farmacia)
        REFERENCES farmacia(cnpj)
);
--alterar coluna data
ALTER TABLE farmacia
MODIFY cep CHAR(8) NOT NULL;

--DELETAR TABELA
DROP TABLE farmacia;

--alterando outra coluna
ALTER TABLE produto
MODIFY codproduto INT AUTO_INCREMENT;

--inserir dadods na primeira tabela
INSERT INTO farmacia (
    cnpj,
    nomefarmacia,
    telefone,
    rua,
    numero,
    complemento,
    bairro,
    cidade,
    estado,
    cep
)
VALUES (
    '12345678000199',
    'Farmácia Saúde total',
    1133224455,
    'Rua das Flores',
    '123',
    'Proximo ao mercado',
    'Centro',
    'São Paulo',
    'SP',
    '01001000'
);

--alterando um dado especifico de uma coluna
UPDATE farmacia
SET telefone = 11987654321
WHERE cnpj = '12345678000199';

--- deletar

DELETE FROM farmacia
WHERE cnpj = '12345678000199'

--alterar tipo de dado telefone
ALTER TABLE farmacia
MODIFY telefone BIGINT NOT NULL;

--inserindo 
INSERT INTO farmacia (
    cnpj,
    nomefarmacia,
    telefone,
    rua,
    numero,
    complemento,
    bairro,
    cidade,
    estado,
    cep
)
VALUES (
    '11111111000111',
    'Farmácia Popular',
    11999990001,
    'Av. Brasil',
    '1000',
    NULL,
    'Jardins',
    'São Paulo',
    'SP',
    '01452000'
),
(
  '22222200012',
  'Drogaria Vida',
  '11888887777',
  'Rua central',
  '45',
  'Sala 2',
  'Centro',
  'Campinas',
  'SP',
  '1301000' 
),
(
'33333333000133',
'Farmácia Bem Estar',
11777776666,
'Rua Saúde',
'789',
NULL,

'Vila Nova',
'Santos',
'SP',
'11015000'
); 

--inserindo dado da tabela farmaceutico (FK foi referenciada)
INSERT INTO farmaceutico(
    rg,
    nomefarmaceutico,
    cnpj_farmacia
)
VALUES(
    12345678,
    'João Carlos da Silva',
    '11111111000111'
);

--inserindo dados de tabela de produtos
INSERT INTO produto (
    quantproduto,
    valorproduto,
    cnpj_farmacia
)
VALUES(
    50,
    19.90,
    '11111111000111'
);
--listando os dados de duas colunas
SELECT nomefarmacia, cidade
FROM farmacia;

--listando com filtro

SELECT *
FROM farmacia
WHERE cidade = 'São Paulo'

--DEletar um dado da tabela
DELETE FROM farmacia
WHERE cnpj = '12345678000199'

--ai ai
DROP DATABASE sistemadefarmacia

--listar com comparação
SELECT *
FROM produto
WHERE quantproduto > 20;

SELECT *
FROM farmacia
WHERE cidade = 'São Paulo'
AND bairro = 'Jardins';

SELECT *
FROM farmacia
WHERE cidade = 'São Paulo'
OR cidade = 'Campinas;'

SELECT *
FROM produto
WHERE valorproduto BETWEEN 10 and 50;

-- Concedendo permissão - apenas de leitura
GRANT SELECT
ON sistemadefarmacia. *
TO 'usuario_farmacia'@'localhost';
 
-- Concedendo permissões específicas
GRANT SELECT, INSERT
ON sistemadefarmacia. *
TO 'usuario_farmacia'@'localhost';


-- Revogando permissões de um usuário

REVOKE INSERT 

ON sistemadefarmacia. *

FROM 'usuario_farmacia'@'localhost';

-- revogando todas as permissoes do usuario
REVOKE ALL PRIVELEGES
ON sistemadefarmacia.*
FROM 'usuario_farmacia'@'localhost';