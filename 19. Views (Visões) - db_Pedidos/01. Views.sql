USE db_Pedidos
/*
1. Tipos e Vantagens de VIEWS
-----------------------------

	VIEW é uma consulta salva no banco de dados, 
	que pode ser reutilizada como se fosse uma tabela.

	Pode ser criada com CREATE VIEW e utilizada com SELECT normalmente.

Vantagens:

	Simplifica consultas complexas (facilita para o usuário final).

	Melhora a segurança (esconde colunas confidenciais).

	Facilita a manutenção de código SQL.

	Pode servir de base para relatórios.

2. Restrições e Limitações
--------------------------

A VIEW não armazena dados — apenas a consulta (os dados vêm da tabela original).

Algumas VIEWS não são atualizáveis, especialmente se usarem:

	JOIN, GROUP BY, DISTINCT, UNION, TOP, HAVING etc.

Não é possível usar ORDER BY diretamente (exceto com TOP).
*/

-- 1) Criação com CREATE VIEW
CREATE VIEW VW_CLIENTE AS
SELECT  
      CODCLI,
      NOME,
      FANTASIA,
      CIDADE,
      ESTADO,
      FONE1,
      E_MAIL
FROM dbo.TB_CLIENTE
WHERE ESTADO = 'SP' -- filtra clientes do estado de SP

-----------------------------------------------------------------------
-- 2 - Alteração com ALTER VIEW
-- Se quiser incluir mais colunas ou mudar o filtro:

ALTER VIEW VW_CLIENTE AS
SELECT  
      CODCLI,
      NOME,
      FANTASIA,
      CIDADE,
      ESTADO,
      FONE1,
      E_MAIL,
      DATA_CAD
FROM dbo.TB_CLIENTE
WHERE ESTADO IN ('SP', 'RJ');
-----------------------------------------------------------------------

-- 3) Exclusão com DROP VIEW
-- Para remover a VIEW:

DROP VIEW VW_CLIENTE


-----------------------------------------------------------------------
-- 4 - Visualização de Metadados
-- Ver informações sobre as views criadas:

-- Lista todas as views do banco
SELECT * FROM sys.views

-- Mostra o código SQL de uma view específica
EXEC sp_helptext 'VW_CLIENTE'


-----------------------------------------------------------------------
-- 5 - VIEWS Atualizáveis
-- Se a VIEW for simples (sem JOIN, sem funções agregadas), 
-- é possível fazer INSERT, UPDATE e DELETE diretamente nela, 
-- e o SQL Server aplica as alterações na tabela original
-- TB_CLIENTE.

-- Atualizando dados através da view
UPDATE VW_CLIENTE
SET FONE1 = '(11) 99999-0000'
WHERE CODCLI = 1001




































































































