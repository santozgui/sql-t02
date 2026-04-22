CREATE DATABASE consertodolele;
USE consertodolele;
 
CREATE TABLE pecascomputador (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_peca VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    fornecedor VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    rua_fornecedor VARCHAR(200),
    cep_fornecedor VARCHAR(20)
);
INSERT INTO pecascomputador(
nome_peca,
quantidade,
valor,
fornecedor,
telefone,
rua_fornecedor,
cep_fornecedor)
 VALUES
('Memória RAM 8GB',
 15,
220.00,
'TechMemory',
'11988776655',
'Rua da Tecnologia, 100',
'01010-000'),

('HD 1TB',
 25,
 310.00,
 'Armazem Digital',
 '11997654321',
 'Av. Central, 450',
 '02020-000'),

('SSD 480GB',
40,
380.00,
'FastStorage',
'11999887766',
'Rua Velocidade, 88',
'03030-000'),

('Placa Mãe ASUS',
10,
750.00,
'InfoPlacas',
'11991234567',
'Av. das Peças, 900',
'04040-000'),

('Fonte 500W',
30,
260.00,
'PowerTech',
'11993456789',
'Rua Energia, 77',
'05050-000'),

('Processador i5',
8,
1250.00,
'CPU Brasil',
'11994561234',
'Av. Intel, 123',
'06060-000'),

('Placa de Vídeo GTX1660',
5, 1800.00,
'GamerStore',
'11995678901',
'Rua Gamer, 321',
'07070-000'),

('Teclado Mecânico',
50,
350.00,
'Periféricos SP',
'11996789012',
'Av. dos Acessórios, 55',
'08080-000'),

('Mouse Óptico',
60,
120.00,
'Periféricos SP',
'11996789012',
'Av. dos Acessórios, 55',
'08080-000'),

('Cooler para CPU',
22,
190.00,
'RefrigTech',
'11997890123',
'Rua do Resfriamento, 9',
'09090-000');

-- 5. Todos os dados
SELECT *
FROM pecascomputador;
 
-- 6. Fornecedor e telefone
SELECT fornecedor, telefone 
FROM pecascomputador;
 
-- 7. Quantidade > 20
SELECT * 
FROM pecascomputador 
WHERE quantidade > 20;
 
-- 8. AND: quantidade >20 E valor >300
SELECT * 
FROM pecascomputador 
WHERE quantidade > 20 AND valor > 300;
 
-- 9. OR: nome contém 'RAM' OU fornecedor 'Periféricos'
SELECT * 
FROM pecascomputador 
WHERE nome_peca LIKE '%RAM%' OR fornecedor = 'Periféricos SP';
 
-- 10. LIKE para fornecedores com 'Tech'
SELECT * 
FROM pecascomputador 
WHERE fornecedor LIKE '%Tech%';
 
-- 11. Ordem por valor ASC
SELECT * 
FROM pecascomputador ORDER BY valor ASC;
 
-- 12. Ordem por valor DESC
SELECT * 
FROM pecascomputador ORDER BY valor DESC;
 
-- 13. LIMIT 4
SELECT * 
FROM pecascomputador LIMIT 4;

CREATE TABLE pedidocliente (
    idcliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    idproduto INT,
    FOREIGN KEY (idproduto) REFERENCES pecascomputador(id)
);
 
-- Inserção de 5 clientes (ligando a ids 1-5 das peças)
INSERT INTO pedidocliente (nome, sobrenome, email, telefone, idproduto) VALUES
('Ana', 'Silva', 'ana.silva@email.com', '11988887777', 1),
('Carlos', 'Souza', 'carlos.souza@email.com', '11999998888', 2),
('Mariana', 'Oliveira', 'mariana.oliveira@email.com', '11977776666', 3),
('João', 'Pereira', 'joao.pereira@email.com', '11966665555', 4),
('Fernanda', 'Costa', 'fernanda.costa@email.com', '11955554444', 5);

-- Parte JOINs
-- INNER JOIN com WHERE (ex: valor >300)
SELECT p.nome_peca, p.valor, c.nome, c.sobrenome
FROM pecascomputador p
INNER JOIN pedidocliente c ON p.id = c.idproduto
WHERE p.valor > 300;
 
-- INNER JOIN com 2 cols peças + 1 cliente, ORDER BY valor DESC
SELECT p.nome_peca, p.fornecedor, c.nome, p.valor
FROM pecascomputador p
INNER JOIN pedidocliente c ON p.id = c.idproduto
ORDER BY p.valor DESC;

-- Parte Usuários
-- 5. Criar usuário
CREATE USER 'alunoatividade'@'localhost' IDENTIFIED BY 'senha123';
 
-- 6. Conceder SELECT
GRANT SELECT ON consertodolele.* TO 'alunoatividade'@'localhost';
 
-- 7. Revogar SELECT
REVOKE SELECT ON consertodolele.* FROM 'alunoatividade'@'localhost';
 
-- 8. Deletar usuário
DROP USER 'alunoatividade'@'localhost';