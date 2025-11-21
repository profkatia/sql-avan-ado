
-- 1. 
USE db_Vendas
SET LANGUAGE BRAZILIAN

/*
Enunciado – Controle de Transações: Inserção de Vendas e Tratamento de Erros

Crie um script em Transact-SQL (T-SQL) que simule duas situações de venda no 
sistema, utilizando transações para garantir a integridade dos dados.

Iniciar uma transação com BEGIN TRANSACTION.

Declarar variáveis para o cliente, produto, quantidade, valor total, 
data da venda e status da transação.

Calcular o valor total (preço × quantidade) usando os dados da tabela TB_PRODUTOS.

Inserir uma nova venda na tabela TB_VENDAS.

Verificar se ocorreu erro na inserção.

    Se houver erro → executar ROLLBACK TRANSACTION e exibir a mensagem de falha.

    Se estiver tudo certo → executar COMMIT TRANSACTION e exibir mensagem de 
    sucesso com o valor formatado. */


BEGIN TRANSACTION -- Iniciando uma transação

-- Declarando variáveis
DECLARE @cliente_id INT = 1             -- Cliente para o pedido (João Silva).
DECLARE @produto_id INT = 3             -- Produto "Cadeira Gamer"
DECLARE @quantidade INT = 2             -- Quantidade 2 unidades
DECLARE @valor_total MONEY				-- Valor total do pedido.
DECLARE @data_venda DATETIME = GETDATE() -- Data atual da venda.
DECLARE @status_transacao VARCHAR(50)    -- Status da transação.

-- Recalculando o valor total
SELECT @valor_total = p.preco * @quantidade
FROM TB_PRODUTOS p
WHERE p.produto_id = @produto_id

-- Exibir o resultado SELECT acima
SELECT @valor_total AS valor_total

-- Inserindo outra venda
INSERT INTO TB_VENDAS (cliente_id, produto_id, quantidade, data_venda, valor_total)
VALUES (@cliente_id, @produto_id, @quantidade, @data_venda, @valor_total)

-- Verificando se a segunda inserção foi bem-sucedida
IF @@ERROR <> 0
BEGIN
    SET @status_transacao = 'Falha: Erro na inserção da segunda venda'
    ROLLBACK TRANSACTION -- Revertendo a transação se houver erro na segunda inserção
    PRINT @status_transacao
    RETURN
END

-- Se todas as inserções forem bem-sucedidas, confirmamos a transação
SET @status_transacao = 'Sucesso, venda inserida no valor de: ' + FORMAT(@valor_total, 'C', 'pt-BR')
COMMIT TRANSACTION -- Confirmando a transação
PRINT @status_transacao

-- Verificando os dados inseridos nas tabelas 'vendas'
SELECT 
	TOP (50) *
FROM TB_VENDAS
--------------------------------------------------------------------------------------------------


-- 2. Caso de falha: Tentando inserir uma venda com quantidade inválida
-- Para testar a falha da transação, vamos tentar inserir um pedido com quantidade negativa.

BEGIN TRANSACTION

-- Definindo uma quantidade inválida (negativa)
SET @quantidade = -1

-- Tentando inserir a venda com quantidade negativa
IF @quantidade <= 0
BEGIN
    SET @status_transacao = 'Falha: Quantidade inválida ' + CAST(@quantidade AS VARCHAR(50)) 
    ROLLBACK TRANSACTION -- Revertendo a transação caso a quantidade seja inválida
    PRINT @status_transacao
    RETURN
END

-- Caso contrário, inserimos a venda (essa parte não será executada devido à validação acima)
INSERT INTO TB_VENDAS (cliente_id, produto_id, quantidade, data_venda, valor_total)
VALUES (@cliente_id, @produto_id, @quantidade, @data_venda, @valor_total)

-- Confirmando a transação (não será executado devido ao rollback anterior)
COMMIT TRANSACTION


