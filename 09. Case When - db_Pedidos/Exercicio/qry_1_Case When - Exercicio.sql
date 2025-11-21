use db_Pedidos;

set language brazilian;


-- =============== EXERCICIO =====================================
/*
1) TB_EMPREGADO

Com base no << Case When >> quando o PREMIO_MENSAL for maior ou igual à 1300 'Ótimo' 
senão 'Bom'
o nome da coluna será 'Situação do Prêmio'
*/

Select NOME,
		DATA_ADMISSAO,
		PREMIO_MENSAL,
		Case When 
			PREMIO_MENSAL >= 1300 Then 'Ótimo'
		Else	
			'Bom'
		End 'SITUACAO DO PREMIO'
from TB_EMPREGADO
Order By PREMIO_MENSAL desc

-----------------------------------------------------------------------------------
/*
2) TB_PRODUTO

Com base no << Case When >> quando QTD_MINIMA for menor ou igual a zero 'Ruim' 
senão 'Bom'
o nome da coluna 'Nível de Estoque'

classifique em ordem crescente: QTD_MINIMA

*/

Select	
	DESCRICAO, 
	QTD_MINIMA,
	Case When
		QTD_MINIMA is null Then 'Ruim'
	Else
		'Bom'
	End 'NIVEL DE ESTOQUE'
from TB_PRODUTO
Order By QTD_MINIMA
-----------------------------------------------------------------------------------
/*
3) TB_PRODUTO

Com base no << Case When >> 
quando QTD_MINIMA for menor ou igual a 200 'Ruim' 
quando QTD_MINIMA for menor ou igual a 1000 'Bom'
senão 'Ótimo'

classifique em ordem crescente: QTD_MINIMA

*/
Select	
	DESCRICAO, 
	QTD_MINIMA,
	Case When
		QTD_MINIMA is null Then 'Ruim'
	When 
		QTD_MINIMA <= 200 Then 'Ruim'
	When 
		QTD_MINIMA <= 1000 Then 'Bom'
	Else
		'Ótimo'
	End 'NIVEL DE ESTOQUE'
from TB_PRODUTO
Order By QTD_MINIMA

-----------------------------------------------------------------------------------
/*
4) TB_CLIENTE X TB_PEDIDO X TB_VENDEDOR

utilize LEFT JOIN 

Mostre os campos: NOME, ESTADO, NOME VENDEDOR, NUM_PEDIDO, VLR_TOTAL

Com base no << Case When >> quando o VLR_TOTAL for 
menor ou igual à 100 'Não Atingiu Meta'
menor ou igual à 10000 'Atingiu Meta'
caso contrário 'Analisar'

classifique a coluna VLR_TOTAL em ordem do menor para o maior

o nome da coluna será 'Situação de Vendas'
*/

Select 
	CLIENTE.NOME,
	CLIENTE.ESTADO,
	VENDEDOR.NOME as VENDEDOR,
	PEDIDO.NUM_PEDIDO,
	PEDIDO.VLR_TOTAL ,
	Case When
		PEDIDO.VLR_TOTAL <= 100 Then 'Não Atingiu Meta'
	When
		PEDIDO.VLR_TOTAL <= 10000 Then 'Atingiu Meta'
	Else
		'Analisar'
	End 'SITUACAO DE VENDAS'
From TB_CLIENTE as CLIENTE
	left join TB_PEDIDO as PEDIDO
	on CLIENTE.CODCLI = PEDIDO.CODCLI
	left join TB_VENDEDOR as VENDEDOR
	on VENDEDOR.CODVEN = PEDIDO.CODVEN
Order By PEDIDO.VLR_TOTAL