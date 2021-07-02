package main

import (
	"fmt"
	"github.com/gocolly/colly/v2"
	"log"
)

func main() {
	c := colly.NewCollector()

	// Find and visit all links
	//c.OnHTML("a[href]", func(e *colly.HTMLElement) {
	//	e.Request.Visit(e.Attr("href"))
	//})

	c.OnRequest(func(r *colly.Request) {
		fmt.Println("Visiting", r.URL)
	})

	c.OnResponse(func(res *colly.Response) {
		log.Println(string(res.Body))
	})

	err := c.Visit("https://www.meituan.com/ptapi/poi/getcomment?id=87997721&offset=0&pageSize=10&mode=0&sortType=1")
	log.Println(err)
}
