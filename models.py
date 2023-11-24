from pydantic import BaseModel, validator, constr
from enum import Enum
from main import db
import datetime
from sqlalchemy import CheckConstraint, UniqueConstraint

class TipoTransaccion(str, Enum):
    compra = "compra"
    venta = "venta"

class Transaccion(BaseModel):
    producto_id: int
    monto: float
    cantidad: int
    tipo: TipoTransaccion

    @validator('monto')
    def validate_monto(cls, value):
        if value < 0:
            raise ValueError('La cantidad no puede ser menor que 0')
        return value

    @validator('cantidad')
    def validate_cantidad(cls, value):
        if value <= 0:
            raise ValueError('La cantidad tiene que ser mayor a 0')
        return value

class Marca(BaseModel):
    nombre: constr(min_length=2)

class Producto(BaseModel):
    nombre: constr(min_length=2)
    marca_id: str
    color: str = "NA"
    
    @validator('color', pre=True, always=True)
    def validate_color(cls, value):
        if value == "":
            return cls.__fields__['color'].default
        return value

class Cliente(BaseModel):
    nombre: constr(min_length=2)
    telefono: str

    @validator('telefono')
    def validate_telefono(cls, telefono):
        if len(telefono) != 10:
          raise ValueError('El número de teléfono debe tener 10 dígitos')
        return telefono

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

