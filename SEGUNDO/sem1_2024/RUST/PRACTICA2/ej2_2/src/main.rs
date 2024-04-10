fn main() {
    println!("El numero 3 es primo: {}.",es_primo(3));
    println!("El numero 4 es primo: {}.",es_primo(4));
    println!("El numero 21 es primo: {}.",es_primo(21));
    println!("El numero 37 es primo: {}.",es_primo(37));
    println!("El numero 59 es primo: {}.",es_primo(59));
}

fn es_primo(num: i32) -> bool {
    let mut divisores = 0;
    for i in 1..=num {
        if num % i == 0 {
            divisores+=1;
        }
        if divisores>2 {
            break
        }
    }
    divisores < 3
}
