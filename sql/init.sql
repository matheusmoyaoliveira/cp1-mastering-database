CREATE TABLE TB_HEROIS (
    id_heroi NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(50),
    classe VARCHAR2(20),
    hp_atual NUMBER,
    hp_max NUMBER,
    status VARCHAR2(20) DEFAULT 'ATIVO'
);

INSERT INTO TB_HEROIS (nome, classe, hp_atual, hp_max)
VALUES ('Artorias', 'GUERREIRO', 150, 150);

INSERT INTO TB_HEROIS (nome, classe, hp_atual, hp_max)
VALUES ('Sif', 'LADRÃO', 100, 100);

INSERT INTO TB_HEROIS (nome, classe, hp_atual, hp_max)
VALUES ('Gwyn', 'MAGO', 80, 80);

COMMIT;