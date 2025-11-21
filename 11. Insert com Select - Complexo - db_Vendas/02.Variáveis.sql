/*
Variáveis
Uma variável local do Transact-SQL é um objeto nos scripts  que mantém
um valor de dado. Por meio do comando DECLARE, podemos criar variáveis locais,
sendo isto feito no corpo de uma procedure
*/
--Exemplo de declaração de variáveis

DECLARE @A INT =10;
DECLARE @B INT =20;
PRINT @A + @B

/*
Atribuindo valores às variáveis
É possível atribuir valores para cada uma das variáveis. Para tal, utilizamos o comando
DECLARE e  SET
*/
DECLARE @A INT =10, @B INT =20, @C INT;
SET @C = @A + @B;
PRINT @C;



