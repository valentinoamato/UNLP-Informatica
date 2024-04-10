const ARRAY_REPEAT_VALUE: String = String::new();
fn main() {
    let array1: [&str; 6] = ["Hola","Esto","Es","Un","Test","."];
    let mut array2 =  [ARRAY_REPEAT_VALUE; 6];
    for i in 0..array1.len() {
        array2[i]=String::from(array1[i]);
    }
    println!("El resultado de cantidad_de_cadenas_mayor_a() es: {:?}.",cantidad_de_cadenas_mayor_a(array2,3));
}

fn cantidad_de_cadenas_mayor_a(cadenas: [String; 6],limite: usize) -> u32 {
    let mut cant = 0;
    for s in cadenas {
        if s.len()>limite {
            cant+=1;
        }
    }
    cant
}
