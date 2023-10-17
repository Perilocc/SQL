CREATE DATABASE vendas;
USE vendas;

CREATE TABLE vendedores(
	id_vendedor INT PRIMARY KEY,
    nome_vendedor VARCHAR(50)
);

INSERT INTO vendedores
(id_vendedor, nome_vendedor)
VALUES
(1, 'João'),
(2, 'Heitor'),
(3, 'Gabriel'),
(4, 'Fábio'),
(5, 'Pedro');

SELECT id_vendedor, nome_vendedor FROM vendedores;

CREATE TABLE clientes(
	id_cliente INT,
    nome_cliente VARCHAR(50),
    n_vendedor INT
);

INSERT INTO clientes
(id_cliente, nome_cliente, n_vendedor)
VALUES
(1, 'Isabele', 4),
(2, 'Rhaynan', 3),
(3, 'Samuel', 4),
(4, 'Rony', 2),
(5, 'Abel', 3),
(6, 'Miguel', 4),
(7, 'Eniberto', 2),
(8, 'William', 1),
(9, 'Jeff', 2),
(10, 'Jarvan', 3),
(11, 'Zoe', 4),
(12, 'Sion', 2),
(13, 'Jason', NULL),
(14, 'John', NULL)
;

SELECT id_cliente, nome_cliente, n_vendedor FROM clientes;

-- Junção de Tabelas
-- Case 1:
SELECT 
clientes.id_cliente,
clientes.nome_cliente,
clientes.n_vendedor,
vendedores.nome_vendedor
FROM clientes
INNER JOIN vendedores ON clientes.n_vendedor = vendedores.id_vendedor ORDER BY n_vendedor ASC; 
/* Nesse caso, juntamos a informação id do vendedor presente em ambas as tabelas, de modo que o sistema retome as informações juntas.
Porém, ele acaba omitindo os clientes que não foram atendidos por nenhum vendedor e os vendedores que não atenderam nenhum cliente.*/

-- Case 2:
SELECT 
clientes.id_cliente,
clientes.nome_cliente,
clientes.n_vendedor,
vendedores.nome_vendedor
FROM clientes
LEFT JOIN vendedores ON clientes.n_vendedor = vendedores.id_vendedor; 
/*Nesse caso, o LEFT serve para indicar qual tabela está sendo utilizada como base, que no caso é a tabela clientes, devido ao left,
e nela são expostos todos os clientes, até mesmo os que não foram atendidos por nenhum vendedor, que é o caso dos clientes 13 e 14*/

-- Case 3:
SELECT 
clientes.id_cliente,
clientes.nome_cliente,
clientes.n_vendedor,
vendedores.nome_vendedor
FROM clientes
RIGHT JOIN vendedores ON clientes.n_vendedor = vendedores.id_vendedor ORDER BY n_vendedor ASC;
/* Ness caso, mostra todos os vendedores através da base da tabela vendedores, até mesmo os que não atenderam nenhum cliente.*/

-- Case 4:
SELECT 
clientes.id_cliente,
clientes.nome_cliente,
clientes.n_vendedor,
vendedores.nome_vendedor
FROM clientes
RIGHT JOIN vendedores ON clientes.n_vendedor = vendedores.id_vendedor GROUP BY n_vendedor HAVING COUNT(n_vendedor) >= 1 ORDER BY n_vendedor ASC; 
/* Nesse caso, foi combinado a junção com group by e funções de agregação*/

-- União de Selects através do comando UNION

-- Tabela 1
CREATE TABLE contas_pagar(
	descricao VARCHAR(20),
    valor INT,
    vencimento VARCHAR(20)
);

INSERT INTO contas_pagar
(descricao, valor, vencimento)
VALUES
('Impostos', 70, '12-10-2023'),
('Luz', 100, '15-10-2023'),
('Aluguel', 750, '30-10-2023'),
('Água', 130, '15-10-2023')
;

-- Tabela 2
CREATE TABLE contas_receber(
	descricao VARCHAR(20),
    valor INT,
    vencimento VARCHAR(20)
);

INSERT INTO contas_receber
(descricao, valor, vencimento)
VALUES
('Venda', 300, '11-10-2023'),
('Venda', 100, '07-10-2023'),
('Venda', 30, '13-10-2023'),
('Venda', 100, '15-10-2023'),
('Reembolso', 150, '29-10-2023'),
('Reembolso', 75, '12-10-2023'),
('Devolução', 52, '10-10-2023')
;

-- Usos do UNION

-- Caso 1:
SELECT descricao, valor, vencimento FROM contas_pagar
UNION
SELECT descricao, valor, vencimento FROM contas_receber
ORDER BY vencimento ASC
;
/* Esse comando UNION serve para unir buscas de modo a relaciona-las, porém as colunas de ambas devem ser iguais para que seja
executada de forma correta.*/

-- Caso 2:
SELECT descricao, valor, vencimento, 'PAGAR' AS tipo FROM contas_pagar
UNION
SELECT descricao, valor, vencimento, 'RECEBER' AS tipo FROM contas_receber
ORDER BY tipo ASC
;
/* Uso do comando UNION com a criação de colunas e classificações.*/

-- Caso 3:
SELECT descricao, valor, vencimento, 'PAGAR' AS tipo FROM contas_pagar
UNION ALL
SELECT descricao, valor, vencimento, 'RECEBER' AS tipo FROM contas_receber
ORDER BY tipo ASC
;
/*Se alguma linha for idêntica a outra, da maneira normal do uso do UNION, apenas uma será exposta e a outra(s) será(ão) ocultada(s),
por isso se utiliza o ALL juntamente do UNION, para que todos os dados sejam expostos.
*/

-- Outros testes

SELECT SUM(valor), 'Despesa' AS tipo FROM contas_pagar
UNION
SELECT  SUM(valor), 'Capital' AS tipo FROM contas_receber
;

-- Declaração de resultados em variáveis e cálculo com variáveis;
SET @despesas = (SELECT SUM(valor) FROM contas_pagar); -- armazena o resultado do select em @despesas
SET @despesas = CAST(@despesas AS SIGNED); -- Converte o valor de @despesas em INT
SELECT @despesas;
SET @ganhos = (SELECT SUM(valor) FROM contas_receber);
SET @ganhos = CAST(@ganhos AS SIGNED);
SELECT @ganhos;
SELECT @ganhos - @despesas AS Receita;

-- GROUP BY

SELECT valor, COUNT(valor) AS contas FROM contas_pagar GROUP BY valor;

SELECT valor, COUNT(valor) AS contas FROM contas_pagar
UNION ALL
SELECT valor, COUNT(valor) AS contas FROM contas_receber GROUP BY valor HAVING contas > 1;













