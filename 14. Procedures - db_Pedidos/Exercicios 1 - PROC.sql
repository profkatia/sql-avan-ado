
-- 1️ — Procedure: Cadastrar Empregado

CREATE OR ALTER PROCEDURE SP_INSERIR_EMPREGADO
    @NOME VARCHAR(100),
    @NUM_DEPEND INT,
    @DATA_NASCIMENTO DATETIME,
    @COD_DEPTO INT,
    @COD_CARGO INT,
    @DATA_ADMISSAO DATETIME,
    @SALARIO MONEY,
    @PREMIO_MENSAL MONEY,
    @SINDICALIZADO VARCHAR(1),
    @OBS NVARCHAR(MAX),
    @FOTO VARBINARY(MAX),
    @COD_SUPERVISOR INT
AS
BEGIN
    INSERT INTO TB_EMPREGADO (
           NOME,
           NUM_DEPEND,
           DATA_NASCIMENTO,
           COD_DEPTO,
           COD_CARGO,
           DATA_ADMISSAO,
           SALARIO,
           PREMIO_MENSAL,
           SINDICALIZADO,
           OBS,
           FOTO,
           COD_SUPERVISOR
    )
    VALUES (
           @NOME,
           @NUM_DEPEND,
           @DATA_NASCIMENTO,
           @COD_DEPTO,
           @COD_CARGO,
           @DATA_ADMISSAO,
           @SALARIO,
           @PREMIO_MENSAL,
           @SINDICALIZADO,
           @OBS,
           @FOTO,
           @COD_SUPERVISOR
    )
    PRINT 'Empregado inserido com sucesso.'
END


---------------------- 1 - EXECUTAR PROC ---------------------------------------------
EXEC SP_INSERIR_EMPREGADO
    @NOME = 'CARLOS PEREIRA',
    @NUM_DEPEND = 3,
    @DATA_NASCIMENTO = '19880625',
    @COD_DEPTO = 2,
    @COD_CARGO = 4,
    @DATA_ADMISSAO = '20230915',
    @SALARIO = 4200.00,
    @PREMIO_MENSAL = 350.00,
    @SINDICALIZADO = 'S',
    @OBS = 'Empregado com ótimo desempenho',
    @FOTO = NULL,              
    @COD_SUPERVISOR = 1

-------------------------------------------------------------------------------------
-- 2 - Procedure: Atualizar Salário do Empregado
CREATE OR ALTER PROCEDURE SP_ATUALIZAR_SALARIO
    @CODFUN INT,
    @NOVOSALARIO MONEY
AS
BEGIN
    UPDATE TB_EMPREGADO
    SET Salario = @NOVOSALARIO
    WHERE CODFUN = @CODFUN

    PRINT 'Salário atualizado com sucesso.'
END
---------------------- 2 - EXECUTAR PROC ---------------------------------------------
EXEC SP_ATUALIZAR_SALARIO
    @CODFUN = 1,        -- código do funcionário que você quer atualizar
    @NOVOSALARIO = 5000.00  -- novo valor do salário



-------------------------------------------------------------------------------------
-- 3 — Procedure: Listar Fornecedores Por Estado
CREATE OR ALTER PROCEDURE SP_LISTAR_FORNECEDORES_Estado
    @ESTADO VARCHAR(50)
AS
BEGIN
    SELECT 
        COD_FORNECEDOR, 
        NOME, 
        CIDADE, 
        ESTADO, 
        CNPJ
    FROM TB_FORNECEDOR
    WHERE ESTADO = @ESTADO
    ORDER BY NOME
END
---------------------- 3 - EXECUTAR PROC ---------------------------------------------

EXEC SP_LISTAR_FORNECEDORES_Estado
    @ESTADO = 'SP'

-------------------------------------------------------------------------------------

-- 4 - Procedure: Inserir Departamento
CREATE OR ALTER PROCEDURE SP_INSERIR_DEPARTAMENTO
    @DEPTO VARCHAR(100)  -- nome do departamento
AS
BEGIN
    INSERT INTO TB_DEPARTAMENTO (DEPTO)
    VALUES (@DEPTO)

    PRINT 'Departamento inserido com sucesso.'
END
---------------------- 4 - EXECUTAR PROC ---------------------------------------------
EXEC SP_INSERIR_DEPARTAMENTO
    @DEPTO = 'MARKETING'


-------------------------------------------------------------------------------------
-- 5 - Procedure: Listar Produtos com QTDE MINIMA
CREATE OR ALTER PROCEDURE SP_LISTAR_PRODUTO_QTDE_MINIMA
    @Limite INT   -- quantidade mínima para filtrar
AS
BEGIN    
    SELECT 
        ID_Produto, 
        DESCRICAO, 
        PRECO_VENDA,
        QTD_MINIMA        
    FROM TB_PRODUTO
    WHERE QTD_MINIMA <= @Limite  -- filtra produtos abaixo do limite
    ORDER BY QTD_MINIMA ASC
END

---------------------- 5 - EXECUTAR PROC ---------------------------------------------
EXEC SP_LISTAR_PRODUTO_QTDE_MINIMA
    @Limite = 189


-------------------------------------------------------------------------------------
-- 6️ — Procedure: Registrar Pedido
CREATE OR ALTER PROCEDURE SP_INSERIR_PEDIDO
    @CODCLI INT,
    @CODVEN INT,
    @DATA_EMISSAO DATETIME,
    @VLR_TOTAL MONEY,
    @SITUACAO VARCHAR(1),
    @OBSERVACOES NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO TB_PEDIDO (
            CODCLI
           ,CODVEN
           ,DATA_EMISSAO
           ,VLR_TOTAL
           ,SITUACAO
           ,OBSERVACOES)
    VALUES (@CODCLI, @CODVEN, @DATA_EMISSAO, @VLR_TOTAL,@SITUACAO, @OBSERVACOES)

    PRINT 'Pedido registrado com sucesso.'
END

---------------------- 6 - EXECUTAR PROC ---------------------------------------------
EXEC SP_INSERIR_PEDIDO
    @CODCLI = 101,                        -- código do cliente
    @CODVEN = 5,                          -- código do vendedor
    @DATA_EMISSAO = '20251025',         -- data do pedido (AAAA-MM-DD)
    @VLR_TOTAL = 1500.50,                 -- valor total do pedido
    @SITUACAO = 'A',                      -- situação: A = Aberto
    @OBSERVACOES = 'Pedido com entrega rápida'  -- observações



-------------------------------------------------------------------------------------
-- 7️ — Procedure: Total de Vendas por Vendedor
CREATE OR ALTER PROCEDURE SP_TOTAL_VENDAS_VENDEDOR
AS
BEGIN
    SELECT 
        V.NOME,
        FORMAT(SUM(P.VLR_TOTAL), 'C', 'PT-BR') AS TotalVendas
    FROM TB_VENDEDOR V
            INNER JOIN TB_PEDIDO P 
                ON V.CODVEN = P.CODVEN
    GROUP BY V.NOME
    ORDER BY TotalVendas DESC
END

---------------------- 7 - EXECUTAR PROC ---------------------------------------------
EXEC SP_TOTAL_VENDAS_VENDEDOR


-------------------------------------------------------------------------------------
-- 8 - Predure: Listar Fornecedores Inteligente
CREATE OR ALTER PROCEDURE SP_LISTAR_FORNECEDORES_INTELIGENTE
    @ESTADO VARCHAR(50) = NULL,  -- filtrar por estado, se desejar
    @TOP INT = 10                -- quantos registros retornar
AS
BEGIN
    SELECT TOP (@TOP)
          COD_FORNECEDOR
        , NOME
        , NOME_FANTASIA
        , FISICA_JURIDICA
        , COD_PAIS
        , CPF
        , CNPJ
        , INSC_ESTADUAL
        , ENDERECO
        , CEP
        , BAIRRO
        , CIDADE
        , ESTADO
        , FONE1
        , FONE2
        , FAX
        , E_MAIL
        , WEB_SITE
        , SN_ATIVO
    FROM TB_FORNECEDOR
    WHERE (@ESTADO IS NULL OR ESTADO = @ESTADO)
    ORDER BY NOME
END

EXEC SP_LISTAR_FORNECEDORES_INTELIGENTE
    @ESTADO = 'SP',
    @TOP = 1000

EXEC SP_LISTAR_FORNECEDORES_INTELIGENTE
    @ESTADO = 'MG',
    @TOP = 1000  -- ou qualquer número grande que cubra todos



