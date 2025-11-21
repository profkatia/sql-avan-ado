/*
Comando SQL	Explicação Simples
==============================
BEGIN TRY ... END TRY	Bloco que tenta executar os comandos. Se der erro, pula para o bloco CATCH.
BEGIN TRANSACTION		Inicia uma transação. Protege o processo: ou tudo acontece, ou nada.
DELETE FROM ... WHERE	Exclui registros específicos, com base numa condição (WHERE).
PRINT					Mostra mensagens no console do SQL Server. Útil para acompanhar o que está sendo feito.
COMMIT					Finaliza e grava todas as alterações da transação.
BEGIN CATCH ... END		Bloco que é executado se algo der errado no TRY.
ROLLBACK				Desfaz tudo que foi feito na transação, em caso de erro.
@@TRANCOUNT				Verifica se ainda existe uma transação ativa. Evita dar ROLLBACK à toa.
ERROR_MESSAGE()			Retorna uma descrição do erro ocorrido.

*/

-- Início do bloco TRY.
-- Aqui o SQL tenta executar os comandos. Se tudo der certo, segue normalmente.
-- Se der erro em qualquer parte, pula para o bloco CATCH.
BEGIN TRY  

    -- Inicia uma transação.
    -- A transação garante que tudo que for feito abaixo seja tratado como uma única operação.
    -- Se der erro em qualquer etapa, tudo será desfeito com ROLLBACK.
    BEGIN TRANSACTION                         

    -- Exclui todos os registros da tabela TB_PEDIDOS onde o cliente_id é 1.
    -- Deve-se excluir primeiro os pedidos, pois eles dependem do cliente (chave estrangeira).
    DELETE FROM TB_PEDIDOS 
    WHERE cliente_id = 1

    -- Exibe mensagem no console informando que os pedidos do cliente foram excluídos.
    PRINT 'EXCLUSAO....  TB_PEDIDOS cliente_id = 1'

    -- Após excluir os pedidos, agora é possível excluir o cliente com ID 1.
    DELETE FROM TB_CLIENTES 
    WHERE cliente_id = 1

    -- Exibe mensagem informando que o cliente foi excluído.
    PRINT '...EXCLUSAO....  TB_CLIENTES cliente_id = 1'

    -- Confirma a transação.
    -- Ou seja, grava de forma permanente todas as alterações feitas acima.
    COMMIT TRANSACTION

    -- Exibe mensagem final de sucesso no console.
    PRINT 'Exclusões realizadas com sucesso e transação confirmada.'

-- Fim do bloco TRY.
END TRY

-- Início do bloco CATCH.
-- Se algum erro ocorrer no bloco TRY, este bloco será executado.
BEGIN CATCH  

    -- Verifica se ainda existe uma transação ativa (não finalizada).
    IF @@TRANCOUNT > 0
    BEGIN
        -- Se houver, desfaz todas as alterações feitas na transação.
        -- Isso evita que o banco de dados fique com dados incompletos ou inconsistentes.
        ROLLBACK TRANSACTION  
    END

    -- Exibe no console a mensagem do erro que aconteceu.
    -- A função ERROR_MESSAGE() mostra a descrição do erro.
    PRINT 'Erro durante a exclusão: ' + ERROR_MESSAGE()

-- Fim do bloco CATCH.
END CATCH


