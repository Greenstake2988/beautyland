import csv
import requests

API_URL_PRODUCTOS  = 'http://192.168.7.34:5000/productos'


def limpiar_monto(monto):
    # Eliminar el símbolo de dólar ('$') y otros caracteres no numéricos
    monto_limpio = ''.join(c for c in monto if c.isdigit() or c == '.')

    return monto_limpio

# Obtener la lista de productos desde la base de datos (puede variar según tu implementación)
def obtener_productos_desde_bd():
    # Aquí obtendrías los productos de tu base de datos
    # y los almacenarías en una lista con sus respectivos IDs, nombres y colores
    # En este ejemplo, se utiliza una lista estática para simplificar
    response = requests.get(API_URL_PRODUCTOS)
    if response.status_code == 200:
        productos = response.json()
    return productos

# Procesar el archivo CSV de ventas
def procesar_archivo_csv(archivo_csv, archivo_salida):
    productos = obtener_productos_desde_bd()

    with open(archivo_csv, 'r') as file, open(archivo_salida, 'w', newline='') as output_file:
        reader = csv.DictReader(file)
        writer = csv.writer(output_file)

        # Escribir encabezados en el archivo de salida
        writer.writerow(['producto_id', 'monto', 'cantidad', 'tipo'])

        for row in reader:
            nombre_producto = row['nombre']
            color_producto = row['color']
            monto_producto = row['monto']
            cantidad_producto = row['cantidad']
            tipo = row['tipo']

            # Buscar el producto correspondiente en la lista de productos
            producto_encontrado = None
            for producto in productos:
                if producto['nombre'] == nombre_producto and producto['color'] == color_producto:
                    producto_encontrado = producto
                    break

            if producto_encontrado:
                # Obtener el ID del producto encontrado
                id_producto = producto_encontrado['id']
                # Convertir el valor a flotante
                monto_limpio = limpiar_monto(row['monto'])
                monto_producto = float(monto_limpio)
                # Escribir la fila en el archivo de salida
                writer.writerow([id_producto, monto_producto, cantidad_producto, tipo])
            else:
                print(f"No se encontró el producto: '{nombre_producto}' ({color_producto})")

# Ejemplo de uso
archivo_salida = 'archivo_transacciones.csv'
archivo_entrada = 'archivo_nombres_transacciones.csv'
procesar_archivo_csv(archivo_entrada, archivo_salida)
