-- Criando a tabela PRODUTO
CREATE TABLE PRODUTO (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  quantidade INT NOT NULL,
  preco DECIMAL(10,2) NOT NULL
);

-- Criando a tabela VENDA
CREATE TABLE VENDA (
  id SERIAL PRIMARY KEY,
  produto_id INT REFERENCES PRODUTO(id),
  data_venda DATE NOT NULL,
  quantidade INT NOT NULL
);

-- Inserindo dados na tabela PRODUTO
INSERT INTO PRODUTO (nome, quantidade, preco)
VALUES
  ('Notebook Dell', 10, 4000.00),
  ('Teclado Logitech', 5, 120.00),
  ('Mouse Logitech', 20, 50.00);

-- Criando um trigger para atualizar a quantidade de produtos após a venda
CREATE TRIGGER atualiza_quantidade_produto
AFTER INSERT ON VENDA
FOR EACH ROW
BEGIN
  UPDATE PRODUTO
  SET quantidade = quantidade - NEW.quantidade
  WHERE id = NEW.produto_id;
END;

-- Inserindo uma venda
INSERT INTO VENDA (produto_id, data_venda, quantidade)
VALUES
  (1, '2023-02-09', 2);

-- Consultando a quantidade de produtos após a venda
SELECT *
FROM PRODUTO;
