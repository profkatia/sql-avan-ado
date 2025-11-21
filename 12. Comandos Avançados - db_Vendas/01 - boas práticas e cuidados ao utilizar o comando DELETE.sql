use db_Vendas
/*
Boas práticas e cuidados na utilização do comando DELETE

1) BOA PRÁTICA: Sempre faça um SELECT antes para verificar o que será excluído

*/
SELECT 
	TOP (100) *
FROM TB_RELATORIO_VENDAS 
WHERE cliente_id = 1  

-- AGORA SIM: Apagar somente os registros desejados, 
---com base no filtro
DELETE FROM TB_RELATORIO_VENDAS 
WHERE cliente_id = 1

SELECT 
	TOP (100) *
FROM TB_RELATORIO_VENDAS 


/*

O que esse código faz?
BEGIN TRANSACTION: inicia um processo que só será salvo se não houver erros.

DELETE: exclui os registros desejados.

COMMIT: confirma e grava as alterações no banco de dados.

ROLLBACK: desfaz as alterações se algum erro ocorrer.

@@TRANCOUNT: 
a) verificar se há uma transação em andamento, antes de fazer um COMMIT ou ROLLBACK.
b) evitar erros, como tentar dar ROLLBACK sem ter iniciado uma transação

TRY...CATCH: estrutura que captura erros e evita que o banco fique em estado inconsistente.
-- 2) 

*/

-- Início do bloco TRY: aqui o SQL vai tentar 
-- executar os comandos sem erro.
BEGIN TRY

    -- Inicia uma transação. Isso significa que o SQL só vai "salvar" as alterações
    -- se tudo funcionar corretamente até o fim (com COMMIT).
    BEGIN TRANSACTION

    -- Exclui os registros da tabela TB_RELATORIO_VENDAS onde o cliente_id é igual a 3.
    -- Ou seja, apaga todas as vendas feitas pelo cliente 3.
    DELETE FROM TB_RELATORIO_VENDAS 
    WHERE cliente_id = 3

    -- Se a exclusão deu certo, confirma a transação.
    -- Agora sim as alterações são gravadas de forma definitiva no banco.
    COMMIT

    -- Exibe uma mensagem de sucesso no console (janela de mensagens).
    PRINT 'Exclusão realizada com sucesso e COMMIT efetuado.'

-- Fim do bloco TRY
END TRY

-- Início do bloco CATCH: se algum erro acontecer 
-- no bloco TRY, o SQL pula para cá.
BEGIN CATCH

    -- Verifica se ainda existe uma transação ativa (não finalizada).
    IF @@TRANCOUNT > 0
    BEGIN
        -- Se sim, desfaz todas as alterações feitas desde o BEGIN TRANSACTION.
        ROLLBACK
    END

    -- Mostra na tela uma mensagem com o erro que aconteceu.
    -- A função ERROR_MESSAGE() captura e exibe o motivo do erro.
    PRINT 'Erro durante a exclusão: ' + ERROR_MESSAGE()

-- Fim do bloco CATCH
END CATCH
























