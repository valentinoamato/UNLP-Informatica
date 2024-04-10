fn main() {
    println!("El numero 2 es par: {}.",es_par(2));
    println!("El numero 3 es par: {}.",es_par(3));
    println!("El numero 4 es par: {}.",es_par(4));
}

fn es_par(num: i32) -> bool {
    num % 2 == 0
}
