use std::{fs::File, io::{Error, Read, Write}};
use serde::{Serialize, Deserialize};
use chrono::{prelude::Local, Datelike};

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

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
enum Animal {
    Perro,
    Gato,
    Caballo,
    Otro,
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Humano { //NO TENGO ENIE PARA PONER DUENIO
    nombre: String,
    direccion: String,
    telefono: u32
}


#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Mascota {
    nombre: String,
    edad: u32,
    tipo: Animal,
    humano: Humano
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Atencion {
    mascota: Mascota,
    diagnostico: String,
    tratamiento: String,
    proxima_visita: Option<Fecha>
}

#[derive(PartialEq, Debug)]
struct Veterinaria {
    nombre: String,
    direccion: String,
    id: u32,
    cola_atencion: Vec<Mascota>,
    atenciones_realizadas: Vec<Atencion>,
    path:String,
}

impl Humano {
    fn new(nombre: String,direccion: String,telefono: u32) -> Humano {
        Humano{
            nombre,
            direccion,
            telefono
        }
    }
}

impl Mascota {
    fn new(nombre: String,edad: u32,tipo: Animal,humano: Humano) -> Mascota {
        Mascota{
            nombre,
            edad,
            tipo,
            humano
        }
    }
}

impl Atencion {
    fn new(mascota: Mascota,diagnostico: String,tratamiento: String,proxima_visita: Option<Fecha>) -> Atencion {
        Atencion{
            mascota,
            diagnostico,
            tratamiento,
            proxima_visita
        }
    }
}

impl Veterinaria {
    fn new(nombre: String,direccion: String,id: u32, path: String) -> Result<Veterinaria, Error> {
        let cola_atencion = Vec::new();
        let atenciones_realizadas =  Vec::new();
        let veterinaria = Veterinaria{
            nombre,
            direccion,
            id,
            cola_atencion,
            atenciones_realizadas,
            path,
        };
        veterinaria.guardar_atenciones()?;
        Ok(veterinaria)
    }
    
    fn build(nombre: String,direccion: String,id: u32,path:String) -> Result<Veterinaria, Error> {
        let cola_atencion = Vec::new();
        let atenciones_realizadas =  match File::open(&path) {
            Ok(mut file) => {
                let mut buffer = String::new();
                file.read_to_string(&mut buffer)?;
                let atenciones = serde_json::from_str(&buffer)?;
                atenciones
            },
            Err(_) => Vec::new(),
        };
        Ok(Veterinaria{
            nombre,
            direccion,
            id,
            cola_atencion,
            atenciones_realizadas,
            path,
        })
    }

    fn agregar_mascota(&mut self,mascota: Mascota) {
        self.cola_atencion.push(mascota);
    }

    fn agregar_mascota_prioridad(&mut self,mascota: Mascota) {
        self.cola_atencion.insert(0,mascota);
    }

    fn atender(&mut self) -> Option<Mascota>{
        match self.cola_atencion.len() {
            0 => None,
            _ => {
                Some(self.cola_atencion.remove(0))}
        }
    }

    fn eliminar_mascota(&mut self,nombre: &String) {
        for i in 0..self.cola_atencion.len() {
            if self.cola_atencion[i].nombre==*nombre {
                self.cola_atencion.remove(i);
                break;
            }
        }
    }

    fn registrar_atencion(&mut self,atencion: Atencion) -> Result<(), Error> {
        self.atenciones_realizadas.push(atencion);
        self.guardar_atenciones()
    }

    fn buscar_atencion(&self,mascota: &String,humano: &String,telefono: u32) -> Option<&Atencion> {
        let mut option = None;
        for i in 0..self.atenciones_realizadas.len() {
            let atencion = &self.atenciones_realizadas[i];
            if (atencion.mascota.nombre==*mascota) &&
               (atencion.mascota.humano.nombre==*humano) &&
               (atencion.mascota.humano.telefono==telefono) {
                option = Some(atencion);
                break;
            }
        }
        option
    }

    fn modificar_diagnostico(&mut self,atencion: &Atencion,diagnostico: String) -> Result<(), Error>{
        for i in 0..self.atenciones_realizadas.len() {
            if self.atenciones_realizadas[i] == *atencion {
                self.atenciones_realizadas[i].diagnostico = diagnostico;
                self.guardar_atenciones()?;
                break;
            }
        }
        Ok(())
    }

    fn modificar_fecha(&mut self,atencion: &Atencion,fecha: Option<Fecha>) -> Result<(), Error>{
        for i in 0..self.atenciones_realizadas.len() {
            if self.atenciones_realizadas[i] == *atencion {
                self.atenciones_realizadas[i].proxima_visita = fecha;
                self.guardar_atenciones()?;
                break;
            }
        }
        Ok(())
    }
    
    fn eliminar_atencion(&mut self,atencion: &Atencion) -> Result<(), Error> {
        for i in 0..self.atenciones_realizadas.len() {
            if self.atenciones_realizadas[i] == *atencion {
                self.atenciones_realizadas.remove(i);
                self.guardar_atenciones()?;
                break;
            }
        }
        Ok(())
    }

    fn guardar_atenciones(&self) -> Result<(), Error> {
        let mut file = File::create(&self.path)?;
        let serialized = serde_json::to_string(&self.atenciones_realizadas)?;
        file.write_all(serialized.as_bytes())
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
mod humano_tests {
    use super::Humano;

    #[test]
    fn test_humano_new() {
        let humano1 = Humano::new("n1".to_string(), "d1".to_string(), 1);
        let humano2 = Humano {
            nombre:"n1".to_string(),
            direccion:"d1".to_string(),
            telefono: 1,
        };
        assert_eq!(humano1,humano2);
    }
}

#[cfg(test)]
mod mascota_tests {
    use super::*;

    #[test]
    fn test_mascota_new() {
        let humano = Humano::new("n1".to_string(), "d1".to_string(), 1);
        let mascota1 = Mascota::new("n1".to_string(),1,Animal::Caballo, humano.clone());
        let mascota2 = Mascota {
            nombre:"n1".to_string(),
            edad:1,
            tipo:Animal::Caballo,
            humano,
        };
        assert_eq!(mascota1,mascota2);
    }
}

#[cfg(test)]
mod atencion_test {
    use super::*;

    #[test]
    fn test_atencion_new() {
        let humano = Humano::new("n1".to_string(), "d1".to_string(), 1);
        let mascota = Mascota::new("n1".to_string(), 1, Animal::Caballo, humano);
        let atencion1 = Atencion::new(mascota.clone(), "si".to_string(), "no".to_string(), None);
        let atencion2 = Atencion {
            mascota,
            diagnostico:"si".to_string(),
            tratamiento:"no".to_string(),
            proxima_visita: None,
        };
        assert_eq!(atencion1,atencion2);
    }
}



#[cfg(test)]
mod veterinaria_tests {
    use super::*;

    fn crear_veterinaria(path: String) -> Veterinaria {
        let nombre = String::from("Perritos Contentos");
        let direccion = String::from("1 e 2 y 3");
        let id = 1;
        let cola_atencion = Vec::new();
        let atenciones_realizadas = Vec::new();
        let mut veterinaria = Veterinaria{nombre,direccion,id,cola_atencion,atenciones_realizadas,path};
        
        let humano1 = Humano::new("Carlos".to_string(),"4 e 5 y 6".to_string(),2211111111);
        let humano2 = Humano::new("Mateo".to_string(),"7 e 8 y 9".to_string(),2212222222);
        let humano3 = Humano::new("Juan".to_string(),"10 e 11 y 12".to_string(),2213333333);
        let humano4 = Humano::new("Pedro".to_string(),"13 e 14 y 15".to_string(),2214444444);

        let mascota1 = Mascota::new("Pepito".to_string(),1,Animal::Perro,humano1);
        let mascota2 = Mascota::new("Pepota".to_string(),2,Animal::Gato,humano2);
        let mascota3 = Mascota::new("Pepon".to_string(),3,Animal::Caballo,humano3);
        let mascota4 = Mascota::new("Pepote".to_string(),4,Animal::Otro,humano4);

        veterinaria.agregar_mascota(mascota1);
        veterinaria.agregar_mascota(mascota2);
        veterinaria.agregar_mascota(mascota3);
        veterinaria.agregar_mascota(mascota4);
        veterinaria
    }

    fn atender_todos(veterinaria: &mut Veterinaria) {
        while let Some(mascota) = veterinaria.atender() {
            veterinaria.registrar_atencion(Atencion::new(mascota, "d".to_string(), "t".to_string(), None)).unwrap();
        }
    }

    #[test]
    fn test_veterinaria_new() {
        let path = String::from("archivos/tests/veterinaria_new.json");
        let veterinaria1 = Veterinaria::new("n1".to_string(),"d1".to_string(),1,path.clone()).unwrap();
        let veterinaria2 = Veterinaria {
            nombre:"n1".to_string(),
            direccion:"d1".to_string(),
            atenciones_realizadas: Vec::new(),
            cola_atencion: Vec::new(),
            id:1,
            path:path.clone(),
        };
        assert_eq!(veterinaria1,veterinaria2);
        assert_eq!(veterinaria1.atenciones_realizadas,Veterinaria::build("n".to_string(), "d".to_string(), 1,path).unwrap().atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_build() {
        let path = String::from("archivos/tests/veterinaria_build.json");
        let mut veterinaria1 = crear_veterinaria(path.clone());
        atender_todos(&mut veterinaria1);
        let veterinaria2 = Veterinaria::build("n1".to_string(), "d1".to_string(), 1,path).unwrap();
        assert_eq!(veterinaria1.atenciones_realizadas,veterinaria2.atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_agregar_mascota() {
        let path = String::from("archivos/tests/veterinaria_agregar_mascota.json");
        let mut veterinaria = crear_veterinaria(path.clone());
        assert_eq!(veterinaria.cola_atencion.len(),4);
        let humano = Humano::new("n1".to_string(), "d1".to_string(), 1);
        let mascota = Mascota::new("n1".to_string(),1,Animal::Caballo,humano);
        veterinaria.agregar_mascota(mascota.clone());
        assert_eq!(veterinaria.cola_atencion.len(),5);
        assert_eq!(veterinaria.cola_atencion[4],mascota);
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_agregar_mascota_prioridad() {
        let path = String::from("archivos/tests/veterinaria_agregar_mascota_prioridad.json");
        let mut veterinaria = crear_veterinaria(path);
        assert_eq!(veterinaria.cola_atencion.len(),4);
        let humano = Humano::new("n1".to_string(), "d1".to_string(), 1);
        let mascota = Mascota::new("n1".to_string(),1,Animal::Caballo,humano);
        veterinaria.agregar_mascota_prioridad(mascota.clone());
        assert_eq!(veterinaria.cola_atencion.len(),5);
        assert_eq!(veterinaria.cola_atencion[0],mascota);
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_atender() {
        let path = String::from("archivos/tests/veterinaria_atender.json");
        let mut veterinaria = crear_veterinaria(path);
        assert_eq!(veterinaria.cola_atencion.len(),4);
        let mascota = veterinaria.cola_atencion[0].clone();    
        let respuesta = veterinaria.atender();
        assert!(respuesta.is_some());
        if let Some(m) = respuesta {
            assert_eq!(m,mascota);
        }
        assert_eq!(veterinaria.cola_atencion.len(),3);
        
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
        //veterinaria vacia
        veterinaria.cola_atencion.clear();
        assert!(veterinaria.atender().is_none());
    }

    #[test]
    fn test_veterinaria_eliminar_mascota() {
        let path = String::from("archivos/tests/veterinaria_eliminar_mascota.json");
        let mut veterinaria = crear_veterinaria(path);
        let mascota2 = veterinaria.cola_atencion[1].clone();
        assert_eq!(veterinaria.cola_atencion.len(),4);
        veterinaria.eliminar_mascota(&"NOEXISTE".to_string());
        veterinaria.eliminar_mascota(&mascota2.nombre);
        assert_eq!(veterinaria.cola_atencion.len(),3);
        assert_ne!(veterinaria.cola_atencion[1],mascota2);
        veterinaria.guardar_atenciones().unwrap();
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_registrar_atencion() {
        let path = String::from("archivos/tests/veterinaria_registrar_atencion.json");
        let mut veterinaria = crear_veterinaria(path);
        assert_eq!(veterinaria.cola_atencion.len(),4);
        assert_eq!(veterinaria.atenciones_realizadas.len(),0);
        atender_todos(&mut veterinaria);
        assert_eq!(veterinaria.cola_atencion.len(),0);
        assert_eq!(veterinaria.atenciones_realizadas.len(),4);
        let humano = Humano::new("n1".to_string(), "d1".to_string(), 1);
        let mascota = Mascota::new("n1".to_string(), 1, Animal::Caballo, humano);
        let atencion = Atencion::new(mascota, "d1".to_string(), "t1".to_string(), None);
        veterinaria.registrar_atencion(atencion.clone()).unwrap();
        assert_eq!(veterinaria.atenciones_realizadas.len(),5);
        assert_eq!(veterinaria.atenciones_realizadas[4],atencion);
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_buscar_atencion() {
        let path = String::from("archivos/tests/veterinaria_buscar_atencion.json");
        let mut veterinaria = crear_veterinaria(path);
        atender_todos(&mut veterinaria);
        let atencion = veterinaria.atenciones_realizadas[1].clone();
        assert!(veterinaria.buscar_atencion(&"no".to_string(), &"no".to_string(), 0).is_none());
        let mascota = &atencion.mascota.nombre;
        let humano = &atencion.mascota.humano.nombre;
        let telefono = atencion.mascota.humano.telefono;
        let respuesta = veterinaria.buscar_atencion(mascota,humano,telefono);
        assert!(respuesta.is_some());
        if let Some(a) = respuesta {
            assert_eq!(*a,atencion);
        }
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_modificar_diagnostico() {
        let path = String::from("archivos/tests/veterinaria_modificar_diagnostico.json");
        let mut veterinaria = crear_veterinaria(path);
        atender_todos(&mut veterinaria);
        let mut atencion = veterinaria.atenciones_realizadas[0].clone();
        let diagnostico_original = atencion.diagnostico.clone();
        atencion.diagnostico = "NO_EXISTE".to_string();
        veterinaria.modificar_diagnostico(&atencion, "no".to_string()).unwrap(); //No existe la atencion, no modifica nada
        
        atencion.diagnostico = diagnostico_original;
        assert_eq!(veterinaria.atenciones_realizadas[0].diagnostico,"d".to_string());
        veterinaria.modificar_diagnostico(&atencion, "nuevo_diagnostico1".to_string()).unwrap();
        assert_eq!(veterinaria.atenciones_realizadas[0].diagnostico,"nuevo_diagnostico1".to_string());
        
        atencion.diagnostico = "nuevo_diagnostico1".to_string();
        veterinaria.modificar_diagnostico(&atencion, "nuevo_diagnostico2".to_string()).unwrap();
        assert_eq!(veterinaria.atenciones_realizadas[0].diagnostico,"nuevo_diagnostico2".to_string());
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_modificar_fecha() {
        let path = String::from("archivos/tests/veterinaria_modificar_fecha.json");
        let mut veterinaria = crear_veterinaria(path);
        atender_todos(&mut veterinaria);
        let mut atencion = veterinaria.atenciones_realizadas[0].clone();
        let fecha_original = atencion.proxima_visita;
        let nueva_fecha = Fecha::new(9999, 9999, 9999);
        atencion.proxima_visita = Some(nueva_fecha);
        
        veterinaria.modificar_fecha(&atencion, None).unwrap(); //No existe la atencion con fecha nueva_fecha
        assert_eq!(veterinaria.atenciones_realizadas[0].proxima_visita,fecha_original); //No se modifica la fecha
        
        atencion.proxima_visita = fecha_original;
        veterinaria.modificar_fecha(&atencion, None).unwrap();
        assert_eq!(veterinaria.atenciones_realizadas[0].proxima_visita,None);
        let fecha = Fecha::now();
        veterinaria.modificar_fecha(&atencion, Some(fecha)).unwrap();
        assert_eq!(veterinaria.atenciones_realizadas[0].proxima_visita,Some(fecha));
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
    }

    #[test]
    fn test_veterinaria_eliminar_atencion() {
        let path = String::from("archivos/tests/veterinaria_eliminar_atencion.json");
        let mut veterinaria = crear_veterinaria(path);
        atender_todos(&mut veterinaria);
        assert_eq!(veterinaria.atenciones_realizadas.len(),4);
        let humano = Humano::new("n1".to_string(), "d1".to_string(), 1);
        let mascota = Mascota::new("n1".to_string(), 1, Animal::Caballo, humano);
        let atencion = Atencion::new(mascota, "d1".to_string(), "t1".to_string(), None);
        veterinaria.eliminar_atencion(&atencion).unwrap(); //atencion no existe, no elimina
        assert_eq!(veterinaria.atenciones_realizadas.len(),4);
        
        let atencion = &veterinaria.atenciones_realizadas[2].clone();
        veterinaria.eliminar_atencion(&atencion).unwrap();
        assert_eq!(veterinaria.atenciones_realizadas.len(),3);
        assert_ne!(veterinaria.atenciones_realizadas[2],*atencion);
        assert_eq!(veterinaria.atenciones_realizadas,
            Veterinaria::build(veterinaria.nombre.clone(), veterinaria.direccion.clone(), veterinaria.id, veterinaria.path.clone()).unwrap().atenciones_realizadas);
    }
}

