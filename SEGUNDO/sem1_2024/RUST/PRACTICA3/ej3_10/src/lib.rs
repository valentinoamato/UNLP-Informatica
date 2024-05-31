pub mod fecha;

use fecha::Fecha;
use chrono::prelude::*;

#[derive(PartialEq, Debug, Clone)]
enum Genero {
    Novela,
    Infantil,
    Tecnico,
    Otro,
}

#[derive(PartialEq, Debug, Clone)]
enum Estado {
    EnPrestamo,
    Devuelto,
}

#[derive(PartialEq, Debug, Clone)]
struct Libro { 
    titulo: String,
    autor: String,
    paginas: u32,
    genero: Genero
}

#[derive(PartialEq, Debug, Clone)]
struct Cantidad {
    libro: Libro,
    cantidad: u32
}

#[derive(PartialEq, Debug, Clone)]
struct Cliente { 
    nombre: String,
    telefono: u32,
    correo: String
}
#[derive(PartialEq, Debug, Clone)]
struct Prestamo {
    libro: Libro,
    cliente: Cliente,
    vencimiento: Fecha,
    estado: Estado,
    devolucion: Option<Fecha>,
}

#[derive(PartialEq, Debug)]
struct Biblioteca {
    nombre: String,
    direccion: String,
    disponibles: Vec<Cantidad>,
    prestamos: Vec<Prestamo>
}

impl Libro {
    fn new(titulo: String,autor: String,paginas: u32,genero: Genero) -> Libro {
        Libro{
            titulo,
            autor,
            paginas,
            genero
        }
    }
}

impl Cliente {
    fn new(nombre: String,telefono: u32,correo: String) -> Cliente {
        Cliente{
            nombre,
            telefono,
            correo,
        }
    }
}

impl Prestamo {
    fn new(libro: Libro,cliente: Cliente,vencimiento: Fecha) -> Prestamo {
        Prestamo{
            libro,
            cliente,
            vencimiento,
            estado:Estado::EnPrestamo,
            devolucion:None
        }
    }
}

impl Biblioteca {
    fn new(nombre: String,direccion: String) -> Biblioteca {
        let disponibles = Vec::new();
        let prestamos =  Vec::new();
        Biblioteca{
            nombre,
            direccion,
            disponibles,
            prestamos,
        }
    }

    fn agregar_libro(&mut self,libro:Libro,cantidad:u32) {
        self.disponibles.push(Cantidad{libro,cantidad});
    }

    fn copias(&self,libro:&Libro) -> u32 {
        let mut copias = 0;
        for cantidad in &self.disponibles {
            if cantidad.libro == *libro {
                copias = cantidad.cantidad;
            }
        }
        copias
    }

    fn incrementar(&mut self,libro:&Libro) {
        for cantidad in &mut self.disponibles {
            if cantidad.libro == *libro {
                cantidad.cantidad+=1;
                break;
            }
        }
    }

    fn decrementar(&mut self,libro:&Libro) {
        for cantidad in &mut self.disponibles {
            if (cantidad.libro == *libro) && (cantidad.cantidad>0) {
                cantidad.cantidad-=1;
            }
        }
    }

    fn prestamos(&self,cliente:&Cliente) -> u32 {
        let mut cantidad = 0;
        for prestamo in &self.prestamos {
            if (prestamo.cliente == *cliente) && (prestamo.estado == Estado::EnPrestamo) {
                cantidad+=1;
            }
        }
        cantidad
    }

    fn prestar(&mut self,cliente:Cliente,libro:Libro,vencimiento:Fecha) -> bool {
        if (self.copias(&libro)>0) && (self.prestamos(&cliente)<=5) {
            self.prestamos.push(Prestamo::new(libro, cliente, vencimiento));
            true
        } else {
            false
        }
    }

    fn vencimientos_proximos(&self,dias:u32) -> Vec<Prestamo> {
        //Necesito ser conciente de la fecha actual para saber si un vencimiento es cercano o no
        let now = Local::now();
        let mut hoy = Fecha::new(now.day(), now.month(), now.year() as u32);
        hoy.sumas_dias(dias);
        let mut prestamos: Vec<Prestamo> = Vec::new();
        for prestamo in &self.prestamos {
            if (hoy.es_mayor(&prestamo.vencimiento)) && (prestamo.estado == Estado::EnPrestamo) {
                prestamos.push(prestamo.clone());
            }
        }
        prestamos
    }

    fn prestamos_vencidos(&self) -> Vec<Prestamo> {
        self.vencimientos_proximos(0)
    }

    fn buscar(&self,libro:&Libro,cliente:&Cliente) -> Option<Prestamo> {
        let mut option = None;
        for prestamo in &self.prestamos {
            if (prestamo.cliente == *cliente) && (prestamo.libro == *libro) {
                option = Some(prestamo.clone());
                break;
            }
        }
        option
    }

    fn devolver(&mut self,libro:&Libro,cliente:&Cliente) {
        for prestamo in &mut self.prestamos {
            if (prestamo.cliente ==  *cliente) && (prestamo.libro == *libro) {
                prestamo.estado = Estado::Devuelto;
                let now = Local::now();
                prestamo.devolucion = Some(Fecha::new(now.day(), now.month(), now.year() as u32));
            }
        }
    }
}

#[cfg(test)]
mod biblioteca_tests {
    //--|||||||||||||||||||||||||||||--ADVERTENCIA--|||||||||||||||||||||||||||||--
    //--||||||||||||||||||||--RIESGO DE CEGUERA PERMANENTE--||||||||||||||||||||--
    use super::*;

    #[test]
    fn test_biblioteca() {
        let nombre = String::from("Silencio");
        let direccion = String::from("1 e 2 y 3");
        let disponibles = Vec::new();
        let prestamos = Vec::new();
        let mut biblioteca = Biblioteca{nombre,direccion,disponibles,prestamos};
        assert_eq!(Biblioteca::new("Silencio".to_string(),"1 e 2 y 3".to_string()),biblioteca);
        
        let humano1 = Cliente::new("Persona1".to_string(),1,"Carlos.com".to_string());
        let humano2 = Cliente::new("Persona2".to_string(),2,"Mateo.com".to_string());
        let humano3 = Cliente::new("Persona3".to_string(),3,"Juan.com".to_string());
        let humano4 = Cliente::new("Persona4".to_string(),4,"Pedro.com".to_string());

        let libro1 = Libro::new("Libro1".to_string(),"Autor1".to_string(),10,Genero::Infantil);
        let libro2 = Libro::new("Libro2".to_string(),"Autor2".to_string(),20,Genero::Novela);
        let libro3 = Libro::new("Libro3".to_string(),"Autor3".to_string(),30,Genero::Tecnico);
        let libro4 = Libro::new("Libro4".to_string(),"Autor4".to_string(),40,Genero::Otro);

        biblioteca.agregar_libro(libro1.clone(),0);
        biblioteca.incrementar(&libro1);
        biblioteca.agregar_libro(libro2.clone(),3);
        biblioteca.decrementar(&libro2);
        biblioteca.agregar_libro(libro3.clone(),3);
        biblioteca.agregar_libro(libro4.clone(),4);

        assert_eq!(biblioteca.copias(&libro1),1);
        assert_eq!(biblioteca.copias(&libro2),2);

        let now = Local::now();
        let mut ayer = Fecha::new(now.day(), now.month(), now.year() as u32);
        let mut quince_dias = ayer.clone();
        quince_dias.sumas_dias(15);
        ayer.restar_dias(1);
        let mut nunca = ayer.clone();
        nunca.sumas_dias(u32::MAX);

        biblioteca.prestar(humano1.clone(), libro1.clone(), quince_dias.clone());
        biblioteca.prestar(humano2.clone(), libro2.clone(), quince_dias.clone());
        biblioteca.prestar(humano3.clone(), libro3.clone(), nunca.clone());
        biblioteca.prestar(humano4.clone(), libro1.clone(), nunca.clone());
        biblioteca.prestar(humano4.clone(), libro2.clone(), nunca.clone());
        biblioteca.prestar(humano4.clone(), libro3.clone(), ayer.clone());
        biblioteca.prestar(humano4.clone(), libro4.clone(), ayer.clone());
        assert_eq!(biblioteca.prestamos(&humano4),4);
        
        let v = biblioteca.prestamos.clone();
        assert_eq!(biblioteca.buscar(&libro1, &humano1),Some(v[0].clone()));
        assert_eq!(biblioteca.vencimientos_proximos(20),vec![v[0].clone(),v[1].clone(),v[5].clone(),v[6].clone()]);
  
        assert_eq!(biblioteca.prestamos_vencidos(),biblioteca.prestamos[5..]);

        biblioteca.devolver(&libro1, &humano1);
        assert_eq!(biblioteca.disponibles[0].cantidad,1);
        ayer.sumas_dias(1);
        let prestamo = biblioteca.prestamos[0].clone();
        assert_eq!(prestamo.estado,Estado::Devuelto);
        assert_eq!(prestamo.devolucion,Some(ayer));
    }


}