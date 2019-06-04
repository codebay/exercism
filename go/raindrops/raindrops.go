package raindrops

import (
	"strconv"
)

type factorSound struct {
	divisor int
	sound string
}

var sounds = []factorSound{
	{3, "Pling"},
	{5, "Plang"},
	{7, "Plong"},
}

// Convert a number to a string, however if the number has the factors 3,5 or 7 instead return a string containing
// 'Pling', 'Plang' and 'Plong' respectively
func Convert(n int) string {
	c := ""
	for _, s := range sounds {
		if n%s.divisor == 0 {
			c += s.sound
		}
	}

	if len(c) == 0 {
		c = strconv.Itoa(n)
	}

	return c
}