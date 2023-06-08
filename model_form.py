from __future__ import annotations

import streamlit as st
import streamlit_pydantic as sp
from pydantic import BaseModel
from datetime import datetime

class Model(BaseModel):
    fecha: datetime
    concepto: str
    numero_factura: str
    monto: float
    tipo: str
    forma_pago: str


def main() -> None:
    st.header("Model Form Submission")
    data = sp.pydantic_form(key="my_model", model=Model)
    if data:
        st.json(data.json())


if __name__ == "__main__":
    main()

