fn main() {
    let mut f = 1.0;
    incrementar(&mut f);
    println!("El resultado de incrementar() es: {}.",f);
}

fn incrementar(num: &mut f32) {
    *num=*num+1.0;
}
