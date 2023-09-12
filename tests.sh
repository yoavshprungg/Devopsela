#/bin/bash

responseCode=$(curl -s -o /dev/null -w '%{http_code}' http://localhost:5000)

if [[ "$responseCode" -eq 200 ]]; then
    echo "Application test succeeded with response code 200"
else
    echo "Application test failed with response code $responseCode"
fi
