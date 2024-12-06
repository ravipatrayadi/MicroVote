#!/bin/bash
set -eo pipefail

host="$(hostname -i || echo '127.0.0.1')"

if ping="$(redis-cli -h "$host" ping)" && [ "$ping" = 'PONG' ]; then
	echo "yes"
	exit 0
fi

exit 1