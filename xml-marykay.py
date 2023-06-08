# -*- coding: utf-8 -*-

import xmltodict
import csv
import html
import re
import math

MARCA_ID = 12
FILENAME = "orderNo-1412011.xml"
# Cargar el archivo XML y convertirlo a diccionario
with open(FILENAME) as f:
    doc = xmltodict.parse(f.read())

# Acceder a los valores del diccionario
conceptos = doc["cfdi:Comprobante"]["cfdi:Conceptos"]["cfdi:Concepto"]
total = 0
valorServicios = 0
totalProductos= 0
for concepto in conceptos:
    if concepto["@Unidad"] == "Pieza" and float(concepto["cfdi:Impuestos"]["cfdi:Traslados"]["cfdi:Traslado"]["@Importe"]) != 0:
        valor = concepto["@ValorUnitario"]
        cantidad = concepto["@Cantidad"]
        importe = concepto["@Importe"]
        descripcion = concepto["@Descripcion"]
        impuesto = concepto["cfdi:Impuestos"]["cfdi:Traslados"]["cfdi:Traslado"]["@Importe"]

        print(f"valor: {valor} cantidad: {cantidad} importe: {importe} impuesto: {impuesto}" )
        print(f"descripcion: {descripcion}")

        total = round((float(importe) + float(impuesto)), 2) + round(total, 2)
        print(f"Total hasta el momento {total}")
        totalProductos += int(cantidad)
    else:
        if concepto["@Descripcion"] == "Flete":
            impuesto = concepto["cfdi:Impuestos"]["cfdi:Traslados"]["cfdi:Traslado"]["@Importe"]
            valorServicios += float(impuesto)
        valorServicios += round(float(concepto["@ValorUnitario"]), 2)   

impuestos = doc["cfdi:Comprobante"]["cfdi:Impuestos"]["@TotalImpuestosTrasladados"]

costo_extra_por_producto = valorServicios/totalProductos
print(f"\nTotal Productos: {totalProductos}")
print(f"Subtotal: {total}")
print(f"Servicios: {valorServicios}")
total_factura = round((total + valorServicios), 2)
print(f"Total FActura: {total_factura}")
print(f"Costo Extra pro Prdocuto: {round(costo_extra_por_producto, 2)}")

# Definir los nombres de las columnas para el archivo CSV productos
nombres_columnas = ["marca_id","nombre", "color"]
# Crear el archivo CSV para productos
with open("archivo_productos.csv", mode="w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(nombres_columnas)
    for concepto in conceptos:
         if concepto["@Unidad"] == "Pieza" and float(concepto["cfdi:Impuestos"]["cfdi:Traslados"]["cfdi:Traslado"]["@Importe"]) != 0: 
            # Convertir los valores html que esten mal convertidos
            descripcion = html.unescape(concepto["@Descripcion"])
            # Buscamos si tiene color
            resultado = re.search(r'\((.*?)\)', descripcion)
            # Los productos que tienen color
            if resultado:
                nombre = re.sub(r'\(.*?\)', '', descripcion.strip())
                color = resultado.group(1)
            # Los productos que no tienen color
            else:
                nombre = descripcion
                color = ""
            # Armams la fila
            datos = [
                    MARCA_ID,
                    nombre,
                    color,
                ]
            writer.writerow(datos)

# Definir los nombres de las columnas para el archivo CSV transacciones
nombres_columnas = ["nombre","color", "monto", "cantidad", "tipo"]
# Crear el archivo CSV para transacciones
with open("archivo_nombres_transacciones.csv", mode="w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(nombres_columnas)
    # Recorrer los elementos y escribir los datos en el archivo CSV
    for concepto in conceptos:
        # Buscamos solo los productos con costo
        if concepto["@Unidad"] == "Pieza" and float(concepto["cfdi:Impuestos"]["cfdi:Traslados"]["cfdi:Traslado"]["@Importe"]) != 0: 
            # Convertir los valores html que esten mal convertidos
            descripcion = html.unescape(concepto["@Descripcion"])
            # Datos
            cantidad = concepto["@Cantidad"]
            tipo = "compra"
            monto = float(concepto["@ValorUnitario"]) * 1.16 + costo_extra_por_producto
            # Buscamos si tiene color
            resultado = re.search(r'\((.*?)\)', descripcion)
            # Los productos que tienen color
            if resultado:
                nombre = re.sub(r'\(.*?\)', '', descripcion.strip())
                color = resultado.group(1)
            # Los productos que no tienen color
            else:
                nombre = descripcion
                color = "NA"
            # Armams la fila
            datos = [
                    nombre,
                    color,
                    monto,
                    cantidad,
                    tipo,
                ]
            writer.writerow(datos)