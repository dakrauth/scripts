#!/bin/bash
PLATFORM=$(uname)
if [ $PLATFORM = "Darwin" ]; then
    pushd ~/Downloads

    # Get a more recent nightly build of SequelPro that can handle v8 servers
    curl -O https://sequelpro.com/builds/Sequel-Pro-Build-97c1b85783.zip

    popd
elif [ $PLATFORM = "Linux" ]; then
    # Coming soon!
fi
