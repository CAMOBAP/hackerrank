package main

import (
    "bufio"
    "fmt"
    "io"
    "os"
    "strconv"
    "strings"
)

// Complete the counterGame function below.
//
// Two cases:
// 1. end with 1
//    431241 (10) -> 1101001010010001001 (2)
//                   LR L  R L  R   L  R
//                                     ^-loos
// 1. end with 0
//    431240 (10) -> 1101001010010001000 (2)
//                   LR L  R L  R    LRL
//                                     ^-loos
func counterGame(n int64) string {
    str := strconv.FormatInt(n, 2)
    ones := strings.Count(str, "1")

    var tralingZeros int
    for i := len(str) - 1; i > 0; i-- {
        if str[i] == '0' {
            tralingZeros += 1
        } else {
            break;
        }
    }

    if ((ones - 1) + tralingZeros) % 2 == 1 {
        return "Louise"
    } else {
        return "Richard"
    }
}

func main() {
    reader := bufio.NewReaderSize(os.Stdin, 1024 * 1024)

    stdout, err := os.Create(os.Getenv("OUTPUT_PATH"))
    checkError(err)

    defer stdout.Close()

    writer := bufio.NewWriterSize(stdout, 1024 * 1024)

    tTemp, err := strconv.ParseInt(readLine(reader), 10, 64)
    checkError(err)
    t := int32(tTemp)

    for tItr := 0; tItr < int(t); tItr++ {
        n, err := strconv.ParseInt(readLine(reader), 10, 64)
        checkError(err)

        result := counterGame(n)

        fmt.Fprintf(writer, "%s\n", result)
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
