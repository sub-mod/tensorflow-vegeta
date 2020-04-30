#!/bin/bash
echo $PWD
if [[ $TEST_LOOP = "y" ]]
then
	echo "####################################"
	echo "      DEV/TEST MODE.....       	  "
	echo "####################################"
    echo "Starting a infinite while loop to debug in console terminal\n"
    while :
	do
		echo "Press [CTRL+C] to stop.."
		sleep 1
	done
fi

export TERM=xterm-color
cd /opt/app-root/src/
ls
echo "==================="
touch target.list
echo "POST $ROUTE_FROM_ENV" >> target.list
echo "Content-Type: application/json" >> target.list
echo "@/opt/app-root/src/payload.json" >> target.list
cat target.list
echo "==================="
touch results.json

echo "==================="
echo "Run vegeta"
echo "==================="
vegeta attack -targets=target.list -rate=${REQUEST_RATE_PER_SEC} -duration=${DURATION} -insecure >> results.json &
BACK_PID=$!

while kill -0 $BACK_PID ; do
    echo "Process is still active..."
    vegeta report results.json > report.txt
    cat report.txt
    echo "==================="
    sleep 1
    # You can add a timeout here if you want
done
vegeta report results.json > report.txt
cat report.txt
echo "==================="
echo "END"
echo "==================="
