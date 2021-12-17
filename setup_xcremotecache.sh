#!/usr/bin/env zsh

XC_REMOTE_CACHE_MODE="${1}"
XCODE_PROJECT_PATH="${2}"

echo "Configure XCRemoteCache for ${XCODE_PROJECT_PATH}"

cat > $(dirname "${XCODE_PROJECT_PATH}")/.rcinfo << EOF
primary_repo: $(grep -o 'url = \(.*\)' .git/config | awk '{print $NF}')$(echo "${XCODE_PROJECT_PATH}" | sed 's/^\.//')
cache_addresses:
- $XC_REMOTE_CACHE_ADDRESS
# - http://localhost:8080/cache
EOF

if [ "${XC_REMOTE_CACHE_MODE}" = "consumer" ]; then
    echo "Initialize XCRemoteCache in consumer mode"
    xcremotecache/xcprepare integrate --input "${XCODE_PROJECT_PATH}" --mode consumer --consumer-eligible-configurations Debug --consumer-eligible-platforms 'iphoneos'
elif [ "${XC_REMOTE_CACHE_MODE}" = "producer" ]; then
    echo "Initialize XCRemoteCache in producer mode"
    xcremotecache/xcprepare integrate --input "${XCODE_PROJECT_PATH}" --mode producer --final-producer-target XcodeBenchmark
else
    echo "XC Remote Cache mode is not specified or invalid (XC_REMOTE_CACHE_MODE: \"${XC_REMOTE_CACHE_MODE}\"). Skip setting up cache"
fi
