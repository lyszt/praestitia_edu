CREATE TABLE permissao (
    id   SERIAL PRIMARY KEY
);

CREATE TABLE grupo (
    id   SERIAL       PRIMARY KEY,
    nome VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE grupo_permissao (
    grupo_id     INTEGER NOT NULL REFERENCES grupo(id) ON DELETE CASCADE,
    permissao_id INTEGER NOT NULL REFERENCES permissao(id) ON DELETE CASCADE,
    PRIMARY KEY (grupo_id, permissao_id)
);

CREATE TABLE usuario (
    id       BIGSERIAL    PRIMARY KEY,
    nome     VARCHAR(150) NOT NULL,
    grupo_id INTEGER      REFERENCES grupo(id) ON DELETE SET NULL
);

CREATE TABLE endereco (
    id          SERIAL       PRIMARY KEY,
    cep         VARCHAR(10),
    numero      VARCHAR(20),
    logradouro  VARCHAR(200),
    bairro      VARCHAR(100),
    cidade      VARCHAR(100),
    estado      CHAR(2)
);

CREATE TABLE lead (
    id                  SERIAL       PRIMARY KEY,
    usuario_id          BIGINT       REFERENCES usuario(id) ON DELETE CASCADE,
    endereco_id         INTEGER      REFERENCES endereco(id) ON DELETE SET NULL,
    nome                VARCHAR(200) NOT NULL,
    email               VARCHAR(254) NOT NULL,
    telefone            VARCHAR(20),
    empresa             VARCHAR(200),
    cargo               VARCHAR(100),
    origem              VARCHAR(20)  NOT NULL DEFAULT 'site',
    interesse           VARCHAR(200),
    status              VARCHAR(20)  NOT NULL DEFAULT 'novo',
    pontuacao           INTEGER      NOT NULL DEFAULT 0,
    observacoes         TEXT,
    data_cadastro       TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    data_ultimo_contato TIMESTAMPTZ,

    CONSTRAINT lead_status_check CHECK (
        status IN ('novo', 'contatado', 'qualificado', 'em_negociacao', 'convertido', 'perdido')
    ),
    CONSTRAINT lead_origem_check CHECK (
        origem IN ('site', 'indicacao', 'redes_sociais', 'email', 'telefone', 'evento', 'outro')
    )
);

CREATE TABLE cliente (
    id             SERIAL       PRIMARY KEY,
    usuario_id     BIGINT       REFERENCES usuario(id) ON DELETE CASCADE,
    endereco_id    INTEGER      REFERENCES endereco(id) ON DELETE SET NULL,
    nome           VARCHAR(200) NOT NULL,
    email          VARCHAR(254) NOT NULL UNIQUE,
    telefone       VARCHAR(20),
    empresa        VARCHAR(200),
    cnpj_cpf       VARCHAR(18),
    status         VARCHAR(20)  NOT NULL DEFAULT 'ativo',
    data_cadastro  TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    observacoes    TEXT,

    CONSTRAINT cliente_status_check CHECK (
        status IN ('ativo', 'inativo', 'pendente', 'suspenso')
    )
);

CREATE TABLE concorrente (
    id             SERIAL       PRIMARY KEY,
    usuario_id     BIGINT       NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
    endereco_id    INTEGER      REFERENCES endereco(id) ON DELETE SET NULL,
    nome           VARCHAR(200) NOT NULL,
    email          VARCHAR(254),
    site           VARCHAR(200),
    cnpj           VARCHAR(18),
    data_cadastro  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_usuario_grupo       ON usuario(grupo_id);
CREATE INDEX idx_lead_usuario        ON lead(usuario_id);
CREATE INDEX idx_lead_email          ON lead(email);
CREATE INDEX idx_cliente_usuario     ON cliente(usuario_id);
CREATE INDEX idx_cliente_email       ON cliente(email);
CREATE INDEX idx_cliente_status      ON cliente(status);
CREATE INDEX idx_concorrente_usuario ON concorrente(usuario_id);
