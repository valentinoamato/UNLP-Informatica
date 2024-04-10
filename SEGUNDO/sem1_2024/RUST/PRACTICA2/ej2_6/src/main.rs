const ARRAY_REPEAT_VALUE: String = String::new();
fn main() {
    let array1: [&str; 6] = ["Hola","Esto","Es","Un","Test","."];
    let mut array2 =  [ARRAY_REPEAT_VALUE; 6];
    for i in 0..array1.len() {
        array2[i]=String::from(array1[i]);
    }
    println!("El resultado de longitud_de_cadenas() es: {:?}.",longitud_de_cadenas(array2));
}

fn longitud_de_cadenas(cadenas: [String; 6]) -> [usize; 6] {
    let mut resultado = [0; 6];
    for i in 0..cadenas.len() {
        resultado[i]=cadenas[i].len();
    }
    resultado
}
