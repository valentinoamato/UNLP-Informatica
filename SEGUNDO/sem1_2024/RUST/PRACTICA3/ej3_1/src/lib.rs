use std::fmt::format;

#[derive(PartialEq, Debug)]
struct Persona {
    nombre: String,
    edad: u8,
    direccion: Option<String>
}

impl Persona {
    fn new(nombre: String, edad: u8, direccion: Option<String>) -> Persona {
        Persona{
            nombre,
            edad,
            direccion,
        }
    }

    fn to_string(&self) -> String {
        let direccion: &str;
        if let Some(dir) = &self.direccion {
            direccion = dir;
        } else {
            direccion = "desconocida"
        }
        format!("Nombre: {}, Edad: {}, Direccion: {}",self.nombre,self.edad,direccion)
    }

    fn obtener_edad(&self) -> u8 {
        self.edad
    }

    fn actualizar_direccion(&mut self,nueva_direccion: Option<String>) {
        self.direccion = nueva_direccion;
    }
}

#[cfg(test)]
mod persona_tests {
    use super::Persona;

    #[test]
    fn test_new_persona() {
        let nombre = String::from("Joaquin Ticera");
        let edad = 22;
        let persona = Persona{nombre: nombre.clone(),edad,direccion:None};
        assert_eq!(Persona::new(nombre.clone(), edad, None),persona);
        let persona = Persona{
            nombre:String::from("Pedro Di Nardo"),
            edad:21,
            direccion:Some(String::from("55 e 8 y 9"))};
        assert_ne!(Persona::new(nombre, edad, None),persona);
        assert_eq!(Persona::new(String::from("Pedro Di Nardo"), 21, Some(String::from("55 e 8 y 9"))),persona);
    }

    #[test]
    fn test_to_string_persona() {
        let nombre = String::from("Joaquin Ticera");
        let edad = 22;
        let  direccion = Some(String::from("50 y 120"));
        let persona = Persona{nombre,edad,direccion};
        assert_eq!(persona.to_string(), String::from("Nombre: Joaquin Ticera, Edad: 22, Direccion: 50 y 120"));
    }

    #[test]
    fn test_obtener_edad_persona() {
        let nombre = String::from("Joaquin Ticera");
        let edad = 22;
        let  direccion = Some(String::from("50 y 120"));
        let persona = Persona{nombre,edad,direccion};
        assert_eq!(persona.obtener_edad(),22);
    }

    #[test]
    fn test_actualizar_direccion() {
        let nombre = String::from("Joaquin Ticera");
        let edad = 22;
        let  direccion = Some(String::from("50 y 120"));
        let mut persona = Persona{nombre,edad,direccion:direccion.clone()};
        assert_eq!(persona.direccion,direccion);
        persona.actualizar_direccion(None);
        assert_eq!(persona.direccion,None);
    }
}