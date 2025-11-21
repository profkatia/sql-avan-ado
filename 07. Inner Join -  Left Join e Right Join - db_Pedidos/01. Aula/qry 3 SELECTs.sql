use db_Pedidos;

set language brazilian;

-- TB_CLIENTE
-- 1) retorne somente a coluna: Cidade
Select	 	 
	 CIDADE
From TB_CLIENTE
Order By CIDADE;

-- 2) TB_CLIENTE
-- a) retorne as CIDADES SEM DUPLICIDADE
Select
	 Distinct -- remove as duplicidades
	 CIDADE
From TB_CLIENTE
Order By CIDADE;

-- 3) 
-- RTRIM() = Remove os espaços à direita do texto
-- LTRIM() = Remove os espaços à esquerda do texto
-- TRIM() = ** é o melhor ** Remove os espaços à esquerda e à direita do texto
Select
	 Distinct
	 Trim(CIDADE)
From TB_CLIENTE
Order By Trim(CIDADE);

/* 
4) 

Funções: LEN, SUBSTRING

LEN: a função LEN() retorna o comprimento(tamanho) de um texto, conta a
quantidade de "dígitos/caracteres" do texto, no Excel equivale a função
=Núm.Caract()

SUBSTRING: a função SUBSTRING() extrai alguns caracteres de um texto, seu
principlamente objetivo é cortar o TEXTO de acordo com a posição no Excel
equivale a função =Ext.Texto()
*/
Select 
	NOME,
	LEN(CEP_COB) as [QTDE CARACTERES],
	CEP_COB,
	SUBSTRING(CEP_COB,1,5) + '-' + SUBSTRING(CEP_COB,6,3) as CEP
From TB_CLIENTE
Where LEN(TRIM(CEP_COB)) = 8




