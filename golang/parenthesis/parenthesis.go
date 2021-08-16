package main

import (
	"bufio"
	"fmt"
	"os"
)

// ()
// stack = "("

func isCorrectParenthesis(line string) bool {
	var stack string
	for _, c := range line {
		switch c {
		case '(':
			stack += "("
		case ')':
			if len(stack) == 0 {
				return false
			}
			stack = stack[:len(stack)-1]
		}
	}
	if len(stack) != 0 {
		return false
	}
	return true
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		ans := line + " is correct"
		if !isCorrectParenthesis(line) {
			ans = line + " is incorrect"
		}
		fmt.Println(ans)
	}
}
