fn main() {
    let nums1 = [1.0,2.0,3.0,4.0,5.0,6.0];
    let nums2 = [7.0,8.0,9.0,10.0,11.0,12.0];
    println!("El resultado de sumar_arreglos() es: {:?}.",sumar_arreglos(nums1,nums2));
}

fn sumar_arreglos(nums1: [f32; 6],nums2: [f32; 6]) -> [f32; 6] {
    let mut resultado = [0.0; 6];
    for i in 0..nums1.len() {
        resultado[i]=nums1[i]+nums2[i];
    }
    resultado
}
