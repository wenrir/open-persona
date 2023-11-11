#!/usr/bin/env sh

set -e

if [[ "$1" == "dev" ]];
then
    cd /app
    echo "=== Start npm development env ==="
    yarn install
    yarn dev
elif [[ "$1" == "build" ]];
then
   cd /app
    echo "=== build component ==="
   yarn install
   yarn build
   exit
elif [[ "$1" == "lint" ]];
then
   cd /app
   echo "=== Lint ==="
   yarn install
   yarn lint
   exit

elif [[ "$1" == "test" ]];
then
   cd /app
   echo "=== Test ==="
   yarn install
   yarn check
   yarn test
   exit
else
   if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ] || { [ -f "${1}" ] && ! [ -x "${1}" ]; }; then
      set -- node "$@"
   fi
   exec "$@"
fi

tail -f /dev/null
