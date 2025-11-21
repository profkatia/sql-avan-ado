use db_Vendas
/*
Redução do valor mínimo do pedido
 
Enunciado:
A empresa decidiu reduzir o valor mínimo 
para que um pedido seja considerado válido. 
Antes era R$ 500,00; agora, pedidos a partir 
de R$ 300,00 devem ser aceitos. Modifique a 
verificação do valor total no código original
para aceitar pedidos com valor igual ou 
superior a R$ 300,00.

Pede-se:
1) inicie com DECLARE + variaveis + tipos

*/
DECLARE @cliente_id INT = 1
DECLARE @produto_id INT = 1
DECLARE @quantidade INT = 2
DECLARE @valor_total MONEY
DECLARE @status_pedido VARCHAR(50)

SELECT @valor_total = p.preco * @quantidade
FROM TB_PRODUTOS p
WHERE p.produto_id = @produto_id

SELECT @valor_total AS valor_total

IF @quantidade <= 0
	BEGIN
		PRINT 'Erro: Quantidade inválida!'
		SET @status_pedido = 'Erro'
	END
ELSE IF @valor_total < 300
	BEGIN
		PRINT 'Erro: Valor total inferior a R$300,00!'
		SET @status_pedido = 'Erro'
	END
ELSE
	BEGIN
		PRINT 'Pedido válido!'
		SET @status_pedido = 'Pendente'

		INSERT INTO TB_PEDIDOS(cliente_id, produto_id, quantidade, valor_total, data_pedido, status_pedido)
		VALUES (@cliente_id, @produto_id, @quantidade, @valor_total, GETDATE(), @status_pedido)

		PRINT 'Pedido inserido com sucesso!'
END














