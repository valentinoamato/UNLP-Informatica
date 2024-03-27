use std::io::{stdin, stdout, Write};

fn main() {
    let a = true;
    let mut input = String::new();

    print!("\nPlease enter 'true' or 'false':");
    stdout().flush().expect("flush failed");
    stdin().read_line(&mut input).expect("Failed to read line.");
    let b: bool = match input.trim() {
        "true" => true,
        _ => false,
    };

    println!("{} or {} is {}",a,b,a | b);
    println!("{} and {} is {}",a,b,a & b);
    

    

}
