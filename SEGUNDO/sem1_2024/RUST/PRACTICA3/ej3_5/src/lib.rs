#[derive(PartialEq, Debug)]
struct Producto {
    nombre: String,
    precio: f32,
    id: u32
}

impl Producto {
    fn new(nombre: String, precio: f32,id: u32) -> Producto {
        Producto{
            nombre,
            precio,
            id
        }
    }

    fn calcular_impuestos(&self,porcentaje_de_impuestos: f32) -> f32 {
        //No se entiende la consigna
        self.precio * porcentaje_de_impuestos
    }

    fn aplicar_descuento(&self,porcentaje_de_descuento: f32) -> f32 {
        //No se entiende la consigna
        self.precio * porcentaje_de_descuento
    }

    fn calcular_precio_total(&self,porcentaje_de_impuestos: Option<f32>,porcentaje_de_descuento: Option<f32>) -> f32 {
        let mut monto = self.precio;
        if let Some(porcentaje) = porcentaje_de_impuestos {
            monto+=self.calcular_impuestos(porcentaje);
        }
        if let Some(porcentaje) = porcentaje_de_descuento {
            monto-=self.aplicar_descuento(porcentaje);
        }
        monto
        
    }
}

#[cfg(test)]
mod producto_tests {
    use super::*;

    #[test]
    fn test_producto() {
        let nombre = String::from("Banana");
        let precio = 100.0;
        let id = 1;
        let banana = Producto{nombre, precio, id};
        assert_eq!(Producto::new("Banana".to_string(), 100.0, 1),banana);
        assert_eq!(banana.calcular_impuestos(0.1),10.0);
        assert_eq!(banana.aplicar_descuento(0.1),10.0);
        assert_eq!(banana.calcular_precio_total(Some(0.1),None),110.0);

    }


}