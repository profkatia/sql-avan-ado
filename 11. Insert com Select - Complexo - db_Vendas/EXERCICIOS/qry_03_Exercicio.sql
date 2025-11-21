use db_Vendas
----------------------------------------------------------
/*
Limite de quantidade por pedido

Enunciado:
Para evitar pedidos excessivos, implemente uma 
regra que impede pedidos com mais de 10 unidades 
do mesmo produto. Caso o usuário tente fazer 
um pedido com quantidade maior que 10, exiba 
uma mensagem de erro e não insira o pedido.
*/
DECLARE @cliente_id INT = 2
DECLARE @produto_id INT = 1
DECLARE @quantidade INT = 15
DECLARE @valor_total DECIMAL(10, 2)
DECLARE @status_pedido VARCHAR(50)

IF @quantidade > 10
BEGIN
    PRINT 'Erro: Quantidade superior ao limite de 10 unidades!'
    SET @status_pedido = 'Erro'
END
ELSE
BEGIN
    SELECT @valor_total = p.preco * @quantidade
    FROM TB_PRODUTOS p
    WHERE p.produto_id = @produto_id

    IF @valor_total < 500
    BEGIN
        PRINT 'Erro: Valor total inferior a R$500,00!'
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
END














