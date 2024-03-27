use std::io::{stdin, stdout, Write};
fn main() {
    let mut base: u32 = 10;
    let mut input = String::new();
    print!("Please enter a number: ");
    stdout().flush().expect("Flush failed.");
    stdin().read_line(&mut input).expect("Failed to read line");
    base += input.trim().parse::<u32>().expect("Invalid input.");
    println!("{}^2={}",base,base * base);
}
