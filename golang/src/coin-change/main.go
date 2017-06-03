package main

import (
    "fmt"
    "sort"
)

func sliceEqual(a, b []int) bool {

    if a == nil && b == nil { 
        return true; 
    }

    if a == nil || b == nil { 
        return false; 
    }

    if len(a) != len(b) {
        return false
    }

    for i := range a {
        if a[i] != b[i] {
            return false
        }
    }

    return true
}

func contains(a [][]int, b []int) bool {
    for _, v := range a {
        if len(v) == len(b) && sliceEqual(v, b) {
            return true
        }
    }
    return false
}

func calc(path []int, sum int, coins []int, n int, result [][]int) [][]int {
    for _, c := range coins {
        if c + sum < n {
            result = calc(append(path, c), c + sum, coins, n, result)
        } else if c + sum == n {
            p := make([]int, len(path) + 1)
            copy(p, append(path, c))
            sort.Ints(p)
            
            if !contains(result, p) {
                result = append(result, p)
            }
        }
    }
    
    return result
}

func main() {
    var n, m, ci int
    fmt.Scanf("%d %d\n", &n, &m)
    
    c := make([]int, 0, m)
    for i := 0; i < m; i++ {
        fmt.Scanf("%d", &ci)
        
        if ci <= n {
            c = append(c, ci)
        }
    }
    
    result := calc(make([]int, 0, n), 0, c, n, make([][]int, 0, n))
    
    fmt.Println(len(result))
}
