use db_Pedidos


/* configurar o Studio para:
1) mensagens de erros
2) formatações para data(dd/mm/yyyy)
3) valores monetários R$ 0.000,00 

Definição: Microsoft 
Especifica o ambiente de idioma para a sessão. 
O idioma da sessão determina os formatos de datetime e as mensagens do sistema.
*/
set language brazilian

/* 1) retornar os produtos 
usa-se colchetes[] para apelidos com 
espaços entre palavras
Link referente as formatações
https://learn.microsoft.com/pt-br/sql/t-sql/functions/format-transact-sql?view=sql-server-ver17

1) No Select, retorne os campos: ID_PRODUTO, DESCRICAO, PRECO_CUSTO, PRECO_VENDA
2) tabela: TB_PRODUTO
3) formate em moeda R$ os campos: PRECO_CUSTO e PRECO_VENDA
*/
select 
		ID_PRODUTO as CODIGO,
		DESCRICAO 'DESCRICAO DO PRODUTO',
		-- formatação contábil
		format(PRECO_CUSTO, 'C', 'PT-BR') as [PRECO CUSTO],
		-- formatação contábil
		format(PRECO_VENDA, 'C', 'PT-BR') as [PRECO VENDA]  
from TB_PRODUTO


---------------------------------------------------------------------------------------
/* 2) mostrar os pedidos
e formatar a coluna DATA_EMISSAO para dd/MM/yyyy
Tabela: TB_Pedido

"mm" minúsculo significa um minuto em uma hora, mas "MM" 
maiúsculo significa o mês do ano. Eles não devem ser misturados. 
Os meses devem ser usados ​​junto com o ano ou dia, enquanto os 
minutos devem ser usados ​​junto com uma hora.
*/
select 
	NUM_PEDIDO as [N° PEDIDO],	
	FORMAT(DATA_EMISSAO, 'dd/MM/yyyy') as [DATA FORMATADA],
	FORMAT(VLR_TOTAL, 'C', 'PT-BR') as [R$ TOTAL],
	SITUACAO,
	OBSERVACOES 	
from TB_Pedido

---------------------------------------------------------------------------------------
-- 3) selecionar os 10 primeiros registros
-- Tabela: TB_Pedido
select 
	top 10 *
from TB_PEDIDO
order by NUM_PEDIDO
---------------------------------------------------------------------------------------
-- 4) selecionar os 15 últimos registros e 
-- classificar em ordem do maior para o menor [Z-A]
-- Tabela: TB_Pedido
SELECT TOP 15 *
FROM TB_PEDIDO
ORDER BY NUM_PEDIDO DESC

---------------------------------------------------------------------------------------

-- 5) Exibir da linha 100 até 300
--	OFFSET 99 ROWS pula os 99 primeiros registros (ou seja, começa no 100).
--	FETCH NEXT 201 ROWS ONLY pega os 201 registros seguintes, ou seja, do 100 até o 300.
--	Importante: você precisa usar o ORDER BY, senão o SQL Server não aceita OFFSET-FETCH.

--  Definições finais: 
--		"OFFSET" em inglês significa "deslocamento" ou "salto"
--		"ROWS" linhas
--		"FETCH NEXT" é usado para trazer um número específico de linhas a partir da posição indicada pelo OFFSET.
SELECT 
	NUM_PEDIDO,
	CODCLI,
	CODVEN,
	DATA_EMISSAO, 
	VLR_TOTAL
FROM TB_PEDIDO
ORDER BY NUM_PEDIDO
OFFSET 99 ROWS FETCH NEXT 201 ROWS ONLY

---------------------------------------------------------------------------------------

-- 6) selecionar os 10% dos primeiros registros
-- TB_CLIENTE
select 
	top(25) percent * 	
from TB_CLIENTE
order by codcli desc
---------------------------------------------------------------------------------------

-- 7) listar as 7 pessoas com o maior salário
-- TB_EMPREGADO
select 
	top(7) *
from TB_EMPREGADO 
order by SALARIO desc
---------------------------------------------------------------------------------------
-- 8) Será que a análise anterior está correta ? 
-- Mas realmente quais são as pessoas com o maior 
-- salário inclusive comparadas ao último ?

-- WITH TIES é usado para incluir linhas que correspondam aos valores da última linha
-- TB_EMPREGADO
select 
	top(7) with ties *
from TB_EMPREGADO 
order by SALARIO desc




