from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from models import Transaccion, Marca, Producto, Cliente
from sqlalchemy import CheckConstraint, UniqueConstraint, func
import datetime

DB_Beautyland = "beautyland"
DB_Test = "test"
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://oscar:@localhost/'+DB_Beautyland
db = SQLAlchemy(app)

class MarcaDB(db.Model):
    __tablename__ = 'marcas'

    id = db.Column(db.Integer, primary_key=True, unique=True)
    nombre = db.Column(db.String(100), unique=True)

class ProductoDB(db.Model):
    __tablename__ = 'productos'

    id = db.Column(db.Integer, primary_key=True)
    marca_id = db.Column(db.Integer, db.ForeignKey('marcas.id'))
    nombre = db.Column(db.String(100))
    color = db.Column(db.String(50), default="NA")

    __table_args__ = (
        UniqueConstraint('color', 'nombre', name='uq_producto_color_nombre'),
    )

class ClienteDB(db.Model):
    __tablename__ = 'clientes'

    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), unique=True)
    telefono = db.Column(db.String(50))

class TransaccionDB(db.Model):
    __tablename__ = 'transacciones'

    id = db.Column(db.Integer, primary_key=True)
    producto_id = db.Column(db.Integer, db.ForeignKey('productos.id'))
    monto = db.Column(db.Float)
    cantidad = db.Column(db.Integer)
    tipo = db.Column(db.String(10))
    creado_el = db.Column(db.DateTime, default=datetime.datetime.utcnow)
    
    __table_args__ = (
        CheckConstraint(
            tipo.in_(['compra', 'venta']),
            name='check_tipo'
        ),
    )


@app.route('/clientes', methods=['POST'])
def create_cliente():
    data = request.get_json()
    cliente = Cliente(**data)
    db_cliente = ClienteDB(nombre=cliente.nombre, telefono=cliente.telefono)
    db.session.add(db_cliente)
    db.session.commit()
    return jsonify({'message': 'cliente creada satisfactoriamente!'})
@app.route('/clientes', methods=['GET'])
def get_clientes():
    clientes = ClienteDB.query.all()
    result = []
    for cliente in clientes:
        result.append({'id': cliente.id,'nombre':cliente.nombre, 'telefono':cliente.telefono})
    return jsonify(result)

@app.route('/marcas', methods=['POST'])
def create_marca():
    data = request.get_json()
    marca = Marca(**data)
    db_marca = MarcaDB(nombre=marca.nombre)
    db.session.add(db_marca)
    db.session.commit()
    return jsonify({'message': 'marca creada satisfactoriamente!'})
@app.route('/marcas', methods=['GET'])
def get_marcas():
    marcas = MarcaDB.query.all()
    result = []
    for marca in marcas:
        result.append({'id': marca.id,'nombre':marca.nombre})
    return jsonify(result)

@app.route('/productos', methods=['POST'])
def create_producto():
    data = request.get_json()
    producto = Producto(**data)
    db_producto = ProductoDB(marca_id=producto.marca_id,nombre=producto.nombre, color=producto.color)
    db.session.add(db_producto)
    db.session.commit()
    return jsonify({'message': 'producto creado satisfactoriamente!'})
@app.route('/productos', methods=['GET'])
def get_productos():
    productos = db.session.query(ProductoDB, MarcaDB).join(MarcaDB, ProductoDB.marca_id == MarcaDB.id).all()
    # Itera sobre los productos y calcula las existencias
    result = []
    for producto, marca in productos:
        suma_compras = db.session.query(func.sum(TransaccionDB.cantidad)).filter(TransaccionDB.producto_id == producto.id, TransaccionDB.tipo == 'compra').scalar()
        suma_ventas = db.session.query(func.sum(TransaccionDB.cantidad)).filter(TransaccionDB.producto_id == producto.id, TransaccionDB.tipo == 'venta').scalar()
        existencia = (suma_compras or 0) - (suma_ventas or 0)        
        producto.existencia = existencia
        result.append({'id':producto.id,'marca':marca.nombre,'nombre': producto.nombre,'color':producto.color, 'existencia':producto.existencia})
    return jsonify(result)
@app.route('/productos/<int:producto_id>', methods=["DELETE"])
def delete_producto(producto_id):
    producto = ProductoDB.query.filter_by(id=producto_id).first()
    if producto:
        db.session.delete(producto)
        db.session.commit()
        return jsonify({'message': 'Producto eliminado correctamente'})
    return jsonify({'message': 'Producto no encontrado'}), 404
    
@app.route('/transaccions', methods=['POST'])
def create_transaccions():
    data = request.get_json()
    print(data)
    transaccion = Transaccion(**data)
    db_transaccion = TransaccionDB(producto_id=transaccion.producto_id, monto=transaccion.monto, cantidad=transaccion.cantidad, tipo=transaccion.tipo)
    db.session.add(db_transaccion)
    db.session.commit()
    return jsonify({'message': 'transaccion creado satisfactoriamente!'})
@app.route('/transaccions', methods=['GET'])
def get_transaccions():
    transaccions = db.session.query(TransaccionDB, ProductoDB).join(ProductoDB, TransaccionDB.producto_id == ProductoDB.id).all()

    result = []
    for transaccion, producto in transaccions:
        result.append({'id':transaccion.id,'producto':producto.nombre, 'color':producto.color, 'monto': transaccion.monto,'cantidad':transaccion.cantidad,'tipo':transaccion.tipo,'creado_el':transaccion.creado_el })
    return jsonify(result)
@app.route('/transaccions/<int:transaccion_id>', methods=['DELETE'])
def delete_transaccions(transaccion_id):
    transaccion = db.session.query(TransaccionDB).get(transaccion_id)
    
    if transaccion:
        db.session.delete(transaccion)
        db.session.commit()

        return jsonify({'message': 'Transacción eliminada correctamente'})

    return jsonify({'message': 'Transacción no encontrada'}), 404

@app.shell_context_processor
def shell_context():
    return dict(db=db, Marca=MarcaDB, Producto=ProductoDB, Cliente=ClienteDB, Transaccion=TransaccionDB)

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        suma_total = db.session.query(func.sum(TransaccionDB.monto * TransaccionDB.cantidad)).filter(TransaccionDB.tipo == 'venta').scalar()
        print(suma_total)
    app.run(debug=True, port=5000, host='0.0.0.0')
