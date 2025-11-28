use db_Vendas
/*
Papel do sp_columns

A stored procedure sp_columns acessa os metadados da tabela e mostra:

1) Quais colunas existem

2) Tipos de dados e tamanhos

3) Se podem receber valores nulos (NULLABLE)

Em resumo:
sp_columns é uma ferramenta para inspecionar a estrutura de uma tabela, 
garantindo que você saiba exatamente o que pode ou não pode fazer com os dados armazenados.

Inclui nome da coluna, tipo de dado, tamanho, se permite nulo, etc.


*/


-- Se você quiser ver todas as colunas da tabela TB_CLIENTES:
EXEC sp_columns 'TB_CLIENTES'







