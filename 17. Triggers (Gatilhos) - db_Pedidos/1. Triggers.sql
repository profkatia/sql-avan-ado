USE db_Pedidos
/*
O que é uma TRIGGER?
===================
Trigger (em português: gatilho) é um comando automático que é 
executado quando algo acontece em uma tabela, como:

	1) Um registro é inserido (INSERT),

	2) Um registro é atualizado (UPDATE),

	3) Um registro é deletado (DELETE).

Quando usar uma trigger?
========================
Você pode usar triggers para:

	1) Auditar dados (gravar quem alterou ou inseriu algo),

	2) Fazer validações extras (como impedir exclusões),

	3) Atualizar automaticamente outra tabela.

*/

/* 
Exemplo 1
=========
No exemplo a seguir, o objetivo é registrar em uma tabela 
de histórico de salários todas
as alterações de salário efetuadas na tabela TB_EMPREGADO. 
Devemos registrar o código do funcionário, a data da alteração, 
o salário antigo e o salário novo. 
Vejamos a criação da tabela de histórico de salários:
*/


-- 1. Crie a tabela
CREATE TABLE EMPREGADOS_HIST_SALARIO
(
	
	NUM_MOVTO INT IDENTITY,
	CODFUN INT,
	DATA_ALTERACAO DATETIME,
	SALARIO_ANTIGO MONEY,
	SALARIO_NOVO MONEY,
	CONSTRAINT PK_EMPREGADOS_HIST_SALARIO PRIMARY KEY(NUM_MOVTO)
)

----------------------------------------------------------------------------------------------
-- 2. Crie uma trigger para gravar histórico 
--    de alteração dos salários
CREATE TRIGGER TRG_EMPREGADOS_HIST_SALARIO
ON TB_EMPREGADO
FOR UPDATE
AS BEGIN
	
	-- VARIAVEIS
	DECLARE @CODFUN INT, @SALARIO_ANTIGO FLOAT,	@SALARIO_NOVO FLOAT

	-- LEITURA DO SALARIO ANTIGO DA TABELA VIRTUAL DELETED
	-- (ANTES DA ATUALIZAÇÃO)
	SELECT
		@SALARIO_ANTIGO = SALARIO
	FROM deleted

	-- LEITURA DO CÓDIGO DO FUNCIONÁRIO E O SALARIO NOVO
	-- DA TABELA VIRTUAL INSERTED(APÓS A ATUALIZAÇÃO)
	SELECT
		@CODFUN = CODFUN,
		@SALARIO_NOVO = SALARIO
	FROM inserted

	-- VERIFICA SE HOUVE MUDANÇA NO VALOR DO SALARIO
	IF @SALARIO_ANTIGO <> @SALARIO_NOVO
	BEGIN 

		-- SE O SALARIO MUDOU, INSERE UM REGISTRO NA TABELA
		-- DE HISTORICO DE SALARIOS
		INSERT INTO EMPREGADOS_HIST_SALARIO(
			CODFUN,
			DATA_ALTERACAO,
			SALARIO_ANTIGO,
			SALARIO_NOVO
		)
		VALUES(
			@CODFUN,
			GETDATE(),
			@SALARIO_ANTIGO,
			@SALARIO_NOVO
		)

	END

END 


----------------------------------------------------------------------------------------------
-- 3. Atualizar salário de um funcionário após criar a trigger
UPDATE TB_EMPREGADO
SET	SALARIO = SALARIO * 1.2
WHERE CODFUN = 3


-- 3.1 Verificar o histórico de alterações
SELECT
	TOP (100) *
FROM EMPREGADOS_HIST_SALARIO

----------------------------------------------------------------------------------------------
-- 4. Atualizar salário de vários funcionários (em lote)
--	  Ao realizarmos o procedimento a seguir, apenas a primeira 
--    linha das tabelas é lida, pois uma variável escalar não 
--    consegue armazenar mais de um valor ao mesmo tempo:
SELECT
	TOP (50) 
	CODFUN,
	NOME,
	SALARIO
FROM TB_EMPREGADO
WHERE CODFUN IN (4, 5, 7)

--4 = 600.00
--5 = 1200.00
--7 = 4500.00

UPDATE TB_EMPREGADO
SET SALARIO =  SALARIO * 1.2
WHERE CODFUN IN (4, 5, 7)

-- 4.1 Conferir se foram gerados os históricos para os 3 funcionários
SELECT
	TOP(100) *
FROM EMPREGADOS_HIST_SALARIO


----------------------------------------------------------------------------------------------
-- 5. A solução é utilizar um JOIN entre as tabelas DELETED e INSERTED, 
--    e substituir o INSERT...VALUES por INSERT...SELECT.
--    Vejamos o procedimento de alteração do trigger:
-- ESTA ALTRAÇÃO NA TRIGGER PERMITIRÁ REGISTRAR TODAS AS ALTERAÇÕES
-- EM MASSA NA TB_EMPREGADO
ALTER TRIGGER TRG_EMPREGADOS_HIST_SALARIO
ON TB_EMPREGADO
FOR UPDATE
AS BEGIN

	INSERT INTO EMPREGADOS_HIST_SALARIO (
		CODFUN,
		DATA_ALTERACAO,
		SALARIO_ANTIGO,
		SALARIO_NOVO
	)
	SELECT
		I.CODFUN,
		GETDATE(),
		D.SALARIO,
		I.SALARIO
	FROM 
		inserted I
	JOIN
		deleted D ON I.CODFUN = D.CODFUN
	WHERE I.SALARIO <> D.SALARIO

END

----------------------------------------------------------------------------------------------

-- 6. Apagar todos os registros: EMPREGADOS_HIST_SALARIO
DELETE FROM EMPREGADOS_HIST_SALARIO

----------------------------------------------------------------------------------------------
-- 7. Atualizar
UPDATE TB_EMPREGADO
SET SALARIO = SALARIO * 1.2
WHERE CODFUN IN (4, 5, 7)

-- 7.1 Ver o resutado
SELECT 
	TOP (15) *	
FROM EMPREGADOS_HIST_SALARIO












