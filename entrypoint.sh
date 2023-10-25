#!/usr/bin/env sh

set -e


if [[ "$1" == "dev" ]];
then
    cd /app
    npm install
    npm run dev
elif [[ "$1" == "build" ]];
then
   cd /app
   npm install
   npm run build
   exit
else
   if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ] || { [ -f "${1}" ] && ! [ -x "${1}" ]; }; then
      set -- node "$@"
   fi
   exec "$@"
fi

tail -f /dev/null
