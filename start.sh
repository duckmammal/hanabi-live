#!/bin/bash

# Get the directory of this script
# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Get the name of the repository
# https://stackoverflow.com/questions/23162299/how-to-get-the-last-part-of-dirname-in-bash/23162553
REPO="$(basename "$DIR")"

# Recompile the Golang code and start the service
cd "$DIR/server"
go build -o "$DIR/$REPO"
if [[ $? -eq 0 ]]; then
  # The build was successful; restart the server
  supervisorctl start "$REPO"
else
  echo "$REPO - Go compilation failed!"
fi
