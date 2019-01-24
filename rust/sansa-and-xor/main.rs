// Complete the sansaraXor function below.
fn sansara_xor(array: &Vec<i32>) -> i32 {
    if array.len() % 2 == 0 {
        return 0;
    } 
    
    let mut result : i32 = 0;
    for i in 0 .. array.len() {
        if i % 2 == 0 {
            result ^= array[i];
        }
    }

    return result;
}

fn main() {
    let mut input_str = String::new();
    let stdin = std::io::stdin();

    stdin.read_line(&mut input_str).expect("could not read T");
    let t : usize = input_str.trim().parse().unwrap();

    for _ in 0..t {
        input_str.clear();
        stdin.read_line(&mut input_str).expect("could not read N");
        let n : usize = input_str.trim().parse().unwrap();

        input_str.clear();
        stdin.read_line(&mut input_str).expect("could not read ARRAY");
        let input: Vec<i32> = input_str.trim().split(' ').flat_map(str::parse::<i32>).collect::<Vec<_>>();
        if input.len() != n {
            panic!("ARRAY have wrong size {}, expected {}", input.len(), n);
        }

        let result = sansara_xor(&input);

        println!("{}", result);
    }
}

