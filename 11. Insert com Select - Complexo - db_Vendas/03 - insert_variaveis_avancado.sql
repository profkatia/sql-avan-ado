USE db_Vendas
/*
Este script demonstra como realizar inserções avançadas utilizando múltiplas variáveis e transações.
Usaremos transações para garantir a atomicidade das inserções, e várias variáveis para 
gerenciar os dados de forma dinâmica.


EXPLICAÇÃO:
Para que serve BEGIN TRANSACTION no SQL Server?
===============================================
BEGIN TRANSACTION serve para iniciar uma transação no banco de dados.
Ou seja, ele marca o início de um bloco de comandos que só será efetivado 
(salvo) se tudo der certo. Caso algo dê errado, você pode reverter tudo com ROLLBACK.

Conceito-chave: "Tudo ou nada"
==============================
Imagine que você está:

	Transferindo dinheiro entre contas

	Atualizando múltiplas tabelas

	Inserindo vários dados interdependentes

Se algo falhar no meio do processo, você não quer dados incompletos ou quebrados no banco.

É aí que entra a transação.

O que o comando garante?
========================
Atomicidade: ou tudo é executado com sucesso, ou nada é salvo.

Consistência: o banco fica sempre em um estado válido.

Controle de erro: você decide quando salvar (COMMIT) ou desfazer (ROLLBACK) as alterações.

Quando usar BEGIN TRANSACTION?
==============================
Situação										Justificativa
--------                                        -------------
Alterar mais de uma tabela						Para garantir consistência
Transferências financeiras, estoque, pedidos	Para não deixar dados incompletos
Atualizações sensíveis							Para poder cancelar em caso de erro


*/
/*
Enunciado – Controle de Transação de Venda no SQL Server
========================================================
Crie um bloco de código Transact-SQL (T-SQL) que simule o 
registro de uma venda no banco de dados, garantindo segurança e consistência dos dados.

O sistema deve:

	Iniciar uma transação para garantir que todas as etapas ocorram corretamente.

	Declarar variáveis para armazenar:

	o código do cliente,

	o produto comprado,

	a quantidade,

	a data da venda e

	o valor total.

Calcular o valor total (preço × quantidade) com base na tabela TB_PRODUTOS.

Validar a quantidade — se for menor ou igual a zero, cancelar a transação com ROLLBACK.

Inserir o registro na tabela TB_VENDAS apenas se tudo estiver correto.

Confirmar a operação com COMMIT TRANSACTION caso não haja erros.

Resumo
======
Etapa	Ação				Comando Principal
1		Inicia a transação	BEGIN TRANSACTION
2		Declara variáveis	DECLARE
3		Calcula valor total	SELECT
4		Verifica quantidade	IF / ROLLBACK
5		Insere a venda		INSERT INTO
6		Testa erros			@@ERROR
7		Confirma			COMMIT
8		Mostra resultado	SELECT TOP (10)     */

BEGIN TRANSACTION -- Iniciando uma transação

-- Declarando variáveis
DECLARE @cliente_id INT = 1             -- Cliente para o pedido (João Silva).
DECLARE @produto_id INT = 2             -- Produto comprado (Smartphone).
DECLARE @quantidade INT = 3             -- Quantidade comprada (3 unidades).
DECLARE @valor_total MONEY     -- Valor total do pedido.
DECLARE @data_venda DATETIME = GETDATE() -- Data atual da venda.
DECLARE @status_transacao VARCHAR(50)    -- Status da transação.

-- Calculando o valor total da venda (preço do produto * quantidade)
SELECT @valor_total = p.preco * @quantidade
FROM TB_PRODUTOS p
WHERE p.produto_id = @produto_id

-- exibir o resultado do SELECT acima
SELECT @valor_total AS valor_total

-- Validação para garantir que a quantidade seja válida (maior que 0)
IF @quantidade <= 0
BEGIN
	SET @status_transacao = 'Falha: Quantidade inválida'
	ROLLBACK TRANSACTION -- Revertendo a transação caso a quantidade seja inválida
	PRINT @status_transacao
	RETURN
END

-- Inserindo a venda na tabela 'vendas' usando as variáveis
INSERT INTO TB_VENDAS (cliente_id, produto_id, quantidade, data_venda, valor_total)
VALUES (@cliente_id, @produto_id, @quantidade, @data_venda, @valor_total)

-- Validando o sucesso da inserção
IF @@ERROR <> 0
BEGIN
	SET @status_transacao = 'Falha: Erro na inserção da venda'
	ROLLBACK TRANSACTION -- Revertendo a transação caso haja erro na inserção
	PRINT @status_transacao
	RETURN
END

-- Tudo ocorreu bem, confirmar a transação
COMMIT TRANSACTION
SET @status_transacao = 'Sucesso: Venda registrada com sucesso'
PRINT @status_transacao

SELECT 
	TOP (10) *
FROM TB_VENDAS
