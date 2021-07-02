package main

import (
	"log"
	"testing"
	"time"
)

func TestSome(t *testing.T) {

	for {
		log.Println("loglog")
		time.Sleep(3 * time.Second)
	}
}
