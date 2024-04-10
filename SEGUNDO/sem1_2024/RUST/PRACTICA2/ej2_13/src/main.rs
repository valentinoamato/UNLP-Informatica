const ARRAY_REPEAT_VALUE: String = String::new();
fn main() {
    let array1: [&str; 8] = ["Hola","Estimado","Usuario","Esto","Es","Un","Test","."];
    let mut array2 =  [ARRAY_REPEAT_VALUE; 8];
    for i in 0..array1.len() {
        array2[i]=String::from(array1[i]);
    }

    ordenar_nombres(&mut array2);
    println!("El resultado de ordenar_nombres() es: {:?}.",array2);
}

fn ordenar_nombres(cadenas: &mut [String; 8]) {
    let mut min: usize;
    let mut aux: String;
    for i in 0..cadenas.len()-1 {
        min = i;
        for j in i..cadenas.len() {
            if cadenas[j]<cadenas[min] {
                min=j;
            }
        }
        aux=cadenas[i].clone();
        cadenas[i]=cadenas[min].clone();
        cadenas[min]=aux;
        
    }
}
