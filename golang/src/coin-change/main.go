package main

import (
	"fmt"
	"sort"
	"os"

	"common"
)

var (
	input, _ = os.Open(common.Relative("test/input02.txt"))
	// input = os.Stdin
)

func sliceEqual(a, b []int) bool {

	if a == nil && b == nil {
		return true
	}

	if a == nil || b == nil {
		return false
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

// my solution
func calc(path []int, sum int, coins []int, n int, result [][]int) [][]int {
	fmt.Println(">", path)

	for _, c := range coins {
		if c+sum < n {
			result = calc(append(path, c), c+sum, coins, n, result)
		} else if c+sum == n {
			p := make([]int, len(path)+1)
			copy(p, append(path, c))
			sort.Ints(p)

			if !contains(result, p) {
				result = append(result, p)
			}
		}
	}

	return result
}

// http://prismoskills.appspot.com/lessons/Dynamic_Programming/Chapter_03_-_Max_ways_in_which_coins_can_make_a_sum.jsp
func coins(coins []int, sum int) int64 {
	if len(coins) == 0 {
		return 0
	}

	tabulation := make([]int64, (sum + 1) * len(coins))

	for i := 0; i < len(coins); i++ {
		tabulation[i] = 1
	}

	for s := 1; s <= sum; s++ {
		for c := 0; c < len(coins); c++ {
			var exclude int64
			if c >= 1 {
				exclude = tabulation[s * len(coins) + c - 1]
			}

			sumLeft := s - coins[c]

			var include int64
			if sumLeft >= 0 {
				include = tabulation[sumLeft * len(coins) + c]
			}

			tabulation[s * len(coins) + c] = exclude + include
		}
	}

	return tabulation[sum * len(coins) + len(coins) - 1]
}

func main() {
	common.StartProfile()
	defer common.StopProfile()

	var n, m, ci int
	fmt.Fscanf(input,"%d %d\n", &n, &m)

	c := make([]int, 0, m)
	for i := 0; i < m; i++ {
		fmt.Fscanf(input,"%d", &ci)

		if ci <= n {
			c = append(c, ci)
		}
	}

	fmt.Println(coins(c, n))
}
