pub mod fecha;

use fecha::Fecha;

#[derive(PartialEq, Debug, Clone)]
enum Animal {
    Perro,
    Gato,
    Caballo,
    Otro,
}

#[derive(PartialEq, Debug, Clone)]
struct Humano { //NO TENGO ENIE PARA PONER DUENIO
    nombre: String,
    direccion: String,
    telefono: u32
}


#[derive(PartialEq, Debug, Clone)]
struct Mascota {
    nombre: String,
    edad: u32,
    tipo: Animal,
    humano: Humano
}

#[derive(PartialEq, Debug, Clone)]
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
    atenciones_realizadas: Vec<Atencion>
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
    fn new(nombre: String,direccion: String,id: u32) -> Veterinaria {
        let cola_atencion = Vec::new();
        let atenciones_realizadas =  Vec::new();
        Veterinaria{
            nombre,
            direccion,
            id,
            cola_atencion,
            atenciones_realizadas
        }
    }

    fn agregar_mascota(&mut self,mascota: Mascota) {
        self.cola_atencion.push(mascota);
    }

    fn agregar_mascota_prioridad(&mut self,mascota: Mascota) {
        self.cola_atencion.insert(0,mascota);
    }

    fn atender(&mut self) -> Option<Mascota>{
        if self.cola_atencion.len()==0 {
            return None;
        }
        Some(self.cola_atencion.remove(0))
    }

    fn eliminar_mascota(&mut self,nombre: String) {
        for i in 0..self.cola_atencion.len() {
            if self.cola_atencion[i].nombre==nombre {
                self.cola_atencion.remove(i);
                break;
            }
        }
    }

    fn registrar_atencion(&mut self,atencion: Atencion) {
        self.atenciones_realizadas.push(atencion);
    }

    fn buscar_atencion(&self,mascota: String,humano: String,telefono: u32) -> Option<Atencion> {
        let mut option = None;
        for i in 0..self.atenciones_realizadas.len() {
            let atencion = self.atenciones_realizadas[i].clone();
            if (atencion.mascota.nombre==mascota) &&
               (atencion.mascota.humano.nombre==humano) &&
               (atencion.mascota.humano.telefono==telefono) {
                option = Some(atencion);
                break;
            }
        }
        option
    }

    fn modificar_diagnostico(&mut self,atencion: Atencion,diagnostico: String) {
        for i in 0..self.atenciones_realizadas.len() {
            if self.atenciones_realizadas[i] == atencion {
                self.atenciones_realizadas[i].diagnostico = diagnostico;
                break;
            }
        }
    }

    fn modificar_fecha(&mut self,atencion: Atencion,fecha: Option<Fecha>) {
        for i in 0..self.atenciones_realizadas.len() {
            if self.atenciones_realizadas[i] == atencion {
                self.atenciones_realizadas[i].proxima_visita = fecha;
                break;
            }
        }
    }
    
    fn eliminar_atencion(&mut self,atencion: Atencion) {
        for i in 0..self.atenciones_realizadas.len() {
            if self.atenciones_realizadas[i] == atencion {
                self.atenciones_realizadas.remove(i);
            }
        }
    }
}

#[cfg(test)]
mod veterinaria_tests {
    use super::*;

    #[test]
    fn test_veterinaria() {
        let nombre = String::from("Perritos Contentos");
        let direccion = String::from("1 e 2 y 3");
        let id = 1;
        let cola_atencion = Vec::new();
        let atenciones_realizadas = Vec::new();
        let mut veterinaria = Veterinaria{nombre,direccion,id,cola_atencion,atenciones_realizadas};
        assert_eq!(Veterinaria::new("Perritos Contentos".to_string(),"1 e 2 y 3".to_string(),1),veterinaria);
        
        let humano1 = Humano::new("Carlos".to_string(),"4 e 5 y 6".to_string(),2211111111);
        let humano2 = Humano::new("Mateo".to_string(),"7 e 8 y 9".to_string(),2212222222);
        let humano3 = Humano::new("Juan".to_string(),"10 e 11 y 12".to_string(),2213333333);
        let humano4 = Humano::new("Pedro".to_string(),"13 e 14 y 15".to_string(),2214444444);

        let mascota1 = Mascota::new("Pepito".to_string(),1,Animal::Perro,humano1.clone());
        let mascota2 = Mascota::new("Pepota".to_string(),2,Animal::Gato,humano2.clone());
        let mascota3 = Mascota::new("Pepon".to_string(),3,Animal::Caballo,humano3.clone());
        let mascota4 = Mascota::new("Pepote".to_string(),4,Animal::Otro,humano4.clone());

        veterinaria.agregar_mascota(mascota2.clone());
        veterinaria.agregar_mascota(mascota3.clone());
        veterinaria.agregar_mascota(mascota4.clone());
        veterinaria.agregar_mascota_prioridad(mascota1.clone());
        
        let mascota = veterinaria.atender();
        assert!(mascota.is_some());
        if let Some(a) = mascota {
            assert_eq!(a,mascota1.clone());
        }

        veterinaria.eliminar_mascota("Pepon".to_string()); 

        let mut atencion  = Atencion::new(mascota1.clone(),"Desidratacion".to_string(),"Agua".to_string(),None);
        veterinaria.registrar_atencion(atencion.clone());

        let buscar = veterinaria.buscar_atencion(mascota1.clone().nombre,humano1.clone().nombre,humano1.clone().telefono);
        assert!(buscar.is_some());
        if let Some(a) = buscar {
            assert_eq!(a,atencion.clone());
        }
        veterinaria.modificar_diagnostico(atencion.clone(), "Triquinosis".to_string());
        atencion.diagnostico = "Triquinosis".to_string();
        
        let fecha = Some(Fecha::new(1, 2, 3));
        veterinaria.modificar_fecha(atencion.clone(), fecha.clone());
        atencion.proxima_visita = fecha.clone();

        let buscar = veterinaria.buscar_atencion(mascota1.clone().nombre,humano1.clone().nombre,humano1.clone().telefono);
        assert!(buscar.is_some());
        if let Some(a) = buscar {
            assert_eq!(a.diagnostico,"Triquinosis".to_string());
            assert_eq!(a.proxima_visita,fecha);
        }
        veterinaria.eliminar_atencion(atencion);
        assert!(veterinaria.atenciones_realizadas.is_empty());
        assert_eq!(veterinaria.cola_atencion,vec![mascota2,mascota4]);
    }


}