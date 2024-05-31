#[derive(PartialEq, Debug)]
enum Tipo {
    Equilatero, //3 Lados iguales
    Isosceles,  //2 Lados iguales
    Escaleno    //0 Lados iguales
}

#[derive(PartialEq, Debug)]
struct Triangulo {
    lado_a: f32,
    lado_b: f32,
    lado_c: f32
}

impl Triangulo {
    fn new(lado_a: f32, lado_b: f32,lado_c: f32) -> Triangulo {
        Triangulo{
            lado_a,
            lado_b,
            lado_c
        }
    }

    fn determinar_tipo(&self) -> Tipo {
        if self.lado_a==self.lado_b {
            if self.lado_a==self.lado_c {
                Tipo::Equilatero
            } else {
                Tipo::Isosceles
            }
        } else if (self.lado_a==self.lado_c) || (self.lado_b==self.lado_c) {
            Tipo::Isosceles
        } else {
            Tipo::Escaleno
        }
    }

    fn calcular_area(&self) -> f32 {
        //Formula de Heron
        let s = self.calcular_perimetro() / 2.0;
        f32::sqrt(s*(s-self.lado_a)*(s-self.lado_b)*(s-self.lado_c))
        }

    fn calcular_perimetro(&self) -> f32 {
        self.lado_a + self.lado_b + self.lado_c
    }
}

#[cfg(test)]
mod triangulo_tests {
    use super::*;

    #[test]
    fn triangulo() {
        let lado_a = 3.0;
        let lado_b = 2.0;
        let lado_c = 1.5;
        let triangulo = Triangulo{lado_a, lado_b, lado_c};
        assert_eq!(Triangulo::new(3.0, 2.0, 1.5),triangulo);
        assert_eq!(triangulo.determinar_tipo(),Tipo::Escaleno);
        assert_eq!(triangulo.calcular_area(),1.333170563);
        assert_eq!(triangulo.calcular_perimetro(),6.5);

    }


}