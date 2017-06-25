#!/bin/bash

while true; do
    case $1 in
      --list) challenges=$(ls -1 src | grep -vwE '(common|golang.org)')
		echo "Challenges list:" $challenges
		exit 0;;
	  *) break;;
    esac
done

TEST_TIMEOUT=5s

challenges="$@"
if [ -z "$challenges" ]; then
	challenges=$(ls -1 src | grep -vwE "(common|golang.org)")
fi

for challenge in $challenges; do
	echo $challenge

	if [ -d "./src/$challenge" ]; then
		go install $challenge
		
		for i in {0..99}; do
			input=$(printf "src/$challenge/test/input%02d.txt" $i)
			output=$(printf "src/$challenge/test/output%02d.txt" $i)

			if [ -f "$input" ] ; then
				start_time=$(date +%s)

				test_output=$(gtimeout $TEST_TIMEOUT bin/$challenge < $input)
				test_exitcode=$?

				end_time=$(date +%s)
				diff_time=$(echo "$end_time - $start_time" | bc)

				if [ $test_exitcode == 124 ]; then
					test_status="timeout"
				elif [ true ]; then
					test_status="success"
				else
					test_status="failure"					
				fi

				echo "[$test_status] $challenge / $i / $diff_time sec."
			fi 
		done
	else
		echo "[error] there is no $challenge"
	fi
	
done
