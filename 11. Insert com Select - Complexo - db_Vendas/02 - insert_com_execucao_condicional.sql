-- Este script demonstra como utilizar a estrutura condicional
-- IF...ELSE dentro de um comando INSERT.
-- A lógica condicional valida os dados antes de realizar a 
-- inserção, para garantir que apenas dados válidos
-- sejam inseridos na tabela.

-- 1. Crie uma tabela de exemplo chamada 'pedidos', onde serão inseridos dados de pedidos.
USE DB_VENDAS
SET LANGUAGE BRAZILIAN

CREATE TABLE TB_PEDIDOS 
(
    pedido_id INT PRIMARY KEY IDENTITY(1,1),       -- Identificador único para o pedido.
    cliente_id INT,                  -- Identificador do cliente (chave estrangeira).
    produto_id INT,                  -- Identificador do produto (chave estrangeira).
    quantidade INT,                  -- Quantidade do produto.
    valor_total MONEY,      -- Valor total do pedido.
    data_pedido DATETIME,            -- Data do pedido.
    status_pedido VARCHAR(50)        -- Status do pedido (ex: 'Pendente', 'Concluído').
)

--------------------------------------------------------------------------------------------------------
/*
-- 2. Utilizando o IF...ELSE dentro de um comando INSERT
-- Vamos agora simular uma inserção de pedidos com lógica condicional 
-- para validar se a quantidade de produto é válida
-- e se o valor total do pedido é superior a um valor mínimo, antes de inserir na TB_PEDIDOS

- Por que no DECLARE sou obrigado a atribuir valores para as variaveis ?
  Resposta: não é obrigado a informar valores ao declarar variáveis no 
            T-SQL (SQL Server). O DECLARE serve apenas para criar a 
			variável — a atribuição de valor é opcional.

- Então por que atribuir valores pode ser importante?
  Resposta: porque se você tentar usar uma variável antes de atribuir 
            valor, ela virá com NULL, o que pode gerar erros ou 
			comportamentos inesperados.

			Exemplo:
			========
			DECLARE @quantidade INT

			IF @quantidade <= 0
				PRINT 'Quantidade inválida!'
			Isso não funciona como esperado, porque @quantidade é NULL inicialmente em T-SQL

			NULL <= 0 --> resulta em UNKNOWN (não é verdadeiro)
			
			ATENÇÃO: Então o IF nem entra no bloco.

			Boas práticas
			=============
			1) Declare e atribua valor inicial se for usar em comparações lógicas (IF, WHILE, etc).

			2) Se a variável será preenchida depois (como com SELECT ... INTO ou SET), 
			   você pode só declarar primeiro.

Comando		Finalidade
=======     ==========
DECLARE.... É usado para criar (declarar) uma variável no T-SQL
BEGIN...... Inicia um bloco de comandos
END........	Finaliza o bloco iniciado por BEGIN
SET........	Atribui valor a uma variável declarada
PRINT...... Exibir mensagens de texto no console de execução do SQL Server

*/


DECLARE @cliente_id INT = 1         -- Cliente que está realizando o pedido (exemplo: João Silva).
DECLARE @produto_id INT = 1         -- Produto que está sendo solicitado (exemplo: Laptop).
DECLARE @quantidade INT = 2         -- Quantidade do produto (exemplo: 2 unidades).
DECLARE @valor_total DECIMAL(10, 2) -- Valor total do pedido (calculado posteriormente).
DECLARE @status_pedido VARCHAR(50)  -- Status do pedido.

-- Calculando o valor total do pedido
SELECT 
	@valor_total = p.preco * @quantidade
FROM TB_PRODUTOS p
WHERE p.produto_id = @produto_id

-- Exibindo o valor total calculado
SELECT @valor_total AS valor_total


-- Definindo a lógica condicional
IF @quantidade <= 0
BEGIN
	-- Se a quantidade for menor ou igual a zero, o pedido não é válido
	PRINT 'Erro: Quantidade inválida para o pedido!'
	SET @status_pedido = 'Erro'
END
ELSE IF @valor_total < 500
BEGIN
	-- Se o valor total do pedido for menor que 500, o pedido será considerado inválido
	PRINT 'Erro: O valor total do pedido é inferior ao valor mínimo de R$500,00!'
	SET @status_pedido = 'Erro'
END
ELSE
BEGIN
    -- Caso contrário, o pedido é válido e será inserido na tabela, ou seja,
	-- valor >= 500,00
    PRINT 'Pedido válido. Realizando a inserção na tabela...'
    SET @status_pedido = 'Pendente' -- O pedido será inicialmente "Pendente".
    
    -- Inserindo o pedido na tabela 'pedidos'
    INSERT INTO TB_PEDIDOS(cliente_id, produto_id, quantidade, valor_total, data_pedido, status_pedido)
    VALUES (@cliente_id, @produto_id, @quantidade, @valor_total, GETDATE(), @status_pedido)

    PRINT 'Pedido inserido com sucesso!'
END

-- 3. Verificar o conteúdo da tabela 'pedidos' após a execução
SELECT
	top (50) *
FROM TB_PEDIDOS

--------------------------------------------------------------------------------------------------------

-- 4. Exemplo de inserção de pedido com valores que não atendem aos requisitos
-- Agora, vamos tentar inserir um pedido com uma quantidade inválida ou um valor total abaixo de R$500.

-- Tentar inserir um pedido com quantidade negativa
DECLARE @quantidade_invalida INT = -1
DECLARE @valor_total_invalido DECIMAL(10, 2)
DECLARE @produto_id_invalido INT = 1
DECLARE @status_pedido_invalido VARCHAR(50) = 'PENDENTE'
DECLARE @cliente_id_invalido INT = 1

-- Calculando o valor total para o pedido inválido
SELECT @valor_total_invalido = p.preco * @quantidade_invalida
FROM TB_PRODUTOS p
WHERE p.produto_id = @produto_id_invalido

-- 
SELECT @valor_total_invalido AS valor_total_invalido

IF @quantidade_invalida <= 0
BEGIN
	PRINT 'Erro: Quantidade inválida para o pedido!'
	SET @status_pedido_invalido = 'Erro'
END
ELSE IF @valor_total_invalido < 500
BEGIN
	PRINT 'Erro: O valor total do pedido é inferior ao valor mínimo de R$500,00!'
	SET @status_pedido_invalido = 'Erro'
END
ELSE
BEGIN
	INSERT INTO TB_PEDIDOS (cliente_id, produto_id, quantidade, valor_total, data_pedido, status_pedido)
	VALUES (@cliente_id_invalido, @produto_id_invalido, @quantidade_invalida, @valor_total_invalido, GETDATE(), @status_pedido_invalido)
	PRINT 'Pedido inserido com sucesso!'
END

-- 5. Verificando a TB_PEDIDOS novamente
SELECT 
	TOP (50) *
FROM TB_PEDIDOS















