--ATUALIZAR A BASE DE DADOS
use db_Pedidos

set language brazilian

/*1) alterar 1 linha no bco de dados
	Update = atualizar
	TB_EMPREGADO = nome da tabela
	SET SALARIO(coluna) = exige indicar o nome da coluna a ser atualizada
	Where = *** é obrigatório ter no Update ***,
	para indicar o registro a ser atualizado
*/

-- 1) atualize a TB_EMPREGADO coluna SALARIO para 3900,
-- somente para CODFUN = 1
-- visualizar o registro antes de ser alterado
-- lembre-se: primeiro faça o SELECT e depois UPDATE
select 
	CODFUN as CÓDIGO, 
	NOME as [NOME FUNCIONÁRIO], 
	format(SALARIO,'C', 'PT-BR') as  [SALÁRIO],
	format(DATA_ADMISSAO,'dd/MM/yyyy') as [DT ADMISSÃO]
from TB_EMPREGADO
where CODFUN = 1

-- SEU UPDATE ---- AQUI ----
UPDATE TB_EMPREGADO -- indicar a tabela
SET SALARIO = 3900 -- indicar o(s) campo(s)
WHERE CODFUN = 1  -- obrigatoriamente colocar WHERE com o critério


----------------------------------------------------------------------------------------------------

-- 2) TB_PRODUTO 
-- REAJUSTAR O PRECO_VENDA EM 20%
select 
	DESCRICAO,
	PRECO_CUSTO,
	PRECO_VENDA
from TB_PRODUTO
order by PRECO_VENDA desc

-- SEU UPDATE ---- AQUI ----
UPDATE TB_PRODUTO
SET	PRECO_VENDA = PRECO_VENDA * 1.2

----------------------------------------------------------------------------------------------------
-- 3) TB_PRODUTO
-- REAJUSTAR O PRECO_CUSTO EM 30% 
-- REAJUSTAR O PRECO_VENDA EM 45%
-- SOMENTE PARA O PRODUTO = 'AGENDA DE MESA'
select
	DESCRICAO,
	PRECO_CUSTO,
	PRECO_VENDA
from TB_PRODUTO
where DESCRICAO = 'AGENDA DE MESA'

-- SEU UPDATE ---- AQUI ----
UPDATE TB_PRODUTO
SET PRECO_CUSTO = PRECO_CUSTO*1.3,
	PRECO_VENDA = PRECO_VENDA*1.45
WHERE DESCRICAO = 'AGENDA DE MESA'
----------------------------------------------------------------------------------------------------
-- 4) AUMENTAR O VALOR DOS PEDIDOS DE SP EM 15%
-- antes de atualizar visualize os registros 
select 
	CLIENTE.CIDADE,
	CLIENTE.ESTADO,
	PEDIDO.VLR_TOTAL
from TB_PEDIDO PEDIDO
	 JOIN TB_CLIENTE CLIENTE
	on CLIENTE.CODCLI = PEDIDO.CODCLI  
where CLIENTE.ESTADO='SP'

-- SEU UPDATE ---- AQUI ----
UPDATE PEDIDO
SET PEDIDO.VLR_TOTAL = PEDIDO.VLR_TOTAL * 1.15
FROM TB_PEDIDO PEDIDO 
     JOIN TB_CLIENTE CLIENTE
		ON PEDIDO.CODCLI = CLIENTE.CODCLI
WHERE CLIENTE.ESTADO = 'SP'

