fn main() {
    const VALUE: i32 = 2;
    let mut array = [1,2,3,4,5,6];
    println!("{:?}",array);
    array = array.map(|n| n*VALUE);
    println!("{:?}",array);
}
