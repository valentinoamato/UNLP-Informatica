fn main() {
    let nums = [1,2,3,4,5,6];
    println!("El resultado de cantidad_impares() es: {}.",cantidad_impares(nums));
}

fn cantidad_impares(nums: [i32; 6]) -> i32 {
    let mut cantidad = 0;
    for i in nums {
        if i % 2 != 0 {
            cantidad+=1;
        }
    }
    cantidad
}
