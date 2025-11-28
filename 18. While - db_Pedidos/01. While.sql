USE db_Pedidos
/*
Atualização de CPF com WHILE
----------------------------------------
Banco de dados: db_Pedidos
Tabela: TB_FORNECEDOR

Você trabalha com uma tabela chamada TB_FORNECEDOR, que contém os 
dados dos fornecedores da empresa.
Cada fornecedor possui um campo CNPJ, mas em alguns casos o valor 
armazenado ali é, na verdade, um CPF (11 dígitos).

Sua tarefa é:

	Criar um código SQL que percorra todos os fornecedores da tabela, 
	um por um, e copie o valor do campo CNPJ para o campo CPF apenas 
	quando o valor do CNPJ tiver exatamente 11 caracteres.

Pede-se:
========

1) Criar um código SQL utilizando a estrutura de repetição WHILE.

2) O código deve percorrer, linha por linha, todos os registros 
da tabela TB_FORNECEDOR, utilizando a coluna COD_FORNECEDOR como referência de controle.

3) Em cada linha, o código deve:

	Remover os espaços do valor da coluna CNPJ utilizando a função TRIM

	Verificar se o valor do CNPJ possui exatamente 11 caracteres

	Caso essa condição seja verdadeira, copiar esse valor para a 
	coluna CPF do mesmo fornecedor.

4) Caso o valor do CNPJ não tenha 11 caracteres, nenhuma 
ação deve ser realizada.

5) Ao final da execução, o campo CPF deve conter os valores do CNPJ 
apenas nos casos em que o CNPJ representava, na verdade, um CPF.


INFORMAÇÕES ADICIONAIS APÓS CRIARMOS O CÓDIGO
---------------------------------------------
Explicando em partes:
WHILE				= é uma estrutura de repetição, parecida com “enquanto” em português.

@id IS NOT NULL		= garante que a variável @id tem um valor válido (não está vazia).

@id <= @max_id		= verifica se o @id ainda está dentro do intervalo desejado, ou seja, não passou do último código de fornecedor.

Os dois juntos garantem que o loop só continue se o @id estiver válido e ainda houver registros para processar.

*/

-- Declara uma variável para controlar o ID atual no loop
DECLARE @id INT

-- Declara uma variável para armazenar 
-- o maior ID da tabela (limite do loop)
DECLARE @max_id INT

-- Declara uma variável para armazenar 
-- temporariamente o valor do CNPJ da linha atual
DECLARE @cnpj NVARCHAR(50)

-- Declara variável para armazenar a 
-- quantidade que será atualizada
DECLARE @qtde_alteracoes INT

-- Inicializa a variável @id com o 
-- menor ID da tabela TB_FORNECEDOR
SELECT @id = MIN(COD_FORNECEDOR) FROM TB_FORNECEDOR

-- Inicializa a variável @max_id com o 
-- maior ID da tabela TB_FORNECEDOR
SELECT @max_id = MAX(COD_FORNECEDOR) FROM TB_FORNECEDOR


-- Verifica quantos registros têm 
-- CNPJ com exatamente 11 caracteres
SELECT @qtde_alteracoes = COUNT(*)
FROM TB_FORNECEDOR
WHERE LEN(TRIM(CNPJ)) = 11;

-- Mostra na tela a quantidade de 
-- registros que podem ser atualizados
PRINT 'Qtde de registros a serem atualizados: ' + CAST(@qtde_alteracoes AS VARCHAR)


-- Inicia o loop que vai de @id(menor) até @max_id(último),
-- para percorrer cada fornecedor
-- TRADUÇÃO: Enquanto o valor de @id não for nulo e for menor ou igual 
-- ao valor de @max_id, continue executando o bloco de comandos
WHILE @id IS NOT NULL AND @id <= @max_id
BEGIN
    -- Busca o valor do CNPJ da linha atual, removendo espaços antes e depois usando TRIM
    SELECT @cnpj = TRIM(CNPJ)
    FROM TB_FORNECEDOR
    WHERE COD_FORNECEDOR = @id

    -- Verifica se o CNPJ não é nulo e tem exatamente 11 caracteres (indicando CPF)
    IF @cnpj IS NOT NULL AND LEN(@cnpj) = 11
    BEGIN
        -- Atualiza o campo CPF da linha atual com o valor do CNPJ (CPF)
        UPDATE TB_FORNECEDOR
        SET CPF = @cnpj
        WHERE COD_FORNECEDOR = @id
    END

    -- Atualiza a variável @id para o próximo ID maior que o atual,
    -- garantindo que mesmo IDs não sequenciais sejam tratados
    SELECT @id = MIN(COD_FORNECEDOR)
    FROM TB_FORNECEDOR
    WHERE COD_FORNECEDOR > @id
END


SELECT 
      NOME,  
      CNPJ,    
      CPF
FROM TB_FORNECEDOR
WHERE LEN(CPF) = 11