use std::{fs::File, io::{Error, Read, Write}};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
enum Primario {
    Amarillo,
    Rojo,
    Azul
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
enum Secundario { //No son todos colores secundarios pero bueno
    Verde,
    Blanco,
    Negro,
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
enum Color {
    Primario(Primario),
    Secundario(Secundario)
}

#[derive(Serialize, Deserialize, PartialEq, Debug, Clone)]
struct Auto {
    marca: String,
    modelo: String,
    anno: u32,
    precio: f64,
    color:Color
}

#[derive(Serialize, Deserialize, PartialEq, Debug)]
struct Consecionaria {
    nombre: String,
    direccion: String,
    autos: Vec<Auto>,
    path: String,
}

impl Auto {
    fn new(marca: String,modelo: String,anno: u32,precio: f64,color: Color) -> Auto {
        Auto{
            marca,
            modelo,
            anno,
            precio,
            color
        }
    }

    fn calcular_precio(&self) -> f64 {
        let mut monto = self.precio;
        if self.marca.as_str()=="BMW" {
            monto+=self.precio*0.15;
        }
        if self.anno<2000 {
            monto-=self.precio*0.05;
        }
        if let Color::Primario(_) = self.color {
            monto+=self.precio*0.25;
        } else {
            monto-=self.precio*0.1;
        }
        monto
    }
}

impl Consecionaria {
    fn new(nombre: String,direccion: String, path: String) -> Consecionaria {
        Consecionaria{
            nombre,
            direccion,
            autos: Vec::new(),
            path,
        }
    }

    fn build(path: &String) -> Result<Consecionaria, Error> {
        let mut file = File::open(path)?;
        let mut buf = String::new();
        file.read_to_string(&mut buf)?;
        let consecionaria  = serde_json::from_str(&buf)?;
        Ok(consecionaria)      
    }

    fn agregar_auto(&mut self,auto: Auto) -> Result<(),Error> {
        self.autos.push(auto);
        self.guardar()?;
        Ok(())
    }

    fn eliminar_auto(&mut self,auto: &Auto) -> Result<bool,Error>{
        for i in 0..self.autos.len() {
            if self.autos[i]==*auto {
                self.autos.remove(i);
                self.guardar()?;
                return Ok(true)
            }
        }
        Ok(false)
    }

    fn buscar_auto(&mut self,auto: &Auto) -> Option<&mut Auto>{
        let mut option = None;
        for i in 0..self.autos.len() {
            if self.autos[i]==*auto {
                option = Some(&mut self.autos[i]);
                break;
            }
        }
        option
    }

    fn guardar(&self) -> Result<(), Error> {
        let mut file = File::create(&self.path)?;
        let serialized = serde_json::to_string(self)?;
        file.write_all(&serialized.as_bytes())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn crear_concesionaria(path: String) -> Consecionaria {
        let nombre = String::from("Concesionaria");
        let direccion = String::from("10 e 51 y 52");
        let mut concesionaria = Consecionaria::new(nombre, direccion, path);
        
        let auto1 = Auto::new("Fiat".to_string(),"Uno".to_string(),2015,10.0,Color::Primario(Primario::Amarillo));
        let auto2 = Auto::new("BMW".to_string(),"Nose".to_string(),2024,20.0,Color::Secundario(Secundario::Negro));
        let auto3 = Auto::new("Honda".to_string(),"HR-V".to_string(),1456,5.0,Color::Primario(Primario::Rojo));
        concesionaria.agregar_auto(auto1).unwrap();
        concesionaria.agregar_auto(auto2.clone()).unwrap();
        concesionaria.agregar_auto(auto3).unwrap();
        concesionaria
    }

    #[test]
    fn test_concesionaria_new() {
        let path = "archivos/tests/concesionaria_new.json".to_string();
        let concesionaria1 = Consecionaria::new("Nombre".to_string(), "Direccion".to_string(),path.clone());
        let consecionaria2 = Consecionaria {
            nombre:String::from("Nombre"),
            direccion:String::from("Direccion"),
            autos:Vec::new(),
            path,
        };
        assert_eq!(concesionaria1,consecionaria2);
    }

    #[test]
    fn test_concesionaria_build() {
        let path = "archivos/tests/concesionaria_build.json".to_string();
        let concesionaria1 = crear_concesionaria(path.clone());
        let consecionaria2 = Consecionaria::build(&path).unwrap();
        assert_eq!(concesionaria1,consecionaria2);
    }

    #[test]
    fn test_concesionaria_agregar() {
        let path = "archivos/tests/concesionaria_agregar.json".to_string();
        let mut concesionaria = crear_concesionaria(path.clone());
        assert_eq!(concesionaria.autos.len(),3);
        let auto = Auto::new("Ferrari".to_string(),"Ferrarus 1".to_string(),4000,500.0,Color::Primario(Primario::Rojo));
        concesionaria.agregar_auto(auto.clone()).unwrap();
        assert_eq!(concesionaria.autos.len(),4);
        assert_eq!(concesionaria.autos[3],auto);
        assert_eq!(concesionaria,Consecionaria::build(&path).unwrap());
    }

    #[test]
    fn test_concesionaria_eliminar() {
        let path = "archivos/tests/concesionaria_eliminar.json".to_string();
        let mut concesionaria = crear_concesionaria(path.clone());
        assert_eq!(concesionaria.autos.len(),3);
        let mut auto = concesionaria.autos[0].clone();
        auto.marca = "no".to_string();
        assert_eq!(concesionaria.eliminar_auto(&auto).unwrap(),false);
        auto.marca = "Fiat".to_string();
        assert_eq!(concesionaria.autos[0],auto);
        assert_eq!(concesionaria.eliminar_auto(&auto).unwrap(),true);
        assert_eq!(concesionaria.autos.len(),2);
        assert_ne!(concesionaria.autos[0],auto);
        assert_eq!(concesionaria,Consecionaria::build(&path).unwrap());
    }

    #[test]
    fn test_concesionaria_buscar() {
        let path = "archivos/tests/concesionaria_buscar.json".to_string();
        let mut concesionaria = crear_concesionaria(path.clone());
        let mut auto = concesionaria.autos[0].clone();
        auto.marca = "no".to_string();
        assert!(concesionaria.buscar_auto(&auto).is_none());
        auto.marca = "Fiat".to_string();
        if let Some(a) = concesionaria.buscar_auto(&auto) {
            assert_eq!(auto,*a);
        }
        assert_eq!(concesionaria,Consecionaria::build(&path).unwrap());
    }

    
    #[test]
    fn test_auto_new() {
        let auto1 = Auto::new("Fiat".to_string(),"Uno".to_string(),2015,10.0,Color::Primario(Primario::Amarillo));
        let auto2 = Auto {
            marca:"Fiat".to_string(),
            modelo:"Uno".to_string(),
            anno:2015,
            precio:10.0,
            color:Color::Primario(Primario::Amarillo),
        };
        assert_eq!(auto1,auto2);
    }

    #[test]
    fn test_auto_calcular_precio() {
        let auto1 = Auto::new("Fiat".to_string(),"Uno".to_string(),2015,10.0,Color::Primario(Primario::Amarillo));
        let auto2 = Auto::new("BMW".to_string(),"Nose".to_string(),2024,20.0,Color::Secundario(Secundario::Negro));
        let auto3 = Auto::new("Honda".to_string(),"HR-V".to_string(),1456,5.0,Color::Primario(Primario::Rojo));
        assert_eq!(auto1.calcular_precio(),12.5);
        assert_eq!(auto2.calcular_precio(),21.0);
        assert_eq!(auto3.calcular_precio(),6.0);
    }


}