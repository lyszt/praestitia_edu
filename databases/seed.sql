INSERT INTO permissao (id) VALUES (1), (2);

INSERT INTO grupo (nome) VALUES ('admin'), ('vendedor');

INSERT INTO grupo_permissao VALUES (1, 1), (1, 2), (2, 1);

INSERT INTO usuario (nome, grupo_id) VALUES
    ('Shadow Shock', 1),
    ('Jean-Luc Picard', 2),
    ('Deanna Troi', 2);

INSERT INTO endereco (cep, numero, logradouro, bairro, cidade, estado) VALUES
    ('01310-100', '1701', 'Av. Paulista',   'Bela Vista', 'São Paulo',      'SP'),
    ('20040-020', '74656', 'Av. Rio Branco','Centro',     'Rio de Janeiro', 'RJ');

INSERT INTO lead (usuario_id, endereco_id, nome, email, telefone, empresa, origem, status, pontuacao) VALUES
    (1, 1, 'William Riker',    'riker@starfleet.fed',   '+1800ENTERPRISE', 'Starfleet Command', 'indicacao',    'convertido',    90),
    (1, 1, 'Geordi La Forge',  'laforge@enterprise.fed', NULL,             'Engineering Div',   'site',         'qualificado',   75),
    (2, 2, 'Worf Son of Mogh', 'worf@kronos.kli',        NULL,             'House of Martok',   'site',         'em_negociacao', 60),
    (2, 1, 'Data',             'data@enterprise.fed',    NULL,             'Starfleet R&D',     'email',        'novo',          40),
    (3, NULL,'Q',              'q@continuum.uni',         NULL,             'Q Continuum',       'redes_sociais','perdido',        5);

INSERT INTO cliente (usuario_id, endereco_id, nome, email, empresa, status) VALUES
    (1, 1, 'William Riker',   'riker@starfleet.fed',    'Starfleet Command', 'ativo'),
    (1, 1, 'Geordi La Forge', 'laforge@enterprise.fed', 'Engineering Div',   'ativo'),
    (2, 2, 'Beverly Crusher', 'crusher@sickbay.fed',    'Starfleet Medical', 'pendente');

INSERT INTO concorrente (usuario_id, endereco_id, nome, site, cnpj) VALUES
    (1, 2, 'Borg Collective', 'borg.uni',        '00.000.001/0001-00'),
    (1, 2, 'Romulan Empire',  'romulus.rom.emp', NULL);
