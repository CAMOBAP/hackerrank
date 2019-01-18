package main

import (
	"fmt"
	"os"
)

var (
	// input, _ = os.Open("/Users/camobap/Developers/Projects/hackerrank/golang/src/coin-change/test/input02.txt")
	input = os.Stdin
)

// http://prismoskills.appspot.com/lessons/Dynamic_Programming/Chapter_03_-_Max_ways_in_which_coins_can_make_a_sum.jsp
func coins(coins []int, sum int) int64 {
	if len(coins) == 0 {
		return 0
	}

	tabulation := make([]int64, (sum+1)*len(coins))

	for i := 0; i < len(coins); i++ {
		tabulation[i] = 1
	}

	for s := 1; s <= sum; s++ {
		for c := 0; c < len(coins); c++ {
			var exclude int64
			if c >= 1 {
				exclude = tabulation[s*len(coins)+c-1]
			}

			sumLeft := s - coins[c]

			var include int64
			if sumLeft >= 0 {
				include = tabulation[sumLeft*len(coins)+c]
			}

			tabulation[s*len(coins)+c] = exclude + include
		}
	}

	return tabulation[sum*len(coins)+len(coins)-1]
}

func main() {
	var n, m, ci int
	fmt.Fscanf(input, "%d %d\n", &n, &m)

	c := make([]int, 0, m)
	for i := 0; i < m; i++ {
		fmt.Fscanf(input, "%d", &ci)

		if ci <= n {
			c = append(c, ci)
		}
	}

	fmt.Println(coins(c, n))
}
