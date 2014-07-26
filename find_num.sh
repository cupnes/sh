#!/bin/bash
readonly PRECISION=10
readonly res=$1
readonly nums=$(echo $@ | cut -d' ' -f2-)
readonly num_nums=$(($# - 1))

usage() {
	echo "Usage: $(basename $0) target_num num1 [num2 num3 ..]"
}

find_num() {
	local now_num=$(echo $nums | cut -d' ' -f$1)
	local calc_form
	if [ $1 -eq ${num_nums} ]; then
		calc_form=$(echo "$2${now_num}" | sed 's/,/ /g')
		local err_chk=$(echo "${calc_form}" | bc 2>&1 >/dev/null)
		if [ -n "${err_chk}" ]; then
			return 1
		fi
		local calc_res=$(echo "scale=$PRECISION;${calc_form}" | bc | cut -d'.' -f1)
		case ${calc_res} in
		''|'-') calc_res=0;;
		esac
		if [ ${calc_res} -eq $res ]; then
			printf '%s = %d\n' "${calc_form}" ${calc_res}
		fi
		return 0
	fi

	for op in '+' '-' '*' '/'; do
		calc_form="$2${now_num},$op,"
		find_num $(($1 + 1)) ${calc_form}
	done
}

case $# in
0|1) usage;;
*) find_num 1;;
esac
