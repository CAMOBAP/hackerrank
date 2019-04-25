use std::collections::HashMap;

fn optimized_estimate(s: &str) -> usize {
    let mut map = HashMap::new();

    for ch in s.chars() {
        map.insert(ch, 1);
    }

    return map.keys().len();
}

fn naive_estimate(s: &str) -> usize {
    let mut p = String::new();

    let mut r = 0usize;
    let mut b = 0;
    while b < s.len() {
        for e in b+1..s.len()+1 {
            if !p.contains(&s[b..e]) {
                if e - b == 1 {
                    p.push_str(&s[b..e]);
                } else {
                    p.push_str(&s[b..e-1]);
                }
                if e - b == 1  {
                    r = r + 1;
                }
                b = e;
                break;
            } else if e == s.len() {
                b = e;
                break;
            }
        }

        if b == s.len() - 1 {
            break;
        }
    }

    return r;
}

fn main() {
    let stdin = std::io::stdin();
    let mut s = String::new();
    
    stdin.read_line(&mut s).expect("could not read T");
    let t : usize = s.trim().parse().unwrap();

    for _ in 0..t {
        s.clear();
        stdin.read_line(&mut s).expect("could not read string");
        
        println!("{}", optimized_estimate(&s.trim()));
    }
}
