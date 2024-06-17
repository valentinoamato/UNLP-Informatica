use std::{fs::File, io::{Error, Read, Write}};
use chrono::prelude::*;
use serde::{Serialize,Deserialize};

#[derive(Serialize, Deserialize, PartialEq, Debug, Copy, Clone)]
pub struct Fecha {
    dia: u32,
    mes: u32,
    anno: u32,
}

impl Fecha {
    pub fn new(dia: u32, mes: u32, anno: u32) -> Fecha {
        Fecha{
            dia,
            mes,
            anno,
        }
    }

    fn now() -> Fecha {
        let now = Local::now();
        Fecha {
            dia:now.day(),
            mes:now.month(),
            anno:now.year() as u32,
        }
    }

    pub fn es_bisiesto(&self) -> bool {
        self.anno % 4 == 0
    }

    pub fn dias(&self) -> [u32; 12] { 
        if self.es_bisiesto() {
            [31,29,31,30,31,30,31,31,30,31,30,31]
        } else {
            [31,28,31,30,31,30,31,31,30,31,30,31]
        }
    }

    pub fn es_fecha_valida(&self) -> bool {
        self.mes<=12 && (self.dia<=self.dias()[(self.mes-1) as usize])
    }

    pub fn sumar_dias(&mut self,dias: u32) {
        let mut left = dias;
        while left>365 {
            self.anno+=1;
            left-=365;
        }

        let mut dias_por_mes = self.dias(); 

        while left>dias_por_mes[(self.mes-1) as usize] {
            left-=dias_por_mes[(self.mes-1) as usize];
            self.mes+=1;
            if self.mes == 13 {
                self.mes = 1;
                self.anno+=1;
                dias_por_mes = self.dias();
            }
        }

        while left>0 {
            self.dia+=1;
            left-=1;
            if self.dia>dias_por_mes[(self.mes-1) as usize] {
                self.dia = 1;
                self.mes+=1;
                if self.mes == 13 {
                    self.mes = 1;
                    self.anno += 1;
                    dias_por_mes = self.dias();
                } 
            }
        }
    }

    pub fn restar_dias(&mut self,dias: u32) {
        let mut left = dias;
        while left>365 {
            self.anno-=1;
            left-=365;
        }

        let mut dias_por_mes = self.dias(); 

        while left>dias_por_mes[(self.mes-1) as usize] {
            left-=dias_por_mes[(self.mes-1) as usize];
            self.mes-=1;
            if self.mes == 0 {
                self.mes = 12;
                self.anno-=1;
                dias_por_mes = self.dias();
            }
        }

        while left>0 {
            self.dia-=1;
            left-=1;
            if self.dia == 0 {
                self.mes-=1;
                self.dia = dias_por_mes[(self.mes-1) as usize];
                if self.mes == 0 {
                    self.mes = 12;
                    self.anno -= 1;
                    dias_por_mes = self.dias();
                } 
            }
        }
    }

    pub fn es_mayor(&self,fecha: &Fecha) -> bool {
        let mut mayor = false;
        if self.anno>fecha.anno {
            mayor = true;
        } else if self.anno == fecha.anno {
            if self.mes>fecha.mes {
                mayor = true;
            } else if self.mes == fecha.mes {
                if self.dia>fecha.dia {
                    mayor = true;
                }
            }
        }
        mayor
    }
}


#[derive(Serialize, Deserialize, PartialEq, Debug, Clone, Copy)]
enum Genero {
    Novela,
    Infantil,
    Tecnico,
    Otro,
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone, Copy)]
enum Estado {
    EnPrestamo,
    Devuelto,
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Libro { 
    titulo: String,
    autor: String,
    paginas: u32,
    genero: Genero
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Cantidad {
    libro: Libro,
    cantidad: u32
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Cliente { 
    nombre: String,
    telefono: u32,
    correo: String
}
#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Prestamo {
    libro: Libro,
    cliente: Cliente,
    vencimiento: Fecha,
    estado: Estado,
    devolucion: Option<Fecha>,
}

#[derive(Serialize, Deserialize, PartialEq, Debug)]
struct Biblioteca {
    nombre: String,
    direccion: String,
    disponibles: Vec<Cantidad>,
    prestamos: Vec<Prestamo>,
    path: String,
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
    fn new(nombre: String,direccion: String, path: String) -> Result<Biblioteca, Error> {
        let disponibles = Vec::new();
        let prestamos =  Vec::new();
        let bibioteca = Biblioteca{
            nombre,
            direccion,
            disponibles,
            prestamos,
            path,
        };
        bibioteca.guardar()?;
        Ok(bibioteca)
    }

    fn build(path: &String) -> Result<Biblioteca, Error> {
        let mut file = File::open(path)?;
        let mut buf = String::new();
        file.read_to_string(&mut buf)?;
        let biblioteca = serde_json::from_str(&buf)?;
        Ok(biblioteca)

    }

    fn agregar_libro(&mut self,libro:Libro,cantidad:u32) -> Result<(), Error> {
        self.disponibles.push(Cantidad{libro,cantidad});
        self.guardar() 
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

    fn incrementar(&mut self,libro:&Libro) -> Result<(), Error> {
        for cantidad in &mut self.disponibles {
            if cantidad.libro == *libro {
                cantidad.cantidad+=1;
                self.guardar()?;
                break;
            }
        }
        Ok(())
    }

    fn decrementar(&mut self,libro:&Libro) ->  Result<(), Error>{
        for cantidad in &mut self.disponibles {
            if (cantidad.libro == *libro) && (cantidad.cantidad>0) {
                cantidad.cantidad-=1;
                self.guardar()?;
                break;
            }
        }
        Ok(())
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

    fn prestar(&mut self,cliente:Cliente,libro:Libro,vencimiento:Fecha) -> Result<bool, Error> {
        if (self.copias(&libro)>0) && (self.prestamos(&cliente)<=5) {
            self.decrementar(&libro)?;
            self.prestamos.push(Prestamo::new(libro, cliente, vencimiento));
            self.guardar()?;
            Ok(true)
        } else {
            Ok(false)
        }
    }

    fn vencimientos_proximos(&self,dias:u32) -> Vec<&Prestamo> {
        let mut hoy = Fecha::now();
        hoy.sumar_dias(dias);
        let mut prestamos: Vec<&Prestamo> = Vec::new();
        for prestamo in &self.prestamos {
            if (hoy.es_mayor(&prestamo.vencimiento)) && (prestamo.estado == Estado::EnPrestamo) {
                prestamos.push(&prestamo);
            }
        }
        prestamos
    }

    fn prestamos_vencidos(&self) -> Vec<&Prestamo> {
        self.vencimientos_proximos(0)
    }

    fn buscar(&self,libro:&Libro,cliente:&Cliente) -> Option<&Prestamo> {
        let mut option = None;
        for prestamo in &self.prestamos {
            if (prestamo.cliente == *cliente) && (prestamo.libro == *libro) {
                option = Some(prestamo);
                break;
            }
        }
        option
    }

    fn devolver(&mut self,libro:&Libro,cliente:&Cliente) -> Result<(), Error> {
        for prestamo in &mut self.prestamos {
            if (prestamo.cliente ==  *cliente) && (prestamo.libro == *libro) && (prestamo.estado == Estado::EnPrestamo) {
                prestamo.estado = Estado::Devuelto;
                prestamo.devolucion = Some(Fecha::now());
                self.incrementar(libro)?;
                break;
            }
        }
        Ok(())
    }

    fn guardar(&self) -> Result<(), Error> {
        let mut file = File::create(&self.path)?;
        let buf = serde_json::to_string(&self)?;
        file.write_all(buf.as_bytes())
    }
}

#[cfg(test)]
mod fecha_tests {
    use super::*;

    #[test]
    fn test_fecha_new() {
        let (dia,mes,anno) = (1,2,3);
        let fecha1 = Fecha {
            dia,
            mes,
            anno,
        };
        let fecha2 = Fecha::new(dia, mes, anno);
        assert_eq!(fecha1,fecha2);
    }

    #[test]
    fn test_fecha_now() {
        let fecha1 = Fecha::now();
        let now = Local::now();
        let fecha2 = Fecha {
            dia:now.day(),
            mes:now.month(),
            anno:now.year() as u32,
        };
        assert_eq!(fecha1,fecha2);
    }

    #[test]
    fn test_fecha_es_bisiesto() {
        let mut fecha = Fecha::new(1, 1, 1);
        for i in 1..=100 {
            fecha.anno = i;
            assert_eq!(fecha.es_bisiesto(),i % 4 == 0);
        }
    }

    #[test]
    fn test_fecha_dias() {
        let fecha = Fecha::new(1, 1, 1);
        assert_eq!(fecha.dias(),[31,28,31,30,31,30,31,31,30,31,30,31]);
        let fecha = Fecha::new(1, 1, 4);
        assert_eq!(fecha.dias(),[31,29,31,30,31,30,31,31,30,31,30,31]);
    }

    #[test]
    fn test_fecha_es_fecha_valida() {
        let mut fecha = Fecha::new(1, 1, 1);
        assert!(fecha.es_fecha_valida());
        fecha.dia=29;
        fecha.mes = 2;
        assert!(!fecha.es_fecha_valida());
        fecha.anno = 4;
        assert!(fecha.es_fecha_valida());
        fecha.mes=13;
        assert!(!fecha.es_fecha_valida());
    }

    #[test]
    fn test_fecha_sumar_dias() {
        let mut fecha1 = Fecha::new(26,4,2024);
        fecha1.sumar_dias(1000);
        assert_eq!(fecha1,Fecha{dia:21,mes:1,anno:2027});
    }

    #[test]
    fn test_fecha_restar_dias() {
        let mut fecha1 = Fecha::new(21,1,2027);
        fecha1.restar_dias(1000);
        assert_eq!(fecha1,Fecha{dia:26,mes:4,anno:2024});
    }

    #[test]
    fn test_fecha_es_mayor() {
        let mut fecha1 = Fecha::new(1, 1, 1); 
        let mut fecha2 = Fecha::new(1, 1, 1); 
        assert!(!fecha1.es_mayor(&fecha2));
        fecha1.dia = 2;
        assert!(fecha1.es_mayor(&fecha2));
        fecha2.mes = 2;
        assert!(fecha2.es_mayor(&fecha1));
        fecha1.anno = 2;
        assert!(fecha1.es_mayor(&fecha2));
    }

}

#[cfg(test)]
mod libro_tests {
    use super::*;

    #[test]
    fn test_libro_new() {

        let titulo = "titulo".to_string();
        let autor = "autos".to_string();
        let paginas = 200;
        let genero = Genero::Infantil;
        let libro1 = Libro::new(titulo.clone(), autor.clone(), paginas, genero);
        let libro2 = Libro {
            titulo,
            autor,
            paginas,
            genero,
        };
        assert_eq!(libro1,libro2);
    }
}

#[cfg(test)]
mod cliente_tests {
    use super::*;

    #[test]
    fn test_cliente_new() {

        let nombre = "nombre".to_string();
        let telefono = 200;
        let correo = "correo@correo.com".to_string();
        let cliente1 = Cliente::new(nombre.clone(), telefono, correo.clone());
        let cliente2 = Cliente {
            nombre,
            telefono,
            correo,
        };
        assert_eq!(cliente1,cliente2);
    }
}


#[cfg(test)]
mod prestamo_tests {
    use super::*;

    #[test]
    fn test_prestamo_new() {
        let libro = Libro::new("t".to_string(), "a".to_string(), 100, Genero::Novela);
        let cliente = Cliente::new("n".to_string(), 100, "c".to_string());
        let vencimiento = Fecha::now();
        let prestamo1 = Prestamo::new(libro.clone(), cliente.clone(), vencimiento);
        let prestamo2 = Prestamo {
            libro,
            cliente,
            vencimiento,
            estado:Estado::EnPrestamo,
            devolucion:None,
        };
        assert_eq!(prestamo1,prestamo2);
    }
}

#[cfg(test)]
mod biblioteca_tests {
    use super::*;

    fn crear_bibioteca(path:String) -> Biblioteca {
        let nombre = String::from("Silencio");
        let direccion = String::from("1 e 2 y 3");
        let mut biblioteca = Biblioteca::new(nombre,direccion,path).unwrap();
        
        let humano1 = Cliente::new("Persona1".to_string(),1,"Carlos.com".to_string());
        let humano2 = Cliente::new("Persona2".to_string(),2,"Mateo.com".to_string());
        let humano3 = Cliente::new("Persona3".to_string(),3,"Juan.com".to_string());
        let humano4 = Cliente::new("Persona4".to_string(),4,"Pedro.com".to_string());

        let libro1 = Libro::new("Libro1".to_string(),"Autor1".to_string(),10,Genero::Infantil);
        let libro2 = Libro::new("Libro2".to_string(),"Autor2".to_string(),20,Genero::Novela);
        let libro3 = Libro::new("Libro3".to_string(),"Autor3".to_string(),30,Genero::Tecnico);
        let libro4 = Libro::new("Libro4".to_string(),"Autor4".to_string(),40,Genero::Otro);

        biblioteca.agregar_libro(libro1.clone(),5).unwrap();
        biblioteca.agregar_libro(libro2.clone(),4).unwrap();
        biblioteca.agregar_libro(libro3.clone(),3).unwrap();
        biblioteca.agregar_libro(libro4.clone(),2).unwrap();
        
        let mut fecha = Fecha::now();
        fecha.restar_dias(6);
        biblioteca.prestar(humano1.clone(), libro1.clone(), fecha).unwrap();//0
        fecha.sumar_dias(2);
        biblioteca.prestar(humano1.clone(), libro2.clone(), fecha).unwrap();//1
        fecha.sumar_dias(2);
        biblioteca.prestar(humano1.clone(), libro3.clone(), fecha).unwrap();//2
        fecha.sumar_dias(2);
        biblioteca.prestar(humano1, libro4, fecha).unwrap();                //3
        fecha.sumar_dias(2);
        biblioteca.prestar(humano2.clone(), libro1.clone(), fecha).unwrap();//4
        fecha.sumar_dias(2);
        biblioteca.prestar(humano2.clone(), libro2.clone(), fecha).unwrap();//5
        fecha.sumar_dias(2);
        biblioteca.prestar(humano2, libro3, fecha).unwrap();                //6
        fecha.sumar_dias(2);
        biblioteca.prestar(humano3.clone(), libro1.clone(), fecha).unwrap();//7
        fecha.sumar_dias(2);
        biblioteca.prestar(humano3, libro2, fecha).unwrap();                //8
        fecha.sumar_dias(2);
        biblioteca.prestar(humano4, libro1, fecha).unwrap();                //9

        biblioteca
    }
    
    #[test]
    fn test_biblioteca_new() {
        let path = String::from("archivos/tests/biblioteca_new.json");
        let nombre = "n".to_string();
        let direccion = "d".to_string();
        let biblioteca1 = Biblioteca::new(nombre.clone(), direccion.clone(),path.clone()).unwrap();
        let biblioteca2 = Biblioteca {
            nombre,
            direccion,
            disponibles: Vec::new(),
            prestamos: Vec::new(),
            path:path.clone(),
        };
        assert_eq!(biblioteca1,biblioteca2);
        assert_eq!(biblioteca1,Biblioteca::build(&path).unwrap());
    }

    #[test]
    fn test_biblioteca_build() {
        let path = String::from("archivos/tests/biblioteca_build.json");
        let biblioteca1 = crear_bibioteca(path.clone());
        let biblioteca2 = Biblioteca::build(&path).unwrap();
        assert_eq!(biblioteca1,biblioteca2);
    }

    #[test]
    fn test_biblioteca_agregar_libro() {
        let path = String::from("archivos/tests/biblioteca_agregar_libro.json");
        let mut biblioteca = crear_bibioteca(path.clone());
        assert_eq!(biblioteca.disponibles.len(),4);
        let libro = Libro::new("t".to_string(), "a".to_string(), 1, Genero::Infantil);
        biblioteca.agregar_libro(libro.clone(), 3).unwrap();
        let cantidad = Cantidad {
            libro,
            cantidad: 3,
        };
        assert_eq!(biblioteca.disponibles.len(),5);
        assert_eq!(biblioteca.disponibles[4],cantidad);
        assert_eq!(biblioteca,Biblioteca::build(&path).unwrap());
    }

    #[test]
    fn test_biblioteca_copias() {
        let path = String::from("archivos/tests/biblioteca_copias.json");
        let mut biblioteca = crear_bibioteca(path);
        let libro1 = &biblioteca.disponibles[0].libro.clone();
        let libro2 = &biblioteca.disponibles[1].libro.clone();
        let libro3 = &mut biblioteca.disponibles[2].libro.clone();
        assert_eq!(biblioteca.copias(&libro1),1);
        assert_eq!(biblioteca.copias(&libro2),1);
        assert_eq!(biblioteca.copias(&libro3),1);
        libro3.titulo = "NO-EXISTE".to_string();
        assert_eq!(biblioteca.copias(&libro3),0);

        //biblioteca vacia
        biblioteca.disponibles.clear();
        libro3.titulo = "NO-EXISTE".to_string();
        assert_eq!(biblioteca.copias(&libro3),0);
    }

    #[test]
    fn test_biblioteca_incrementar() {
        let path = String::from("archivos/tests/biblioteca_incrementar.json");
        let mut biblioteca = crear_bibioteca(path.clone());
        let libro1 = &biblioteca.disponibles[0].libro.clone();
        let libro3 = &mut biblioteca.disponibles[2].libro.clone();
        assert_eq!(biblioteca.copias(&libro1),1);
        biblioteca.incrementar(libro1).unwrap();
        biblioteca.incrementar(libro1).unwrap();
        assert_eq!(biblioteca.copias(&libro1),3);

        libro3.titulo = "NO-EXISTE".to_string();
        biblioteca.incrementar(&libro3).unwrap();

        assert_eq!(biblioteca,Biblioteca::build(&path).unwrap());

        //biblioteca vacia
        biblioteca.disponibles.clear();
        biblioteca.incrementar(&libro3).unwrap();

    }
    
    #[test]
    fn test_biblioteca_decrementar() {
        let path = String::from("archivos/tests/biblioteca_decrementar.json");
        let mut biblioteca = crear_bibioteca(path.clone());
        let libro4 = &biblioteca.disponibles[3].libro.clone();
        let libro3 = &mut biblioteca.disponibles[2].libro.clone();
        assert_eq!(biblioteca.copias(&libro4),1);
        biblioteca.decrementar(libro4).unwrap();
        assert_eq!(biblioteca.copias(&libro4),0);
        biblioteca.decrementar(libro4).unwrap();
        assert_eq!(biblioteca.copias(&libro4),0);
        
        libro3.titulo = "NO-EXISTE".to_string();
        biblioteca.decrementar(&libro3).unwrap();
        
        assert_eq!(biblioteca,Biblioteca::build(&path).unwrap());

        //biblioteca vacia
        biblioteca.disponibles.clear();
        biblioteca.decrementar(&libro3).unwrap();
    }
    
    #[test]
    fn test_biblioteca_prestamos() {
        let path = String::from("archivos/tests/biblioteca_prestamos.json");
        let mut biblioteca = crear_bibioteca(path);
        let cliente1 = &biblioteca.prestamos[0].cliente.clone();
        assert_eq!(*cliente1.nombre, "Persona1".to_string());
        let cliente2 = &biblioteca.prestamos[4].cliente.clone();
        assert_eq!(*cliente2.nombre, "Persona2".to_string());
        let cliente3 = &biblioteca.prestamos[7].cliente.clone();
        assert_eq!(*cliente3.nombre, "Persona3".to_string());
        let cliente4 = &biblioteca.prestamos[9].cliente.clone();
        assert_eq!(*cliente4.nombre, "Persona4".to_string());

        assert_eq!(biblioteca.prestamos(&cliente1),4);
        assert_eq!(biblioteca.prestamos(&cliente2),3);
        assert_eq!(biblioteca.prestamos(&cliente3),2);
        assert_eq!(biblioteca.prestamos(&cliente4),1);
        
        //cliente no existe
        let cliente5 = Cliente::new("n".to_string(), 1, "c".to_string());
        assert_eq!(biblioteca.prestamos(&cliente5),0);
                
        //biblioteca vacia
        biblioteca.prestamos.clear();
        assert_eq!(biblioteca.prestamos(&cliente5),0);
    }
    
    #[test]
    fn test_biblioteca_prestar() {
        let path = String::from("archivos/tests/biblioteca_prestar.json");
        let mut biblioteca = crear_bibioteca(path.clone());
        let cliente1 = biblioteca.prestamos[0].cliente.clone();
        assert_eq!(*cliente1.nombre, "Persona1".to_string());
        let cliente2 = biblioteca.prestamos[4].cliente.clone();
        assert_eq!(*cliente2.nombre, "Persona2".to_string());
        let libro1 = Libro::new("Libro1".to_string(),"Autor1".to_string(),10,Genero::Infantil);
        let libro2 = Libro::new("Libro2".to_string(),"Autor2".to_string(),20,Genero::Novela);
        let libro3 = Libro::new("Libro3".to_string(),"Autor3".to_string(),30,Genero::Tecnico);
        assert_eq!(biblioteca.copias(&libro1),1);
        assert_eq!(biblioteca.copias(&libro2),1);
        assert_eq!(biblioteca.copias(&libro3),1);
        assert_eq!(biblioteca.prestamos(&cliente1),4);
        assert_eq!(biblioteca.prestamos(&cliente2),3);

        let fecha = Fecha::now();
        assert!(biblioteca.prestar(cliente1.clone(),libro1.clone(),fecha).unwrap());
        assert!(biblioteca.prestar(cliente1.clone(),libro2.clone(),fecha).unwrap());
        assert!(!biblioteca.prestar(cliente1.clone(),libro3.clone(),fecha).unwrap()); //No puede porque ya tiene 6 prestamos
        assert_eq!(biblioteca.copias(&libro1),0);
        assert_eq!(biblioteca.copias(&libro2),0);
        assert_eq!(biblioteca.copias(&libro3),1);
        assert_eq!(biblioteca.prestamos(&cliente1),6);

        assert!(!biblioteca.prestar(cliente2.clone(),libro1.clone(),fecha).unwrap());//No puede porque no hay copias
        assert!(!biblioteca.prestar(cliente2.clone(),libro2.clone(),fecha).unwrap());//No puede porque no hay copias
        assert!(biblioteca.prestar(cliente2.clone(),libro3.clone(),fecha).unwrap()); 
        assert_eq!(biblioteca.copias(&libro1),0);
        assert_eq!(biblioteca.copias(&libro2),0);
        assert_eq!(biblioteca.copias(&libro3),0);
        assert_eq!(biblioteca.prestamos(&cliente2),4);
        
        assert_eq!(biblioteca,Biblioteca::build(&path).unwrap());
        
        //biblioteca vacia
        biblioteca.disponibles.clear();
        assert!(!biblioteca.prestar(cliente1,libro1,fecha).unwrap()); 
    }

    #[test]
    fn test_biblioteca_vencimientos_proximos() {
        let path = String::from("archivos/tests/biblioteca_vencimientos_proximos.json");
        let biblioteca = crear_bibioteca(path);
        let prestamos = biblioteca.prestamos.clone();
        let iguales = |x: &[Prestamo], y: Vec<&Prestamo>| {
            let mut equal = x.len() == y.len();
            if equal {
                for (i, prestamo) in x.iter().enumerate() {
                    if *prestamo!=*y[i] {
                        equal = false;
                        break;
                    }
                }
            }
            equal
        };
        assert!(iguales(&prestamos[..3],biblioteca.vencimientos_proximos(0)));
        assert!(!iguales(&prestamos[..3],biblioteca.vencimientos_proximos(3)));
        assert!(iguales(&prestamos[..6],biblioteca.vencimientos_proximos(6)));
        assert!(!iguales(&prestamos[..6],biblioteca.vencimientos_proximos(9)));
        assert!(iguales(&prestamos[..],biblioteca.vencimientos_proximos(9999)));
    }

    #[test]
    fn test_biblioteca_prestamos_vencidos() {
        let path = String::from("archivos/tests/biblioteca_prestamos_vencidos.json");
        let biblioteca = crear_bibioteca(path);
        let prestamos = biblioteca.prestamos.clone();
        let vencidos = biblioteca.prestamos_vencidos();
        assert!(!vencidos.is_empty());
        for (i, prestamo) in prestamos[..3].iter().enumerate() {
            assert_eq!(*prestamo,*vencidos[i]);
        }
    }

    #[test]
    fn test_biblioteca_buscar() {
        let path = String::from("archivos/tests/biblioteca_buscar.json");
        let mut biblioteca = crear_bibioteca(path);
        let cliente1 = &biblioteca.prestamos[0].cliente.clone();
        let libro1 = &mut biblioteca.prestamos[0].libro.clone();
        assert_eq!(*cliente1.nombre, "Persona1".to_string());
        assert_eq!(*libro1.titulo, "Libro1".to_string());
        let respuesta = biblioteca.buscar(&libro1,&cliente1);
        assert!(respuesta.is_some());
        if let Some(prestamo) = respuesta {
            assert_eq!(prestamo.cliente,*cliente1);
            assert_eq!(prestamo.libro,*libro1);
        }
        libro1.titulo = "NO".to_string();
        assert!(biblioteca.buscar(&libro1,&cliente1).is_none());
        
        //biblioteca vacia
        biblioteca.prestamos.clear();
        assert!(biblioteca.buscar(&libro1,&cliente1).is_none());
    }

    #[test]
    fn test_biblioteca_devolver() {
        let path = String::from("archivos/tests/biblioteca_devolver.json");
        let mut biblioteca = crear_bibioteca(path.clone());
        let cliente1 = biblioteca.prestamos[0].cliente.clone();
        assert_eq!(*cliente1.nombre, "Persona1".to_string());
        let libro1 = Libro::new("Libro1".to_string(),"Autor1".to_string(),10,Genero::Infantil);
        let libro2 = Libro::new("Libro2".to_string(),"Autor2".to_string(),20,Genero::Novela);
        let libro3 = Libro::new("Libro3".to_string(),"Autor3".to_string(),30,Genero::Tecnico);
        assert_eq!(biblioteca.copias(&libro1),1);
        assert_eq!(biblioteca.copias(&libro2),1);
        assert_eq!(biblioteca.copias(&libro3),1);
        assert_eq!(biblioteca.prestamos(&cliente1),4);
        assert_eq!(biblioteca.prestamos[0].estado,Estado::EnPrestamo);
        
        biblioteca.devolver(&libro1,&cliente1).unwrap();
        assert_eq!(biblioteca.prestamos[0].estado,Estado::Devuelto);
        biblioteca.devolver(&libro1,&cliente1).unwrap(); //No devuelve nada 
        biblioteca.devolver(&libro2,&cliente1).unwrap();
        biblioteca.devolver(&libro3,&cliente1).unwrap(); //No puede porque ya tiene 6 prestamos
        assert_eq!(biblioteca.copias(&libro1),2);
        assert_eq!(biblioteca.copias(&libro2),2);
        assert_eq!(biblioteca.copias(&libro3),2);
        assert_eq!(biblioteca.prestamos(&cliente1),1);
        
        assert_eq!(biblioteca,Biblioteca::build(&path).unwrap());
        
        //biblioteca vacia
        biblioteca.disponibles.clear();
        biblioteca.devolver(&libro1,&cliente1).unwrap(); 
    }
}