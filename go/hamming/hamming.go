// Hamming package implements the Hamming distance between two DNA strands
package hamming

import "errors"

// Distance counts the number of different nucleotides between two DNA strands of equal length
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, errors.New("hamming distance is only defined for sequences of equal length")
	}

	d := 0
	for i, _ := range a {
		if a[i] != b[i] {
			d += 1
		}
	}

	return d, nil
}
