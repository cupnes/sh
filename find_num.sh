#!/bin/bash

usage() {
	echo "Usage: $(basename $0) num1 [num2 num3 ...]"
}

find_num_0() {
	echo 'error: Please specify one or more arguments.' > /dev/stderr
	usage
	exit 1
}

main() {
	case $# in
	0)
		find_num_0
		;;
	*)
		echo 'error: Illegal arguments.' > /dev/stderr
		usage
		exit 1
	;;
	esac
}

main
