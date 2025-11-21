use db_Pedidos
set language brazilian

-- 1) TB_DEPARTAMENTO x TB_EMPREGADO
--    === left ===

-- retornar TB_DEPARTAMENTO = COD_DEPTO, DEPTO
-- retornar TB_EMPREGADO = NOME
-- Faça análise: Quais departamentos estão sem empregados ?

select 
		DEPARTAMENTO.COD_DEPTO,
		DEPARTAMENTO.DEPTO,
		EMPREGADO.NOME,
		format(EMPREGADO.SALARIO, 'C', 'PT-BR') As SALÁRIO
from TB_DEPARTAMENTO DEPARTAMENTO 
	 left join TB_EMPREGADO EMPREGADO
			on DEPARTAMENTO.COD_DEPTO = EMPREGADO.COD_DEPTO
order by EMPREGADO.NOME
---------------------------------------------------------------------------------

/* 2) 	  
-- Faça análise:
Quais clientes fizeram pedidos ?
OBS.: o CLIENTE 'BBBB' foi cadastrador porém houve erro no sistema ao registrar
no banco de dados
*/
select	
	cliente.NOME,
	ped.NUM_PEDIDO,
	prod.DESCRICAO,
	itens.QUANTIDADE,
	itens.PR_UNITARIO,
	ped.VLR_TOTAL			
from TB_CLIENTE cliente
		left join TB_PEDIDO ped
			on cliente.CODCLI = ped.CODCLI
		left join TB_ITENSPEDIDO itens
			on itens.NUM_PEDIDO = ped.NUM_PEDIDO
		left join TB_PRODUTO prod
			on prod.ID_PRODUTO = itens.ID_PRODUTO
order by ped.NUM_PEDIDO
---------------------------------------------------------------------------------

/* 3) 
-- TB_DEPARTAMENTO x TB_EMPREGADO
--                  === right ===

faça análise: Quais empregados estão sem departamentos ?
-- retorne: NOME, DEPTO
*/
select 
	EMPREGADO.NOME, 
	DEPARTAMENTO.DEPTO
from
	TB_DEPARTAMENTO DEPARTAMENTO 
		right outer join TB_EMPREGADO EMPREGADO
			on EMPREGADO.COD_DEPTO = DEPARTAMENTO.COD_DEPTO
order by DEPARTAMENTO.DEPTO

