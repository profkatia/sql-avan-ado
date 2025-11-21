
/*
 1) TB_EMPREGADO
 LOCALIZE O REGISTRO SINDICALIZADO NULL E 
 ATUALIZE ESTE REGISTRO PARA 'S'

 lembre-se: 
 1º crie uma consulta para localizar o registro e entender o que deverá ser atualizado.

 2º UPDATE não pede desculpas, ou seja, utilize WHERE

 3º execute UPDATE sem WHERE somente se você tem 100% de certeza desta regra !( CUIDADO )
*/
select *	
from TB_EMPREGADO
where SINDICALIZADO = 'S'
order by SINDICALIZADO

-- SEU UPDATE ---- AQUI ----
UPDATE TB_EMPREGADO
SET SINDICALIZADO = 'S'
WHERE SINDICALIZADO is NULL

--------------------------------------------------------------------------------------------

-- 2) TB_EMPREGADO
-- PARA OS SALÁRIOS MENORES DO QUE 1000, REAJUSTAR OS SALÁRIOS EM 10% 
select * 
from TB_EMPREGADO
Where SALARIO < 1000

-- SEU UPDATE ---- AQUI ----
UPDATE TB_EMPREGADO
SET SALARIO =  SALARIO * 1.10
WHERE SALARIO < 1000

--------------------------------------------------------------------------------------------
-- 3) TB_DEPARTAMENTO
-- O DEPTO = 'CPD' PRECISA SER ATUALIZADO PARA 'TECNOLOGIA'
-- UPDATE ---- AQUI ----
SELECT 
	COD_DEPTO,
	DEPTO
FROM TB_DEPARTAMENTO
WHERE DEPTO = 'C.P.D.'

UPDATE TB_DEPARTAMENTO
SET DEPTO = 'TECNOLOGIA'
WHERE DEPTO = 'C.P.D.'

SELECT 
	COD_DEPTO,
	DEPTO
FROM TB_DEPARTAMENTO
WHERE DEPTO = 'TECNOLOGIA'
--------------------------------------------------------------------------------------------
-- 4) TB_EMPREGADO
-- O EMPREGADO CODFUN 2 'JOSE REIS' DESISTIU DE SER SINDICALIZADO E 
-- ELE IRÁ REVER JUNTO AO SINDICATO SUA SITUAÇÃO, SENDO ASSIM
-- PRECISAMOS CONSIDERA-LO COMO SINDICALIZADO NULL
select 
	NOME
	SALARIO,
	SINDICALIZADO
from TB_EMPREGADO
order by CODFUN

-- SEU UPDATE ---- AQUI ----
UPDATE TB_EMPREGADO
SET SINDICALIZADO = NULL
WHERE CODFUN = 2

