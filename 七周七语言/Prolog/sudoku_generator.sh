#!/bin/bash

row_num=$1
col_num=$2

element_num=$((${row_num} * ${col_num}))

puzzle=""
valid=""
for((i = 0; i < element_num; i++))
do
	row[$i]=""
	col[$i]=""
	block[$i]=""
done
seperator=", "

for((i = 0; i < element_num; i++))
do
	for((j = 0; j < element_num; j++))
	do
		puzzle="${puzzle}${seperator}S${i}${j}"
		row[$i]="${row[$i]}${seperator}S${i}${j}"
		col[$i]="${col[$i]}${seperator}S${j}${i}"
		base_row=$(((${i} / ${row_num}) * ${row_num}))
		base_col=$(((${i} % ${row_num}) * ${col_num}))
		block_row=$(($base_row + (${j} / ${col_num})))
		block_col=$(($base_col + (${j} % ${col_num})))
		block[$i]="${block[$i]}${seperator}S${block_row}${block_col}"
	done
	valid="${valid}${seperator}Row${i}${seperator}Col${i}${seperator}Block${i}"
done

puzzle=${puzzle#${seperator}}
for((i = 0; i < element_num; i++))
do
	row[$i]=${row[$i]#${seperator}}
	col[$i]=${col[$i]#${seperator}}
	block[$i]=${block[$i]#${seperator}}
done
valid=${valid#${seperator}}

cat << EOF
valid([]).
valid([Head|Tail]) :- 
	fd_all_different(Head), 
	valid(Tail).

sudoku(Puzzle, Solution) :-
	Solution = Puzzle,
	Puzzle = [${puzzle}],
	fd_domain(Solution, 1, ${element_num}), 
`
for((i = 0; i < element_num; i++))
do
	echo "	Row${i} = [${row[$i]}]," 
done
for((i = 0; i < element_num; i++))
do
	echo "	Col${i} = [${col[$i]}]," 
done
for((i = 0; i < element_num; i++))
do
	echo "	Block${i} = [${block[$i]}]," 
done
`
	valid([${valid}]),
	fd_labeling(Solution),
`
echo "	write('Solution is : ')," 
echo "	nl," 
for((i = 0; i < element_num; i++))
do
	echo "	print(Row${i})," 
	echo "	nl,"
done
`
	true.
EOF
exit
