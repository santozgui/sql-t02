-- =============================================
-- BANCO DE DADOS FÍSICO - SISTEMA SST (eSocial)
-- =============================================
 
CREATE DATABASE IF NOT EXISTS db_sst;
USE db_sst;
 
-- =============================================
-- TABELA: USUARIO
-- =============================================
CREATE TABLE USUARIO (
    id              INT             NOT NULL AUTO_INCREMENT,
    nome_completo   VARCHAR(150)    NOT NULL,
    email           VARCHAR(200)    NOT NULL,
    senha_hash      VARCHAR(255)    NOT NULL,
    perfil          VARCHAR(50)     NOT NULL,
    CONSTRAINT PK_USUARIO PRIMARY KEY (id),
    CONSTRAINT UK_USUARIO_EMAIL UNIQUE (email)
);
 
-- =============================================
-- TABELA: TOKEN_RECUPERACAO_SENHA
-- =============================================
CREATE TABLE TOKEN_RECUPERACAO_SENHA (
    id              INT             NOT NULL AUTO_INCREMENT,
    usuario_id      INT             NOT NULL,
    codigo          VARCHAR(255)    NOT NULL,
    criado_em       DATETIME        NOT NULL,
    expira_em       DATETIME        NOT NULL,
    utilizado       BOOLEAN         NOT NULL DEFAULT FALSE,
    CONSTRAINT PK_TOKEN_RECUPERACAO_SENHA PRIMARY KEY (id),
    CONSTRAINT FK_TOKEN_USUARIO FOREIGN KEY (usuario_id) REFERENCES USUARIO(id)
);
 
-- =============================================
-- TABELA: EMPREGADO
-- =============================================
CREATE TABLE EMPREGADO (
    matricula       VARCHAR(20)     NOT NULL,
    nome_completo   VARCHAR(150)    NOT NULL,
    cpf             VARCHAR(14)     NOT NULL,
    setor           VARCHAR(100)    NOT NULL,
    cargo           VARCHAR(100)    NOT NULL,
    data_admissao   DATE            NOT NULL,
    CONSTRAINT PK_EMPREGADO PRIMARY KEY (matricula),
    CONSTRAINT UK_EMPREGADO_CPF UNIQUE (cpf)
);
 
-- =============================================
-- TABELA: MEDICO
-- =============================================
CREATE TABLE MEDICO (
    id              INT             NOT NULL AUTO_INCREMENT,
    nome            VARCHAR(150)    NOT NULL,
    crm             VARCHAR(20)     NOT NULL,
    orgao_uf        VARCHAR(2)      NOT NULL,
    especialidade   VARCHAR(100)    NOT NULL,
    email           VARCHAR(200)    NULL,
    CONSTRAINT PK_MEDICO PRIMARY KEY (id),
    CONSTRAINT UK_MEDICO_CRM UNIQUE (crm)
);
 
-- =============================================
-- TABELA: AMBIENTE_TRABALHO
-- =============================================
CREATE TABLE AMBIENTE_TRABALHO (
    id              INT             NOT NULL AUTO_INCREMENT,
    codigo          VARCHAR(20)     NOT NULL,
    descricao       TEXT            NOT NULL,
    CONSTRAINT PK_AMBIENTE_TRABALHO PRIMARY KEY (id),
    CONSTRAINT UK_AMBIENTE_TRABALHO_CODIGO UNIQUE (codigo)
);
 
-- =============================================
-- TABELA: FATOR_RISCO_AMBIENTAL
-- =============================================
CREATE TABLE FATOR_RISCO_AMBIENTAL (
    id                      INT             NOT NULL AUTO_INCREMENT,
    empregado_matricula     VARCHAR(20)     NOT NULL,
    ambiente_trabalho_id    INT             NOT NULL,
    data_avaliacao          DATE            NOT NULL,
    inicio_exposicao        DATE            NOT NULL,
    fim_exposicao           DATE            NULL,
    processo_produtivo      TEXT            NULL,
    descricao_atividades    TEXT            NULL,
    epi_utilizado           BOOLEAN         NOT NULL DEFAULT FALSE,
    epi_eficaz              BOOLEAN         NOT NULL DEFAULT FALSE,
    CONSTRAINT PK_FATOR_RISCO_AMBIENTAL PRIMARY KEY (id),
    CONSTRAINT FK_FATOR_RISCO_EMPREGADO FOREIGN KEY (empregado_matricula) REFERENCES EMPREGADO(matricula),
    CONSTRAINT FK_FATOR_RISCO_AMBIENTE FOREIGN KEY (ambiente_trabalho_id) REFERENCES AMBIENTE_TRABALHO(id)
);
 
-- =============================================
-- TABELA: ITEM_FATOR_RISCO
-- =============================================
CREATE TABLE ITEM_FATOR_RISCO (
    id              INT             NOT NULL AUTO_INCREMENT,
    fator_risco_id  INT             NOT NULL,
    tipo_fator      VARCHAR(50)     NOT NULL,
    agente          VARCHAR(100)    NOT NULL,
    intensidade     VARCHAR(50)     NULL,
    tecnica_medicao VARCHAR(100)    NULL,
    CONSTRAINT PK_ITEM_FATOR_RISCO PRIMARY KEY (id),
    CONSTRAINT FK_ITEM_FATOR_RISCO FOREIGN KEY (fator_risco_id) REFERENCES FATOR_RISCO_AMBIENTAL(id)
);
 
-- =============================================
-- TABELA: EPI_EPC
-- =============================================
CREATE TABLE EPI_EPC (
    id                      INT             NOT NULL AUTO_INCREMENT,
    fator_risco_id          INT             NOT NULL,
    descricao               TEXT            NOT NULL,
    certificado_aprovacao   VARCHAR(50)     NULL,
    un_valor                VARCHAR(50)     NULL,
    status_eficacia         VARCHAR(50)     NULL,
    CONSTRAINT PK_EPI_EPC PRIMARY KEY (id),
    CONSTRAINT FK_EPI_EPC_FATOR_RISCO FOREIGN KEY (fator_risco_id) REFERENCES FATOR_RISCO_AMBIENTAL(id)
);
 
-- =============================================
-- TABELA: CAT (Comunicação de Acidente de Trabalho)
-- =============================================
CREATE TABLE CAT (
    id                      INT             NOT NULL AUTO_INCREMENT,
    empregado_matricula     VARCHAR(20)     NOT NULL,
    medico_assistente_id    INT             NULL,
    data_acidente           DATE            NOT NULL,
    hora_acidente           TIME            NOT NULL,
    data_obito              DATE            NULL,
    tipo_cat                VARCHAR(50)     NOT NULL,
    emitente_cat            VARCHAR(100)    NOT NULL,
    local_acidente          VARCHAR(200)    NOT NULL,
    hora_entrada_trabalho   TIME            NULL,
    hora_saida_trabalho     TIME            NULL,
    descricao_acidente      TEXT            NOT NULL,
    parte_corpo_atingida    VARCHAR(100)    NOT NULL,
    agente_causador         VARCHAR(100)    NOT NULL,
    cid10                   VARCHAR(10)     NOT NULL,
    natureza_lesao          VARCHAR(100)    NOT NULL,
    codigo_sinan            VARCHAR(50)     NULL,
    CONSTRAINT PK_CAT PRIMARY KEY (id),
    CONSTRAINT FK_CAT_EMPREGADO FOREIGN KEY (empregado_matricula) REFERENCES EMPREGADO(matricula),
    CONSTRAINT FK_CAT_MEDICO FOREIGN KEY (medico_assistente_id) REFERENCES MEDICO(id)
);
 
-- =============================================
-- TABELA: TESTEMUNHA_CAT
-- =============================================
CREATE TABLE TESTEMUNHA_CAT (
    id              INT             NOT NULL AUTO_INCREMENT,
    cat_id          INT             NOT NULL,
    nome_completo   VARCHAR(150)    NOT NULL,
    cpf             VARCHAR(14)     NOT NULL,
    telefone        VARCHAR(20)     NULL,
    CONSTRAINT PK_TESTEMUNHA_CAT PRIMARY KEY (id),
    CONSTRAINT FK_TESTEMUNHA_CAT FOREIGN KEY (cat_id) REFERENCES CAT(id)
);
 
-- =============================================
-- TABELA: ASO (Atestado de Saúde Ocupacional)
-- =============================================
CREATE TABLE ASO (
    id                      INT             NOT NULL AUTO_INCREMENT,
    empregado_matricula     VARCHAR(20)     NOT NULL,
    medico_responsavel_id   INT             NOT NULL,
    data_aso                DATE            NOT NULL,
    tipo_exame_aso          VARCHAR(50)     NOT NULL,
    resultado               VARCHAR(50)     NOT NULL,
    observacoes             TEXT            NULL,
    CONSTRAINT PK_ASO PRIMARY KEY (id),
    CONSTRAINT FK_ASO_EMPREGADO FOREIGN KEY (empregado_matricula) REFERENCES EMPREGADO(matricula),
    CONSTRAINT FK_ASO_MEDICO FOREIGN KEY (medico_responsavel_id) REFERENCES MEDICO(id)
);
 
-- =============================================
-- TABELA: TIPO_EXAME
-- =============================================
CREATE TABLE TIPO_EXAME (
    codigo          VARCHAR(20)     NOT NULL,
    nome            VARCHAR(150)    NOT NULL,
    tipo            VARCHAR(50)     NOT NULL,
    periodicidade   VARCHAR(50)     NULL,
    CONSTRAINT PK_TIPO_EXAME PRIMARY KEY (codigo),
    CONSTRAINT UK_TIPO_EXAME_NOME UNIQUE (nome)
);
 
-- =============================================
-- TABELA: ASO_EXAME
-- =============================================
CREATE TABLE ASO_EXAME (
    id                  INT             NOT NULL AUTO_INCREMENT,
    aso_id              INT             NOT NULL,
    tipo_exame_codigo   VARCHAR(20)     NOT NULL,
    data_realizacao     DATE            NOT NULL,
    resultado_exame     VARCHAR(100)    NOT NULL,
    CONSTRAINT PK_ASO_EXAME PRIMARY KEY (id),
    CONSTRAINT FK_ASO_EXAME_ASO FOREIGN KEY (aso_id) REFERENCES ASO(id),
    CONSTRAINT FK_ASO_EXAME_TIPO FOREIGN KEY (tipo_exame_codigo) REFERENCES TIPO_EXAME(codigo)
);
 
-- =============================================
-- TABELA: EVENTO_ESOCIAL
-- =============================================
CREATE TABLE EVENTO_ESOCIAL (
    id                      INT             NOT NULL AUTO_INCREMENT,
    tipo_evento             VARCHAR(50)     NOT NULL,
    empregado_matricula     VARCHAR(20)     NOT NULL,
    cat_id                  INT             NULL,
    aso_id                  INT             NULL,
    fator_risco_id          INT             NULL,
    data_hora_transmissao   DATETIME        NOT NULL,
    protocolo               VARCHAR(100)    NULL,
    status                  VARCHAR(50)     NOT NULL,
    numero_recibo           VARCHAR(100)    NULL,
    CONSTRAINT PK_EVENTO_ESOCIAL PRIMARY KEY (id),
    CONSTRAINT FK_EVENTO_EMPREGADO FOREIGN KEY (empregado_matricula) REFERENCES EMPREGADO(matricula),
    CONSTRAINT FK_EVENTO_CAT FOREIGN KEY (cat_id) REFERENCES CAT(id),
    CONSTRAINT FK_EVENTO_ASO FOREIGN KEY (aso_id) REFERENCES ASO(id),
    CONSTRAINT FK_EVENTO_FATOR_RISCO FOREIGN KEY (fator_risco_id) REFERENCES FATOR_RISCO_AMBIENTAL(id)
);
 