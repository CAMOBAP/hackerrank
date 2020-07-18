// #[macro_use] extern crate text_io;
// use text_io::scan;

use std::collections::HashMap;

fn scan_pair() -> (i32, i32) {
    let mut line = String::new();
    std::io::stdin().read_line(&mut line).expect("input");
    let nums = line.trim().split(' ').flat_map(str::parse::<i32>).collect::<Vec<_>>();
    return (nums[0], nums[1]); // (row, col) aka (y, x)
}

fn in_square(x: i32, y: i32, size: i32) -> bool {
    return x > 0 && x <= size && y > 0 && y <= size;
}

fn obstacle_idx(x: i32, y: i32, size: i32) -> i64 {
    return (y as i64 - 1) * size as i64 + x as i64;
}

fn main() {
    let (size, obstacles_size) = scan_pair();
    let (qy, qx) = scan_pair();
    
    let mut obstacles: HashMap<i64, bool> = HashMap::new();
    for _ in 1..obstacles_size+1 {
        let (oy, ox) = scan_pair();

        obstacles.insert(obstacle_idx(ox, oy, size), true);
    }

    let mut result: i32 = 0;
    let ds: [[i32; 2]; 8] = [
        [-1,  1], [0,  1], [1,  1],
        [-1,  0], /* q */  [1,  0],
        [-1, -1], [0, -1], [1, -1]
    ];
    for d in ds.iter() {
        let (mut sx, mut sy) = (qx + d[0], qy + d[1]);
        while in_square(sx, sy, size) && !*obstacles.entry(obstacle_idx(sx, sy, size)).or_insert(false) {
            result += 1;
            sx += d[0];
            sy += d[1];
        }
    }

    println!("{}", result);
}

