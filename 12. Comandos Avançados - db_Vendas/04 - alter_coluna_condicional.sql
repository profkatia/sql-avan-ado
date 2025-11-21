-- Exemplo de alteração de tipo de dado condicional.
-- Neste exemplo, vamos alterar o tipo da coluna 
-- 'nome_cliente' de VARCHAR(100) para VARCHAR(150), 
-- mas apenas se a coluna não houver dados.

-- Passo 1: Verificar se a coluna 'nome_cliente' contém dados.
-- Vamos contar quantos registros possuem valores na coluna 'nome_cliente'.
DECLARE @num_dados INT

-- Contando os registros onde a coluna 'nome_cliente' não é NULL.
SELECT @num_dados = COUNT(*)
FROM TB_CLIENTES
WHERE nome_cliente IS NOT NULL

PRINT @num_dados

-- Passo 2: Condicionalmente alterar o tipo de dado da 
-- coluna 'nome_cliente' se não houver dados.
-- Obs.: professor para dar certo mude para: IF @num_dados >= 0
IF @num_dados = 0
	BEGIN
		-- Alterando o tipo da coluna 'nome_cliente' CHAR(15), caso a coluna esteja vazia.
		ALTER TABLE TB_CLIENTES
		ALTER COLUMN nome_cliente VARCHAR(150)

		PRINT 'Tipo de dado alterado para CHAR(15).'
	END
ELSE
	BEGIN
		PRINT 'A coluna contém dados e não pode ser alterada para o novo tipo.'
	END



-- 3. Verificando se a alteração foi realizada com sucesso.
-- Verificando a estrutura da tabela 'clientes' após a tentativa de alteração de tipo.
EXEC sp_columns 'TB_CLIENTES'

-- 4. Caso você queira verificar se a alteração foi aplicada, use o comando SELECT abaixo:
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TB_CLIENTES'



