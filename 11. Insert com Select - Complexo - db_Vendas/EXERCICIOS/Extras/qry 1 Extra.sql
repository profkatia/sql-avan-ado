-- 1 – Inserir Apenas os Top 10 Clientes por Gasto Total
-- Objetivo: Usar ORDER BY e TOP para limitar os dados inseridos.
-- INSERIR OS TOP 10 CLIENTES QUE MAIS GASTARAM NO TOTAL
INSERT INTO TB_RELATORIO_VENDAS (cliente_id, nome_cliente, produto_id, nome_produto, total_gasto)
SELECT TOP 10
	c.cliente_id,
    c.nome_cliente,
    p.produto_id,
    p.nome_produto,
    SUM(v.quantidade * p.preco) AS total_gasto
FROM TB_VENDAS v
	JOIN TB_CLIENTES c 
		ON v.cliente_id = c.cliente_id
	JOIN TB_PRODUTOS p 
		ON v.produto_id = p.produto_id
GROUP BY c.cliente_id, c.nome_cliente, p.produto_id, p.nome_produto
ORDER BY total_gasto DESC



-- 2 – Agrupar Apenas por Cliente (Sem Detalhar Produto)
-- Objetivo: Simplificar o agrupamento para analisar o total gasto por cliente.
-- INSERIR DADOS AGRUPADOS APENAS POR CLIENTE
INSERT INTO TB_RELATORIO_VENDAS 
(cliente_id, nome_cliente, total_gasto)
SELECT 	
	c.cliente_id,
    c.nome_cliente,    
    SUM(v.quantidade * p.preco) AS total_gasto
FROM TB_VENDAS v
		JOIN TB_CLIENTES c 
			ON v.cliente_id = c.cliente_id
		JOIN TB_PRODUTOS p 
			ON v.produto_id = p.produto_id
GROUP BY c.cliente_id, c.nome_cliente
HAVING SUM(v.quantidade * p.preco) > 3000









