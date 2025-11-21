USE db_Vendas

/*
Exercício 1: Excluir vendas de um cliente específico

Enunciado:
----------
Crie um script que exclua todas as vendas realizadas 
por um cliente , utilizando 
controle de transação e tratamento de erros.

*/
BEGIN TRY
    BEGIN TRANSACTION

    DELETE FROM TB_RELATORIO_VENDAS
    WHERE nome_cliente = ??????

    COMMIT
    PRINT 'Vendas de Lucas Silva excluídas com sucesso.'

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK

    PRINT 'Erro ao excluir vendas de Lucas Silva: ' + ERROR_MESSAGE()
END CATCH



/*
Exercício 2: Atualizar nome de produto com erro de digitação

Enunciado:
----------
Suponha que o produto foi cadastrado com o nome 
errado: 'Fone Blutooth' (com erro). Crie um script para 
corrigir o nome para 'Fone Bluetooth' em todas as vendas, 
usando transação e tratamento de erro.

*/
BEGIN TRY
    BEGIN TRANSACTION

    UPDATE TB_RELATORIO_VENDAS
    SET nome_produto = 'Fone Bluetooth'
    WHERE nome_produto = 'Fone Blutooth'

    COMMIT
    PRINT 'Nome do produto corrigido com sucesso.'

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK

    PRINT 'Erro ao atualizar nome do produto: ' + ERROR_MESSAGE()
END CATCH















