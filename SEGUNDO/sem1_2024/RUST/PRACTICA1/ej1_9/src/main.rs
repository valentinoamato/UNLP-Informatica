fn main() {
    let array = [1,2,3,4,5];
    let mut total: i32 = 0;
    for n in array {
        total += n;
    }
    println!("{}",total);
}
