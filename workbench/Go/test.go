package main

import "fmt"

type person struct {
	name string
	data int
}

func main() {

	person1 := person{name: "Manuel", data: 1}

	var ptr *string
	ptr = &person1.name

	fmt.Printf("Valor de ptr %p\n", ptr)
	fmt.Printf("Valor de ptr %s\n", *ptr)

	*ptr = "Kevin"

	fmt.Printf("Valor de ptr %s\n", *ptr)

	arr := [10]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	var s = arr[1:5]

	arr2 := [4]string{
		"Manuel",
		"Kevin",
		"Jose",
		"Raul",
	}

	sl := arr2[1:3]
	fmt.Printf("\n %s\n%d", sl, s)

	a := [3]bool{true, true, true}
	b := []bool{true, true, true}
	b = append(b, false, false)

	fmt.Println(a)
	fmt.Println(b)

	str := []struct {
		d int
		p bool
	}{
		{2, true},
		{2, true},
		{2, true},
		{2, true},
		{2, true},
	}

	fmt.Println(str)

}
