// Complete the kangaroo function below.
// Solve equasion: x1 + v1 * t = x2 + v2 * t ~ t = (x2 - x1) / (v1 - v2))
fn kangaroo(x1: i32, v1: i32, x2: i32, v2: i32) -> String {
    let mut result = false;

    if v1 == v2 {
        // corner case
        result = x1 == x2;
    } else {
        let integer_solution = (x2 - x1) % (v1 - v2) == 0;
        if integer_solution {
            let t = (x2 - x1) / (v1 - v2);
            result = t >= 0i32;
        }
    }

    return String::from(if result { "YES" } else { "NO" });
}

fn main() {
    let mut input_str = String::new();
    std::io::stdin().read_line(&mut input_str).expect("could not read stdin");
    let input: Vec<i32> = input_str.trim().split(' ').flat_map(str::parse::<i32>).collect::<Vec<_>>();
    let x1 = input[0];
    let v1 = input[1];
    let x2 = input[2];
    let v2 = input[3];

    let result = kangaroo(x1, v1, x2, v2);

    println!("{}", result);
}
