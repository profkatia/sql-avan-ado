 /*
 Boas práticas ao escolher nomes de bancos no SQL Server:
 ========================================================
 Regras	
 ======
✅ Sem espaços	SQL não permite espaços em nomes (use _ ou CamelCase)	db_Bicyclon ou BicyclonDB
✅ Comece com letra	evita erro de sintaxe	db_Bicyclon, não 123Banco
✅ Evite acentos e caracteres especiais	para evitar problemas em servidores diferentes	Bicyclon, não Biciclón
✅ Use prefixos padrão (opcional)	“db_” é comum para indicar que é um banco	db_Vendas, db_Escola
✅ Seja claro e descritivo	o nome deve dizer para que serve	db_Livraria, db_CarroVenda
❌ Não use palavras reservadas do SQL	evite nomes como Database, Table, User
*/

CREATE DATABASE db_Bicyclon








