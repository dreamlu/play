package main

import (
	"math/rand"
	"os"
	"runtime/trace"
	"sync"
)

func main() {
	trace.Start(os.Stderr)
	defer trace.Stop()
	var total int
	var wg sync.WaitGroup

	for i:=0 ;i < 10;i++{
		wg.Add(1)
		go func() {
			for j:=0;j < 1000;j++ {
				total += readNumber()
			}
			wg.Done()
		}()
	}
	wg.Wait()
}

func readNumber() int {
	return rand.Intn(10)
}