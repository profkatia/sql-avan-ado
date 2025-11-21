-- utilização do comando
-- SELECT com clausula WHERE(filtro)
use db_Pedidos


/* configurar o Studio para:
1) mensagens de erros
2) formatações para data(dd/mm/yyyy)
3) valores monetários R$ 0.000,00 

Definição: Microsoft 
Especifica o ambiente de idioma para a sessão. 
O idioma da sessão determina os formatos de datetime e as mensagens do sistema.
*/
set language brazilian

-- 1) tabela: TB_Cliente
-- filtrar os registros onde o Estado = SP
select 
	NOME, 
	FANTASIA, 
	CIDADE, 
	ESTADO -- campos da tabela
from TB_CLIENTE -- tabela origem(onde os dados estão)
where ESTADO = 'SP' -- filtrar pela coluna

-------------------------------------------------------------------------------------------
/* 2) tabela: TB_Cliente
filtrar os registros por
Estado = SP 
*/
select 
	NOME, 
	FANTASIA, 
	E_MAIL, 
	ICMS 
from TB_CLIENTE
where ESTADO='SP'

-------------------------------------------------------------------------------------------

/* 3) tabela: TB_Cliente
filtrar os registros na coluna Nome que começam com JOSE ou Maria
*/
--COMANDO LIKE
select 
	NOME, 
	CNPJ, 
	ICMS 
from TB_CLIENTE
where  NOME LIKE 'JOSE%' or NOME LIKE 'MARIA%'
-------------------------------------------------------------------------------------------

/* 4) tabela: TB_CLIENTE
retornar somente os registros  
onde a coluna Nome contém Sousa ou Souza
*/
select
	CODCLI,
	NOME, 
	CIDADE, 
	ESTADO, 
	E_MAIL
from TB_CLIENTE 
where NOME LIKE '%SOU[SZ]A%'

-------------------------------------------------------------------------------------------


/* 5) tabela: TB_CLIENTE
retornar todos os registros  
onde a coluna Nome contenha LTDA
*/

SELECT 
	NOME, 
	CIDADE, 
	ESTADO, 
	E_MAIL
FROM TB_CLIENTE 
WHERE NOME LIKE '%LTDA%';

-------------------------------------------------------------------------------------------

-- clausula where filtros com Datas

/* 6) tabela: TB_EMPREGADO
filtrar DATA_ADMISSAO >= '01-01-2000' AND DATA_ADMISSAO <='31-12-2000'
*/
select 
	   NOME, 
       format(DATA_ADMISSAO, 'dd/MM/yyyy') as ADMISSAO,
	   format(SALARIO, 'c', 'pt-br') as SALARIO,
	   format(PREMIO_MENSAL, 'c', 'pt-br') as [PREMIO MENSAL]
from TB_EMPREGADO 
where DATA_ADMISSAO >= '01-01-2000' AND DATA_ADMISSAO <='31-12-2000'

-------------------------------------------------------------------------------------------


-- 7)retornar os registros para o ANO específico ( É MAIS RAPIDO )
-- tabela: TB_EMPREGADO
select NOME,  
		 format(DATA_ADMISSAO, 'dd/MM/yyyy') as ADMISSÃO
from TB_EMPREGADO 
where YEAR(DATA_ADMISSAO) = 2000
-------------------------------------------------------------------------------------------

-- 8) tabela: TB_EMPREGADO
-- retornar os registros para os anos da LISTA (IN)
select 
	NOME,
	SALARIO,
	format(DATA_ADMISSAO, 'dd/MM/yyyy') as ADMISSAO
from TB_EMPREGADO 
where YEAR(DATA_ADMISSAO) IN (2000, 2005, 2010)
-------------------------------------------------------------------------------------------


/* 9) 
tabela: TB_EMPREGADO
retornar registros agrupados pela coluna: DATA_ADMISSAO
e somar a coluna SALARIO

*/

select 
	year(DATA_ADMISSAO) as ADMISSAO,	
	SALARIO as Total_Formatado	
from TB_EMPREGADO
order by year(DATA_ADMISSAO) asc 

----- agrupado fica neste modelo ( MELHOR E ENXUTO )
select 
	year(DATA_ADMISSAO) as ADMISSAO,	
	format(avg(SALARIO), 'R$ ###,##0.00') as Total_Formatado	
from TB_EMPREGADO
group by year(DATA_ADMISSAO)
order by year(DATA_ADMISSAO) asc 

-------------------------------------------------------------------------------------------
-- 10) tabela: TB_CLIENTE, retornar os registros da região SUDESTE
select 
	NOME, 
	ENDERECO, 
	CIDADE, 
	ESTADO 
from TB_CLIENTE 
where ESTADO in ('SP', 'RJ', 'ES', 'MG')
order by ESTADO asc -- ou desc

-------------------------------------------------------------------------------------------
-- 11) tabela: TB_CLIENTE
-- retornar os estados diferentes de: ('SP', 'RJ', 'ES', 'MG')
select 
	NOME, 
	ENDERECO, 
	CIDADE, 
	ESTADO 
from TB_CLIENTE 
where ESTADO NOT in ('SP', 'RJ', 'ES', 'MG')
order by ESTADO





