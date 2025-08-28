CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

insert into cliente values
(1, 'Davi', '12385694550', '83997569364', 'davi34@gmail.com'),
(2, 'Pedro', '19345783490', '83745890457', 'pedro9@gmail.com'),
(3, 'Maria', '98765432100', '83988887777', 'maria.souza@gmail.com'),
(4, 'Ana', '45612378911', '83996665544', 'ana.lima@gmail.com'),
(5, 'José', '19239495939', '83848384854', 'jose@gmail.com'),
(6, 'João Feijão', '146508459012', '8392834587', 'feijaobom@gmail.com');



CREATE TABLE veiculo (
    id_veiculo SERIAL PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(50),
    ano INT,
    categoria VARCHAR(50), -- SUV, Sedan, Hatch, etc.
    preco_diaria NUMERIC(10,2),
    disponivel BOOLEAN DEFAULT TRUE
);

INSERT INTO veiculo VALUES
(1, 'Onix', 'Chevrolet', 2022, 'Hatch', 120.00, TRUE),
(2, 'Corolla', 'Toyota', 2021, 'Sedan', 200.00, TRUE),
(3, 'Compass', 'Jeep', 2023, 'SUV', 300.00, TRUE),
(4, 'HB20', 'Hyundai', 2020, 'Hatch', 110.00, TRUE),
(5, 'X3','BMW', 2024, 'SUV', 600.00, TRUE ),
(6, 'Uno', 'Fiat', 2006, 'Hatch', 50.00, TRUE),
(7, 'Classic', 'Chevrolet', 2016, 'Hatch', 70.00, TRUE),
(8, 'Gol', 'Wolkswagen', 2012, 'Hatch', 70.00, TRUE);


CREATE TABLE aluguel (
    id_aluguel SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES Cliente(id_cliente),
    id_veiculo INT REFERENCES Veiculo(id_veiculo),
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    valor_total NUMERIC(10,2)
);

INSERT INTO aluguel VALUES
(1, 1, 2, '2025-08-01', '2025-08-08', 200.00 * 7), -- Pega o valor do aluguel e multiplica pelos dias
(2, 2, 1, '2025-08-03', '2025-08-06', 120.00 * 3), 
(3, 3, 3, '2025-08-10', '2025-08-15', 300.00 * 5), 
(4, 4, 4, '2025-08-15', '2025-08-20', 110.00 * 5); 


-- Liste o nome do cliente e o modelo do veículo que ele alugou.
create view Consulta1 as
select cliente.nome as nome_cliente, 
veiculo.modelo as modelo_veiculo
from aluguel    --aluguel como tabela principal, serve como uma ponte entre cliente e veiculo
join cliente on aluguel.id_cliente = cliente.id_cliente -- une o aluguel com o cliente
join veiculo on aluguel.id_veiculo = veiculo.id_veiculo; -- une o aluguel com o veiculo

select * from Consulta1;

-- Liste todos os alugueis com mais de R$ 1000,00, exibindo: nome do cliente, modelo do veículo, valor_total.
create view Consulta2 as
select cliente.nome as nome_cliente,
veiculo.modelo as modelo_veiculo,
aluguel.valor_total
from aluguel -- a tabela aluguel será a ponte
inner join cliente on aluguel.id_cliente = cliente.id_cliente
inner join veiculo on aluguel.id_veiculo = veiculo.id_veiculo
where aluguel.valor_total > 1000;

select * from Consulta2;

-- Liste todos os veículos que nunca foram alugados
create view Consulta3 as
select veiculo.modelo as veiculos_nunca_alugados
from veiculo -- pra pegar todos os veículos
left join aluguel on veiculo.id_veiculo = aluguel.id_veiculo
where aluguel.id_veiculo is NULL; -- pega os que não têm junção 

select * from Consulta3;

--Calcule o valor total de aluguéis realizados na loja.
-- não sei se é o valor total ou a quantidade, fiz a quantidade
create view Consulta4 as
select count(id_aluguel) as quantidade_alugueis
from aluguel;
select * from Consulta4;

--Mostre o número de veículos alugados por categoria (SUV, Sedan, etc.).
select veiculo.categoria,
veiculo.id_veiculo
from aluguel
join veiculo on aluguel.id_veiculo = veiculo.id_veiculo







