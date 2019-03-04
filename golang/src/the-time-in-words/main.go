package main

import (
    "bufio"
    "fmt"
    "io"
    "os"
    "strconv"
    "strings"
)

func digitToString(n int32) string {
    switch n % 10 {
        case 1: return "one"
        case 2: return "two"
        case 3: return "three"
        case 4: return "four"
        case 5: return "five"
        case 6: return "six"
        case 7: return "seven"
        case 8: return "eight"
        case 9: return "nine"
    }

    return ""
}

func numberToString(n int32) string {
    d1 := n / 10
    d0 := n % 10

    var s1 string
    var s0 string = ""

    if d1 == 1 {
        switch d0 {
            case 0: s1 = "ten"
            case 1: s1 = "eleven"
            case 2: s1 = "twelve"
            case 3: s1 = "thirteen"
            case 5: s1 = "fifteen"
            case 8: s1 = "eighteen"
            default: s1 = digitToString(d0) + "teen"
        }
    } else {
        switch d1 {
            case 2: s1 = "twenty"
            case 3: s1 = "thirty"
            case 4: s1 = "forty"
            case 5: s1 = "fifty"
        }

        if d0 != 0 {
            if d1 != 0 {
                s0 = " "
            }
            s0 += digitToString(d0)
        }
    }
    return s1 + s0
}

// Complete the timeInWords function below.
func timeInWords(h int32, m int32) string {
    if m == 0 {
        return numberToString(h) + " o' clock"
    }

    var next_h int32 = h + 1
    if h == 12 {
        next_h = 1
    }

    var min_str = "minutes" 
    if m == 1 {
        min_str = "minute"
    }

    if m % 15 == 0 {
        switch m {
            case 15:
                return "quarter past " + numberToString(h)
            case 30:
                return "half past " + numberToString(h)
            case 45:
                return "quarter to " + numberToString(next_h)
        }
    } else if m > 30 {
        return numberToString(60 - m) + " " + min_str + " to " + numberToString(next_h)
    }
    
    return numberToString(m) + " " + min_str + " past " + numberToString(h)
}

func main() {
    reader := bufio.NewReaderSize(os.Stdin, 1024 * 1024)

    stdout, err := os.Create(os.Getenv("OUTPUT_PATH"))
    checkError(err)

    defer stdout.Close()

    writer := bufio.NewWriterSize(stdout, 1024 * 1024)

    hTemp, err := strconv.ParseInt(readLine(reader), 10, 64)
    checkError(err)
    h := int32(hTemp)

    mTemp, err := strconv.ParseInt(readLine(reader), 10, 64)
    checkError(err)
    m := int32(mTemp)

    result := timeInWords(h, m)

    fmt.Fprintf(writer, "%s\n", result)

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

