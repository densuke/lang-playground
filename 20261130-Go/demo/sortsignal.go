package main

import (
	"fmt"
	"sort"
)

func main() {
	list := []int{5, 2, 8, 1, 9, 3}
	c := make(chan int) // channel を作る
	// 並べ替えを goroutine で始める。終わったら channel に合図を送る
	go func() {
		sort.Ints(list)
		c <- 1 // 値は何でもよい。合図だけ送る
	}()
	fmt.Println("並べ替えを待つ間に、別の仕事をする")
	<-c // 合図が来るまで待つ
	fmt.Println(list)
}
