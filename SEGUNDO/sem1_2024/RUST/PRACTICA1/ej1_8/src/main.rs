use std::io::{stdin, stdout, Write};
fn main() {
    let string = String::from("this is a test string");
    let mut input = String::new();
    print!("Please enter character: ");
    stdout().flush().expect("Flush failed.");
    stdin().read_line(&mut input).expect("Failed to read line");
    let char1: char = input.trim().parse().expect("Invalid input.");
    println!("Character {} appears {} times in string '{}'",char1,string.split(char1).count()-1,string);
}
