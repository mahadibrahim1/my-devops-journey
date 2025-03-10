#!/bin/bash

first="$1"
second="$2"

add=$((first + second))
minus=$((first - second))
multi=$((first * second))
divide=$((first / second))


echo "Addition= $add"
echo "Subtraction= $minus"
echo "Multiplication= $multi"
echo "Division= $divide"
