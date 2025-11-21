use db_Pedidos


set language brazilian;

-- EXERCICIO

-- 1) relacionar: TB_CLIENTE x TB_PEDIDO
-- retornar TB_CLIENTE: CODCLI, NOME, BAIRRO
-- retornar TB_PEDIDO: NUM_PEDIDO, VLR_TOTAL
-- onde VLR_TOTAL for maior do que três mil reais
-- classificado do maior para menor coluna VLR_TOTAL
-- 4002 registros
select 
	CLIENTE.CODCLI,
	CLIENTE.NOME,
	PEDIDO.NUM_PEDIDO,
	PEDIDO.VLR_TOTAL, 
	CLIENTE.BAIRRO
from TB_CLIENTE CLIENTE 
	join TB_PEDIDO PEDIDO
		on CLIENTE.CODCLI = PEDIDO.CODCLI
where PEDIDO.VLR_TOTAL > 3000
order by PEDIDO.VLR_TOTAL desc

-- 2) relacionar: TB_CLIENTE x TB_PEDIDO x TB_VENDEDOR
-- retornar TB_CLIENTE: CODCLI, NOME
-- retornar TB_PEDIDO: NUM_PEDIDO, VLR_TOTAL
-- retornar TB_VENDEDOR: NOME
-- onde coluna VLR_TOTAL menor do que mil reais e NOME VENDEDOR igual LÉIA
-- 1048 registros
select 
	CLIENTE.CODCLI,
	CLIENTE.NOME,
	PEDIDO.NUM_PEDIDO,
	PEDIDO.VLR_TOTAL,
	VENDEDOR.NOME as [NOME VENDEDOR]
from TB_CLIENTE CLIENTE
	 join TB_PEDIDO PEDIDO
		on CLIENTE.CODCLI = PEDIDO.CODCLI
     join TB_VENDEDOR VENDEDOR
		on VENDEDOR.CODVEN = PEDIDO.CODVEN
where PEDIDO.VLR_TOTAL < 1000 AND
      VENDEDOR.NOME = 'LEIA'

-- 3) relacionar: TB_PEDIDO x TB_CLIENTE
-- retornar TB_PEDIDO: NUM_PEDIDO, CODVEN, DATA_EMISSAO
-- retornar TB_CLIENTE: CODCLI, NOME, CIDADE, ESTADO
-- onde o estado igual a são paulo
-- 6.304 registros
   select 
		PEDIDO.NUM_PEDIDO, 
		CLIENTE.CODCLI, 
		PEDIDO.CODVEN, 
		PEDIDO.DATA_EMISSAO, 
		CLIENTE.NOME,
		CLIENTE.CIDADE,
		CLIENTE.ESTADO
   from TB_PEDIDO PEDIDO 
		join TB_CLIENTE CLIENTE 
			on PEDIDO.CODCLI = CLIENTE.CODCLI
   where CLIENTE.ESTADO = 'SP'


