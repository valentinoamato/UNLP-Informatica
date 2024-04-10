fn main() {
    let mut nums = [1,8,2,7,3,6,4,5];
    remplazar_pares(&mut nums);
    println!("El resultado de remplazar_pares() es: {:?}.",nums);
}

fn remplazar_pares(nums: &mut [i32; 8]) {
    for i in 0..nums.len() {
        if nums[i] % 2 == 0 {
            nums[i]=-1;
        }
    }
    }
