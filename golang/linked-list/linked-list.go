package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

type Node struct {
	next *Node
	data int
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	first := Node{data: 1}

	// populate list
	for cur := &first; scanner.Scan(); cur = cur.next {
		newData, _ := strconv.Atoi(scanner.Text())
		cur.next = &Node{data: newData}
	}

	// print list
	for cur := &first; cur != nil; cur = cur.next {
		fmt.Printf("%d ", cur.data)
	}
	fmt.Printf("\n")
}
