package strand

import "strings"

// ToRNA returns the RNA complement of the DNA strand
func ToRNA(dna string) string {
	return strings.NewReplacer(
		"G", "C",
		"C", "G",
		"T", "A",
		"A", "U",
	).Replace(dna)
}
