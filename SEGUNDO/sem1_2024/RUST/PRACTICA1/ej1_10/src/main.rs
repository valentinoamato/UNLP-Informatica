fn main() {
    let array1 = [1,2,3,4,5];
    let array2 = [6,7,8,9,10];
    let mut array3: [i32; 5] = [0; 5];

    for i in 0..5 {
        array3[i]=array1[i]+array2[i];
    }
    println!("{:?}",array3);
}
