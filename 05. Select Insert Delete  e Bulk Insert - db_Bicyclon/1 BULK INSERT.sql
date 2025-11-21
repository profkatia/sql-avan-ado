use db_Bicyclon

set language brazilian

-- a versão do arquivo precisa ser .CSV
-- inserir alto volume de registros 
-- ( mais utilizado no mercado de trabalho )

-- bulk = massa
-- insert = inserir
-- Nome da Tabela

	bulk insert TB_PRODUTO	
	-- informe o local completo do arquivo
	from 'c:\Importar dados para o SQL Server\Nome_Arquivo.csv'
	with (
		fieldterminator = ';', -- caracter separador do arquivo .csv
		codepage = '65001' -- equivalente UTF8 ( permite a correta escrita de acentos e caracteres especiais )
		)




