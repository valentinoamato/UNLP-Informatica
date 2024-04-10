fn main() {
    let nums = [1.0,2.0,3.0,4.0,5.0,6.0];
    println!("El resultado de duplicar_valores() es: {:?}.",duplicar_valores(nums));
}

fn duplicar_valores(nums: [f32; 6]) -> [f32; 6] {
    let mut resultado = [0.0; 6];
    for i in 0..nums.len() {
        resultado[i]=nums[i]*2.0;
    }
    resultado
}
