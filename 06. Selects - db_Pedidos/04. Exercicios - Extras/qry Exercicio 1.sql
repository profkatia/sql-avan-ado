use db_Pedidos 

set language brazilian

  -- 8) retorne as colunas COD FORNECEDOR, NOME, NOME FANTASIA, FISICA_JURIDICA, BAIRRO
  -- origem: TB FORNECEDOR
  -- filtre: NOME com início 'AÇO' e BAIRRO igual 'ACLIMAÇÃO'
  -- 1 registro retornado
  select 
	COD_FORNECEDOR, 
	NOME, 
	NOME_FANTASIA, 
	FISICA_JURIDICA, 
	BAIRRO
  from TB_FORNECEDOR
  WHERE NOME like 'ACO%' and BAIRRO = 'ACLIMACAO'
  -------------------------------------------------------------------------------------------
  
  -- 9) retorne as colunas: COD FORNECEDOR, NOME, NOME FANTASIA, FISICA_JURIDICA, BAIRRO
  -- origem: TB FORNECEDOR
  -- filtre: NOME com início 'ACO' e BAIRRO igual 'móoca'
  -- 3 registros retornados
 select 
	COD_FORNECEDOR, 
	NOME, 
	NOME_FANTASIA, 
	FISICA_JURIDICA, 
	BAIRRO
  from TB_FORNECEDOR
  WHERE NOME like 'ACO%' and BAIRRO = 'MOOCA'
  -------------------------------------------------------------------------------------------
  -- 10) retorne as colunas: NOME, DATA ADMISSAO, SALARIO, SINDICALIZADO
  -- orgiem: TB EMPREGADO
  -- filtre: SINDICALIZADO igual a sim e o ano da DATA ADMISSAO igual à 1986
  -- classificado por salário crescente
  -- 5 linhas retornadas
 select
	NOME, 
	DATA_ADMISSAO, 
	SALARIO, 
	SINDICALIZADO	
 from TB_EMPREGADO
 where SINDICALIZADO = 'S' and
	   year(DATA_ADMISSAO) = 1986





