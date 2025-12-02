#!/bin/bash

input_file="input.txt"
#input_file="test.txt"  # Expected output: 3

dial=50
dial_size=100
zero_count=0

process_line() {
  local line="$1"
  local direction="${line:0:1}"
  local value="${line:1}"

  if [[ "$direction" == "L" ]]; then
    dial=$(( ((dial - value ) % dial_size + dial_size) % dial_size)) # Always > 0
  else
    dial=$(( (dial + value) % dial_size ))
  fi

  if [[ $dial == 0 ]]; then
    zero_count=$((zero_count + 1))
  fi
}

while IFS= read -r line; do
  process_line $line
done < $input_file


echo "Zeros: $zero_count"
