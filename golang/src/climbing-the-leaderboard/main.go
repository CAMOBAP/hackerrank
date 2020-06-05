package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

// Complete the climbingLeaderboard function below.
func climbingLeaderboard(scores []int32, alice []int32) []int32 {
	var cur_rank int32 = 1
	ranks := make([]int32, len(alice))
	rank_index := len(ranks) - 1

	alice_index := len(alice) - 1
	alice_score := alice[alice_index]

	score_index := 0
	curr_score := scores[score_index]
	last_score := curr_score

	for alice_index >= 0 {
		// fmt.Printf("scores[%d]=%d alice[%d]=%d\n", score_index, curr_score, alice_index, alice_score)
		if alice_score >= curr_score {
			ranks[rank_index] = cur_rank
			rank_index -= 1

			if alice_index > 0 {
				alice_index -= 1
				alice_score = alice[alice_index]
			} else {
				break
			}
		} else {
			if score_index < len(scores)-1 {
				score_index += 1
				curr_score = scores[score_index]

				if curr_score != last_score {
					cur_rank += 1
				}
			} else {
				break
			}

			last_score = curr_score
		}
	}

	for i := rank_index; i >= 0; i-- {
		ranks[i] = cur_rank + 1
	}

	return ranks
}

func main() {
	reader := bufio.NewReaderSize(os.Stdin, 1024*1024*10)

	stdout, err := os.Create(os.Getenv("OUTPUT_PATH"))
	checkError(err)

	defer stdout.Close()

	writer := bufio.NewWriterSize(stdout, 1024*1024*10)

	scoresCount, err := strconv.ParseInt(readLine(reader), 10, 64)
	checkError(err)

	scoresTemp := strings.Split(readLine(reader), " ")

	var scores []int32

	for i := 0; i < int(scoresCount); i++ {
		scoresItemTemp, err := strconv.ParseInt(scoresTemp[i], 10, 64)
		checkError(err)
		scoresItem := int32(scoresItemTemp)
		scores = append(scores, scoresItem)
	}

	aliceCount, err := strconv.ParseInt(readLine(reader), 10, 64)
	checkError(err)

	aliceTemp := strings.Split(readLine(reader), " ")

	var alice []int32

	for i := 0; i < int(aliceCount); i++ {
		aliceItemTemp, err := strconv.ParseInt(aliceTemp[i], 10, 64)
		checkError(err)
		aliceItem := int32(aliceItemTemp)
		alice = append(alice, aliceItem)
	}

	result := climbingLeaderboard(scores, alice)

	for i, resultItem := range result {
		fmt.Fprintf(writer, "%d", resultItem)

		if i != len(result)-1 {
			fmt.Fprintf(writer, "\n")
		}
	}

	fmt.Fprintf(writer, "\n")

	writer.Flush()
}

func readLine(reader *bufio.Reader) string {
	str, _, err := reader.ReadLine()
	if err == io.EOF {
		return ""
	}

	return strings.TrimRight(string(str), "\r\n")
}

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}
