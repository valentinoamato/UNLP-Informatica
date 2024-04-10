fn main() {
    let nums = [1,2,3,4,5,6];
    println!("El resultado de suma_pares() es: {}.",suma_pares(nums));
}

fn suma_pares(nums: [i32; 6]) -> i32 {
    let mut suma = 0;
    for i in nums {
        if i % 2 == 0 {
            suma+=i;
        }
    }
    suma
}
