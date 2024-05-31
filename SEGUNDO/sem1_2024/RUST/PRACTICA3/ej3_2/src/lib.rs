use std::fmt::format;

#[derive(PartialEq, Debug)]
struct Rectangulo {
    alto: f32,
    ancho: f32,
}

impl Rectangulo {
    fn new(alto: f32, ancho: f32) -> Rectangulo {
        Rectangulo{
            alto,
            ancho,
        }
    }

    fn calcular_area(&self) -> f32 {
        self.ancho * self.alto 
    }

    fn calcular_perimetro(&self) -> f32 {
        self.alto * 2.0 + self.ancho * 2.0
    }

    fn es_cuadrado(&self) -> bool {
        self.alto == self.ancho
    }
}

#[cfg(test)]
mod rectangulo_tests {
    use super::Rectangulo;

    #[test]
    fn test_rectangulo() {
        let alto = 4.0;
        let ancho = 2.5;
        let rectangulo = Rectangulo{alto, ancho};
        assert_eq!(Rectangulo::new(alto, ancho),Rectangulo{alto:4.0,ancho:2.5});
        assert_eq!(rectangulo.calcular_area(),10.0);
        assert_eq!(rectangulo.calcular_perimetro(),13.0);
        assert!(!rectangulo.es_cuadrado());

    }


}