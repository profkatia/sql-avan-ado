USE db_Pedidos
set language brazilian

/*
O que é uma Stored Procedure? ( mais conhecida como PROC )
=============================
Uma Stored Procedure (ou procedimento armazenado) é um 
bloco de código SQL pré-compilado e armazenado no 
banco de dados que pode ser executado sempre que necessário.

Ela funciona como uma função ou rotina no banco de dados, 
que pode receber parâmetros, executar comandos SQL 
complexos, e retornar resultados.

Vantagens
=========
** Execução rápida
	A execução das stored procedures é mais rápida do que comandos SQL armazenados
	no CLIENT porque elas já tiveram sua sintaxe previamente verificada e foram
	otimizadas durante sua criação. Assim, as stored procedures poderão ser acessadas
	a partir do cache, depois de sua primeira execução.

** Tráfego na rede
	As stored procedures são capazes de diminuir a quantidade de dados que trafega
	pela rede.

** Segurança
	As stored procedures podem ser aproveitadas como um mecanismo de segurança,
	restringindo o acesso às tabelas.

** Programação modular
As stored procedures, após serem criadas, podem ser chamadas a partir de qualquer
aplicação, ou seja, elas oferecem uma programação modular.

Função do AS( obrigatório ):
============
O AS separa a definição da procedure do seu conteúdo. 
Ele diz ao SQL Server: 
“A partir daqui, vem o que a procedure realmente vai fazer.”

ATENÇÃO:
========
>>>>>>>> prefixo SP_ : no momento de atribuir nomes às stored procedures

*/

-- 1o passo - Crie uma Stored Procedure
CREATE PROCEDURE SP_LISTA_CLIENTE
AS BEGIN
	
	SELECT 
		CODCLI, NOME, ESTADO
	FROM TB_CLIENTE

END 

----------------------------------------------------------------------------------------
-- 2o passo - Executar uma Stored Procedure
EXEC SP_LISTA_CLIENTE


----------------------------------------------------------------------------------------
-- 3. Alterar uma Stored Procedure
ALTER PROCEDURE SP_LISTA_CLIENTE
AS BEGIN

	SELECT
		TOP (50) *
	FROM TB_CLIENTE


END


----------------------------------------------------------------------------------------
-- 4. Apagar (excluir) uma Stored Procedure
DROP PROCEDURE SP_LISTA_CLIENTE


----------------------------------------------------------------------------------------
/* 5. Criação e Execução de Stored Procedure com Parâmetro
A empresa Comercial Ideal deseja consultar o total de vendas 
mensais realizadas em um determinado ano. As informações 
estão armazenadas na tabela TB_PEDIDO, que contém os seguintes campos:

	A) DATA_EMISSAO = data da venda

	B) VLR_TOTAL = valor total da venda

Você foi encarregado de criar uma Stored Procedure que receba 
um ano como parâmetro e retorne, mês a mês, o total vendido no período.
----------------------------------------------------------------------------------------
Tarefas:
	Crie a Stored Procedure SP_TOT_VENDIDO que:

	Recebe um parâmetro chamado @ANO (tipo INT);

	Filtra os pedidos realizados no ano informado;

	Agrupa as vendas por mês e ano;

	Soma o valor total vendido (VLR_TOTAL);

	Ordena os resultados de Janeiro a Dezembro.

Testar a procedure com dois exemplos de anos:

	 ANO 2016

	 ANO 2017

*/
-- SEU CODIGO AQUI
CREATE PROCEDURE SP_TOT_VENDIDO @ANO INT
AS BEGIN
	
	

	SELECT
		YEAR(DATA_EMISSAO) AS ANO,
		MONTH(DATA_EMISSAO) AS MES,
		SUM(VLR_TOTAL) AS TOT_VENDIDO
	FROM TB_PEDIDO
	WHERE YEAR(DATA_EMISSAO) = @ANO
	GROUP BY YEAR(DATA_EMISSAO), MONTH(DATA_EMISSAO)
	ORDER BY MES

	PRINT 'ANO' + CAST(@ANO AS VARCHAR(10))

END

--- Testando
EXEC SP_TOT_VENDIDO 2016

EXEC SP_TOT_VENDIDO 2017

-----------------------------------------------------------------------------------------
/*
6. Este outro exemplo retorna todos os itens de pedido, 
permitindo filtro por período,
cliente e vendedor. Neste caso, os parâmetros @CLIENTE 
e @VENDEDOR não são
obrigatórios. Se forem omitidos, assumirão '%' como default
*/
CREATE PROCEDURE SP_ITENS_PEDIDO @DT1 DATETIME, 
								 @DT2 DATETIME, 
								 @CLIENTE VARCHAR(40) = '%', 
								 @VENDEDOR VARCHAR(40) = '%'
							
AS BEGIN 
	
	SELECT 
		I.NUM_PEDIDO,
		I.NUM_ITEM,
		I.ID_PRODUTO,
		I.QUANTIDADE,
		I.PR_UNITARIO,
		I.DESCONTO,
		I.DATA_ENTREGA,
		PE.DATA_EMISSAO,
		PR.DESCRICAO,
		C.NOME AS CLIENTE,
		V.NOME AS VENDEDOR
	FROM TB_PEDIDO PE
			JOIN TB_CLIENTE C
				ON PE.CODCLI = C.CODCLI
			JOIN TB_VENDEDOR V
				ON PE.CODVEN = V.CODVEN
			JOIN TB_ITENSPEDIDO I
				ON PE.NUM_PEDIDO = I.NUM_PEDIDO
			JOIN TB_PRODUTO PR
				ON PR.ID_PRODUTO = I.ID_PRODUTO
	WHERE PE.DATA_EMISSAO BETWEEN @DT1 AND @DT2 AND
		  C.NOME LIKE @CLIENTE AND V.NOME LIKE @VENDEDOR
	ORDER BY I.NUM_PEDIDO

END

-- PASSANDO TODOS OS PARÂMETROS
EXEC SP_ITENS_PEDIDO 
	@DT1 = '2016-01-01T00:00:00',
	@DT2 = '2016-01-31T23:59:59.997',
	@CLIENTE = '%A%', -- TUDO OS CLIENTES QUE CONTÉM A LETRA A
	@VENDEDOR = 'LEIA'

-- OMITINDO O NOME DO VENDEDOR
EXEC SP_ITENS_PEDIDO
	@DT1 = '2016-01-01T00:00:00',
	@DT2 = '2016-01-31T23:59:59.997',
	@CLIENTE = '%LTDA%'

-- OMITINDO O NOME DO CLIENTE
EXEC SP_ITENS_PEDIDO
	@DT1 = '2016-01-01T00:00:00',
	@DT2 = '2016-01-31T23:59:59.997',
	@VENDEDOR = '%LEIA%'






































