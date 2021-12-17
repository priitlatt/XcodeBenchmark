#!/usr/bin/env zsh

wget https://github.com/spotify/XCRemoteCache/releases/download/v0.3.0/XCRemoteCache-macOS-x86_64-v0.3.0.zip
unzip XCRemoteCache-macOS-x86_64-v0.3.0.zip -d xcremotecache
rm XCRemoteCache-macOS-x86_64-v0.3.0.zip
xattr -d -r com.apple.quarantine xcremotecache/xc*
