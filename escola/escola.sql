-- =====================================================
-- ATIVIDADE: MODELO FÍSICO - BANCO DE DADOS ESCOLA
-- =====================================================

-- CRIANDO O BANCO DE DADOS
CREATE DATABASE escola;

-- SELECIONANDO O BANCO DE DADOS
USE escola;

-- =====================================================
-- CRIAÇÃO DAS TABELAS
-- =====================================================

-- TABELA DE PESSOA INSTRUTORA
CREATE TABLE pessoaInstrutora (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200),
    endereco VARCHAR(500),
    telefone VARCHAR(20)
);

-- TABELA DE DISCIPLINA
CREATE TABLE disciplina (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200)
);

-- TABELA DE PESSOA ESTUDANTE
CREATE TABLE pessoaEstudante (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200),
    endereco VARCHAR(500),
    telefone VARCHAR(20)
);

-- TABELA DE RELACIONAMENTO LECIONAR
-- RELACIONA A INSTRUTORA COM A DISCIPLINA
CREATE TABLE lecionar (
    codigo_instrutora INT,
    codigo_disciplina INT,
    PRIMARY KEY (codigo_instrutora, codigo_disciplina),
    FOREIGN KEY (codigo_instrutora) REFERENCES pessoaInstrutora(codigo),
    FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo)
);

-- TABELA DE RELACIONAMENTO CURSAR
-- RELACIONA O ESTUDANTE COM A DISCIPLINA
CREATE TABLE cursar (
    codigo_disciplina INT,
    codigo_estudante INT,
    PRIMARY KEY (codigo_disciplina, codigo_estudante),
    FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo),
    FOREIGN KEY (codigo_estudante) REFERENCES pessoaEstudante(codigo)
);

-- =====================================================
-- ALTERAÇÃO DOS NOMES DAS COLUNAS
-- =====================================================

-- ALTERANDO A COLUNA NOME DA TABELA pessoaInstrutora
ALTER TABLE pessoaInstrutora
CHANGE nome nomepessoainstrutora VARCHAR(200);

-- ALTERANDO A COLUNA NOME DA TABELA disciplina
ALTER TABLE disciplina
CHANGE nome nomedisciplina VARCHAR(200);

-- ALTERANDO A COLUNA NOME DA TABELA pessoaEstudante
ALTER TABLE pessoaEstudante
CHANGE nome nomeestudante VARCHAR(200);

-- =====================================================
-- INSERÇÃO DE DADOS NAS TABELAS
-- =====================================================

-- INSERINDO DADOS NA TABELA pessoaInstrutora
INSERT INTO pessoaInstrutora (
    nomepessoainstrutora,
    endereco,
    telefone
)
VALUES
('Guilherme Santos', 'Rua da Maçã, 5', '11998890220'),
('Rheylander Soares', 'Rua da Uva, 10', '11989981001');

-- INSERINDO DADOS NA TABELA disciplina
INSERT INTO disciplina (
    nomedisciplina
)
VALUES
('Matemática'),
('Português');

-- INSERINDO DADOS NA TABELA pessoaEstudante
INSERT INTO pessoaEstudante (
    nomeestudante,
    endereco,
    telefone
)
VALUES
('Vinicio Junior', '15 de Novembro, 3', '11975574114'),
('Yago de Jesus', '15 de março, 10', '11956452332');

-- INSERINDO DADOS NA TABELA lecionar
INSERT INTO lecionar (
    codigo_instrutora,
    codigo_disciplina
)
VALUES
(1, 1),
(2, 2);

-- INSERINDO DADOS NA TABELA cursar
INSERT INTO cursar (
    codigo_disciplina,
    codigo_estudante
)
VALUES
(1, 1),
(2, 2);

-- =====================================================
-- ATUALIZAÇÃO DE DADOS
-- =====================================================

-- ATUALIZANDO O TELEFONE DO ESTUDANTE DE CÓDIGO 1
UPDATE pessoaEstudante
SET telefone = '11956654114'
WHERE codigo = 1;

-- ATUALIZANDO O TELEFONE DA INSTRUTORA DE CÓDIGO 2
UPDATE pessoaInstrutora
SET telefone = '11941142332'
WHERE codigo = 2;

-- =====================================================
-- EXCLUSÃO DE DADOS
-- =====================================================

-- EXCLUINDO O RELACIONAMENTO DO ESTUDANTE DE CÓDIGO 2
DELETE FROM cursar
WHERE codigo_estudante = 2;

-- EXCLUINDO O ESTUDANTE DE CÓDIGO 2
DELETE FROM pessoaEstudante
WHERE codigo = 2;

-- =====================================================
-- EXCLUSÃO DAS TABELAS
-- =====================================================

DROP TABLE cursar;
DROP TABLE lecionar;
DROP TABLE pessoaEstudante;
DROP TABLE disciplina;
DROP TABLE pessoaInstrutora;

-- =====================================================
-- EXCLUSÃO DO BANCO DE DADOS
-- =====================================================

DROP DATABASE escola;
