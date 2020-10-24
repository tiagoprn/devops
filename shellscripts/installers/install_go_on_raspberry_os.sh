#!/bin/bash
VERSION='1.11'
apt install -y golang-$VERSION
cp -farv /usr/lib/go-$VERSION/bin/go /usr/local/bin
