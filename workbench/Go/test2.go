package main

import (
	"fmt"
)

func reverse(s string) string {

	n := len(s) - 1

	str := " "
	for i := n; i > 0; i-- {
		str[i] = str + s[i]
	}
	return str
}

func main() {

	a := "Hello"

	fmt.Println(reverse(a))

	fmt.Println(len(a) - 1)

}
