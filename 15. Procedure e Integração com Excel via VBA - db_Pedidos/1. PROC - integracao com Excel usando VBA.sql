-- Criação da procedure
use db_Pedidos

-- 1 - Crie a tabela: TB_RELATORIO_VENDAS
CREATE TABLE TB_RELATORIO_VENDAS
(
	cliente_id int NULL,
	nome_cliente varchar(100) NULL,
	produto_id int NULL,
	nome_produto varchar(100) NULL,
	total_gasto money NULL
) 

---------------------------------------------------------------------

-- 1o CRIE A PROCEDURE QUE SERÁ CHAMADA/EXECUTADA PELO EXCEL(VBA)
-- 2o CRIE O EXCEL COM VBA PARA CHAMAR A PROCEDURE
CREATE PROCEDURE SP_INSERIR_RELATORIO_VENDAS
	@CLIENTE_ID INT,
	@NOME_CLIENTE VARCHAR(50),
	@PRODUTO_ID INT,
	@NOME_PRODUTO VARCHAR(100),
	@TOTAL_GASTO MONEY
AS 
BEGIN
	INSERT INTO TB_RELATORIO_VENDAS(
		cliente_id,
		nome_cliente,
		produto_id,
		nome_produto,
		total_gasto
	)
	VALUES(
		@CLIENTE_ID,
		@NOME_CLIENTE,
		@PRODUTO_ID,
		@NOME_PRODUTO,
		@TOTAL_GASTO
	)
END






















