package main

import (
    "common"
    "fmt"
    "os"
)

var (
    input, _ = os.Open(common.Relative("test/input03.txt"))
    // input = os.Stdin
)

// http://blog.plover.com/math/choose.html
func choose(n, k, m uint) uint {
    if k > n {
        return 0
    }
    
    r := uint(1)
    for d := uint(1); d <= k; d++ {
        r *= n
        r /= d
        n--
    }

    r %= m

    return r;
}

func main() {
    var t, n uint
    fmt.Fscan(input, &t)

    fmt.Printf("%d/%d -> %d\n", 190, 229, choose(229, 190, 1000000000))

    for ti := uint(0); ti < t; ti++ {
        fmt.Fscan(input, &n)
        for ni := uint(0); ni <= n; ni++ {
            fmt.Printf("%d/%d -> %d ", ni, n, choose(n, ni, 1000000000))
        }
        fmt.Println()
    }
}
