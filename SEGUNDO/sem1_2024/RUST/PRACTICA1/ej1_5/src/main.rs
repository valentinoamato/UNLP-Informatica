use std::io::{stdin, stdout, Write};
fn main() {
    let mut string = String::from("The entered string was: ");
    print!("Please enter a string: ");
    stdout().flush().expect("Flush failed.");
    stdin().read_line(&mut string).expect("Failed to read line");
    println!("{}",string.trim());
}
