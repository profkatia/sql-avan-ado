use db_Pedidos

set language brazilian

/*
1) TB_CARGO 
Com base no << Case When >> quando o SALARIO_INIC for 
menor ou igual à 1200 mostre o resultado 'Bom' senão 'Alto'
o nome da coluna será SITUAÇÃO

classifique em ordem crescente a coluna SALARIO_INIC

*/
  Select 
	[COD_CARGO],
    [CARGO],
    [SALARIO_INIC],
  Case When
	SALARIO_INIC <=1200 Then 'Baixo'
  Else
	 'Alto'
  End 'Situação'
  From TB_CARGO
  Order By SALARIO_INIC
  
--------------------------------------------------------------------------------------

/*
2) TB_EMPREGADO 
Com base no << Case When >> 
Quando o SALARIO < 3000 então 'Rever aumento'
Quando o SALARIO >= 3000 e SALARIO <= 8000 então 'Bom'
Quando o SALARIO for NULL então 'Analisar'

O nome da coluna será: Análise Salarial

classifique DESC a coluna SALARIO

*/

select 
	NOME,
	SALARIO,
	case when SALARIO < 3000 then 'Rever aumento'
		when SALARIO >= 3000 and SALARIO <= 8000 then 'Bom'
		when SALARIO is null then 'Analisar'
	else
		'Excelente'
	end 'Análise salarial'
from TB_EMPREGADO
order by SALARIO desc
--------------------------------------------------------------------------------------
/*
3) TB_CARGO X TB_EMPREGADO
utilize INNER JOIN 
Com base no << Case When >> quando o SALARIO for 
menor ou igual à 4900 'Razoável'
menor ou igual à 8000 'Bom'
caso contrário 'Alto'

classifique a coluna SALARIO em ordem do maior para o menor

o nome da coluna será ANÁLISE SALARIAL
*/
Select 
	EMP.NOME,
	CARGO.CARGO,
	EMP.SALARIO,
	Case When EMP.SALARIO <=4900 Then 'Razoável'
		When EMP.SALARIO > 4900 AND EMP.SALARIO <=8000 Then 'Bom'
	Else
		'Alto'
	End 'Análise Salarial'	
From TB_CARGO as CARGO
		inner join TB_EMPREGADO as EMP
			on CARGO.COD_CARGO = EMP.COD_CARGO
Order By EMP.SALARIO Desc;