from pydantic import BaseModel, validator, constr
from enum import Enum

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
