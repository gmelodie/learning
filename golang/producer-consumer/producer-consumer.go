package main

import "fmt"

var sentences = []string{
	"Ouvir Estrelas",
	"Ora (direis) ouvir estrelas! Certo,",
	"Perdeste o senso! E eu vos direi, no entanto,",
	"Que, para ouvi-las, muita vez desperto",
	"E abro as janelas, pálido de espanto...",
	"E conversamos toda a noite,",
	"enquanto a Via-Láctea, como um pálio aberto,",
	"Cintila. E, ao vir do sol, saudoso e em pranto,",
	"Inda as procuro pelo céu deserto.",
	"Direis agora: Tresloucado amigo!",
	"Que conversas com elas? Que sentido",
	"Tem o que dizem, quando estão contigo?",
	"E eu vos direi: Amai para entendê-las!",
	"Pois só quem ama pode ter ouvido",
	"Capaz de ouvir e e de entender estrelas.",
}

func produce(jobs chan<- string) {
	for _, sentence := range sentences {
		jobs <- sentence
	}
	close(jobs)
}

func consume(consumerIdx int, jobs <-chan string, done chan<- string) {
	for job := range jobs {
		fmt.Printf("Consumer %d: %s\n", consumerIdx, job)
		done <- job
	}
}

func main() {
	jobs := make(chan string)
	done := make(chan string)
	consumerCount := 10

	go produce(jobs)

	for i := 0; i < consumerCount; i++ {
		go consume(i, jobs, done)
	}
	<-done
}
