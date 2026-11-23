package main

import "fmt"

// square は n の 2 乗を results に送る
func square(n int, results chan<- [2]int) {
	results <- [2]int{n, n * n}
}

func main() {
	results := make(chan [2]int)
	for n := 1; n <= 5; n++ {
		go square(n, results) // go を前に置くだけで並行に動く
	}
	squares := map[int]int{}
	for range 5 {
		r := <-results
		squares[r[0]] = r[1]
	}
	// 届く順は毎回違う。表示は順番に整える
	for n := 1; n <= 5; n++ {
		fmt.Println(n, "の 2 乗は", squares[n])
	}
}
