/*
O comando USE no SQL Server define o banco de dados ativo
*/
use db_Bicyclon


/* configurar o Studio para:
set language brazilian

1) mensagens de erros
2) formatações para data(dd/mm/yyyy)
3) valores monetários R$ 0.000,00 

Definição: Microsoft 
Especifica o ambiente de idioma para a sessão. 
O idioma da sessão determina os formatos de datetime
e as mensagens de exibição em Português
*/

set language brazilian


-- 1) crie a tabela: TB_CLIENTE
create table TB_CLIENTE
(   
	IDCLIENTE int primary key identity(1,1), -- coluna numérica autonumeração
	IDREGIONAL int, -- campo numérico para FK
	NOME varchar(40) not null, -- campo texto não aceita Nulo
	EMAIL varchar(40) not null,
	CPF char(11) not null,
	PAIS varchar(50) not null,
	UF char(2) not null,
	CIDADE varchar(50) not null,
	BAIRRO varchar(50) not null,
	RUA varchar (50) not null,
	NUMERO int,
	COMPLEMENTO varchar(10)
)

-- 2) crie a tabela: TB_PEDIDO
CREATE TABLE TB_PEDIDO
(	
	IDPEDIDO int primary key identity(1,1), -- coluna numérica autonumeração
	IDCLIENTE int,
	IDVENDEDOR int,
	DATAPEDIDO datetime,
	QTDITENS int,
	VALORTOTAL money

)

-- 3) crie a tabela: TB_VENDEDOR
create table TB_VENDEDOR
(
	IDVENDEDOR int primary key identity(1,1), -- coluna numérica autonumeração
	IDREGIONAL int,
	NOME varchar(40) not null, -- campo texto não aceita Nulo
	EMAIL varchar(40) not null,
	CPF char(11) not null,
	PAIS varchar(50) not null,
	UF char(2) not null,
	CIDADE varchar(50) not null,
	BAIRRO varchar(50) not null,
	RUA varchar (50) not null,
	NUMERO int,
	COMPLEMENTO varchar(10)

)

-- 4) crie a tabela: TB_PRODUTO 
create table TB_PRODUTO
(
	IDPRODUTO int primary key identity(1,1), -- coluna numérica autonumeração
	NOME varchar(40) not null, -- campo texto não aceita Nulo
	LINHA varchar (100) not null,
	VALORUNITARIO money

)



-- 5) crie a tabela: TB_ITEM_PEDIDO
create table TB_ITEM_PEDIDO
(
	IDITEMPEDIDO int primary key identity(1,1), -- coluna numérica autonumeração
	IDPEDIDO int,
	IDPRODUTO int,
	QTD int,
	DESCONTO money,
	VALORITENS money

)

-- 6) crie a tabela: TB_REGIONAL
create table TB_REGIONAL
(
	IDREGIONAL int primary key identity(1,1), -- coluna numérica autonumeração
	NOME varchar(40) not null,
	DDD int,
	TELEFONE varchar(15),
	PAIS varchar(50) not null,
	UF char(2) not null,
	CIDADE varchar(50) not null,
	BAIRRO varchar(50) not null,
	RUA varchar (50) not null,
	NUMERO int,
	COMPLEMENTO varchar(10)

)


