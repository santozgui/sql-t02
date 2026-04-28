-- Atividade 2 - Banco de Dados: Pecas de Computador
-- Banco escolhido: MySQL/MariaDB

-- =========================================================
-- Parte 1 - Criacao do banco de dados
-- =========================================================

CREATE DATABASE IF NOT EXISTS consertodolele;

USE consertodolele;

-- Remove as tabelas caso ja existam, para permitir executar o script novamente.
DROP TABLE IF EXISTS pedidocliente;
DROP TABLE IF EXISTS pecascomputador;

-- Criacao da tabela principal de pecas.
CREATE TABLE pecascomputador (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_peca VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    fornecedor VARCHAR(100) NOT NULL,
    telefone_fornecedor VARCHAR(20) NOT NULL,
    rua_fornecedor VARCHAR(150) NOT NULL,
    cep_fornecedor VARCHAR(10) NOT NULL
);

-- =========================================================
-- Parte 2 - Insercao de dados
-- =========================================================

INSERT INTO pecascomputador
    (nome_peca, quantidade, valor, fornecedor, telefone_fornecedor, rua_fornecedor, cep_fornecedor)
VALUES
    ('Memoria RAM 8GB', 15, 220.00, 'TechMemory', '11988776655', 'Rua da Tecnologia, 100', '01010-000'),
    ('HD 1TB', 25, 310.00, 'Armazem Digital', '11997654321', 'Av. Central, 450', '02020-000'),
    ('SSD 480GB', 40, 380.00, 'FastStorage', '11999887766', 'Rua Velocidade, 88', '03030-000'),
    ('Placa Mae ASUS', 10, 750.00, 'InfoPlacas', '11991234567', 'Av. das Pecas, 900', '04040-000'),
    ('Fonte 500W', 30, 260.00, 'PowerTech', '11993456789', 'Rua Energia, 77', '05050-000'),
    ('Processador i5', 8, 1250.00, 'CPU Brasil', '11994561234', 'Av. Intel, 123', '06060-000'),
    ('Placa de Video GTX1660', 5, 1800.00, 'GamerStore', '11995678901', 'Rua Gamer, 321', '07070-000'),
    ('Teclado Mecanico', 50, 350.00, 'Perifericos SP', '11996789012', 'Av. dos Acessorios, 55', '08080-000'),
    ('Mouse Optico', 60, 120.00, 'Perifericos SP', '11996789012', 'Av. dos Acessorios, 55', '08080-000'),
    ('Cooler para CPU', 22, 190.00, 'RefrigTech', '11997890123', 'Rua do Resfriamento, 9', '09090-000');

-- =========================================================
-- Parte 3 - Consultas SELECT
-- =========================================================

-- 5. Mostre todos os dados da tabela.
SELECT *
FROM pecascomputador;

-- 6. Mostre apenas as colunas fornecedor e telefone do fornecedor.
SELECT fornecedor, telefone_fornecedor
FROM pecascomputador;

-- 7. Mostre todas as pecas com quantidade maior que 20.
SELECT *
FROM pecascomputador
WHERE quantidade > 20;

-- 8. Consulta usando AND, combinando quantidade e valor.
SELECT *
FROM pecascomputador
WHERE quantidade > 20
  AND valor < 400.00;

-- 9. Consulta usando OR, combinando nome da peca e fornecedor.
SELECT *
FROM pecascomputador
WHERE nome_peca = 'HD 1TB'
   OR fornecedor = 'Perifericos SP';

-- 10. Consulta utilizando LIKE.
SELECT *
FROM pecascomputador
WHERE fornecedor LIKE '%Tech%';

-- 11. Consulta ordenando os dados pelo valor em ordem crescente.
SELECT *
FROM pecascomputador
ORDER BY valor ASC;

-- 12. Consulta ordenando os dados pelo valor em ordem decrescente.
SELECT *
FROM pecascomputador
ORDER BY valor DESC;

-- 13. Consulta exibindo apenas 4 registros.
SELECT *
FROM pecascomputador
LIMIT 4;

-- =========================================================
-- Continuacao do modelo de dados - Segunda tabela
-- =========================================================

-- Criacao da tabela de pedidos/clientes com relacionamento por chave estrangeira.
CREATE TABLE pedidocliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    sobrenome VARCHAR(80) NOT NULL,
    email VARCHAR(120) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    id_produto INT NOT NULL,
    CONSTRAINT fk_pedidocliente_pecascomputador
        FOREIGN KEY (id_produto)
        REFERENCES pecascomputador(id_produto)
);

-- Insercao de 5 clientes relacionados a produtos existentes.
INSERT INTO pedidocliente
    (nome, sobrenome, email, telefone, id_produto)
VALUES
    ('Ana', 'Silva', 'ana.silva@email.com', '11988887777', 1),
    ('Carlos', 'Souza', 'carlos.souza@email.com', '11999998888', 2),
    ('Mariana', 'Oliveira', 'mariana.oliveira@email.com', '11977776666', 3),
    ('Joao', 'Pereira', 'joao.pereira@email.com', '11966665555', 4),
    ('Fernanda', 'Costa', 'fernanda.costa@email.com', '11955554444', 5);

-- =========================================================
-- Consultas com INNER JOIN
-- =========================================================

-- 3. INNER JOIN entre pecascomputador e pedidocliente usando WHERE.
SELECT
    pc.id_produto,
    pc.nome_peca,
    pc.fornecedor,
    pc.valor,
    p.id_cliente,
    p.nome,
    p.sobrenome,
    p.telefone
FROM pecascomputador AS pc
INNER JOIN pedidocliente AS p
    ON pc.id_produto = p.id_produto
WHERE pc.valor > 300.00;

-- 4. INNER JOIN com duas colunas da tabela pecascomputador,
-- uma coluna da tabela pedidocliente e ORDER BY DESC.
SELECT
    pc.nome_peca,
    pc.valor,
    p.nome
FROM pecascomputador AS pc
INNER JOIN pedidocliente AS p
    ON pc.id_produto = p.id_produto
ORDER BY pc.valor DESC;

-- =========================================================
-- Usuarios e permissoes
-- =========================================================

-- 5. Crie um novo usuario no banco de dados.
CREATE USER IF NOT EXISTS 'usuario_lele'@'localhost' IDENTIFIED BY 'Senha123@';

-- 6. Conceda a esse usuario apenas permissao de SELECT.
GRANT SELECT ON consertodolele.* TO 'usuario_lele'@'localhost';

-- 7. Revogue a permissao de SELECT do usuario criado.
REVOKE SELECT ON consertodolele.* FROM 'usuario_lele'@'localhost';

-- 8. Delete o usuario criado anteriormente.
DROP USER IF EXISTS 'usuario_lele'@'localhost';
