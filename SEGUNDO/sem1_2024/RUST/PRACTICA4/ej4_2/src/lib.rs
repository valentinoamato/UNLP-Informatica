#[derive(Clone, Debug, PartialEq)]
struct Persona<'a>{
    nombre:&'a str,
    apellido:&'a str,
    direccion:&'a str,
    ciudad:&'a str,
    salario:f64,
    edad:u8,
}

//MODULO A
fn salario_mayor_a<'a>(personas: &'a Vec<Persona<'a>>,salario:f64) -> Vec<&'a Persona<'a>> {
    personas.iter().filter(|persona| persona.salario > salario).collect()
}

//MODULO B
fn ciudad_y_edad_mayor_a<'a>(personas: &'a Vec<Persona<'a>>,ciudad: &'a str, edad:u8) -> Vec<&'a Persona<'a>> {
    personas.iter().filter(|persona| (persona.ciudad == ciudad) && (persona.edad>edad)).collect()
}

// MODULO B
fn misma_ciudad<'a>(personas: &'a Vec<Persona<'a>>,ciudad: &'a str) -> bool {
    personas.iter().find(|persona| persona.ciudad!=ciudad).is_none() //Busca una persona que sea de una ciudad distinta
}

//MODULO D
fn alguien_ciudad<'a>(personas: &'a Vec<Persona<'a>>,ciudad: &'a str) -> bool {
    personas.iter().find(|persona| persona.ciudad==ciudad).is_some() //Busca una persona que sea de la ciudad recibida
}

//MODULO E
fn existe<'a>(personas: &'a Vec<Persona<'a>>,persona: &Persona) -> bool {
    personas.iter().find(|p| *p==persona).is_some() //Busca si existe la persona recibida por parametro
}

//MODULO F
fn edades(personas: & Vec<Persona>) -> Vec<u8> {
    personas.iter().map(|p| p.edad).collect() 
}

//MODULO G
fn min_max_salario<'a>(personas: &'a Vec<Persona<'a>>) -> Option<(&'a Persona, &'a Persona)> {
    if !personas.is_empty() {
        let mut min = &personas[0]; 
        let mut max = &personas[0]; 
        personas.iter().for_each(|persona|{
            match persona.salario {
                s if s>max.salario => max = persona,
                s if s<min.salario => min = persona,
                s if (s==max.salario) && (persona.edad>max.edad) => max = persona,
                s if (s==min.salario) && (persona.edad>min.edad) => min = persona,
                _ => (),
            }
        });
        Some((min, max))
    } else {
        None
    }

}


#[cfg(test)]
mod tests {
    use std::vec;

    use super::*;

    fn crear_vector_personas<'a>() -> Vec<Persona<'a>> {
        let mut personas: Vec<Persona<'a>> = Vec::new();
        personas.push(Persona {
            nombre: "Carlos",
            apellido: "Garcia",
            direccion: "1 e 50 y 51",
            ciudad: "Berazategui",
            salario: 25000.0,
            edad: 25,
        });

        personas.push(Persona {
            nombre: "Juan",
            apellido: "Perez",
            direccion: "2 e 50 y 51",
            ciudad: "La Plata",
            salario: 30000.0,
            edad: 30,
        });

        personas.push(Persona {
            nombre: "Mateo",
            apellido: "Pirulo",
            direccion: "3 e 50 y 51",
            ciudad: "La Plata",
            salario: 35000.0,
            edad: 35,
        });

        personas.push(Persona {
            nombre: "Santiago",
            apellido: "Tiraji",
            direccion: "4 e 50 y 51",
            ciudad: "Los Hornos",
            salario: 40000.0,
            edad: 40,
        });

        personas.push(Persona {
            nombre: "Theo",
            apellido: "Di Santos",
            direccion: "5 e 50 y 51",
            ciudad: "Los Hornos",
            salario: 45000.0,
            edad: 45,
        });

        personas.push(Persona {
            nombre: "Fernando",
            apellido: "Bonavena",
            direccion: "6 e 50 y 51",
            ciudad: "CABA",
            salario: 50000.0,
            edad: 50,
        });

        personas.push(Persona {
            nombre: "Roberto",
            apellido: "Espinoza",
            direccion: "7 e 50 y 51",
            ciudad: "Villa Elisa",
            salario: 55000.0,
            edad: 55,
        });

        personas.push(Persona {
            nombre: "Francisco",
            apellido: "Winsconsin",
            direccion: "8 e 50 y 51",
            ciudad: "Villa Elisa",
            salario: 60000.0,
            edad: 60,
        });
        
        personas 
    }

    fn comparar_personas_con_referencias(personas: &Vec<Persona>, referencias: &Vec<&Persona>) -> bool {
        personas.iter().enumerate().find(|(i, persona)| { //Busca una persona que sea distinta en "personas" y "referencias"
            if *persona != referencias[*i] {
                true
            } else {
                false
            }
        }).is_none()
    }

    #[test]
    fn test_salario_mayor_a() {
        let personas = crear_vector_personas();

        let mut respuesta = salario_mayor_a(&personas, 0.0);
        assert!(comparar_personas_con_referencias(&personas, &respuesta));

        respuesta = salario_mayor_a(&personas, 200000.0);
        assert!(comparar_personas_con_referencias(&Vec::new(), &respuesta));

        respuesta = salario_mayor_a(&personas, 30000.0);
        assert!(comparar_personas_con_referencias(&personas[2..].to_vec(), &respuesta));
    }

    #[test]
    fn test_ciudad_y_edad_mayor_a() {
        let personas = crear_vector_personas();

        let mut respuesta = ciudad_y_edad_mayor_a(&personas, "La Plata",30);
        assert!(comparar_personas_con_referencias(&personas[2..3].to_vec(), &respuesta));

        respuesta = ciudad_y_edad_mayor_a(&personas, "Marte",255);
        assert!(comparar_personas_con_referencias(&Vec::new(), &respuesta));

    }

    #[test]
    fn test_misma_ciudad() {
        let mut personas = crear_vector_personas();
        assert!(!misma_ciudad(&personas, "La Plata"));
        
        personas = personas[6..].to_vec();
        assert!(misma_ciudad(&personas, "Villa Elisa"));
    }

    #[test]
    fn test_alguien_ciudad() {
        let personas = crear_vector_personas();
        assert!(alguien_ciudad(&personas, "Los Hornos"));
        
        assert!(alguien_ciudad(&personas, "Villa Elisa"));
        
        assert!(!alguien_ciudad(&personas, "Neptuno"));
    }

    #[test]
    fn test_existe() {
        let personas = crear_vector_personas();

        assert!(existe(&personas, &personas[3]));

        assert!(existe(&personas, &personas[5]));

        let persona = Persona {
            nombre: "Gianfranco",
            apellido: "Rivadavia",
            direccion: "3 e 3 y 3",
            ciudad: "Narnia",
            salario: -123.456,
            edad: 1,
        };
        assert!(!existe(&personas, &persona));        
    }

    #[test]
    fn test_edades() {
        let personas = crear_vector_personas();

        assert_eq!(edades(&personas),vec![25,30,35,40,45,50,55,60]);

        assert_eq!(edades(&Vec::new()),Vec::new());
    }

    #[test]
    fn test_min_max_salario() {
        let personas = crear_vector_personas();

        assert_eq!(min_max_salario(&personas),Some((&personas[0],&personas[7])));
        
        assert_eq!(min_max_salario(&Vec::new()),None);
    }
}