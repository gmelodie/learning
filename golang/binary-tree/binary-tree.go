package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

type Node struct {
	right *Node
	left  *Node
	data  int
}

func (n *Node) push(item int) {
	switch {
	case item < n.data:
		if n.left == nil {
			n.left = &Node{data: item}
		} else {
			n.left.push(item)
		}
	case item > n.data:
		if n.right == nil {
			n.right = &Node{data: item}
		} else {
			n.right.push(item)
		}
	}
}

func (n *Node) printTree(depth int) {
	for i := 0; i < depth; i++ {
		fmt.Printf("\t")
	}
	fmt.Printf("%d\n", n.data)

	if n.left != nil {
		n.left.printTree(depth + 1)
	}
	if n.right != nil {
		n.right.printTree(depth + 1)
	}
}

func (n *Node) getDepth() int {
	var rightDepth float64
	var leftDepth float64

	if n.right != nil {
		rightDepth += float64(n.right.getDepth())
	}
	if n.left != nil {
		leftDepth += float64(n.left.getDepth())
	}

	return 1 + int(math.Max(rightDepth, leftDepth))
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	root := &Node{}

	// populate tree
	for scanner.Scan() {
		newData, _ := strconv.Atoi(scanner.Text())
		root.push(newData)
	}

	// root.printTree(0)
	fmt.Println(root.getDepth())
}
