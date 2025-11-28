-- Exercício 1 – Atualizar um campo com base na UF

-- Pede-se:
-- 1) crie uma coluna com nome REGIAO na TB_FORNECEDOR 

-- 2) O que o aluno deve usar:
-- Variável de controle de ID

-- WHILE

-- SELECT...INTO ou UPDATE dentro do loop

-- IF...ELSE para verificar a UF

-- QUANDO O ESTADO FOR:
-- SP, RJ, MG, ES = SUDESTE
-- SUL	RS, PR, SC = SUL
-- PE = NORDESTE
-- (qualquer outro estado) = OUTROS
-- Declara as variáveis de controle
DECLARE @id INT;
DECLARE @max_id INT;
DECLARE @uf NVARCHAR(2);

-- Inicializa @id com o menor COD_FORNECEDOR
SELECT @id = MIN(COD_FORNECEDOR) FROM TB_FORNECEDOR;

-- Inicializa @max_id com o maior COD_FORNECEDOR
SELECT @max_id = MAX(COD_FORNECEDOR) FROM TB_FORNECEDOR;

-- Loop para percorrer todos os fornecedores
WHILE @id IS NOT NULL AND @id <= @max_id
BEGIN
    -- Pega o UF do fornecedor atual
    SELECT @uf = UF
    FROM TB_FORNECEDOR
    WHERE COD_FORNECEDOR = @id;

    -- Atualiza a coluna REGIAO conforme o UF
    IF @uf IN ('SP', 'RJ', 'MG', 'ES')
    BEGIN
        UPDATE TB_FORNECEDOR
        SET REGIAO = 'SUDESTE'
        WHERE COD_FORNECEDOR = @id;
    END
    ELSE IF @uf IN ('RS', 'PR', 'SC')
    BEGIN
        UPDATE TB_FORNECEDOR
        SET REGIAO = 'SUL'
        WHERE COD_FORNECEDOR = @id;
    END
    ELSE IF @uf = 'PE'
    BEGIN
        UPDATE TB_FORNECEDOR
        SET REGIAO = 'NORDESTE'
        WHERE COD_FORNECEDOR = @id;
    END
    ELSE
    BEGIN
        UPDATE TB_FORNECEDOR
        SET REGIAO = 'OUTROS'
        WHERE COD_FORNECEDOR = @id;
    END

    -- Avança para o próximo COD_FORNECEDOR
    SELECT @id = MIN(COD_FORNECEDOR)
    FROM TB_FORNECEDOR
    WHERE COD_FORNECEDOR > @id;
END

-- Opcional: mostra a quantidade de fornecedores por região atualizada
SELECT REGIAO, COUNT(*) AS QTDE_FORNECEDORES
FROM TB_FORNECEDOR
GROUP BY REGIAO
ORDER BY REGIAO;





























