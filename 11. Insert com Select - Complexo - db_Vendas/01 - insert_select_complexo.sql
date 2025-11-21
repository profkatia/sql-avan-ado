-- Este script demonstra como realizar uma inserção avançada 
-- utilizando o comando INSERT .... SELECT,
-- combinando múltiplas tabelas e realizando 
-- operações de agregação como SUM

-- Neste momento vamos criar o banco de dados
CREATE DATABASE db_Vendas

USE db_Vendas
SET LANGUAGE brazilian

-- 1. Nesta fase vamos criar as tabelas de exemplo: 
-- 'TB_CLIENTES', 'TB_PRODUTOS' e 'TB_VENDAS'
CREATE TABLE TB_CLIENTES 
(
    cliente_id INT PRIMARY KEY IDENTITY(1,1),
    nome_cliente VARCHAR(100),
    email_cliente VARCHAR(100)
)

CREATE TABLE TB_PRODUTOS 
(
    produto_id INT PRIMARY KEY IDENTITY(1,1),
    nome_produto VARCHAR(100),
    preco MONEY
)

CREATE TABLE TB_VENDAS 
(
    venda_id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT,
    produto_id INT,
    quantidade INT,
    data_venda DATE,
	valor_total MONEY
    -- relaciona com TB_CLIENTES 
    FOREIGN KEY (cliente_id) REFERENCES TB_CLIENTES(cliente_id),
    -- relaciona com TB_PRODUTOS
    FOREIGN KEY (produto_id) REFERENCES TB_PRODUTOS(produto_id)
)
--------------------------------------------------------------------------------------------
-- 2. Inserir dados de exemplo nas tabelas 'TB_CLIENTES', 'TB_PRODUTOS' e 'TB_VENDAS'

-- Inserindo alguns TB_CLIENTES
INSERT INTO TB_CLIENTES (nome_cliente, email_cliente) VALUES
('João Silva', 'joao.silva@email.com'),
('Maria Souza', 'maria.souza@email.com'),
('Carlos Oliveira', 'carlos.oliveira@email.com')

-- Inserindo alguns TB_PRODUTOS
INSERT INTO TB_PRODUTOS (nome_produto, preco) VALUES
('Laptop', 3500.00),
('Smartphone', 1200.00),
('Cadeira Gamer', 800.00)

-- Inserindo algumas TB_VENDAS
INSERT INTO TB_VENDAS (cliente_id, produto_id, quantidade, data_venda) VALUES
(1, 1, 2, GETDATE()),
(2, 2, 1, GETDATE()),
(1, 3, 1, GETDATE()),
(3, 1, 1, GETDATE()),
(2, 3, 3, GETDATE())

--------------------------------------------------------------------------------------------
-- 3. A tabela 'TB_RELATORIO_VENDAS' deverá conter os histórico do total gasto por cada 
-- cliente em cada produto, além do nome do cliente.

-- Primeiro, vamos criar a tabela 'TB_RELATORIO_VENDAS'
CREATE TABLE TB_RELATORIO_VENDAS 
(
    cliente_id INT,
    nome_cliente VARCHAR(100),
    produto_id INT,
    nome_produto VARCHAR(100),
    total_gasto MONEY
)

--------------------------------------------------------------------------------------------
-- 4. Exemplo 
-- Podemos também realizar inserções mais complexas, como filtrar 
-- os TB_CLIENTES que gastaram acima de um valor específico.

-- Inserindo apenas os CLIENTES que gastaram mais de 3000 no total, 
-- com um filtro adicional na agregação.
-- HAVING = filtra o quê? O HAVING será um filtro utilizado após o agrupamento ser feito
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
-- Filtro para total gasto acima de 3000
HAVING SUM(v.quantidade * p.preco) > 3000  

-- Verificar os dados inseridos após o filtro
SELECT 
	TOP (50) *
FROM TB_RELATORIO_VENDAS


--------------------------------------------------------------------------------------------
-- 5. Exemplo
-- 1o passo - cadastrar produto "Drone Profissional 4K" na TB_PRODUTOS
-- o preço do produto é de: 5.300,00
INSERT INTO TB_PRODUTOS (nome_produto, preco) VALUES
('Drone Profissional 4K', 9750)

-- 2o passo - cadastre 1 venda na TB_VENDAS
INSERT INTO TB_VENDAS(cliente_id, produto_id, quantidade, data_venda, valor_total) VALUES
(3, ?, 2, GETDATE(), 19500)


-- 3o passo - quando o produto = 'Drone Profissional 4K' e total_gasto = 19500
-- faça o INSERT INTO na TB_RELATORIO_VENDAS
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
WHERE p.produto_id = 6 -- Drone
GROUP BY c.cliente_id, c.nome_cliente, p.produto_id, p.nome_produto
HAVING SUM(v.quantidade * p.preco) = 19500

--------------------------------------------------------------------------------------------
-- 6 Exemplo 3

-- 1o passo - cadastrar produto "Smart TV OLED 65"" na TB_PRODUTOS
-- o preço do produto é de: 5.300,00
INSERT INTO TB_PRODUTOS (nome_produto, preco) VALUES
('Smart TV OLED 65"', 8799)

-- 2o passo - cadastre 1 venda na TB_VENDAS
INSERT INTO TB_VENDAS(cliente_id, produto_id, quantidade, data_venda, valor_total) VALUES
(3, ?, 1, GETDATE(), 8799)

-- 3o passo - quando o produto = 'Smart TV OLED 65"' e total_gasto esteja entre 8000 e 27000
-- faça o INSERT INTO na TB_RELATORIO_VENDAS
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
HAVING SUM(v.quantidade * p.preco) between 8000 and 27000












