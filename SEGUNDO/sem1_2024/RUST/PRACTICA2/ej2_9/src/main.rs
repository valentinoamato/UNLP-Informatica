fn main() {
    let nums = [1,8,2,7,3,6,4,5];
    println!("El resultado de cantidad_en_rango() es: {}.",cantidad_en_rango(nums,3,7));
}

fn cantidad_en_rango(nums: [i32; 8],inferior: i32,superior: i32) -> i32 {
    let mut cant = 0;
    for i in nums {
        if (i>=inferior) & (i<=superior) {
            cant+=1;
        }
    }
    cant
}
