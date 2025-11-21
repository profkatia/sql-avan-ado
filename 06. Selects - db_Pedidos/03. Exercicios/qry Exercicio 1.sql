
-- A) ATENÇÃO COLOQUE O NOME DO BANCO DE DADOS ***
use db_Pedidos 

-- B) Coloque o código para formatação no padrão brasileiro
set language brazilian
-- Exercicios com SELECT
-------------------------------------------------------------------------------------------
-- 1) retorne as colunas: NOME, FANTASIA, CIDADE
-- origem: TB_CLIENTE
-- 562 registros
select
	NOME, 
	FANTASIA, 
	CIDADE
from TB_CLIENTE
-------------------------------------------------------------------------------------------
-- 2) retorne as colunas: NOME, FANTASIA, CIDADE
-- origem: TB_CLIENTE
-- filtre: CIDADE = Rio de Janeiro
-- 21 registros
select
	NOME, 
	FANTASIA, 
	CIDADE
from TB_CLIENTE
where CIDADE = 'Rio de Janeiro'

-------------------------------------------------------------------------------------------
-- 3) retorne as colunas: FANTASIA, ESTADO
-- origem: TB_CLIENTE
-- filtre: ESTADO = 'MINAS GERAIS'
-- 42 registros
select	
	FANTASIA, 
	ESTADO
from TB_CLIENTE
where ESTADO = 'MG'
-------------------------------------------------------------------------------------------
-- 4) retorne as colunas: BAIRRO, NOME, FANTASIA
-- origem: TB_CLIENTE
-- filtre os BAIRROS = BRÁS, CASA VERDE, CENTRO, IPIRANGA
-- classifique BAIRRO em ordem alfabética
-- 97 registros
select	
	BAIRRO, 
	NOME,
	FANTASIA
from TB_CLIENTE
where BAIRRO in ('BRAS', 'CASA VERDE', 'CENTRO', 'IPIRANGA')
order by BAIRRO
-------------------------------------------------------------------------------------------
-- 5) retorne as colunas: NOME, SALARIO, PREMIO_MENSAL
-- origem: TB_EMPREGADO
-- filtre o NOME que contém OLIVEIRA
-- classifique NOME em ordem alfabética
-- 8 registros retornados
select
	NOME, 
	SALARIO, 
	PREMIO_MENSAL
from TB_EMPREGADO
where NOME like '%OLIVEIRA%'
order by NOME
-------------------------------------------------------------------------------------------
-- 6) retorne as colunas: NOME, SALARIO, PREMIO_MENSAL
-- origem: TB_EMPREGADO
-- filtre o SALARIO maior do que três mil
-- classifique SALARIO do maior para o menor
-- formate as colunas SALARIO e PREMIO_MENSAL para o padrão brasileiro(contábil R$)
-- 22 registros retornados  
select
	NOME, 
	format(SALARIO, 'c', 'pt-br') as [SALARIO], 
	format(PREMIO_MENSAL, '') as [PRÊMIO MENSAL] 
from TB_EMPREGADO
where SALARIO >= 3000
order by SALARIO desc
-------------------------------------------------------------------------------------------
-- 7) retorne as colunas: NOME, SALARIO, PREMIO_MENSAL
-- origem: TB_EMPREGADO
-- filtre o PREMIO_MENSAL menor do que mil reais
-- classifique PREMIO_MENSAL do maior para o menor
-- formate as colunas SALARIO e PREMIO_MENSAL para o padrão brasileiro(contábil R$)
-- 36 registros 
select
	NOME, 
	format(SALARIO, 'c', 'pt-br') as [SALARIO], 
	format(PREMIO_MENSAL, '') as [PRÊMIO MENSAL] 
from TB_EMPREGADO
where PREMIO_MENSAL < 1000
order by PREMIO_MENSAL desc





