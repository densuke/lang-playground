package main

import (
	"fmt"
	"sync"
)

func main() {
	var wg sync.WaitGroup
	count := 0
	for range 1000 {
		wg.Add(1)
		go func() {
			defer wg.Done()
			count++ // 鍵なしで同じ変数を書き換える
		}()
	}
	wg.Wait()
	fmt.Println("期待する値は 1000、実際は", count)
}
