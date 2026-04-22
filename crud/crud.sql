CREATE DATABASE db_cadastro;

CREATE TABLE dadosdocliente; (
    codigo INT AUTO INCREMENT PRIMARY KEY,
    nomecompleto VARCHAR(255) NOT NULL,
    nomesocial VARCHAR(255),
    email VARCHAR(200) UNIQUE NOT NULL,
    cpf VARCHAR(20) UNIQUE NOT NULL
);