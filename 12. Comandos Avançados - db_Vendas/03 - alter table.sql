/*

Comando SQL						O que faz
-----------                     ---------
EXEC sp_columns nome_tabela		Mostra a estrutura da tabela (colunas e tipos de dados)
ALTER TABLE ... ADD				Adiciona novas colunas à tabela
ALTER TABLE ... ALTER COLUMN	Altera o tipo de dado ou outras propriedades de uma coluna
ALTER TABLE ... DROP COLUMN		Remove uma coluna da tabela

Quando usar DEFAULT para COLUNA?
--------------------------------
1) Quer evitar valores nulos em uma coluna.
2) Deseja garantir um valor padrão para novos registros.
3) Torna o código de inserção mais simples.

*/

use db_Vendas

-- 1. Adição de novas colunas a uma tabela
-- Adiciona as colunas à tabela TB_CLIENTES 
ALTER TABLE TB_CLIENTES
ADD cpf VARCHAR(11) , 
	data_nascimento DATE ,
	total_pedidos MONEY,
	status_cliente VARCHAR(50) DEFAULT 'Ativo'


---------------------------------------------------------------------
-- 2. Alterar o tipo de dado de uma coluna existente
-- CPF para CHAR(11)

ALTER TABLE TB_CLIENTES
ALTER COLUMN CPF CHAR(11)
---------------------------------------------------------------------


-- 3. Atualizar valores NULL para uma data padrão (exemplo: '1900-01-01')
-- coluna: data_nascimento
UPDATE TB_CLIENTES
SET data_nascimento = '1900-01-01'
WHERE data_nascimento IS NULL

-- 4. Remoção (exclusão) de colunas de uma tabela
--------------------------------------------------
-- Remove a coluna 'cpf' da tabela TB_CLIENTES -- ALTERADO AQUI
ALTER TABLE TB_CLIENTES
DROP COLUMN cpf -- ALTERADO AQUI

-- Remove a coluna 'data_nascimento'
ALTER TABLE TB_CLIENTES
DROP COLUMN data_nascimento

















