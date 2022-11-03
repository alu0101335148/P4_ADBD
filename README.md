# Práctica 4: Modelo relacional (Viveros)

## Autor

Airam Rafael Luque León (alu0101335148@ull.edu.es)

## 1. Modelo entidad-relación

![entity-relation-model](img/entity-relation-model.png)

## 2. Uso del script

```bash
$ sudo su postgres
$ psql 
$ \i adbd.sql
```

## 2. Modelo relacional

Vivero(**id_vivero**, nombre)

Zona(**_id_vivero_**, **id_zona**)

Empleado(**id_empleado**, nombre)

Trabaja(**_id_empleado_**, época(inicio, final), _id_zona_, `productividad`)

Producto(**_id_vivero_**, **_id_zona_**, **id_producto**, stock)

Cliente(**id_cliente**, Fecha de alta, `Numero de pedidos`, Plan)

Pedido(**id_venta**, **_id_producto_**, id_cliente, responsable(_id_empleado_), fecha, cantidad)

## 3. Salida del script

![output](img/output.png)
