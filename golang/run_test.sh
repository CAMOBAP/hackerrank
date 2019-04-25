#!/bin/bash

IGNORE_DIRS="common|golang.org|Makefile"

while true; do
    case $1 in
      --list) challenges=$(ls -1 src | grep -vwE '($IGNORE_DIRS)')
		echo "Challenges list:" $challenges
		exit 0;;
	  *) break;;
    esac
done

TEST_TIMEOUT=5s

challenges="$@"
if [ -z "$challenges" ]; then
	challenges=$(ls -1 src | grep -vwE "($IGNORE_DIRS)")
fi

for challenge in $challenges; do
	echo $challenge

	if [ -d "./src/$challenge" ]; then
		go install $challenge
		
		for i in {0..99}; do
			input=$(printf "src/$challenge/test/input%02d.txt" $i)
			ref_output=$(printf "src/$challenge/test/output%02d.txt" $i)
			cal_output=$(printf "bin/${challenge}_output%02d.txt" $i)

			if [ -f "$input" ] ; then
				start_time=$(date +%s)

                # gtimeout $TEST_TIMEOUT   
                echo "bin/$challenge < $input > $cal_output" 
				OUTPUT_PATH=$cal_output gtimeout $TEST_TIMEOUT bin/$challenge < $input > $cal_output
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
