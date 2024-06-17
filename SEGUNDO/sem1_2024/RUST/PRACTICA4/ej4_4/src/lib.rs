#[derive(PartialEq,Debug,Clone, Copy)]
enum MedioDePago {
    Credito,
    Debito,
    Efectivo,
    Transferencia,
}

#[derive(PartialEq,Debug,Clone, Copy)]
enum Categoria {
    Alimento,
    Bazar,
    Limpieza,
    Otro,
}

#[derive(PartialEq,Debug,Clone)]
struct Producto {
    nombre: String,
    categoria: Categoria,
    precio: f32,
}

impl Producto {
    fn new(nombre: String, categoria: Categoria, precio:f32) -> Producto {
        Producto {
            nombre,
            categoria,
            precio,
        }
    }
}


#[derive(PartialEq,Debug,Clone)]
struct Cliente {
    nombre: String,
    apellido: String,
    direccion: String,
    dni: u32,
    newsletter: Option<String>,
}

impl Cliente {
    fn new(nombre:String,apellido:String,direccion:String,dni:u32,newsletter:Option<String>) -> Cliente {
        Cliente {
            nombre,
            apellido,
            direccion,
            dni,
            newsletter,
        }
    }
}


#[derive(PartialEq,Debug,Clone)]
struct Vendedor {
    nombre: String,
    apellido: String,
    direccion: String,
    dni: u32,
    legajo: u32,
    antiguedad: u32,
    salario: f32,
}

impl Vendedor {
    fn new(nombre: String,apellido:String,direccion:String,dni:u32,legajo:u32,antiguedad:u32,salario:f32) -> Vendedor {
        Vendedor {
            nombre,
            apellido,
            direccion,
            dni,
            legajo,
            antiguedad,
            salario,
        }
    }
}


#[derive(PartialEq,Debug,Clone)]
struct Venta {
    productos: Vec<usize>,
    vendedor: usize,
    cliente: usize,
    fecha: [u32;3],
    medio_de_pago: MedioDePago,
}


#[derive(PartialEq,Debug)]
struct Negocio {
    vendedores: Vec<Vendedor>, //Al separar los tres puedo guardar varias ventas de los mismos vendedores/clientes sin guardarlos multiples veces
    clientes: Vec<Cliente>,
    productos: Vec<Producto>,
    ventas: Vec<Venta>,
    descuentos: Vec<(Categoria,f32)>, 
    descuento_newsletter: f32,
}

impl Negocio {
    fn new(descuentos:Vec<(Categoria, f32)>,descuento_newsletter: f32) -> Negocio {
        Negocio {
            vendedores: Vec::new(),
            clientes: Vec::new(),
            productos: Vec::new(),
            ventas: Vec::new(),
            descuentos,
            descuento_newsletter,
        }
    }

    //MODULO A
    fn agregar_venta(&mut self,fecha: [u32;3],cliente: Cliente, vendedor: Vendedor,medio_de_pago: MedioDePago,productos: Vec<Producto>) {
        //El negocio contiene todos los clientes, vendedores, productos sin repetir
        //Las ventas contienen punteros a sus respentivos clientes, vendedores y productos

        //Evito guardar productos mas de una vez
        let mut productos_ptrs = Vec::new();
        for producto in productos {
            if let Some(i) = self.productos.iter().position(|p| *p==producto) {
                productos_ptrs.push(i);
            } else {
                productos_ptrs.push(self.productos.len());
                self.productos.push(producto);
            }
        }

        //Evito guardar clientes mas de una vez
        let cliente_ptr = if let Some(i) = self.clientes.iter().position(|c| *c==cliente) {
            i
        } else {
            self.clientes.push(cliente);
            self.clientes.len()-1
        };

        //Evito guardar vendedores mas de una vez
        let vendedor_ptr = if let Some(i) = self.vendedores.iter().position(|v| *v==vendedor) {
            i
        } else {
            self.vendedores.push(vendedor);
            self.vendedores.len()-1
        };

        self.ventas.push(Venta {
            productos: productos_ptrs,
            vendedor: vendedor_ptr,
            cliente: cliente_ptr,
            fecha,
            medio_de_pago,
        });

    }

    fn calcular_precio(&self, venta: &Venta) -> Option<f32> {
        if !self.ventas.contains(venta) {
            return None;
        } else {
            Some(venta.productos.iter().map(|n_producto| {
                let producto = &self.productos[*n_producto];
                let precio_base = producto.precio;
                let mut precio = precio_base;
                if self.clientes[venta.cliente].newsletter.is_some() {
                    precio-=precio_base*self.descuento_newsletter;
                } 
                if let Some((_, desc)) = self.descuentos.iter().find(|descuento| descuento.0==producto.categoria) {
                    precio-=precio_base*desc;
                }
                precio
            }).sum())
        }
    }

    //Como cada venta tiene varios productos que a su vez tienen varias categorias, al imprimir las ventas por categoria
    //se repetiran ventas, pero entiendo que es eso lo que pide el enunciado
    //En definitiva es probable que se impriman todas las ventas en las secciones de cada categoria
    fn reporte_por_categoria(&self) {
        let categorias = [Categoria::Alimento,Categoria::Bazar,Categoria::Limpieza,Categoria::Otro];
        for cat in categorias {
            println!("{:?}: ",cat);
            //Si una venta tiene un producto con la categoria actual: Imprimo los datos clave de la venta en la seccion actual
            for venta in &self.ventas {
                for producto in &venta.productos {
                    if self.productos[*producto].categoria == cat {
                        let precio = match self.calcular_precio(venta) {
                            Some(p) => p,
                            None => f32::NAN,
                        };
                        println!("Vendedor: {}, Cliente: {}, Fecha: {}/{}/{}, Monto: {}, Medio de Pago: {:?}",
                            &self.vendedores[venta.vendedor].nombre,
                            &self.clientes[venta.cliente].nombre,
                            venta.fecha[0],
                            venta.fecha[2],
                            venta.fecha[2],
                            precio,
                            venta.medio_de_pago
                        );
                    }
                }
            }
        }
    }

    fn reporte_por_vendedor(&self) {
        for ven in &self.vendedores {
            println!("{:?}: ",ven);
            //Si una venta tiene el vendedor actual: Imprimo los datos clave de la venta en la seccion actual
            for venta in &self.ventas {
                if self.vendedores[venta.vendedor] == *ven {
                    let precio = match self.calcular_precio(venta) {
                        Some(p) => p,
                        None => f32::NAN,
                    };
                    println!("Vendedor: {}, Cliente: {}, Fecha: {}/{}/{}, Monto: {}, Medio de Pago: {:?}",
                        &self.vendedores[venta.vendedor].nombre,
                        &self.clientes[venta.cliente].nombre,
                        venta.fecha[0],
                        venta.fecha[2],
                        venta.fecha[2],
                        precio,
                        venta.medio_de_pago
                    );
                }
            }
        }
    }

}

pub fn add(left: usize, right: usize) -> usize {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    ///Transforms a string slice into a String
    fn S(str: &str) ->String {
        str.to_string()
    }

    fn crear_negocio() -> Negocio {
        let mut negocio = Negocio::new(vec![(Categoria::Alimento,0.1)], 0.1);
        let vendedor1 = Vendedor::new(S("N1"), S("A1"), S("D1"), 1, 1, 1, 1.0);
        let vendedor2 = Vendedor::new(S("N2"), S("A2"), S("D2"), 2, 2, 2, 2.0);
        let cliente3 = Cliente::new(S("N3"), S("A3"), S("D3"), 3, Some(S("3@3.com")));
        let cliente4 = Cliente::new(S("N4"), S("A4"), S("D4"), 4, Some(S("4@4.com")));
        let producto1 = Producto::new(S("P1"), Categoria::Alimento, 10.0);
        let producto2 = Producto::new(S("P2"), Categoria::Bazar, 20.0);
        let producto3 = Producto::new(S("P3"), Categoria::Limpieza, 30.0);
        negocio.agregar_venta([1,10,2024], cliente3.clone(), vendedor1.clone(), MedioDePago::Efectivo, vec![producto1.clone(),producto2.clone()]);
        negocio.agregar_venta([1,10,2024], cliente3, vendedor2.clone(), MedioDePago::Efectivo, vec![producto2.clone(),producto3.clone()]);
        negocio.agregar_venta([1,10,2024], cliente4.clone(), vendedor1, MedioDePago::Efectivo, vec![producto1.clone(),producto3.clone()]);
        negocio.agregar_venta([1,10,2024], cliente4, vendedor2, MedioDePago::Efectivo, vec![producto1,producto2,producto3]);
        negocio
    }

    #[test]
    fn test_agregar_venta() {
        let mut negocio = Negocio::new(vec![(Categoria::Alimento,0.1)], 0.1);
        let vendedor1 = Vendedor::new(S("N1"), S("A1"), S("D1"), 1, 1, 1, 1.0);
        let cliente1 = Cliente::new(S("N1"), S("A1"), S("D1"), 1, Some(S("1@1.com")));
        let producto1 = Producto::new(S("P1"), Categoria::Alimento, 10.0);
        let producto2 = Producto::new(S("P2"), Categoria::Bazar, 20.0);
        negocio.agregar_venta([1,10,2024], cliente1.clone(), vendedor1.clone(), MedioDePago::Efectivo, vec![producto1.clone(),producto2.clone()]);
        negocio.agregar_venta([1,10,2024], cliente1.clone(), vendedor1, MedioDePago::Efectivo, vec![producto1.clone(),producto2.clone()]);
        assert_eq!(negocio.vendedores.len(),1);
        assert_eq!(negocio.clientes.len(),1);
        assert_eq!(negocio.productos.len(),2);
        assert_eq!(negocio.ventas.len(),2);
        assert_eq!(negocio.ventas[0],Venta {
            productos: vec![0,1],
            vendedor: 0,
            cliente: 0,
            fecha: [1,10,2024],
            medio_de_pago:MedioDePago::Efectivo,
        });
        assert_eq!(negocio.ventas[0],Venta {
            productos: vec![0,1],
            vendedor: 0,
            cliente: 0,
            fecha: [1,10,2024],
            medio_de_pago:MedioDePago::Efectivo,
        });
    }

    #[test]
    fn test_calcular_precio() {
        let negocio = crear_negocio();
        assert_eq!(negocio.calcular_precio(&negocio.ventas[0]),Some(26.0));
        assert_eq!(negocio.calcular_precio(&negocio.ventas[1]),Some(45.0));
        assert_eq!(negocio.calcular_precio(&negocio.ventas[2]),Some(35.0));
        assert_eq!(negocio.calcular_precio(&negocio.ventas[3]),Some(53.0));
    }

    #[test]
    fn reportes() {
        let negocio = crear_negocio();
        println!("\n\nReporte por categorias: ");
        negocio.reporte_por_categoria();
        println!("\n\nReporte por vendedores: ");
        negocio.reporte_por_vendedor();
    }

}
