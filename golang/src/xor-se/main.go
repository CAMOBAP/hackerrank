package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

// Complete the xorSequence function below.
func xorSequenceNaive(l int64, r int64) int64 {
	var result int64
	var current int64

	for i := int64(0); i <= r; i++ {
		current = current ^ i

		if i == l {
			result = current
		} else if i > l && i <= r {
			result ^= current
		}
	}

	return result
}

func g(x int64) int64 {
	switch x % 8 {
	case 0:
		return x
	case 1:
		return x
	case 2:
		return 2
	case 3:
		return 2
	case 4:
		return x + 2
	case 5:
		return x + 2
	case 6:
		return 0
	case 7:
		return 0
	}

	panic("If you see this, there is a bug in switch above")
}

func xorSequence(l int64, r int64) int64 {
	return g(r) ^ g(l-1)
}

func main() {
	reader := bufio.NewReaderSize(os.Stdin, 1024*1024)

	stdout, err := os.Create(os.Getenv("OUTPUT_PATH"))
	checkError(err)

	defer stdout.Close()

	writer := bufio.NewWriterSize(stdout, 1024*1024)

	qTemp, err := strconv.ParseInt(readLine(reader), 10, 64)
	checkError(err)
	q := int32(qTemp)

	for qItr := 0; qItr < int(q); qItr++ {
		lr := strings.Split(readLine(reader), " ")

		l, err := strconv.ParseInt(lr[0], 10, 64)
		checkError(err)

		r, err := strconv.ParseInt(lr[1], 10, 64)
		checkError(err)

		result := xorSequence(l, r)

		fmt.Fprintf(writer, "%d\n", result)
	}

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
