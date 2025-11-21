use db_Pedidos
set language brazilian

/*
1) relacionar: TB_CLIENTE x TB_PEDIDO
a) retornar: TB_CLIENTE = COD_CLI, NOME
b) retornar: TB_PEDIDO = NUM_PEDIDO, VLR_TOTAL
c) classificar por CODCLI crescente
*/
select 
	CLIENTE.CODCLI,
	CLIENTE.NOME,
	PEDIDO.NUM_PEDIDO,
	PEDIDO.VLR_TOTAL
-- Origem TB_CLIENTE apelido(CLIENTE) unir 
-- com TB_PEDIDO apelido(PEDIDO) 
from TB_CLIENTE CLIENTE 
	join TB_PEDIDO PEDIDO
		on CLIENTE.CODCLI = PEDIDO.CODCLI
order by CLIENTE.CODCLI
------------------------------------------------------------------------------------
/*
2) relacionar: TB_CLIENTE x TB_PEDIDO x TB_VENDEDOR
a) retornar: TB_CLIENTE = CODCLI, NOME
b) retornar: TB_PEDIDO = NUM_PEDIDO, VLR_TOTAL
c) retornar: TB_VENDEDOR = NOME
d) exibir os clientes e seus pedidos onde o vendedor é o Gilson
*/
select 
	CLIENTE.CODCLI,
	CLIENTE.NOME,
	PEDIDO.NUM_PEDIDO,
	PEDIDO.VLR_TOTAL,
	VENDEDOR.NOME as [NOME VENDEDOR]
from TB_CLIENTE CLIENTE 
    join TB_PEDIDO PEDIDO
		on CLIENTE.CODCLI = PEDIDO.CODCLI
    join TB_VENDEDOR VENDEDOR
		on VENDEDOR.CODVEN = PEDIDO.CODVEN
where VENDEDOR.NOME = 'GILSON'
------------------------------------------------------------------------------------
/*
3) relacionar: TB_VENDEDOR x TB_PEDIDO
a) retornar: TB_VENDEDOR = CODVEN, NOME, VLR_TOTAL
b) formatar VLR_TOTAL contábil
c) mostre o [ TOTAL DE VENDAS ] por cada vendedor
d) arredonde o [ TOTAL DE VENDAS ] sem casas decimais   
e) classifique pelo NOME do vendedor
*/
select 
	VENDEDOR.CODVEN,	
	VENDEDOR.NOME as [NOME VENDEDOR],	
	format(round(sum (PEDIDO.VLR_TOTAL),0), '###,##0.') [TOTAL VENDIDO]
from TB_PEDIDO PEDIDO		
    join TB_VENDEDOR VENDEDOR
		on VENDEDOR.CODVEN = PEDIDO.CODVEN
group by VENDEDOR.CODVEN, VENDEDOR.NOME
order by VENDEDOR.NOME
------------------------------------------------------------------------------------
/* 
4) relacionar: TB_PEDIDO x TB_CLIENTE 
a) retornar: TB_PEDIDO = NUM_PEDIDO, DATA_EMISSAO
b) retornar: TB_CLIENTE = CODCLI, NOME, CIDADE, ESTADO
c) mostre os clientes da cidade Jundiai do estado SP 
   somente para o ano 2014
d) formatar coluna DATA_EMISSAO = dd/MM/yyyy
e) classificar DATA_EMISSAO crescente
*/
select 
	PEDIDO.NUM_PEDIDO, 
	CLIENTE.CODCLI, 	
	format(PEDIDO.DATA_EMISSAO, 'dd/MM/yyyy') [DATA EMISSAO],
	CLIENTE.NOME,
	CLIENTE.CIDADE,
	CLIENTE.ESTADO
from TB_PEDIDO PEDIDO 
	join TB_CLIENTE CLIENTE
		on PEDIDO.CODCLI = CLIENTE.CODCLI
where CLIENTE.CIDADE = 'JUNDIAI' and 
	  CLIENTE.ESTADO = 'SP' and
	  year(PEDIDO.DATA_EMISSAO) = 2014
order by PEDIDO.DATA_EMISSAO
------------------------------------------------------------------------------------
/*
5) TB_EMPREGADO X TB_CARGO
a) retornar: TB_EMPREGADO = NOME, DATA_ADMISSÃO, SALARIO
b) retornar: TB_CAGO = CARGO
c) mostre os colaboradores e seus cargos
*/
select
	EMPREGADO.NOME,
	EMPREGADO.DATA_ADMISSAO,
	EMPREGADO.SALARIO,
	CARGO.CARGO
from TB_EMPREGADO EMPREGADO
		join TB_CARGO CARGO
			on EMPREGADO.COD_CARGO = CARGO.COD_CARGO
order by EMPREGADO.NOME
------------------------------------------------------------------------------------
/*
6) TB_EMPREGADO X TB_CARGO X TB_DEPARTAMENTO
a) retornar: TB_EMPREGADO = NOME, DATA_ADMISSÃO, SALARIO
b) retornar: TB_CAGO = CARGO
c) retornar: TB_DEPARTAMENTO = DEPTO
c) mostre: os colaboradores com seus cargos e seus departamentos
*/
select
	EMPREGADO.NOME,
	EMPREGADO.DATA_ADMISSAO,
	EMPREGADO.SALARIO,
	CARGO.CARGO,
	DEPARTAMENTO.DEPTO
from TB_EMPREGADO EMPREGADO
		join TB_CARGO CARGO
			on EMPREGADO.COD_CARGO = CARGO.COD_CARGO
		join TB_DEPARTAMENTO DEPARTAMENTO
			on DEPARTAMENTO.COD_DEPTO = EMPREGADO.COD_DEPTO
order by EMPREGADO.NOME
------------------------------------------------------------------------------------
/*
7) TB_DEPARTAMENTO x TB_EMPREGADO
a) retornar: TB_DEPARTAMENTO = DEPTO
b) faça uma contagem do departamento 
c) mostre [ QTDE COLABORADOR ] por departamento
*/

-- neste resultado temos: DEPTO e NOME
select
	DEPARTAMENTO.DEPTO,
	EMPREGADO.NOME	
from TB_DEPARTAMENTO DEPARTAMENTO
		join TB_EMPREGADO EMPREGADO
			on DEPARTAMENTO.COD_DEPTO = EMPREGADO.COD_DEPTO
order by DEPARTAMENTO.DEPTO

-- nesta fase faremos a contagem inicial solicitada
select
	DEPARTAMENTO.DEPTO,
	count(DEPARTAMENTO.DEPTO) [QTDE COLABORADOR]	
from TB_DEPARTAMENTO DEPARTAMENTO
		join TB_EMPREGADO EMPREGADO
			on DEPARTAMENTO.COD_DEPTO = EMPREGADO.COD_DEPTO
group by DEPARTAMENTO.DEPTO
order by DEPARTAMENTO.DEPTO

