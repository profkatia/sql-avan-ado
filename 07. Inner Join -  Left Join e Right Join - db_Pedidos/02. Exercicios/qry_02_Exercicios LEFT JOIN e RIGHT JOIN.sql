use db_Pedidos


-- ===================== Exercícios ======================================

/*
1)  TB_DEPARTAMENTO x TB_EMPREGADO 
                     === right ===

pede-se: 

a) localize se existem empregados que não tenham departamentos

b) ordenado pelo: departamento

c) Retornar as colunas: DEPTO, NOME, SINDICALIZADO

*/
-- 3 registros
select
	DEPARTAMENTO.DEPTO,
	EMPREGADO.NOME,
	EMPREGADO.SINDICALIZADO
from TB_DEPARTAMENTO as DEPARTAMENTO
	 right join
	 TB_EMPREGADO as EMPREGADO 	 
	 on EMPREGADO.COD_DEPTO = DEPARTAMENTO.COD_DEPTO
Where DEPARTAMENTO.DEPTO is null
order by DEPARTAMENTO.DEPTO

-----------------------------------------------------------------------------------
/*
2)  TB_DEPARTAMENTO x TB_EMPREGADO
    === left ===

pede-se: 

a) localize se, existem departamentos que não 
tenham empregados relacionados

b) ordenado por: NOME

c) Retornar as colunas: DEPTO, NOME, SINDICALIZADO
*/
-- 2 registros
select 
	DEPARTAMENTO.DEPTO,
	EMPREGADO.NOME,
	EMPREGADO.SINDICALIZADO
from TB_DEPARTAMENTO as DEPARTAMENTO
	 left join TB_EMPREGADO as EMPREGADO
	 on DEPARTAMENTO.COD_DEPTO = EMPREGADO.COD_DEPTO
Where EMPREGADO.NOME is null
order by EMPREGADO.NOME


-----------------------------------------------------------------------------------
/* 3) TB_PRODUTO x TB_ITENSPEDIDO
      == left ==

pede-se:	

a) listar todos os produtos que foram e nao foram vendidos 
com seu respectivo numero de pedido(vendido)

b) onde o desconto for maior do dez

c) ordenado pelo codigo do produto

d) retornar as colunas: COD_PRODUTO, DESCRICAO, PR_UNITARIO, 
DESCONTO, QUANTIDADE

e) multiplique as colunas: PR_UNITARIO * QUANTIDADE e 
mostre apelido [TOTAL]

f) para as colunas de valores formate para contábil: 'R$ ###,##0.00'

*/
-- 95 registros
Select	
	P.COD_PRODUTO,
	P.DESCRICAO,
	format(I.PR_UNITARIO, 'R$ ###,##0.00') as [PRECO UNITARIO],
	I.DESCONTO,
	I.QUANTIDADE,
	format((I.PR_UNITARIO * I.QUANTIDADE), 'R$ ###,##0.00' ) as TOTAL -- cálculo
From TB_PRODUTO as P 
     Left join TB_ITENSPEDIDO as I
	 on P.ID_PRODUTO = I.ID_PRODUTO
Where i.DESCONTO > 10
Order by P.COD_PRODUTO

-----------------------------------------------------------------------------------
-- 4) de todos os pedidos cadastrados existe algum cliente 
-- que não finalizou a compra
-- 11.323 registros
Select
	PEDIDO.CODCLI,
	PEDIDO.VLR_TOTAL,
	CLIENTE.NOME,
	CLIENTE.ESTADO
From TB_PEDIDO as PEDIDO 
	 right join TB_CLIENTE as CLIENTE
	 on PEDIDO.CODCLI = CLIENTE.CODCLI
--From TB_CLIENTE as CLIENTE
--	left join TB_PEDIDO as PEDIDO 	
--	 on CLIENTE.CODCLI  = PEDIDO.CODCLI
Order by PEDIDO.CODCLI 
