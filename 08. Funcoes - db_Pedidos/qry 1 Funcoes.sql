
use db_Pedidos


set language brazilian

--1) funções + agrupamentos
-- retornar o resumo 
-- TB_EMPREGADO

--a) retorne:  COD_DEPTO, SALARIO
--b) conte a qtde de colaboradores
--c) localize o maior salário
--d) localize o menor salário
--e) faça a soma salarial
--f) faça a média salarial
Select 
	COD_DEPTO,
	SALARIO
From TB_EMPREGADO
Order By COD_DEPTO

Select
	COD_DEPTO,
	COUNT(CODFUN) as QTD_DE_FUNCIONÁRIOS,
	MAX(SALARIO) as MAIOR_SALÁRIO,
	MIN(SALARIO) as MENOR_SALÁRIO,
	SUM(SALARIO) as SOMA_SALÁRIOS,
	AVG(SALARIO) as MÉDIA_SALARIOS
From TB_EMPREGADO
Group by COD_DEPTO

------------------------------------------------------------------------------
--2) 
-- localize: colaboradores sem CARGO
-- TB_EMPREGADO x TB_CARGO
select 
	EMPREGADO.NOME,
	CARGO.CARGO
from TB_EMPREGADO EMPREGADO
	 LEFT JOIN TB_CARGO CARGO
		on EMPREGADO.COD_CARGO = CARGO.COD_CARGO
order by CARGO.CARGO

------------------------------------------------------------------------------

-- 3) listar os clientes que compraram totalizando a quantidade comprada
-- e a quantidade de produtos comprados, ordenando por nome do cliente
-- campos a retornar: NOME, FONE1, QUANTIDADE, NUM_PEDIDO
-- TB_CLIENTE x TB_PEDIDO x TB_ITENSPEDIDO  
-- JOIN
-- some a quantidade
-- conte a quantidade de pedidos
-- faça o agrupamento correto
-- classifique do maior para o menor e identifique,
-- qual cliente fez mais pedidos
-- =============================================================================
SELECT 
	CLI.NOME,
	CLI.FONE1 as TELEFONE,
	SUM(ITENSPED.QUANTIDADE) as QTDE,
	COUNT(PED.NUM_PEDIDO) as QTDE_PEDIDOS
FROM TB_CLIENTE CLI 
	JOIN  TB_PEDIDO as PED
		ON CLI.CODCLI = PED.CODCLI 
	JOIN TB_ITENSPEDIDO as ITENSPED
		ON ITENSPED.NUM_PEDIDO = PED.NUM_PEDIDO
GROUP BY CLI.NOME, CLI.FONE1
ORDER BY QTDE_PEDIDOS desc

------------------------------------------------------------------------------
--4) listar todos os produtos vendidos, apresentando: 
-- nome do produto, qtdade de pedidos efetivados por produto,
--  nomes dos vendedores que venderam, o preço medio de venda
--  a última data vendida(pedido),qtdade total vendida
-- TB_PRODUTO x TB_ITENSPEDIDO x TB_PEDIDO x TB_VENDEDOR
-- classifique do maior para o menor coluna qtde pedidos
SELECT 
	PROD.DESCRICAO PRODUTO,	
	COUNT(P.NUM_PEDIDO) QTDADE_PEDIDOS,
	VENDEDOR.NOME VENDEDOR,
	AVG(ITENS.PR_UNITARIO)  PREÇO_MÉDIO,
	MAX(P.DATA_EMISSAO) ÚLTIMA_DATA,
	format(SUM(ITENS.QUANTIDADE) , 'N0' )  QUANTIDADE_VENDIDA                                       
FROM TB_PRODUTO PROD 
	JOIN TB_ITENSPEDIDO as ITENS
		ON   PROD.ID_PRODUTO = ITENS.ID_PRODUTO 
	JOIN TB_PEDIDO as P 
		ON P.NUM_PEDIDO = ITENS.NUM_PEDIDO
	JOIN TB_VENDEDOR VENDEDOR 
		ON VENDEDOR.CODVEN = P.CODVEN
GROUP BY PROD.DESCRICAO, VENDEDOR.NOME 
ORDER BY QTDADE_PEDIDOS desc











