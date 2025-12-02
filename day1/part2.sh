#!/bin/bash

input_file="input.txt"
#input_file="test.txt"  # Expected output: 6

dial=50
dial_size=100
zero_count=0

process_line() {
  local line="$1"
  local direction="${line:0:1}"
  local value="${line:1}"
  local steps_to_zero hits

  if [[ "$direction" == "L" ]]; then
    if ((dial == 0)); then
      steps_to_zero=$dial_size
    else
      steps_to_zero=$dial
    fi
  else
    if ((dial == 0)); then
      steps_to_zero=$dial_size
    else
      steps_to_zero=$((dial_size - dial))
    fi
  fi

  if (( value >= steps_to_zero )); then
    hits=$((1 + (value - steps_to_zero) / dial_size))
    zero_count=$((zero_count + hits))
  fi

  if [[ "$direction" == "L" ]]; then
    dial=$(( (dial - value) % dial_size ))
    if (( dial < 0 )); then
      dial=$((dial + dial_size))
    fi
  else
    dial=$(( (dial + value) % dial_size ))
  fi
}

while IFS= read -r line; do
  process_line $line
done < $input_file


echo "Zeros: $zero_count"
