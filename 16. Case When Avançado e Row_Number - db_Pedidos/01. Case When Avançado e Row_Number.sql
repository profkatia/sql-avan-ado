USE db_Pedidos

-- extrair uma parte específica de uma data, 
-- como o ano, mês, dia, semana, dia da semana
SELECT 
	NOME, 
	SALARIO, 
	DATA_ADMISSAO, 
    CASE DATEPART(WEEKDAY, DATA_ADMISSAO)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Segunda-Feira'
        WHEN 3 THEN 'Terça-Feira'
        WHEN 4 THEN 'Quarta-Feira'
        WHEN 5 THEN 'Quinta-Feira'
        WHEN 6 THEN 'Sexta-Feira'
        WHEN 7 THEN 'Sábado'      
    END AS DIA_SEMANA       
FROM TB_EMPREGADO


/*
Resumo

IIF = fazer uma verificação simples	(IF/ELSE), IIF(SINDICALIZADO = 'S', 'SIM', 'NÃO')
CHOOSE = Retornar valor baseado em índice	CHOOSE(2, 'A', 'B', 'C') → 'B'
*/ 
SELECT 
	CODFUN, 
	NOME, 
	DATA_ADMISSAO,
	-- Substitui o S por SIM e o N por NÃO
	IIF(SINDICALIZADO = 'S', 'SIM', 'NÃO') AS SINDICALIZADO,
	-- Pega o número do dia da semana e devolve o nome que 
	-- está na posição correspondente
	CHOOSE(DATEPART(WEEKDAY, DATA_ADMISSAO), 
	'DOMINGO', 'SEGUNDA','TERÇA','QUARTA','QUINTA','SEXTA','SÁBADO') AS DIA_SEMANA
FROM TB_EMPREGADO



/*  
UTILIZAÇÃO: ROW_NUMBER()
========================
Resumo funcional do código:
---------------------------
Agrupa os pedidos por cliente

Soma o valor total dos pedidos de cada cliente

Ordena os clientes do maior comprador para o menor

Numera cada cliente com base nessa ordem de total de compras

ROW_NUMBER(): Retorna o número sequencial da linha, começando em 1 

OVER: OVER(ORDER BY ...) indica a ordem  crescente ou decrescente que a função deve seguir.

*/
SELECT 
	NOME,  -- Nome do cliente
	TOTAL, -- Total de compras realizadas por esse cliente

	-- Cria uma numeração das linhas baseada na ordem do total de compras (maior para menor)
	ROW_NUMBER() OVER (ORDER BY TOTAL DESC) AS LINHA

-- Define que os dados virão de uma subconsulta, apelidada como A
FROM 
	(
		-- Subconsulta que calcula o total de compras por cliente
		SELECT  
			C.NOME,  -- Nome do cliente vindo da tabela TB_CLIENTE

			-- Soma o valor total dos pedidos feitos por esse cliente
			SUM(P.VLR_TOTAL) AS TOTAL

		-- Origem dos dados: tabela de pedidos (TB_PEDIDO), apelidada como P
		FROM TB_PEDIDO AS P

			-- Faz um JOIN com a tabela de clientes (TB_CLIENTE), apelidada como C
			-- A junção é feita com base no código do cliente (chave primária/estrangeira)
			JOIN TB_CLIENTE AS C 
				ON C.CODCLI = P.CODCLI

		-- Agrupa os dados por nome do cliente para que a soma seja feita corretamente
		GROUP BY C.NOME

	) AS A  -- Fecha a subconsulta e dá o nome (alias) A para ela







