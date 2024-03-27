fn main() {
    let tuple = ("This is a tuple: ",[1,2,3,4,5,6]);
    println!("{}",tuple.0);
    let mut sum = 0;
    for n in tuple.1 {
        sum += n;
    }
    println!("{sum}");
}
