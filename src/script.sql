/*
 * Universidad de La Laguna
 * Asignatura: Administración y Diseño de Bases de Datos
 * Autor: Airam Rafael Luque León
 * Email: alu0101335148@ull.edu.es
 * Fecha: 2022-10-27
 * Descripción: Creación de la base de datos para viveros
 */

---------------------------------Pasos previos---------------------------------

DROP SCHEMA public CASCADE
CREATE SCHEMA public;

DROP TABLE IF EXIST VIVERO;
DROP TABLE IF EXIST ZONA;
DROP TABLE IF EXIST EMPLEADO;
DROP TABLE IF EXIST TRABAJA;
DROP TABLE IF EXIST PEDIDO;
DROP TABLE IF EXIST CLIENTE;

------------------------------Creación de tablas-------------------------------

CREATE TABLE VIVERO (
  ID_VIVERO INT PRIMARY KEY,
  NAME VARCHAR(50) NOT NULL
);



CREATE TABLE ZONA (
  ID_ZONA VARCHAR(50) PRIMARY KEY,
  ID_VIVERO INT PRIMARY KEY,
  CONSTRAINT FK_VIVERO_ZONA 
    FOREIGN KEY (ID_VIVERO) 
      REFERENCES VIVERO(ID_VIVERO) 
        ON DELETE CASCADE
);



CREATE TABLE EMPLEADO (
  ID_EMPLEADO INT PRIMARY KEY,
  NAME VARCHAR(50) NOT NULL,
);



CREATE TABLE TRABAJA (
  ID_EMPLEADO INT PRIMARY KEY,
  EPOCA_INICIO DATE NOT NULL,
  EPOCA_FINAL DATE,
  ID_ZONA VARCHAR(50),
  PRODUCTIVIDAD INT DEFAULT 0,
  CONSTRAINT FK_EMPLEADO_TRABAJA
    FOREIGN KEY (ID_EMPLEADO)
      REFERENCES EMPLEADO(ID_EMPLEADO)
        ON DELETE CASCADE,
  CONSTRAINT FK_ZONA_TRABAJA
    FOREIGN KEY (ID_ZONA)
      REFERENCES ZONA(ID_ZONA)
        ON DELETE SET NULL,
  CONSTRAINT CHECK_EPOCA
    CHECK (EPOCA_INICIO < EPOCA_FINAL),
  CONSTRAINT CHECK_PRODUCTIVIDAD
    CHECK (PRODUCTIVIDAD >= 0)
);



CREATE TABLE PRODUCTO (
  ID_VIVERO INT PRIMARY KEY,
  ID_ZONA VARCHAR(50) PRIMARY KEY,
  ID_PRODUCTO INT PRIMARY KEY,
  STOCK INT,
  CONSTRAINT FK_VIVERO_PRODUCTO
    FOREIGN KEY (ID_VIVERO) 
      REFERENCES VIVERO(ID_VIVERO)
        ON DELETE CASCADE,
  CONSTRAINT FK_ZONA_PRODUCTO
    FOREIGN KEY (ID_ZONA)
      REFERENCES ZONA(ID_ZONA)
        ON DELETE CASCADE
  CONSTRAINT CHECK_STOCK
    CHECK (STOCK >= 0)
);



CREATE TABLE CLIENTE (
  ID_CLIENTE INT PRIMARY KEY,
  NAME VARCHAR(50) NOT NULL,
  FECHA_ALTA DATE NOT NULL,
  NUMERO_PEDIDOS INT DEFAULT 0,
  PLAN VARCHAR(50) NOT NULL,
  CONSTRAINT CHECK_NUMERO_PEDIDOS
    CHECK (NUMERO_PEDIDOS >= 0)
  CONSTRAINT CHECK_PLAN
    CHECK (PLAN IN ('BASICO', 'PLUS'))
);



CREATE TABLE PEDIDO (
  ID_VENTA INT PRIMARY KEY,
  ID_PRODUCTO INT PRIMARY KEY,
  ID_CLIENTE INT,
  RESPONSABLE INT,
  FECHA DATE,
  CANTIDAD INT,
  CONSTRAINT FK_PRODUCTO_PEDIDO 
    FOREIGN KEY (ID_PRODUCTO)
      REFERENCES PRODUCTO(ID_PRODUCTO) 
        ON DELETE CASCADE,
  CONSTRAINT FK_CLIENTE_PEDIDO
    FOREIGN KEY (ID_CLIENTE) 
      REFERENCES CLIENTE(ID_CLIENTE) 
        ON DELETE CASCADE,
  CONSTRAINT FK_EMPLEADO_PEDIDO
    FOREIGN KEY (RESPONSABLE) 
      REFERENCES EMPLEADO(ID_EMPLEADO) 
        ON DELETE SET NULL,
  CONSTRAINT CHECK_CANTIDAD
    CHECK (CANTIDAD >= 0)
);

-----------------------------Inserción de valores------------------------------


INSERT INTO VIVERO
VALUES (1, 'Vivero de Tenerife'),
       (2, 'Vivero de Gran Canaria'),
       (3, 'Vivero de Fuerteventura'),
       (4, 'Vivero de Lanzarote'),
       (5, 'Vivero de La Palma');



INSERT INTO ZONA
VALUES ('Almacén', 1),
       ('Recepción', 1),
       ('Almacén', 2),
       ('Recepción', 2),
       ('Oficina', 2);



INSERT INTO EMPLEADO 
VALUES (1, 'Airam');
       (2, 'Juan');
       (3, 'Pedro');
       (4, 'Luis');
       (5, 'Maria');



INSERT INTO TRABAJA
VALUES (1, '2021-01-01', '2021-12-31', 'Almacén', 0),
       (2, '2021-01-01', '2021-12-31', 'Recepción', 0),
       (3, '2021-01-01', '2021-12-31', 'Almacén', 0),
       (4, '2021-01-01', '2021-12-31', 'Recepción', 0),
       (5, '2021-01-01', NULL, 'Oficina', 0);



INSERT INTO PRODUCTO
VALUES (1, 'Almacén',   1, 2),
       (1, 'Almacén',   2, 5),
       (1, 'Recepción', 1, 10),
       (2, 'Almacén',   2, 7),
       (2, 'Oficina',   2, 4),

INSERT INTO CLIENTE
VALUES (1, 'Juan', '2021-01-01', 0, 'BASICO'),
       (2, 'Pedro', '2021-01-01', 0, 'BASICO'),
       (3, 'Luis', '2021-01-01', 0, 'BASICO'),
       (4, 'Maria', '2021-01-01', 0, 'PLUS'),
       (5, 'Airam', '2021-01-01', 0, 'PLUS');

INSERT INTO PEDIDO
VALUES (1, 1, 1, 1, '2021-01-01', 0),
       (2, 2, 2, 2, '2021-01-01', 0),
       (3, 3, 3, 3, '2021-01-01', 0),
       (4, 4, 4, 4, '2021-01-01', 0),
       (5, 5, 5, 5, '2021-01-01', 0);

/* OJO si se pone null al final del tipo aunque sea una clave ajena puede ser null en caso de que la clave ajeno no exista se pone a null */
