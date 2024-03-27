use std::io::{stdin, stdout, Write};

fn read(input: &mut String) {
    input.clear();
    stdin().read_line(input).expect("Failed to read line.");
}
fn main() {
    loop {
        let mut input = String::new();

        print!("\nPlease enter the operation to perform:
        1 - Multiplication
        2 - Division
        3 - Addition
        4 - Substraction
        5 - Exit
          -> ");

        stdout().flush().expect("Flush failed"); //https://doc.rust-lang.org/std/macro.print.html
        read(&mut input);
        let option: u8 = match input.trim().parse() {
            Ok(5) => {
                println!("\nThanks for using the program.");
                break
            }
            Ok(value @1..=4) => value, //https://doc.rust-lang.org/stable/book/ch18-03-pattern-syntax.html#-bindings
            Err(_) | Ok(_) => {
                println!("Invalid option.");
                continue
            }
        };

        print!("Please enter an operand:");
        stdout().flush().expect("Flush failed");
        read(&mut input);
        let a = match input.trim().parse::<f32>() {
            Ok(value) => value,
            Err(_) => {
                println!("Invalid operand.");
                continue
            }
        };

        print!("Please enter another operand:");
        stdout().flush().expect("Flush failed");
        read(&mut input);
        let b = match input.trim().parse::<f32>() {
            Ok(value) => value,
            Err(_) => {
                println!("Invalid operand.");
                continue
            }
        };

        println!("The result of the operation is:");
        match option {
            1 => println!("{} * {} = {}",a,b,a*b),
            2 => println!("{} \\ {} = {}",a,b,a/b),
            3 => println!("{} + {} = {}",a,b,a+b),
            4 => println!("{} - {} = {}",a,b,a-b),
            _ => continue,
        }
    }
}
