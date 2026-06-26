/* Cadastro de novo lead */
INSERT INTO lead (usuario_id, nome, email, telefone, origem, observacoes)
VALUES (1, 'Shadow Shock', 'shadowshock@elysee.fr', '+33144181818', 'indicacao', 'Presidente da França');

/* Listagem de leads com o usuário responsável */
SELECT
    l.id,
    l.nome       AS lead_nome,
    l.email,
    l.origem,
    u.nome       AS responsavel
FROM lead l
JOIN usuario u ON l.usuario_id = u.id
ORDER BY l.id DESC;

/* Contagem de leads por origem */
SELECT
    origem,
    COUNT(*) AS total_leads
FROM lead
GROUP BY origem
ORDER BY total_leads DESC;

/* Usuários com mais de 2 leads cadastrados */
SELECT
    u.id,
    u.nome          AS usuario,
    COUNT(l.id)     AS total_leads
FROM usuario u
JOIN lead l ON l.usuario_id = u.id
GROUP BY u.id, u.nome
HAVING COUNT(l.id) > 2
ORDER BY total_leads DESC;

/* Leads cujo email já consta como cliente (subconsulta) */
SELECT
    l.nome,
    l.email,
    l.origem
FROM lead l
WHERE l.email IN (SELECT email FROM cliente)
ORDER BY l.nome;

/* Distribuição percentual de clientes por status (ativo, inativo, pendente, suspenso) */
SELECT
    status,
    COUNT(*)                                                AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2)    AS percentual
FROM cliente
GROUP BY status
ORDER BY total DESC;

/* Concorrentes com endereço cadastrado, com dados do responsável */
SELECT
    c.nome       AS concorrente,
    c.site,
    e.logradouro,
    e.cidade,
    e.estado,
    u.nome       AS cadastrado_por
FROM concorrente c
JOIN endereco e  ON e.id = c.endereco_id
JOIN usuario u   ON u.id = c.usuario_id
ORDER BY c.nome;

/* Atualização do status de um lead */
UPDATE lead
SET status = 'contatado'
WHERE nome = 'Data' AND status = 'novo';

/* Remoção de leads perdidos */
DELETE FROM lead
WHERE status = 'perdido';

/* Funil de vendas: leads agrupados por etapa */
SELECT
    status,
    COUNT(*)              AS total,
    ROUND(AVG(pontuacao)) AS pontuacao_media
FROM lead
GROUP BY status
ORDER BY total DESC;

/* Leads com pontuação acima da média geral */
SELECT
    l.nome,
    l.empresa,
    l.status,
    l.pontuacao,
    u.nome  AS responsavel
FROM lead l
JOIN usuario u ON u.id = l.usuario_id
WHERE l.pontuacao > (SELECT AVG(pontuacao) FROM lead)
ORDER BY l.pontuacao DESC;

/* Todos os leads com endereço quando disponível (LEFT JOIN) */
SELECT
    l.nome,
    l.status,
    e.logradouro,
    e.cidade
FROM lead l
LEFT JOIN endereco e ON e.id = l.endereco_id
ORDER BY l.nome;

/* Usuários e seus grupos */
SELECT
    u.nome      AS usuario,
    g.nome      AS grupo
FROM usuario u
JOIN grupo g ON g.id = u.grupo_id
ORDER BY g.nome, u.nome;

/* Clientes por usuário responsável */
SELECT
    u.nome          AS responsavel,
    COUNT(c.id)     AS total_clientes
FROM usuario u
JOIN cliente c ON c.usuario_id = u.id
GROUP BY u.id, u.nome
ORDER BY total_clientes DESC;

/* Empresas com mais de um lead cadastrado */
SELECT
    empresa,
    COUNT(*)    AS total_leads,
    MAX(pontuacao) AS maior_pontuacao
FROM lead
WHERE empresa IS NOT NULL
GROUP BY empresa
HAVING COUNT(*) > 1
ORDER BY total_leads DESC;
