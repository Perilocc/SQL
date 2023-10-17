CREATE DATABASE dev;
USE dev;

CREATE TABLE linguagens(
	nome VARCHAR(40),
    categoria VARCHAR(10),
    Uso CHAR
);

INSERT INTO linguagens
(nome, categoria, Uso, id)
VALUES
('HTML', 'Front', 'Não', 1),
('Python', 'Back', 'Sim', 2);

SELECT * FROM linguagens;
SELECT nome, categoria FROM linguagens;

ALTER TABLE linguagens ADD COLUMN id INT; -- Adiciona a coluna id inteiro na tabela linguagens

UPDATE linguagens SET nome = 'JS' WHERE id = 1; -- Atualiza o nome do item presente no id 1 para JS
UPDATE linguagens SET Uso = 'Sim' WHERE id = 1;

DELETE FROM linguagens WHERE id = 1;

-- SET sql_safe_updates = 0;

SELECT * FROM linguagens WHERE nome LIKE 'Python'; -- Like é utilizado para achar ou confirmar a existência de uma string específica

UPDATE linguagens set id = 2 WHERE nome LIKE "HTML"; -- Atualiza o número do id para 2 onde tiver o nome HTML
UPDATE linguagens set id = 1 WHERE nome LIKE "Python"; -- mesmo caso do acima, onde tiver o nome Python

INSERT INTO linguagens
(nome, categoria, Uso, id)
VALUES
('CSS', 'Front', 'Não', 3);

SELECT * FROM linguagens WHERE categoria LIKE 'F%';  /* F% Serve para buscar todas as palavras que comecem com F, e se for %F, 
busca as que terminam em F.*/

SELECT * FROM linguagens WHERE categoria LIKE 'Banco' OR categoria LIKE 'Front';

SELECT * FROM linguagens WHERE nome LIKE "_t%"; /* _t Serve para achar uma estrutura que comece com uma letra qualquer, em seguida t 
e depois uma letra qualquer.*/

SELECT * FROM linguagens WHERE categoria LIKE "%o%"; -- Seleciona todos os dados, se o nome da categoria possuir o em sua composição silábica

INSERT INTO linguagens
(nome, categoria, Uso, id)
VALUES
('JS', 'Front', 'Não', 4);

INSERT INTO linguagens -- Inserção de dados manualmente
(nome, categoria, Uso, id)
VALUES
('React', 'Front', 'Não', 5),
('Ruby','Back','Nâo',6),
('Sql', 'Banco', 'Sim', 7),
('C', 'Back', 'Sim', 8);

SELECT * FROM linguagens WHERE categoria LIKE "_ront"; /* Busca os termos com essa estrutura de uma letra qualquer + ront.*/
SELECT * FROM linguagens WHERE categoria LIKE "Ba_co"; /* Busca os termos com essa estrutura de Ba + uma letra qualquer + co.*/
SELECT * FROM linguagens WHERE categoria LIKE 'Banco' OR categoria LIKE 'Front'; -- Exemplo igual ao exemplo lá em cima
SELECT * FROM linguagens WHERE categoria NOT LIKE 'Banco'; -- Seleciona todos os dados da tabela linguagens, exceto aqueles em que a categoria é banco;

SELECT nome, categoria, id FROM linguagens WHERE id IN(1, 4, 5); -- Seleciona os dados baseados em seus respectivos id's
SELECT nome, categoria, id FROM linguagens WHERE nome IN('JS', 'Python', 'CSS'); /* Busca de forma comum e pelo nome, id ou outra coluna */

SELECT nome FROM linguagens WHERE id IN (1, 2, 5) OR categoria = 'Banco'; /* Pode se utilizar com WHERE os termos or, and, not para 
combinar características e obter filtros*/
SELECT nome FROM linguagens WHERE id = 7 AND categoria = 'Banco';
SELECT * FROM linguagens WHERE NOT id = 5;
/* Or: O operador Or exige que pelo menos um dos requisitos seja verdadeiro para realizar a busca dos dados;
AND: O operador AND exige que ambos os requisitos sejam atendidos para realizar a busca;
Not: O operador NOT nega a condição escrita a seguir e busca tudo aquilo que não se encaixa em tal classificação;*/

SELECT * FROM linguagens;
SELECT DISTINCT nome FROM linguagens; /* Através do Distinct pode-se obter apenas os dados distintos de uma tabela.*/
DELETE FROM linguagens WHERE id IN(5, 6, 7, 8); /* Apaguei todos os dados iguais e depois introduzi os dados apagados com os comandos salvos
na linha 53.*/

SELECT * FROM linguagens ORDER BY id ASC LIMIT 0, 4 ; /* O Limit serve para delimitar quais linhas devem ser buscadas.
Nesse caso, ele iniciará a busca na linha 0 e a partir dali, os próximos das 4 linhas seguintes baseando-se nos requisitos.
E em conjunto com ORDER BY ... ASC ou DESC, pode-se filtrar em ordem ascendente e descendente.*/ 

SELECT * FROM linguagens LIMIT 5, 8;
SELECT * FROM linguagens LIMIT 5 OFFSET 3; /* OFFSET omite a quantidade de linhas, o número seguinte ao OFFSET é a quantidade de
linhas que serão ocultadas da busca*/
SELECT * FROM linguagens WHERE id BETWEEN 1 AND 5; -- Busca e mostra todos os id's entre 1 e 5
SELECT * FROM linguagens WHERE id NOT BETWEEN 1 AND 4;

SELECT * FROM linguagens ORDER BY id DESC; -- ORDER BY funciona para ordenar uma sequência seja ela de forma crescente ou decrescente 
SELECT * FROM linguagens ORDER BY categoria ASC;
SELECT * FROM linguagens WHERE id > 3 ORDER BY id DESC;

CREATE TABLE cursos(
	nome VARCHAR(40),
    categoria VARCHAR(10), 
    preco FLOAT(5, 2),
    inscritos INT
);

INSERT INTO cursos
(nome, categoria, preco, inscritos) 
VALUES 
('Dev em Dobro', 'Front', 39.90, 1450),
('EmpowerData', 'Dados', 27.70, 950),
('Dev Samurai', 'All', 100, 1743),
('Alura', 'All', 65.40, 760)
;

-- Campos Calculados

SELECT nome, categoria, preco, inscritos, preco - 10.0 AS promoção FROM cursos; /* fará a seleção das colunas a seguir, e adicionará uma coluna
chamada promoção que representa a coluna preco com seus valores subtraídos em 10*/
SELECT nome, categoria, preco, inscritos, preco + 10 AS inflação FROM cursos ORDER BY preco DESC;
SELECT SUM(preco) AS soma FROM cursos WHERE categoria = 'All'; -- Soma os valores da coluna preco e armazena em uma coluna chamada soma
SELECT AVG(preco) FROM cursos; -- Realiza o cálculo da média aritmética dos preços
SELECT MAX(preco) FROM cursos; -- Valor max
SELECT MIN(preco) FROM cursos; -- Valor min
SELECT COUNT(*) FROM linguagens; -- Conta o número de linhas na tabela
SELECT COUNT(preco) FROM cursos WHERE categoria = 'All';
SELECT COUNT(*) AS contagem FROM cursos WHERE categoria ='Dados';

-- GROUP BY

SELECT categoria, COUNT(categoria) AS qtd FROM linguagens WHERE id > 0 GROUP BY categoria HAVING qtd >= 1;
-- Group by faz o agrupamento de campos de agregação como as clausulas max, min, sum, count para que sejam divididos baseado em sua categoria

SELECT Uso, COUNT(id) AS contagem_ids FROM linguagens WHERE id <> 5 GROUP BY Uso;


