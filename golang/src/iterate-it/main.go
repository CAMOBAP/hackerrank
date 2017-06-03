package main

import (
	"fmt"
)

func main() {
	var n int
	fmt.Scanln(&n)
	A := make([]int, 0, n)
	for i := 0; i < n; i++ {
		var a int
		fmt.Scan(&a)
		A = append(A, a)
	}

	rep := 0
	for len(A) != 0 {
		B := make([]int, 0, n/2)

		for _, x := range A {
			for _, y := range A {
				if x != y {
					if x > y {
						B = append(B, x-y)
					} else {
						B = append(B, y-x)
					}
				}
			}
		}

		// fmt.Printf("B = %v\n", B)
		fmt.Printf("len(B) = %v\n", len(B))

		A = B
		rep++

		if rep > n+1 {
			rep = -1
			break
		}
	}

	fmt.Println(rep)
}
