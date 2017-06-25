package main

import (
    "fmt"
    "os"

    // "common"
	"common"
)

var (
    input, _ = os.Open(common.Relative("test/input04.txt"))
	// input = os.Stdin
)

// http://blog.plover.com/math/choose.html
func choose(n, k, m int) int {
    if k > n {
        return 0
    }
    
    r := 1
    for d := 1; d <= k; d++ {
        r *= n
        n--
        r /= d
        r %= m
    }
    
    return r;
}

func main() {
    var t int
    fmt.Fscan(input, &t)
    
    for i := 0; i < t; i++ {
        var z, o int
        fmt.Fscanf(input, "%d %d", &z, &o)
        
        k := o - 1 // first place always 1 
        n := o + z
        
        // http://dxdy.ru/topic10606.html
        cn := n
        ck := k
        
        c := choose(cn, ck, 1000000007)
        
        fmt.Println(c)
        // 1 of 1 -> 1
        // 1 of 2 -> 2
        // 1 of 3 -> 3
        // 1 of 4 -> 4
        // 2 of 2 -> 1
        // 2 of 3 -> 3
        // 2 of 4 -> 6 -> 1100, 1010, 1001, 0110, 0101, 0011
        // 3 of 3 -> 1
        // 3 of 4 -> 4 -> 1110, 1101, 1011, 0111
        // 
        
    }
}
