use std::io::{stdin, stdout, Write};
fn main() {
    let array = ["Hello","This","Is","An","Array"];
    let mut input = String::new();
    print!("Please enter a string: ");
    stdout().flush().expect("Flush failed.");
    stdin().read_line(&mut input).expect("Failed to read line");
    if array.contains(&input.trim()) {
        println!("The array contains the input");
    } else {
        println!("The array doesn't contain the input");
    }
}
