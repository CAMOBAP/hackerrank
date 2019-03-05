package main

import (
    "bufio"
    "fmt"
    "io"
    "os"
    "strconv"
    "strings"
)

// Complete the kaprekarNumbers function below.
func kaprekarNumbers(p int32, q int32) {
    var found bool = false

    for n := int64(p); n <= int64(q); n++ {
        s := n * n
        d := len(strconv.Itoa(int(n)))
        ss := strconv.Itoa(int(s))
        if len(ss) % 2 == 1 {
            ss = "0" + ss
        }

        r, _ := strconv.Atoi(ss[:d])
        l, _ := strconv.Atoi(ss[d:])
        k := int(n) == (r + l)
        
        if k {
            fmt.Print(n, " ")
            found = true
        }
    }

    if !found {
        fmt.Println("INVALID RANGE")
    }
}

func main() {
    reader := bufio.NewReaderSize(os.Stdin, 1024 * 1024)

    pTemp, err := strconv.ParseInt(readLine(reader), 10, 64)
    checkError(err)
    p := int32(pTemp)

    qTemp, err := strconv.ParseInt(readLine(reader), 10, 64)
    checkError(err)
    q := int32(qTemp)

    kaprekarNumbers(p, q)
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

