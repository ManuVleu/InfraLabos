#!/bin/bash
echo "Script name: ${0}"
echo "num params:  ${#}"
echo "Param 1: ${1}"
echo "Param 3: ${3}"
echo "Param 10: ${10}"
shift
shift
shift
echo "num params: ${#}"
echo "Param 1: ${1}"
echo "Param 3: ${3}"
echo "Param 10: ${10}"
echo "Remaining: ${*}"
