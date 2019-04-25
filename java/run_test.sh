#!/bin/bash

TEST_TIMEOUT=5s
OUT_DIR=bin
IGNORE_DIRS="$OUT_DIR|README.md|run_test.sh|Makefile"

while true; do
    case $1 in
      --list) challenges=$(ls -1 . | grep -vwE "($IGNORE_DIRS)")
		echo "Challenges list:" $challenges
		exit 0;;
	  *) break;;
    esac
done

challenges="$@"
if [ -z "$challenges" ]; then
	challenges=$(ls -1 . | grep -vwE "($IGNORE_DIRS)")
fi

mkdir -p $OUT_DIR

for challenge in $challenges; do
	echo $challenge

	if [ -d "./$challenge" ]; then
		mkdir -p $OUT_DIR/$challenge
		javac -sourcepath $challenge $challenge/Solution.java -d $OUT_DIR/$challenge
		
		for i in {0..99}; do
			input=$(printf "$challenge/test/input%02d.txt" $i)
			ref_output=$(printf "$challenge/test/output%02d.txt" $i)
			cal_output=$(printf "$OUT_DIR/${challenge}_output%02d.txt" $i)

			if [ -f "$input" ] ; then
				start_time=$(date +%s)
  
				echo "$OUT_DIR/$challenge < $input > $cal_output" 
				OUTPUT_PATH=$cal_output gtimeout $TEST_TIMEOUT java -cp $OUT_DIR/$challenge Solution < $input > $cal_output
				test_exitcode=$?

				end_time=$(date +%s)
				diff_time=$(echo "$end_time - $start_time" | bc)

				if [ $test_exitcode == 124 ]; then
					test_status="timeout"
				else
					diff $ref_output $cal_output > /dev/null
					diff_exitcode=$?

					if [ $diff_exitcode == 0 ]; then
						test_status="success"
					else
						test_status="failure"
					fi				
				fi

				echo "[$test_status] $challenge / $i / $diff_time sec."
			fi 
		done
	else
		echo "[error] there is no $challenge"
	fi
	
done
