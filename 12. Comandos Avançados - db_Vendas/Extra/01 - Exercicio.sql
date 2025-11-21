USE db_Vendas
/*
Exercício 1: Inserção de nova venda com segurança

Enunciado:
----------
Crie um script para inserir uma nova venda do 
cliente 'Ana Souza', com o produto 'Smartwatch X200', 
produto_id = 18 e total_gasto = 899.90. 
Use transação e TRY...CATCH.

*/
BEGIN TRY
    BEGIN TRANSACTION

    INSERT INTO TB_RELATORIO_VENDAS (nome_cliente, produto_id, nome_produto, total_gasto)
    VALUES ('Ana Souza', 18, 'Smartwatch X200', 899.90)

    COMMIT
    PRINT 'Nova venda registrada com sucesso.'

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK

    PRINT 'Erro ao registrar nova venda: ' + ERROR_MESSAGE()
END CATCH


/*
Exercício 2: Excluir vendas com produto genérico e gasto baixo

Enunciado:
Remova todas as vendas com nome_produto = 'Produto Genérico' e 
total_gasto < 10. Implemente segurança transacional com TRY...CATCH.

*/

BEGIN TRY
    BEGIN TRANSACTION

    DELETE FROM TB_RELATORIO_VENDAS
    WHERE nome_produto = 'Produto Genérico'
      AND total_gasto < 10

    COMMIT
    PRINT 'Vendas com produto genérico de baixo valor excluídas.'

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK

    PRINT 'Erro ao excluir vendas genéricas: ' + ERROR_MESSAGE()
END CATCH


/*
Exercício 3: Corrigir total gasto de um cliente específico

Enunciado:
----------
Você identificou que todas as vendas da cliente 'Mariana Lima' foram 
registradas com o total_gasto = 0. Corrija esse valor para 120.00, 
usando transação e tratamento de erros.

*/
BEGIN TRY
    BEGIN TRANSACTION

    UPDATE TB_RELATORIO_VENDAS
    SET total_gasto = 120.00
    WHERE nome_cliente = 'Mariana Lima'
      AND total_gasto = 0

    COMMIT
    PRINT 'Total gasto corrigido para Mariana Lima.'

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK

    PRINT 'Erro ao corrigir total gasto: ' + ERROR_MESSAGE()
END CATCH









































