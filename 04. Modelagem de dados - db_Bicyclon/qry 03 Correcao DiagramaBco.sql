-- em caso de erro no momento de criar
-- o Diagrama do Banco de Dados
USE db_Bicyclon


-- troca o tipo de acesso para permitir
-- criar o diagrama com o usuário do banco
EXEC sp_changedbowner 'sa' 
