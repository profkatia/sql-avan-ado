use db_Vendas
-- 1 – Adicionar Filtro por Produto

-- 1o passo - cadastrar produto "ar-condicionado" na TB_PRODUTOS
-- o preço do produto é de: 5.300,00
INSERT INTO TB_PRODUTOS (nome_produto, preco) VALUES
('ar-condicionado', 5300.00)

-- 2o passo - cadastre 1 venda na TB_VENDAS
INSERT INTO TB_VENDAS(cliente_id, produto_id, quantidade, data_venda, valor_total) VALUES
(3, 4, 5, GETDATE(), 26500.00)

/*
3o passo - A empresa deseja gerar um relatório com os clientes que 
gastaram mais de R$ 5.000,00 na compra de ar-condicionado.

Utilize as tabelas:

	TB_CLIENTES(cliente_id, nome_cliente)

	TB_PRODUTOS(produto_id, nome_produto, preco)

	TB_VENDAS(venda_id, cliente_id, produto_id, quantidade)

Crie uma instrução SQL que insira na tabela TB_RELATORIO_VENDAS os seguintes dados:

	cliente_id

	nome_cliente

	produto_id

	nome_produto

	total_gasto (calculado como quantidade * preco)

Condições:

	Considere apenas o produto com nome 'AR-CONDICIONADO'

	Insira apenas os clientes cujo total gasto com esse produto seja maior que R$ 3.000,00

*/
INSERT INTO TB_RELATORIO_VENDAS (cliente_id, nome_cliente, produto_id, nome_produto, total_gasto)
SELECT 	
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
WHERE p.nome_produto = 'AR-CONDICIONADO'
GROUP BY c.cliente_id, c.nome_cliente, p.produto_id, p.nome_produto
HAVING SUM(v.quantidade * p.preco) > 3000


-- 2 – Clientes com Total Gasto Entre 2000 e 4000
-- Objetivo: Praticar o uso da cláusula HAVING com intervalo.
-- INSERIR CLIENTES COM GASTO ENTRE 2000 E 4000
INSERT INTO TB_RELATORIO_VENDAS (cliente_id, nome_cliente, produto_id, nome_produto, total_gasto)
SELECT 	
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
HAVING SUM(v.quantidade * p.preco) BETWEEN 2000 AND 4000










