fn main() {
    let nums = [1,6,2,5,3,4];
    println!("El resultado de cantidad_de_mayores() es: {:?}.",cantidad_de_mayores(nums,3));
}

fn cantidad_de_mayores(nums: [i32; 6],limite: i32) -> i32 {
    let mut cant = 0;
    for i in nums {
        if i>limite {
            cant+=1;
        }
    }
    cant
}
