fn main() {
    let mut nums = [1,8,2,7,3,6,4,5];
    multiplicar_valores(&mut nums,3);
    println!("El resultado de multiplicar_valores() es: {:?}.",nums);
}

fn multiplicar_valores(nums: &mut [i32; 8],factor: i32) {
    for i in 0..nums.len() {
        nums[i]=nums[i]*factor;
    }
    }
