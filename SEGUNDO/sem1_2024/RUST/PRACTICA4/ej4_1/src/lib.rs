pub trait Prime {
    fn is_prime(&self) -> bool;
}

impl Prime for u32 {
    fn is_prime(&self) -> bool {
        let mut prime = true;
        if *self<2 {
            prime = false;
        } else {
            for i in 2..=((*self as f32).sqrt() as u32) {
                if self % i == 0 {
                    prime = false;
                    break;
                }
            }
    }
        prime
    }
}

pub fn count_primes(nums: &Vec<impl Prime>) -> u32 {
    let mut count: u32 = 0;
    nums.iter().for_each(|num| {
        if num.is_prime() {
            count+=1;
        }
    });
    count
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn u32_is_prime() {
        let mut primes = Vec::new();
        for i in 0..=50 {
            if i.is_prime() {
                primes.push(i);
            }
        }
        assert_eq!(primes,vec![2,3,5,7,11,13,17,19,
                               23,29,31,37,41,43,47])
    }

    #[test]
    fn test_count_primes() {
        assert_eq!(count_primes(&Vec::<u32>::new()),0);
        assert_eq!(count_primes(&(1..=100).collect()),25);
    }
}