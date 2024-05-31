#[derive(PartialEq, Debug)]
struct Examen {
    materia: String,
    nota: u32
}

#[derive(PartialEq, Debug)]
struct Estudiante {
    nombre: String,
    id: u32,
    examenes: Vec<Examen>
}

impl Examen {
    fn new(materia: String, nota: u32) -> Examen {
        Examen{
            materia,
            nota
        }
    }
}

impl Estudiante {
    fn new(nombre: String,id: u32) -> Estudiante {
        Estudiante{
            nombre,
            id,
            examenes: Vec::new()
        }
    }

    fn agregar_examen(&mut self,examen: Examen) {
        self.examenes.push(examen);
    }

    fn obtener_promedio(&self) -> f32 {
        if self.examenes.is_empty() {
            return -1.0;
        }
        let mut total = 0;
        for examen in &self.examenes {
            total+=examen.nota
        }
        total as f32 / self.examenes.len() as f32
    }

    fn calificacion_mas_alta(&self) -> u32 {
        if self.examenes.is_empty() {
            return 0;
        }
        let mut max = 0;
        for examen in &self.examenes {
            if examen.nota>max {
                max = examen.nota;
            }
        }
        max
    }

    fn calificacion_mas_baja(&self) -> u32 {
        if self.examenes.is_empty() {
            return 0;
        }
        let mut min = 11;
        for examen in &self.examenes {
            if examen.nota<min {
                min = examen.nota;
            }
        }
        min
    }

}

#[cfg(test)]
mod estudiaste_tests {
    use super::*;

    #[test]
    fn test_estudiante() {
        let nombre = String::from("Carlos");
        let id = 1;
        let mut carlos = Estudiante{nombre, id, examenes:Vec::new()};
        assert_eq!(Estudiante::new("Carlos".to_string(), 1),carlos);
        
        carlos.agregar_examen(Examen::new(String::from("Fisica"),8));
        carlos.agregar_examen(Examen::new(String::from("Matematica"),9));
        carlos.agregar_examen(Examen::new(String::from("Quimica"),10));
        assert_eq!(carlos.obtener_promedio(),9.0);
        assert_eq!(carlos.calificacion_mas_alta(),10);
        assert_eq!(carlos.calificacion_mas_baja(),8);

    }


}