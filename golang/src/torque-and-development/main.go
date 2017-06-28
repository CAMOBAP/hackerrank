package main

import (
	"fmt"
	"os"
	"common"
)


var (
	input, _ = os.Open(common.Relative("test/input04.txt"))
	// input = os.Stdin
)

func contains(s []int, e int) bool {
    for _, a := range s {
        if a == e {
            return true
        }
    }
    return false
}

func dedup(s []int) []int {
	m := map[int]bool{}
	
	// walk the slice and for each value we've not seen so far
	// move it to slot K here K i the number of unique values
	// we've seen so far. below, K is represented by `len(m)`
	// after the loop you're left with a slice all unique values at the front
	// in their original order so you simply to re-slice to K to get only the unique values
	for _, v := range s {
		if _, seen := m[v]; !seen {
			s[len(m)] = v
			m[v] = true
		}
	}
	// re-slice s to the number of unique values
	s = s[:len(m)]
	
	return s
}

func bind_components(n, m int64) ([][]int, int64) {
    var from, to int
    groups := make([][]int, 0, n)
            
    for r := int64(0); r < m; r++ {
        fmt.Scanf("%d %d\n", &from, &to)

        if len(groups) == 0 {
            groups = append(groups, []int{from, to})
        } else {
            var added bool
            var merge [2]int

            for i := 0; i < len(groups); i++ {
                group := groups[i]
                if contains(group, from) && contains(group, to) {
                    added = true
                } else if contains(group, from) {
                    group = append(group, to)
                    if added {
                        merge[1] = i
                    } else {
                        merge[0] = i
                        added = true
                    }
                } else if contains(group, to) {
                    group = append(group, from)
                    if added {
                        merge[1] = i
                    } else {
                        merge[0] = i
                        added = true
                    }
                }

                groups[i] = group
            }

            if !added {
                new_group := make([]int, 0, n)
                new_group = append(new_group, from)
                new_group = append(new_group, to)
                groups = append(groups, new_group)
            } else if merge[0] != merge[1] {
                merged := dedup(append(groups[merge[0]], groups[merge[1]]...))
                groups[merge[0]] = merged
                groups = append(groups[:merge[1]], groups[merge[1]+1:]...)

                merge[0] = 0
                merge[1] = 0
            }
        }
    }
    
    var traversed int64
    for i := 0; i < len(groups); i++ {
        traversed += int64(len(groups[i]))
    }
    isolated := n - traversed

    if isolated < 0 {
        isolated = 0
    }
        
    return groups, isolated
}

func drop_edges_input(m int64) {
    var from, to int
            
    for r := int64(0); r < m; r++ {
        fmt.Scanf("%d %d\n", &from, &to)
    }
}


func main() {
	common.StartProfile()
	defer common.StopProfile()

    var q int
    var n, m, c_lib, c_road int64
    fmt.Scanf("%d\n", &q)
    
    for i := 0; i < q; i++ {
        fmt.Scanf("%d %d %d %d\n", &n, &m, &c_lib, &c_road)
        
        if c_lib <= c_road {
            drop_edges_input(m)
            fmt.Println(n * c_lib)
        } else {
            groups, isolated := bind_components(n, m)
            
            var result int64
            if len(groups) > 0 {
                for _, group := range groups {
                    result += c_lib + c_road * int64(len(group) - 1)
                }
               
                result += isolated * c_lib
            } else {
                result = c_lib * n
            }
            
            fmt.Println(result)
        }
    }
}
