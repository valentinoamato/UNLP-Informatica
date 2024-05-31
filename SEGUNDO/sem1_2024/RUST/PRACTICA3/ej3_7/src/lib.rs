#[derive(PartialEq, Debug, Clone)]
enum Primario {
    Amarillo,
    Rojo,
    Azul
}

#[derive(PartialEq, Debug, Clone)]
enum Secundario { //No son todos colores secundarios pero bueno
    Verde,
    Blanco,
    Negro,
}

#[derive(PartialEq, Debug, Clone)]
enum Color {
    Primario(Primario),
    Secundario(Secundario)
}

#[derive(PartialEq, Debug, Clone)]
struct Auto {
    marca: String,
    modelo: String,
    anno: u32,
    precio: f64,
    color:Color
}

#[derive(PartialEq, Debug)]
struct Consecionaria {
    nombre: String,
    direccion: String,
    autos: Vec<Auto>
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
    fn new(nombre: String,direccion: String) -> Consecionaria {
        Consecionaria{
            nombre,
            direccion,
            autos: Vec::new()
        }
    }

    fn agregar_auto(&mut self,auto: Auto) {
        self.autos.push(auto);
    }

    fn eliminar_auto(&mut self,modelo: String) {
        for i in 0..self.autos.len() {
            if self.autos[i].modelo==modelo {
                self.autos.remove(i);
                break;
            }
        }
    }

    fn buscar_auto(&mut self,modelo: String) -> Option<Auto>{
        let mut option = None;
        for i in 0..self.autos.len() {
            if self.autos[i].modelo==modelo {
                option = Some(self.autos[i].clone());
                break;
            }
        }
        option
    }
}

#[cfg(test)]
mod concesionaria_tests {
    use super::*;

    #[test]
    fn test_concesionaria() {
        let nombre = String::from("Concesionaria");
        let direccion = String::from("10 e 51 y 52");
        let autos = Vec::new();
        let mut concesionaria = Consecionaria{nombre, direccion, autos};
        assert_eq!(Consecionaria::new("Concesionaria".to_string(), "10 e 51 y 52".to_string()),concesionaria);
        
        let auto1 = Auto::new("Fiat".to_string(),"Uno".to_string(),2015,10.0,Color::Primario(Primario::Amarillo));
        let auto2 = Auto::new("BMW".to_string(),"Nose".to_string(),2024,20.0,Color::Secundario(Secundario::Negro));
        let auto3 = Auto::new("Honda".to_string(),"HR-V".to_string(),1456,5.0,Color::Primario(Primario::Rojo));
        concesionaria.agregar_auto(auto1);
        concesionaria.agregar_auto(auto2);
        concesionaria.agregar_auto(auto3);


        let auto = concesionaria.buscar_auto("Nose".to_string());
        assert!(auto.is_some());
        if let Some(a) = auto {
            assert_eq!(a.calcular_precio(),21.0);
        }
        concesionaria.eliminar_auto("Nose".to_string());
        let auto = concesionaria.buscar_auto("Nose".to_string());
        assert!(auto.is_none());


    }


}