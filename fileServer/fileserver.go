package main

import (
	"flag"
	"log"
	"net/http"
)

var port *string

func init() {
	// 声明参数
	// 默认8011
	port = flag.String("p", "8011", "fileServer http port")

	// 解析参数
	flag.Parse()
	log.Println("[端口号]:", *port)
}

// 读取当前目录下的所有文件
func main() {

	http.Handle("/", http.FileServer(http.Dir(".")))

	err := http.ListenAndServe(":"+*port, nil)
	if err != nil {
		log.Println(err)
	}
}
