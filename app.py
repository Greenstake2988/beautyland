import streamlit as st
import requests
import time

API_URL_MARCAS = 'http://192.168.7.34:5000/marcas'
API_URL_CLIENTES = 'http://192.168.7.34:5000/clientes'
API_URL_PRODUCTOS  = 'http://192.168.7.34:5000/productos'
API_URL_TRANSACCIONS  = 'http://192.168.7.34:5000/transaccions'


####### MARCAS #######
def alta_marcas():
    st.title('Alta de Marcas')
    st.header('Crear marca')
    nombre = st.text_input('Nombre')
    if st.button('Crear'):
        create_marca(nombre)

    st.header('Marcas')
    get_marcas()
def create_marca(nombre):
    data = {'nombre': nombre}
    response = requests.post(API_URL_MARCAS, json=data)
    if response.status_code == 200:
        st.success('marca created successfully')
    else:
        st.error('Error creating marca')
def get_marcas():
    response = requests.get(API_URL_MARCAS)
    if response.status_code == 200:
        marcas = response.json()
        for marca in marcas:
            st.write(f" Nombre: {marca['nombre']}")
    else:
        st.error('Error retrieving marcas')

##### CLIENTES #####
def alta_clientes():
    # Contenido de la página de alta de clientes
    st.header("Alta de Clientes")
    # Aquí puedes agregar los elementos de tu formulario de alta de clientes
    nombre = st.text_input('Nombre')
    telefono = st.text_input('Telefono')
    if st.button('Crear'):
        create_cliente(nombre, telefono)

    st.header('Clientes')
    get_clientes()
def create_cliente(nombre, telefono):
    data = {'nombre': nombre, 'telefono': telefono}
    response = requests.post(API_URL_CLIENTES, json=data)
    if response.status_code == 200:
        st.success('cliente created successfully')
    else:
        st.error('Error creating cliente')
def get_clientes():
    response = requests.get(API_URL_CLIENTES)
    if response.status_code == 200:
        clientes = response.json()
        for cliente in clientes:
            st.write(f" Nombre: {cliente['nombre']} Telefono: {cliente['telefono']}")
    else:
        st.error('Error retrieving clientes')

#### PRODUCTOS ####
def alta_productos():
    # Contenido de la página de alta de productos
    st.header("Alta de Productos")
    # Buscamos las MARCAS de productos 
    response  = requests.get(API_URL_MARCAS)
    if response.status_code == 200:
        marcas = response.json()
        nombres_marcas = [marca['nombre'] for marca in marcas]
        nombre_seleccionado = st.selectbox('Marca', nombres_marcas)

    if nombre_seleccionado in nombres_marcas:
        marca_id = marcas[nombres_marcas.index(nombre_seleccionado)]['id']
    nombre = st.text_input('Nombre')
    color = st.text_input('Color (Si no tiene dejalo en blanco)')
    if st.button('Crear'):
        create_producto(marca_id, nombre, color)

    st.header('productos')
    get_productos()
def create_producto(marca_id, nombre, color,):  
    data = {'marca_id': marca_id,'nombre': nombre, 'color': color}
    response = requests.post(API_URL_PRODUCTOS, json=data)
    if response.status_code == 200:
        st.success('producto created successfully')
    else:
        st.error('Error creating producto')
def get_productos():
    response = requests.get(API_URL_PRODUCTOS)
    if response.status_code == 200:
        productos = response.json()
        eliminado=False
        for producto in productos:
            col1, col2, col3 = st.columns([3,1,1])
            with col1:
                st.write(f" Marca: {producto['marca']}, Nombre: {producto['nombre']} Color: {producto['color']} Existencia: {producto['existencia']}")
            with col2:
                if st.button("Eliminar", key=producto['id']):
                    eliminado = eliminar_por_id(API_URL_PRODUCTOS, producto['id'])
            with col3:
                if eliminado:
                    st.success("Se ah eliminado")
                    time.sleep(1)
                    st.experimental_rerun()
    else:
        st.error('Error retrieving productos')

#### TRANSACCIONS ####
def alta_transaccions():
    # Contenido de la página de alta de transaccions
    st.header("Alta de Transaccions")
    # Comprueba si el usuario ha elegido un tipo en la sesión actual
    if 'tipo' not in st.session_state:
        st.session_state['tipo'] = False
    
    st.session_state['tipo'] = st.selectbox('Tipo', [" "] + ["venta", "compra"])

    response  = requests.get(API_URL_PRODUCTOS)
    if response.status_code == 200:
        productos = response.json()
        # Si es una venta los pdoructos tienen que tener existencias
        if st.session_state['tipo'] == 'venta':
            # Filtrar los productos por existencia igual a 0
            productos = [producto for producto in productos if producto['existencia'] >= 1]

        nombres_colores_productos = [f"{producto['marca']} - {producto['nombre']} - {producto['color']}" for producto in productos]
        nombre_seleccionado = st.selectbox('Producto', [" "] + nombres_colores_productos)
        producto_seleccionado = next((producto for producto in productos if f"{producto['marca']} - {producto['nombre']} - {producto['color']}" == nombre_seleccionado), None)

    if producto_seleccionado:
        producto_id = producto_seleccionado['id']


    monto = st.text_input('Monto')
    
    if st.session_state['tipo'] == 'venta' and producto_seleccionado is not None:
        # Generar la lista de cantidades desde 1 hasta la cantidad máxima de existencias
        cantidades_existencias = list(range(1, producto_seleccionado['existencia'] + 1))
        cantidad = st.selectbox('Cantidad', cantidades_existencias)
    else:
        cantidad = st.text_input('Cantidad')
    tipo = st.session_state['tipo'] 
        
    if st.button('Crear'):
        create_transaccion(producto_id, monto, cantidad, tipo)

    st.header('Transaccions')
    get_transaccions()
def create_transaccion(producto_id, monto, cantidad, tipo):    
    data = {'producto_id': producto_id,'monto': monto, 'cantidad': cantidad, 'tipo': tipo}
    response = requests.post(API_URL_TRANSACCIONS, json=data)
    if response.status_code == 200:
        st.success('transaccion created successfully')
        time.sleep(1)
        st.experimental_rerun()

    else:
        st.error('Error creating transaccion')
def get_transaccions():
    response = requests.get(API_URL_TRANSACCIONS)
    if response.status_code == 200:
        transaccions = response.json()
        eliminado=False
        for transaccion in transaccions:
            col1, col2, col3 = st.columns([3,1,1])
            with col1:
                st.write(f" ID: {transaccion['id']}, Producto: {transaccion['producto']}, Color: {transaccion['color']}, Monto: {transaccion['monto']}, Cantidad: {transaccion['cantidad']}, Tipo: {transaccion['tipo']}")
            with col2:
                if st.button("Eliminar", key=transaccion['id']):
                    eliminado = eliminar_por_id(API_URL_TRANSACCIONS, transaccion['id'])
            with col3:
                if eliminado:
                    st.success("Se ah eliminado")
                    time.sleep(1)
                    st.experimental_rerun()
    else:
        st.error('Error retrieving transaccions')

### FUNCIONES GLOBALES ###
def eliminar_por_id(API, id):
    response = requests.delete(API+'/'+str(id))
    if response.status_code == 200:
        return True

# Configuración de la barra lateral
sidebar_options = {
    #"Ventas": ventas,
    #"Compras": compras,
    "Alta de Marcas": alta_marcas,
    "Alta de Clientes": alta_clientes,
    "Alta de Productos": alta_productos,
    "Alta de Transaccions": alta_transaccions
}

# Configuración de la página principal
page = st.sidebar.radio("Navegación", list(sidebar_options.keys()))

if __name__ == '__main__':
    # Renderizar la página seleccionada
    sidebar_options[page]()
