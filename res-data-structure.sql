


CREATE TABLE IF NOT EXISTS "disciplina" (
    id BIGSERIAL CONSTRAINT pk_disciplina PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS "professor" (
    id BIGSERIAL CONSTRAINT pk_professor PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);


CREATE TABLE IF NOT EXISTS "aluno" (
    id BIGSERIAL CONSTRAINT pk_aluno PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);


CREATE TABLE IF NOT EXISTS "turma" (
    id BIGSERIAL CONSTRAINT pk_turma PRIMARY KEY,
    dia_da_semana INT NOT NULL,
    horario VARCHAR(45) NOT NULL,
    disciplina_id INT NOT NULL,
    professor_id INT NOT NULL,
    CONSTRAINT fk_turma_disciplina FOREIGN KEY (disciplina_id) REFERENCES disciplina(id),
    CONSTRAINT fk_turma_professor FOREIGN KEY (professor_id) REFERENCES professor(id)
);

CREATE TABLE IF NOT EXISTS "aluno_turma" (
    id BIGSERIAL CONSTRAINT pk_aluno_turma PRIMARY KEY,
    aluno_id INT NOT NULL,
    turma_id INT NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES aluno(id),
    FOREIGN KEY (turma_id) REFERENCES turma(id)
);


INSERT INTO
    aluno(nome)
VALUES 
    ('CARLOS'),
    ('MARIA'),
    ('FELIPE'),
    ('JOANA'),
    ('RENATO'),
    ('CAMILA'),
    ('BRUNO');

INSERT INTO 
    disciplina(nome)
VALUES
    ('MATEMATICA'),
    ('FISICA'),
    ('QUIMICA'),
    ('PORTUGUES'),
    ('HISTORIA');

INSERT INTO
    professor(nome)
VALUES
    ('JOAO PEDRO'),
    ('MARIA CRISTINA'),
    ('LUCAS'),
    ('AMANDA'),
    ('FERNANDO');


INSERT INTO 
    turma(dia_da_semana, horario, disciplina_id, professor_id)
VALUES
    (2, '9h', 1, 1), --mat joao pedro
    (2, '11h', 2, 1), --fis joao pedro
    (3,'9h', 1, 1), --mat joao pedro
    (3, '14h', 3, 2), --qui maria cristina
    (4, '16h', 3, 1); --qui joao pedro


INSERT INTO 
    aluno_turma(aluno_id, turma_id)
VALUES
    (1,1), -- carlos, maria, felipe, joana - turma mat joao pedro
    (2,1),
    (3,1),
    (4,1),
    (1,2), -- carlos maria - turma fis joao pedro
    (2,2),
    (4,4), -- joana renato - turma qui maria cristina
    (5,4); 



-- Buscar os nomes de todos os alunos que frequentam alguma turma do professor 'JOAO PEDRO'.
SELECT
    DISTINCT aluno.nome
FROM
    turma
    LEFT JOIN professor
        ON turma.professor_id=professor.id
    LEFT JOIN aluno_turma
        ON aluno_turma.turma_id=turma.id
    INNER JOIN aluno
        ON aluno.id=aluno_turma.aluno_id
WHERE 
    professor.nome LIKE 'JOAO PEDRO';
    


-- Buscar os dias da semana que tenham aulas da disciplina 'MATEMATICA'.
SELECT 
    DISTINCT dia_da_semana
FROM
    turma
    INNER JOIN disciplina
        ON disciplina.id=turma.disciplina_id
WHERE 
    disciplina.nome LIKE 'MATEMATICA';



-- Buscar todos os alunos que frequentem aulas de 'MATEMATICA' e também 'FISICA'.
SELECT
    DISTINCT aluno.nome
FROM
    turma
    LEFT JOIN disciplina
        ON disciplina.id=turma.disciplina_id
    LEFT JOIN aluno_turma
        ON aluno_turma.turma_id=turma.id
    INNER JOIN aluno
        ON aluno.id=aluno_turma.aluno_id
WHERE 
    disciplina.nome LIKE 'MATEMATICA'
INTERSECT
SELECT
    DISTINCT aluno.nome
FROM
    turma
    LEFT JOIN disciplina
        ON disciplina.id=turma.disciplina_id
    LEFT JOIN aluno_turma
        ON aluno_turma.turma_id=turma.id
    INNER JOIN aluno
        ON aluno.id=aluno_turma.aluno_id
WHERE 
    disciplina.nome LIKE 'FISICA';


-- Buscar as disciplinas que não tenham nenhuma turma.
SELECT 
    disciplina.id, nome
FROM
    disciplina
    LEFT JOIN turma
    ON turma.disciplina_id=disciplina.id
    WHERE disciplina_id IS NULL;



-- Buscar os alunos que frequentem aulas de 'MATEMATICA' exceto os que frequentem 'QUIMICA'.
SELECT
    DISTINCT aluno.nome
FROM
    turma
    LEFT JOIN disciplina
        ON disciplina.id=turma.disciplina_id
    LEFT JOIN aluno_turma
        ON aluno_turma.turma_id=turma.id
    INNER JOIN aluno
        ON aluno.id=aluno_turma.aluno_id
WHERE 
    disciplina.nome LIKE 'MATEMATICA'
EXCEPT
SELECT
    aluno.nome
FROM
    turma
    LEFT JOIN disciplina
        ON disciplina.id=turma.disciplina_id
    LEFT JOIN aluno_turma
        ON aluno_turma.turma_id=turma.id
    INNER JOIN aluno
        ON aluno.id=aluno_turma.aluno_id
WHERE 
    disciplina.nome LIKE 'QUIMICA';